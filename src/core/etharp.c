#include <string.h>
#include "tcpip/etharp.h"
#include "tcpip/ip4.h"
#include "tcpip/sys.h"
#include "tcpip/tcpip.h"
#if TCPIP_VERIFY_FSM
#include "arp_fsm.h"
#endif

#define ARP_HWTYPE_ETH  1U
#define ARP_PTYPE_IPV4  0x0800U
#define ARP_OP_REQUEST  1U
#define ARP_OP_REPLY    2U
#define ARP_HDR_LEN     28U
#define ARP_AGE_STALE_MS  240000U
#define ARP_AGE_EXPIRE_MS 300000U
#define ARP_RETRY_MS      1000U

typedef enum {
    ARP_STATE_EMPTY = 0,
    ARP_STATE_PENDING,
    ARP_STATE_STABLE,
    ARP_STATE_STALE
} arp_entry_state_t;

typedef struct {
    ip4_addr_t ip;
    struct netif *netif;
    uint8_t hwaddr[6];
    uint8_t state;
    uint8_t retries;
    uint32_t state_ts_ms;
    struct pbuf *q[TCPIP_ARP_QUEUE_LEN];
    uint8_t q_len;
#if TCPIP_VERIFY_FSM
    arp_fsm_machine_t fsm;
#endif
} arp_entry_t;

static arp_entry_t arp_table[TCPIP_ARP_TABLE_SIZE];
static const uint8_t eth_bcast[6] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
static const uint8_t eth_zero[6]  = {0, 0, 0, 0, 0, 0};

static inline uint16_t rd16be(const uint8_t *p) {
    return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}

static inline void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}

void etharp_reset(void) {
    for (int i = 0; i < TCPIP_ARP_TABLE_SIZE; i++) {
        for (int k = 0; k < TCPIP_ARP_QUEUE_LEN; k++) {
            if (arp_table[i].q[k]) {
                pbuf_free(arp_table[i].q[k]);
            }
        }
        memset(&arp_table[i], 0, sizeof(arp_table[i]));
#if TCPIP_VERIFY_FSM
        arp_fsm_init(&arp_table[i].fsm);
#endif
    }
}

static void free_entry_queue(arp_entry_t *e) {
    for (uint8_t i = 0; i < e->q_len && i < TCPIP_ARP_QUEUE_LEN; i++) {
        if (e->q[i]) {
            pbuf_free(e->q[i]);
            e->q[i] = NULL;
        }
    }
    e->q_len = 0;
}

static void evict_entry(arp_entry_t *e, uint32_t now_ms) {
#if TCPIP_VERIFY_FSM
    if (e->state != ARP_STATE_EMPTY) {
        arp_fsm_step(&e->fsm, (int64_t)now_ms, ARP_FSM_EV_EVICT, NULL, 0, NULL, NULL, NULL);
    }
#else
    (void)now_ms;
#endif
    free_entry_queue(e);
    memset(&e->ip, 0, sizeof(e->ip));
    e->netif = NULL;
    e->state = ARP_STATE_EMPTY;
    e->retries = 0;
}

static int find_or_alloc_entry(const ip4_addr_t *ip, struct netif *netif, uint32_t now_ms, int create) {
    int empty_idx = -1;
    int oldest_idx = 0;
    uint32_t oldest_age = 0;

    for (int i = 0; i < TCPIP_ARP_TABLE_SIZE; i++) {
        if (arp_table[i].state != ARP_STATE_EMPTY &&
            ip4_addr_cmp(&arp_table[i].ip, ip) &&
            arp_table[i].netif == netif) {
            return i;
        }
        if (arp_table[i].state == ARP_STATE_EMPTY && empty_idx < 0) {
            empty_idx = i;
        } else if (arp_table[i].state != ARP_STATE_EMPTY) {
            uint32_t age = now_ms - arp_table[i].state_ts_ms;
            if (age >= oldest_age) {
                oldest_age = age;
                oldest_idx = i;
            }
        }
    }
    if (!create) return -1;
    if (empty_idx >= 0) return empty_idx;
    evict_entry(&arp_table[oldest_idx], now_ms);
    return oldest_idx;
}

static err_t arp_send_raw(struct netif *netif, uint16_t op,
                          const uint8_t dst_eth[6],
                          const uint8_t tha[6],
                          const ip4_addr_t *tpa) {
    if (!netif || !tpa) return ERR_ARG;
    struct pbuf *p = pbuf_alloc(PBUF_LINK, ARP_HDR_LEN, PBUF_POOL);
    if (!p) return ERR_MEM;
    uint8_t *a = p->payload;
    wr16be(a + 0, ARP_HWTYPE_ETH);
    wr16be(a + 2, ARP_PTYPE_IPV4);
    a[4] = 6U;
    a[5] = 4U;
    wr16be(a + 6, op);
    memcpy(a + 8, netif->hwaddr, 6);
    memcpy(a + 14, &netif->ip_addr.addr, 4);
    memcpy(a + 18, tha, 6);
    memcpy(a + 24, &tpa->addr, 4);
    err_t err = ethernet_output(netif, p, netif->hwaddr, dst_eth, ETHTYPE_ARP);
    pbuf_free(p);
    return err;
}

