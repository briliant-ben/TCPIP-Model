#include <string.h>
#include "tcpip/dhcp.h"
#include "tcpip/dns.h"
#include "tcpip/opt.h"
#include "tcpip/pbuf.h"
#include "tcpip/sys.h"
#include "tcpip/udp.h"

#define DHCP_CLIENT_PORT 68U
#define DHCP_SERVER_PORT 67U
#define DHCP_MAGIC_COOKIE 0x63825363UL
#define DHCP_MIN_LEN 240U

#define DHCP_OP_BOOTREQUEST 1U
#define DHCP_OP_BOOTREPLY   2U

#define DHCP_DISCOVER 1U
#define DHCP_OFFER    2U
#define DHCP_REQUEST  3U
#define DHCP_DECLINE  4U
#define DHCP_ACK      5U
#define DHCP_NAK      6U
#define DHCP_RELEASE  7U

typedef struct {
    struct netif *netif;
    struct udp_pcb *pcb;
    dhcp_state_t state;
    uint32_t xid;
    uint32_t state_ts_ms;
    uint32_t retry_ms;
    uint8_t tries;
    ip4_addr_t server_ip;
    ip4_addr_t offered_ip;
    ip4_addr_t offered_mask;
    ip4_addr_t offered_gw;
    ip4_addr_t offered_dns;
    uint32_t lease_s;
    uint32_t t1_s;
    uint32_t t2_s;
    uint32_t lease_start_ms;
#if TCPIP_VERIFY_FSM
    dhcp_fsm_machine_t fsm;
#endif
} dhcp_ctx_t;

static dhcp_ctx_t dhcp_slots[TCPIP_NETIF_MAX];

static inline uint32_t rd32be(const uint8_t *p) {
    return ((uint32_t)p[0] << 24) | ((uint32_t)p[1] << 16) |
           ((uint32_t)p[2] << 8) | (uint32_t)p[3];
}
static inline void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}
static inline void wr32be(uint8_t *p, uint32_t v) {
    p[0] = (uint8_t)(v >> 24);
    p[1] = (uint8_t)((v >> 16) & 0xFFU);
    p[2] = (uint8_t)((v >> 8) & 0xFFU);
    p[3] = (uint8_t)(v & 0xFFU);
}

static dhcp_ctx_t *find_ctx(const struct netif *netif, int alloc) {
    dhcp_ctx_t *free_slot = NULL;
    for (int i = 0; i < TCPIP_NETIF_MAX; i++) {
        if (dhcp_slots[i].netif == netif) return &dhcp_slots[i];
        if (!dhcp_slots[i].netif && !free_slot) free_slot = &dhcp_slots[i];
    }
    if (alloc && free_slot) {
        memset(free_slot, 0, sizeof(*free_slot));
        free_slot->netif = (struct netif *)netif;
        return free_slot;
    }
    return NULL;
}

static err_t dhcp_send_msg(dhcp_ctx_t *c, uint8_t msg_type, const ip4_addr_t *dst_ip) {
    if (!c || !c->netif || !c->pcb) return ERR_ARG;
    struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, 300U, PBUF_POOL);
    if (!p) return ERR_MEM;
    uint8_t buf[300];
    memset(buf, 0, sizeof(buf));
    buf[0] = DHCP_OP_BOOTREQUEST;
    buf[1] = 1U; /* Ethernet */
    buf[2] = 6U;
    buf[3] = 0U;
    wr32be(buf + 4, c->xid);
    wr16be(buf + 10, (msg_type == DHCP_DISCOVER || msg_type == DHCP_REQUEST) && c->state != DHCP_STATE_RENEWING ? 0x8000U : 0U);
    if (c->state == DHCP_STATE_RENEWING || c->state == DHCP_STATE_REBINDING || c->state == DHCP_STATE_BOUND) {
        memcpy(buf + 12, &c->netif->ip_addr.addr, 4);
    }
    memcpy(buf + 28, c->netif->hwaddr, 6);
    wr32be(buf + 236, DHCP_MAGIC_COOKIE);

    uint16_t idx = 240U;
    buf[idx++] = 53U; buf[idx++] = 1U; buf[idx++] = msg_type;
    if (msg_type == DHCP_REQUEST) {
        if (!ip4_addr_isany(&c->offered_ip) && c->state != DHCP_STATE_RENEWING) {
            buf[idx++] = 50U; buf[idx++] = 4U;
            memcpy(buf + idx, &c->offered_ip.addr, 4);
            idx += 4U;
        }
        if (!ip4_addr_isany(&c->server_ip) && c->state == DHCP_STATE_REQUESTING) {
            buf[idx++] = 54U; buf[idx++] = 4U;
            memcpy(buf + idx, &c->server_ip.addr, 4);
            idx += 4U;
        }
    }
    /* Parameter request list: subnet mask (1), router (3), DNS (6) */
    buf[idx++] = 55U; buf[idx++] = 3U; buf[idx++] = 1U; buf[idx++] = 3U; buf[idx++] = 6U;
    buf[idx++] = 255U;

    pbuf_take(p, buf, (uint16_t)sizeof(buf));
    pbuf_realloc(p, idx);
    err_t err = udp_sendto_if(c->pcb, p, dst_ip, DHCP_SERVER_PORT, c->netif);
    pbuf_free(p);
    return err;
}

