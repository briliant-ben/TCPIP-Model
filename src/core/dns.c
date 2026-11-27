#include <string.h>
#include "tcpip/dns.h"
#include "tcpip/opt.h"
#include "tcpip/pbuf.h"
#include "tcpip/sys.h"
#include "tcpip/udp.h"

#define DNS_MAX_SERVERS 2
#define DNS_QUERY_RETRY_MS 500U

typedef struct {
    int valid;
    char name[128];
    ip4_addr_t ip;
    uint32_t expires_ms;
} dns_cache_entry_t;

typedef struct {
    int active;
    uint16_t txid;
    char name[128];
    dns_found_callback cb;
    void *arg;
    uint32_t sent_ms;
    uint8_t retries;
#if TCPIP_VERIFY_FSM
    dns_fsm_machine_t fsm;
#endif
} dns_pending_t;

static ip4_addr_t dns_servers[DNS_MAX_SERVERS];
static dns_cache_entry_t dns_cache[TCPIP_DNS_CACHE_SIZE];
static dns_pending_t dns_pending[4];
static struct udp_pcb *dns_pcb = NULL;
static uint16_t dns_txid_seq = 0x1100U;

static inline uint16_t rd16be(const uint8_t *p) {
    return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}
static inline uint32_t rd32be(const uint8_t *p) {
    return ((uint32_t)p[0] << 24) | ((uint32_t)p[1] << 16) |
           ((uint32_t)p[2] << 8) | (uint32_t)p[3];
}
static inline void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}

static uint16_t dns_skip_name(const uint8_t *msg, uint16_t len, uint16_t off) {
    int hops = 0;
    while (off < len && hops++ < 64) {
        uint8_t b = msg[off];
        if (b == 0U) return (uint16_t)(off + 1U);
        if ((b & 0xC0U) == 0xC0U) {
            return (off + 2U <= len) ? (uint16_t)(off + 2U) : len;
        }
        off = (uint16_t)(off + 1U + b);
    }
    return len;
}

static uint16_t dns_encode_qname(uint8_t *dst, uint16_t cap, const char *name) {
    uint16_t out = 0U;
    const char *p = name;
    while (*p != '\0') {
        const char *dot = strchr(p, '.');
        size_t llen = dot ? (size_t)(dot - p) : strlen(p);
        if (llen == 0U || llen > 63U || out + 1U + llen >= cap) return 0U;
        dst[out++] = (uint8_t)llen;
        memcpy(dst + out, p, llen);
        out = (uint16_t)(out + llen);
        if (!dot) break;
        p = dot + 1;
    }
    if (out >= cap) return 0U;
    dst[out++] = 0U;
    return out;
}

static void dns_cache_insert(const char *name, const ip4_addr_t *ip, uint32_t ttl_s, uint32_t now_ms) {
    int slot = -1;
    for (int i = 0; i < TCPIP_DNS_CACHE_SIZE; i++) {
        if (dns_cache[i].valid && strcmp(dns_cache[i].name, name) == 0) {
            slot = i;
            break;
        }
        if (!dns_cache[i].valid && slot < 0) slot = i;
    }
    if (slot < 0) slot = 0;
    dns_cache[slot].valid = 1;
    strncpy(dns_cache[slot].name, name, sizeof(dns_cache[slot].name) - 1U);
    dns_cache[slot].name[sizeof(dns_cache[slot].name) - 1U] = '\0';
    dns_cache[slot].ip = *ip;
    dns_cache[slot].expires_ms = now_ms + (ttl_s > 0U ? ttl_s * 1000U : 60000U);
}