err_t etharp_request(struct netif *netif, const ip4_addr_t *ipaddr) {
    return arp_send_raw(netif, ARP_OP_REQUEST, eth_bcast, eth_zero, ipaddr);
}

err_t ethernet_output(struct netif *netif, struct pbuf *p,
                      const uint8_t src[6], const uint8_t dst[6], uint16_t ethertype) {
    if (!netif || !p || !netif->linkoutput) return ERR_ARG;
    if (pbuf_header(p, -(int16_t)SIZEOF_ETH_HDR) != 0) return ERR_BUF;
    uint8_t *eth = p->payload;
    memcpy(eth + 0, dst, 6);
    memcpy(eth + 6, src, 6);
    wr16be(eth + 12, ethertype);
    err_t err = netif->linkoutput(netif, p);
    pbuf_header(p, (int16_t)SIZEOF_ETH_HDR);
    return err;
}

void etharp_update_entry(struct netif *netif, const ip4_addr_t *ipaddr, const uint8_t mac[6]) {
    if (!netif || !ipaddr || !mac || ip4_addr_isany(ipaddr)) return;
    uint32_t now_ms = sys_now();
    int idx = find_or_alloc_entry(ipaddr, netif, now_ms, 1);
    if (idx < 0) return;
    arp_entry_t *e = &arp_table[idx];
    uint8_t was_pending = (e->state == ARP_STATE_PENDING);
#if TCPIP_VERIFY_FSM
    if (e->state == ARP_STATE_EMPTY) {
        arp_fsm_init(&e->fsm);
        arp_fsm_step(&e->fsm, (int64_t)now_ms, ARP_FSM_EV_RX_REQ_LEARN, NULL, 0, NULL, NULL, NULL);
    } else {
        arp_fsm_step(&e->fsm, (int64_t)now_ms, ARP_FSM_EV_RX_REPLY, NULL, 0, NULL, NULL, NULL);
    }
#endif
    e->ip = *ipaddr;
    e->netif = netif;
    memcpy(e->hwaddr, mac, 6);
    e->state = ARP_STATE_STABLE;
    e->retries = 0;
    e->state_ts_ms = now_ms;

    if (was_pending) {
        for (uint8_t k = 0; k < e->q_len && k < TCPIP_ARP_QUEUE_LEN; k++) {
            struct pbuf *qp = e->q[k];
            e->q[k] = NULL;
            if (qp) {
                ethernet_output(netif, qp, netif->hwaddr, e->hwaddr, ETHTYPE_IP);
                pbuf_free(qp);
            }
        }
        e->q_len = 0;
    }
}

int etharp_find_addr(struct netif *netif, const ip4_addr_t *ipaddr, uint8_t mac_out[6]) {
    if (!netif || !ipaddr || !mac_out) return -1;
    uint32_t now_ms = sys_now();
    int idx = find_or_alloc_entry(ipaddr, netif, now_ms, 0);
    if (idx < 0) return -1;
    if (arp_table[idx].state == ARP_STATE_STABLE || arp_table[idx].state == ARP_STATE_STALE) {
        memcpy(mac_out, arp_table[idx].hwaddr, 6);
        return idx;
    }
    return -1;
}

err_t etharp_query(struct netif *netif, const ip4_addr_t *ipaddr, struct pbuf *q) {
    if (!netif || !ipaddr || ip4_addr_isany(ipaddr)) return ERR_ARG;
    uint32_t now_ms = sys_now();
    int idx = find_or_alloc_entry(ipaddr, netif, now_ms, 1);
    if (idx < 0) return ERR_MEM;
    arp_entry_t *e = &arp_table[idx];

    if (e->state == ARP_STATE_STABLE || e->state == ARP_STATE_STALE) {
        if (q) {
            return ethernet_output(netif, q, netif->hwaddr, e->hwaddr, ETHTYPE_IP);
        }
        return ERR_OK;
    }

    int send_req = 0;
    if (e->state == ARP_STATE_EMPTY) {
        e->ip = *ipaddr;
        e->netif = netif;
        e->state = ARP_STATE_PENDING;
        e->retries = 1;
        e->state_ts_ms = now_ms;
        e->q_len = 0;
#if TCPIP_VERIFY_FSM
        arp_fsm_init(&e->fsm);
        arp_fsm_step(&e->fsm, (int64_t)now_ms, ARP_FSM_EV_LOOKUP_MISS, NULL, 0, NULL, NULL, NULL);
#endif
        send_req = 1;
    }

    /* Queue packet BEFORE emitting ARP request so synchronous/reentrant
     * ARP replies (common under NO_SYS=1) flush it cleanly. */
    if (q) {
#if TCPIP_VERIFY_FSM
        arp_fsm_step(&e->fsm, (int64_t)now_ms, ARP_FSM_EV_ENQUEUE, NULL, 0, NULL, NULL, NULL);
#endif
        struct pbuf *clone = pbuf_alloc(PBUF_LINK, q->tot_len, PBUF_POOL);
        if (!clone) return ERR_MEM;
        if (pbuf_copy(clone, q) != ERR_OK) {
            pbuf_free(clone);
            return ERR_BUF;
        }
        if (e->q_len < TCPIP_ARP_QUEUE_LEN) {
            e->q[e->q_len++] = clone;
        } else {
            pbuf_free(e->q[0]);
            for (int k = 1; k < TCPIP_ARP_QUEUE_LEN; k++) e->q[k - 1] = e->q[k];
            e->q[TCPIP_ARP_QUEUE_LEN - 1] = clone;
        }
    }
    if (send_req) {
        etharp_request(netif, ipaddr);
    }
    return ERR_OK;
}