static void dhcp_recv_cb(void *arg, struct udp_pcb *upcb, struct pbuf *p,
                         const ip4_addr_t *addr, uint16_t port) {
    (void)upcb;
    (void)addr;
    (void)port;
    dhcp_ctx_t *c = (dhcp_ctx_t *)arg;
    if (!c || !p || p->tot_len < DHCP_MIN_LEN) {
        if (p) pbuf_free(p);
        return;
    }
    uint8_t pkt[576];
    uint16_t n = p->tot_len < sizeof(pkt) ? p->tot_len : (uint16_t)sizeof(pkt);
    pbuf_copy_partial(p, pkt, n, 0U);
    pbuf_free(p);

    if (pkt[0] != DHCP_OP_BOOTREPLY || rd32be(pkt + 4) != c->xid ||
        memcmp(pkt + 28, c->netif->hwaddr, 6) != 0 ||
        rd32be(pkt + 236) != DHCP_MAGIC_COOKIE) {
        return;
    }

    ip4_addr_t yiaddr;
    memcpy(&yiaddr.addr, pkt + 16, 4);
    uint8_t msg_type = 0U;
    ip4_addr_t srv = {0}, mask = {0}, gw = {0}, dns = {0};
    IP4_ADDR(&mask, 255, 255, 255, 0);
    uint32_t lease = 3600U;

    uint16_t pos = 240U;
    while (pos < n) {
        uint8_t opt = pkt[pos++];
        if (opt == 0U) continue;
        if (opt == 255U) break;
        if (pos >= n) break;
        uint8_t olen = pkt[pos++];
        if (pos + olen > n) break;
        if (opt == 53U && olen >= 1U) msg_type = pkt[pos];
        else if (opt == 1U && olen >= 4U) memcpy(&mask.addr, pkt + pos, 4);
        else if (opt == 3U && olen >= 4U) memcpy(&gw.addr, pkt + pos, 4);
        else if (opt == 6U && olen >= 4U) memcpy(&dns.addr, pkt + pos, 4);
        else if (opt == 51U && olen >= 4U) lease = rd32be(pkt + pos);
        else if (opt == 54U && olen >= 4U) memcpy(&srv.addr, pkt + pos, 4);
        pos = (uint16_t)(pos + olen);
    }

    uint32_t now_ms = sys_now();
    ip4_addr_t bcast = { 0xFFFFFFFFUL };

    if (msg_type == DHCP_OFFER && c->state == DHCP_STATE_SELECTING && !ip4_addr_isany(&yiaddr)) {
        c->offered_ip = yiaddr;
        c->offered_mask = mask;
        c->offered_gw = gw;
        c->offered_dns = dns;
        if (!ip4_addr_isany(&srv)) c->server_ip = srv;
        c->state = DHCP_STATE_REQUESTING;
        c->tries = 0U;
        c->retry_ms = 500U;
        c->state_ts_ms = now_ms;
#if TCPIP_VERIFY_FSM
        (void)dhcp_fsm_step(&c->fsm, (int64_t)now_ms, DHCP_FSM_EV_RX_OFFER, NULL, 0, NULL, NULL, NULL);
#endif
        (void)dhcp_send_msg(c, DHCP_REQUEST, &bcast);
    } else if (msg_type == DHCP_ACK &&
               (c->state == DHCP_STATE_REQUESTING || c->state == DHCP_STATE_RENEWING || c->state == DHCP_STATE_REBINDING)) {
        if (lease == 0U) lease = 3600U;
        if (lease > 86400U) lease = 86400U;
        c->lease_s = lease;
        c->t1_s = lease / 2U;
        c->t2_s = (lease * 7U) / 8U;
        c->lease_start_ms = now_ms;
        c->state = DHCP_STATE_BOUND;
        c->tries = 0U;
        netif_set_addr(c->netif, &yiaddr, &mask, &gw);
        if (!ip4_addr_isany(&dns)) {
            dns_setserver(0U, &dns);
        }
#if TCPIP_VERIFY_FSM
        fsa_val_t args[1] = { fsa_val_int((int64_t)lease) };
        (void)dhcp_fsm_step(&c->fsm, (int64_t)now_ms, DHCP_FSM_EV_RX_ACK, args, 1, NULL, NULL, NULL);
#endif
    } else if (msg_type == DHCP_NAK &&
               (c->state == DHCP_STATE_REQUESTING || c->state == DHCP_STATE_RENEWING || c->state == DHCP_STATE_REBINDING)) {
#if TCPIP_VERIFY_FSM
        if (c->fsm.state == DHCP_FSM_STATE_REQUESTING) {
            (void)dhcp_fsm_step(&c->fsm, (int64_t)now_ms, DHCP_FSM_EV_RX_NAK, NULL, 0, NULL, NULL, NULL);
        }
#endif
        c->state = DHCP_STATE_INIT;
        ip4_addr_t z = {0};
        netif_set_addr(c->netif, &z, &z, &z);
    }
}