static err_t dns_send_query(dns_pending_t *q) {
    if (!dns_pcb || ip4_addr_isany(&dns_servers[0])) return ERR_RTE;
    uint8_t buf[256];
    memset(buf, 0, sizeof(buf));
    wr16be(buf + 0, q->txid);
    wr16be(buf + 2, 0x0100U); /* RD=1 standard query */
    wr16be(buf + 4, 1U);      /* QDCOUNT = 1 */

    uint16_t qn = dns_encode_qname(buf + 12U, (uint16_t)(sizeof(buf) - 16U), q->name);
    if (qn == 0U) return ERR_ARG;
    uint16_t off = (uint16_t)(12U + qn);
    wr16be(buf + off, 1U);     /* QTYPE = A */
    wr16be(buf + off + 2U, 1U);/* QCLASS = IN */
    off = (uint16_t)(off + 4U);

    struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, off, PBUF_POOL);
    if (!p) return ERR_MEM;
    pbuf_take(p, buf, off);
    err_t err = udp_sendto(dns_pcb, p, &dns_servers[0], DNS_SERVER_PORT);
    pbuf_free(p);
    return err;
}

static void dns_recv_cb(void *arg, struct udp_pcb *upcb, struct pbuf *p,
                        const ip4_addr_t *addr, uint16_t port) {
    (void)arg; (void)upcb; (void)addr; (void)port;
    if (!p || p->tot_len < 12U) {
        if (p) pbuf_free(p);
        return;
    }
    uint8_t msg[512];
    uint16_t n = p->tot_len < sizeof(msg) ? p->tot_len : (uint16_t)sizeof(msg);
    pbuf_copy_partial(p, msg, n, 0U);
    pbuf_free(p);

    uint16_t txid = rd16be(msg + 0);
    uint16_t flags = rd16be(msg + 2);
    uint16_t qd = rd16be(msg + 4);
    uint16_t an = rd16be(msg + 6);
    if ((flags & 0x8000U) == 0U) return;

    dns_pending_t *match = NULL;
    for (int i = 0; i < 4; i++) {
        if (dns_pending[i].active && dns_pending[i].txid == txid) {
            match = &dns_pending[i];
            break;
        }
    }
    if (!match) return;

    uint16_t off = 12U;
    for (uint16_t i = 0; i < qd && off < n; i++) {
        off = dns_skip_name(msg, n, off);
        if (off + 4U > n) { off = n; break; }
        off = (uint16_t)(off + 4U);
    }

    ip4_addr_t found_ip = {0};
    uint32_t ttl_s = 60U;
    int ok = 0;
    for (uint16_t i = 0; i < an && off < n; i++) {
        off = dns_skip_name(msg, n, off);
        if (off + 10U > n) break;
        uint16_t rtype = rd16be(msg + off);
        uint16_t rclass = rd16be(msg + off + 2U);
        ttl_s = rd32be(msg + off + 4U);
        uint16_t rdlen = rd16be(msg + off + 8U);
        off = (uint16_t)(off + 10U);
        if (off + rdlen > n) break;
        if (rtype == 1U && rclass == 1U && rdlen == 4U) {
            memcpy(&found_ip.addr, msg + off, 4U);
            ok = 1;
            break;
        }
        off = (uint16_t)(off + rdlen);
    }

    uint32_t now_ms = sys_now();
    char name_copy[128];
    strncpy(name_copy, match->name, sizeof(name_copy) - 1U);
    name_copy[sizeof(name_copy) - 1U] = '\0';
    dns_found_callback cb = match->cb;
    void *cb_arg = match->arg;

    if (ok) {
        dns_cache_insert(name_copy, &found_ip, ttl_s, now_ms);
#if TCPIP_VERIFY_FSM
        (void)dns_fsm_step(&match->fsm, (int64_t)now_ms, DNS_FSM_EV_RX_ANSWER, NULL, 0, NULL, NULL, NULL);
#endif
        match->active = 0;
        if (cb) cb(name_copy, &found_ip, cb_arg);
    } else {
        match->active = 0;
        if (cb) cb(name_copy, NULL, cb_arg);
    }
}