err_t etharp_output(struct netif *netif, struct pbuf *q, const ip4_addr_t *ipaddr) {
    if (!netif || !q || !ipaddr) return ERR_ARG;
    if (ip4_addr_isbroadcast_u32(ipaddr->addr, &netif->ip_addr, &netif->netmask)) {
        return ethernet_output(netif, q, netif->hwaddr, eth_bcast, ETHTYPE_IP);
    }
    const ip4_addr_t *dst_ip = ipaddr;
    if (!ip4_addr_netcmp(dst_ip, &netif->ip_addr, &netif->netmask) && !ip4_addr_isany(&netif->gw)) {
        dst_ip = &netif->gw;
    }
    if (ip4_addr_cmp(dst_ip, &netif->ip_addr)) {
        return ethernet_output(netif, q, netif->hwaddr, netif->hwaddr, ETHTYPE_IP);
    }
    return etharp_query(netif, dst_ip, q);
}

static void etharp_input(struct pbuf *p, struct netif *netif) {
    if (!p || p->len < ARP_HDR_LEN || !netif) {
        if (p) pbuf_free(p);
        return;
    }
    const uint8_t *a = p->payload;
    uint16_t hwtype = rd16be(a + 0);
    uint16_t ptype  = rd16be(a + 2);
    uint8_t hlen = a[4], plen = a[5];
    uint16_t op = rd16be(a + 6);
    if (hwtype != ARP_HWTYPE_ETH || ptype != ARP_PTYPE_IPV4 || hlen != 6U || plen != 4U) {
        pbuf_free(p);
        return;
    }
    uint8_t sha[6];
    ip4_addr_t sip, tip;
    memcpy(sha, a + 8, 6);
    memcpy(&sip.addr, a + 14, 4);
    memcpy(&tip.addr, a + 24, 4);

    int for_us = (!ip4_addr_isany(&netif->ip_addr) && ip4_addr_cmp(&tip, &netif->ip_addr));
    etharp_update_entry(netif, &sip, sha);

    if (op == ARP_OP_REQUEST && for_us) {
        arp_send_raw(netif, ARP_OP_REPLY, sha, sha, &sip);
    }
    pbuf_free(p);
}

err_t ethernet_input(struct pbuf *p, struct netif *netif) {
    if (!p || !netif) {
        if (p) pbuf_free(p);
        return ERR_ARG;
    }
    if (p->len < SIZEOF_ETH_HDR) {
        pbuf_free(p);
        return ERR_BUF;
    }
    uint16_t etype = rd16be(p->payload + 12);
    if (pbuf_header(p, (int16_t)SIZEOF_ETH_HDR) != 0) {
        pbuf_free(p);
        return ERR_BUF;
    }
    if (etype == ETHTYPE_ARP) {
        etharp_input(p, netif);
        return ERR_OK;
    }
    if (etype == ETHTYPE_IP) {
        return ip4_input(p, netif);
    }
    pbuf_free(p);
    return ERR_OK;
}

void etharp_tmr(uint32_t now_ms) {
    for (int i = 0; i < TCPIP_ARP_TABLE_SIZE; i++) {
        arp_entry_t *e = &arp_table[i];
        if (e->state == ARP_STATE_EMPTY) continue;
        uint32_t elapsed = now_ms - e->state_ts_ms;
        if (e->state == ARP_STATE_PENDING) {
#if TCPIP_VERIFY_FSM
            arp_fsm_tick(&e->fsm, (int64_t)now_ms, NULL, NULL);
#endif
            if (elapsed >= ARP_RETRY_MS * e->retries) {
                if (e->retries >= 5U) {
                    evict_entry(e, now_ms);
                } else {
                    e->retries++;
                    if (e->netif) etharp_request(e->netif, &e->ip);
                }
            }
        } else if (e->state == ARP_STATE_STABLE) {
            if (elapsed >= ARP_AGE_STALE_MS) {
#if TCPIP_VERIFY_FSM
                arp_fsm_tick(&e->fsm, (int64_t)now_ms, NULL, NULL);
#endif
                e->state = ARP_STATE_STALE;
                if (e->netif) etharp_request(e->netif, &e->ip);
            }
        } else if (e->state == ARP_STATE_STALE) {
            if (elapsed >= ARP_AGE_EXPIRE_MS) {
#if TCPIP_VERIFY_FSM
                arp_fsm_tick(&e->fsm, (int64_t)now_ms, NULL, NULL);
#endif
                evict_entry(e, now_ms);
            }
        }
    }
}
