#include <string.h>
#include "tcpip/icmp.h"
#include "tcpip/inet_chksum.h"
#include "tcpip/ip4.h"

static icmp_echo_reply_fn echo_reply_cb = NULL;
static void *echo_reply_ctx = NULL;

static inline uint16_t rd16be(const uint8_t *p) {
    return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}

static inline void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}

void icmp_set_echo_reply_cb(icmp_echo_reply_fn cb, void *ctx) {
    echo_reply_cb = cb;
    echo_reply_ctx = ctx;
}

void icmp_input(struct pbuf *p, struct netif *inp, const ip4_addr_t *src, const ip4_addr_t *dst) {
    if (!p || !inp || !src || !dst || p->tot_len < 4U || p->len < 4U) {
        if (p) pbuf_free(p);
        return;
    }
    if (inet_chksum_pbuf(p) != 0U) {
        pbuf_free(p);
        return;
    }
    uint8_t type = p->payload[0];
    if (type == ICMP_ECHO && p->tot_len >= 8U) {
        struct pbuf *r = pbuf_alloc(PBUF_IP, p->tot_len, PBUF_POOL);
        if (r && pbuf_copy(r, p) == ERR_OK) {
            r->payload[0] = ICMP_ER;
            r->payload[1] = 0;
            wr16be(r->payload + 2, 0U);
            wr16be(r->payload + 2, inet_chksum_pbuf(r));
            const ip4_addr_t *reply_src = ip4_addr_cmp(dst, &inp->ip_addr) ? dst : &inp->ip_addr;
            ip4_output_if(r, reply_src, src, 64U, 0U, IP_PROTO_ICMP, inp);
        }
        if (r) pbuf_free(r);
    } else if (type == ICMP_ER && p->tot_len >= 8U && echo_reply_cb) {
        uint16_t id = rd16be(p->payload + 4);
        uint16_t seq = rd16be(p->payload + 6);
        echo_reply_cb(echo_reply_ctx, src, id, seq, (uint16_t)(p->tot_len - 8U));
    }
    pbuf_free(p);
}

static void send_icmp_error(struct pbuf *orig_ip, uint8_t type, uint8_t code) {
    if (!orig_ip || orig_ip->len < IP_HLEN_MIN) return;
    uint16_t hlen = (uint16_t)((orig_ip->payload[0] & 0x0FU) * 4U);
    if (hlen < IP_HLEN_MIN || orig_ip->tot_len < hlen) return;
    uint16_t copy_len = (uint16_t)(hlen + 8U);
    if (copy_len > orig_ip->tot_len) copy_len = orig_ip->tot_len;

    ip4_addr_t dst;
    memcpy(&dst.addr, orig_ip->payload + 12, 4);
    if (ip4_addr_isany(&dst)) return;

    struct pbuf *q = pbuf_alloc(PBUF_IP, (uint16_t)(8U + copy_len), PBUF_POOL);
    if (!q) return;
    memset(q->payload, 0, 8U);
    q->payload[0] = type;
    q->payload[1] = code;
    pbuf_copy_partial(orig_ip, q->payload + 8U, copy_len, 0);
    wr16be(q->payload + 2, inet_chksum_pbuf(q));
    ip4_output(q, NULL, &dst, 64U, 0U, IP_PROTO_ICMP);
    pbuf_free(q);
}

void icmp_dest_unreach(struct pbuf *p, uint8_t code) {
    send_icmp_error(p, ICMP_DUR, code);
}

void icmp_time_exceeded(struct pbuf *p, uint8_t code) {
    send_icmp_error(p, ICMP_TE, code);
}

err_t icmp_send_echo(const ip4_addr_t *dst, uint16_t id, uint16_t seq, const uint8_t *payload, uint16_t len) {
    if (!dst) return ERR_ARG;
    struct pbuf *p = pbuf_alloc(PBUF_IP, (uint16_t)(8U + len), PBUF_POOL);
    if (!p) return ERR_MEM;
    p->payload[0] = ICMP_ECHO;
    p->payload[1] = 0;
    wr16be(p->payload + 2, 0U);
    wr16be(p->payload + 4, id);
    wr16be(p->payload + 6, seq);
    if (len && payload && pbuf_take_at(p, payload, len, 8U) != ERR_OK) {
        pbuf_free(p);
        return ERR_BUF;
    }
    wr16be(p->payload + 2, inet_chksum_pbuf(p));
    err_t err = ip4_output(p, NULL, dst, 64U, 0U, IP_PROTO_ICMP);
    pbuf_free(p);
    return err;
}