err_t dhcp_start(struct netif *netif) {
    if (!netif) return ERR_ARG;
    dhcp_ctx_t *c = find_ctx(netif, 1);
    if (!c) return ERR_MEM;
    if (!c->pcb) {
        c->pcb = udp_new();
        if (!c->pcb) return ERR_MEM;
        ip4_addr_t any = {0};
        err_t berr = udp_bind(c->pcb, &any, DHCP_CLIENT_PORT);
        if (berr != ERR_OK && berr != ERR_USE) {
            udp_remove(c->pcb);
            c->pcb = NULL;
            return berr;
        }
        c->pcb->local_port = DHCP_CLIENT_PORT;
        udp_recv(c->pcb, dhcp_recv_cb, c);
    }
    uint32_t now_ms = sys_now();
    c->xid = 0xD4C00001UL ^ ((uint32_t)netif->hwaddr[5] << 8) ^ now_ms;
    c->state = DHCP_STATE_SELECTING;
    c->tries = 0U;
    c->retry_ms = 500U;
    c->state_ts_ms = now_ms;
    memset(&c->server_ip, 0, sizeof(c->server_ip));
    memset(&c->offered_ip, 0, sizeof(c->offered_ip));
#if TCPIP_VERIFY_FSM
    dhcp_fsm_init(&c->fsm);
    (void)dhcp_fsm_step(&c->fsm, (int64_t)now_ms, DHCP_FSM_EV_START, NULL, 0, NULL, NULL, NULL);
#endif
    ip4_addr_t bcast = { 0xFFFFFFFFUL };
    return dhcp_send_msg(c, DHCP_DISCOVER, &bcast);
}

void dhcp_stop(struct netif *netif) {
    dhcp_ctx_t *c = find_ctx(netif, 0);
    if (!c) return;
#if TCPIP_VERIFY_FSM
    if (c->fsm.state != DHCP_FSM_STATE_INIT) {
        (void)dhcp_fsm_step(&c->fsm, (int64_t)sys_now(), DHCP_FSM_EV_STOP, NULL, 0, NULL, NULL, NULL);
    }
#endif
    if (c->pcb) {
        udp_remove(c->pcb);
        c->pcb = NULL;
    }
    c->state = DHCP_STATE_INIT;
    c->netif = NULL;
}

void dhcp_tmr(uint32_t now_ms) {
    ip4_addr_t bcast = { 0xFFFFFFFFUL };
    for (int i = 0; i < TCPIP_NETIF_MAX; i++) {
        dhcp_ctx_t *c = &dhcp_slots[i];
        if (!c->netif) continue;
        if (c->state == DHCP_STATE_SELECTING || c->state == DHCP_STATE_REQUESTING ||
            c->state == DHCP_STATE_RENEWING || c->state == DHCP_STATE_REBINDING) {
            if ((uint32_t)(now_ms - c->state_ts_ms) >= c->retry_ms) {
                if (c->tries >= 5U) {
                    c->state = DHCP_STATE_SELECTING;
                    c->tries = 0U;
                    c->retry_ms = 500U;
                } else {
                    c->tries++;
                    c->retry_ms = c->retry_ms < 4000U ? c->retry_ms * 2U : 4000U;
                }
                c->state_ts_ms = now_ms;
                if (c->state == DHCP_STATE_SELECTING) {
                    (void)dhcp_send_msg(c, DHCP_DISCOVER, &bcast);
                } else if (c->state == DHCP_STATE_RENEWING && !ip4_addr_isany(&c->server_ip)) {
                    (void)dhcp_send_msg(c, DHCP_REQUEST, &c->server_ip);
                } else {
                    (void)dhcp_send_msg(c, DHCP_REQUEST, &bcast);
                }
            }
        }
        if (c->state == DHCP_STATE_BOUND && c->t1_s > 0U &&
            (uint32_t)(now_ms - c->lease_start_ms) >= c->t1_s * 1000U) {
            c->state = DHCP_STATE_RENEWING;
            c->tries = 0U;
            c->state_ts_ms = now_ms;
            (void)dhcp_send_msg(c, DHCP_REQUEST, !ip4_addr_isany(&c->server_ip) ? &c->server_ip : &bcast);
        }
    }
}

uint8_t dhcp_supplied_address(const struct netif *netif) {
    dhcp_ctx_t *c = find_ctx(netif, 0);
    return (c && c->state == DHCP_STATE_BOUND) ? 1U : 0U;
}

dhcp_state_t dhcp_state_get(const struct netif *netif) {
    dhcp_ctx_t *c = find_ctx(netif, 0);
    return c ? c->state : DHCP_STATE_INIT;
}

void dhcp_reset_all(void) {
    for (int i = 0; i < TCPIP_NETIF_MAX; i++) {
        if (dhcp_slots[i].pcb) udp_remove(dhcp_slots[i].pcb);
    }
    memset(dhcp_slots, 0, sizeof(dhcp_slots));
}