void dns_init(void) {
    dns_reset();
    dns_pcb = udp_new();
    if (dns_pcb) {
        ip4_addr_t any = {0};
        if (udp_bind(dns_pcb, &any, 0U) == ERR_OK) {
            udp_recv(dns_pcb, dns_recv_cb, NULL);
        } else {
            udp_remove(dns_pcb);
            dns_pcb = NULL;
        }
    }
}

void dns_reset(void) {
    if (dns_pcb) {
        udp_remove(dns_pcb);
        dns_pcb = NULL;
    }
    memset(dns_servers, 0, sizeof(dns_servers));
    memset(dns_cache, 0, sizeof(dns_cache));
    memset(dns_pending, 0, sizeof(dns_pending));
}

void dns_setserver(uint8_t numdns, const ip4_addr_t *dnsserver) {
    if (numdns < DNS_MAX_SERVERS) {
        dns_servers[numdns].addr = dnsserver ? dnsserver->addr : 0U;
    }
}

ip4_addr_t dns_getserver(uint8_t numdns) {
    ip4_addr_t z = {0};
    return (numdns < DNS_MAX_SERVERS) ? dns_servers[numdns] : z;
}

err_t dns_gethostbyname(const char *hostname, ip4_addr_t *addr,
                        dns_found_callback found, void *callback_arg) {
    if (!hostname || !addr || strlen(hostname) >= 127U) return ERR_ARG;
    if (ip4addr_aton(hostname, addr)) {
        return ERR_OK;
    }
    uint32_t now_ms = sys_now();
    for (int i = 0; i < TCPIP_DNS_CACHE_SIZE; i++) {
        if (dns_cache[i].valid && strcmp(dns_cache[i].name, hostname) == 0 &&
            (int32_t)(dns_cache[i].expires_ms - now_ms) > 0) {
            *addr = dns_cache[i].ip;
            return ERR_OK;
        }
    }
    if (!dns_pcb) dns_init();
    for (int i = 0; i < 4; i++) {
        if (!dns_pending[i].active) {
            memset(&dns_pending[i], 0, sizeof(dns_pending[i]));
            dns_pending[i].active = 1;
            dns_pending[i].txid = dns_txid_seq++;
            strncpy(dns_pending[i].name, hostname, sizeof(dns_pending[i].name) - 1U);
            dns_pending[i].cb = found;
            dns_pending[i].arg = callback_arg;
            dns_pending[i].sent_ms = now_ms;
            dns_pending[i].retries = 0U;
#if TCPIP_VERIFY_FSM
            dns_fsm_init(&dns_pending[i].fsm);
            (void)dns_fsm_step(&dns_pending[i].fsm, (int64_t)now_ms, DNS_FSM_EV_RESOLVE, NULL, 0, NULL, NULL, NULL);
#endif
            err_t err = dns_send_query(&dns_pending[i]);
            if (err != ERR_OK) {
                dns_pending[i].active = 0;
                return err;
            }
            return ERR_INPROGRESS;
        }
    }
    return ERR_MEM;
}

void dns_tmr(uint32_t now_ms) {
    for (int i = 0; i < 4; i++) {
        dns_pending_t *q = &dns_pending[i];
        if (!q->active) continue;
        if ((uint32_t)(now_ms - q->sent_ms) >= DNS_QUERY_RETRY_MS) {
            if (q->retries >= 3U) {
#if TCPIP_VERIFY_FSM
                dns_fsm_tick(&q->fsm, (int64_t)now_ms, NULL, NULL);
#endif
                dns_found_callback cb = q->cb;
                void *arg = q->arg;
                char nm[128];
                strncpy(nm, q->name, sizeof(nm) - 1U);
                nm[sizeof(nm) - 1U] = '\0';
                q->active = 0;
                if (cb) cb(nm, NULL, arg);
            } else {
                q->retries++;
                q->sent_ms = now_ms;
#if TCPIP_VERIFY_FSM
                dns_fsm_tick(&q->fsm, (int64_t)now_ms, NULL, NULL);
#endif
                (void)dns_send_query(q);
            }
        }
    }
}
