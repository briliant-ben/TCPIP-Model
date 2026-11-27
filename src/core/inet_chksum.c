#include <stddef.h>
#include "tcpip/inet_chksum.h"

/* Sum network-order 16-bit big-endian words into a 32-bit host accumulator
 * without unaligned casts or endianness UB. */
static uint32_t sum_bytes_be(const uint8_t *p, uint16_t len) {
    uint32_t sum = 0;
    uint16_t i = 0;
#if TCPIP_CHECKSUM_FAST
    while ((uint16_t)(i + 8U) <= len) {
        sum += ((uint32_t)p[i] << 8) | p[i + 1U];
        sum += ((uint32_t)p[i + 2U] << 8) | p[i + 3U];
        sum += ((uint32_t)p[i + 4U] << 8) | p[i + 5U];
        sum += ((uint32_t)p[i + 6U] << 8) | p[i + 7U];
        i = (uint16_t)(i + 8U);
    }
#endif
    while ((uint16_t)(i + 2U) <= len) {
        sum += ((uint32_t)p[i] << 8) | p[i + 1U];
        i = (uint16_t)(i + 2U);
    }
    if (i < len) {
        sum += ((uint32_t)p[i] << 8);
    }
    return sum;
}

static uint16_t fold_sum(uint32_t sum) {
    while (sum >> 16) {
        sum = (sum & 0xFFFFUL) + (sum >> 16);
    }
    return (uint16_t)(~sum & 0xFFFFU);
}

static uint32_t sum_pbuf_be(const struct pbuf *p) {
    uint32_t acc = 0;
    int odd = 0;
    for (const struct pbuf *q = p; q != NULL; q = q->next) {
        if (!q->len) continue;
        const uint8_t *d = q->payload;
        uint16_t rem = q->len;
        if (odd) {
            acc += (uint32_t)d[0];
            d++;
            rem--;
            odd = 0;
        }
        uint32_t seg = sum_bytes_be(d, rem);
        if (rem & 1U) odd = 1;
        acc += seg;
        acc = (acc & 0xFFFFUL) + (acc >> 16);
    }
    return acc;
}

uint16_t inet_chksum(const void *dataptr, uint16_t len) {
    if (!dataptr || !len) return 0xFFFFU;
    return fold_sum(sum_bytes_be((const uint8_t *)dataptr, len));
}

uint16_t inet_chksum_pbuf(const struct pbuf *p) {
    return fold_sum(sum_pbuf_be(p));
}

uint16_t inet_chksum_pseudo(const struct pbuf *p, uint8_t proto, uint16_t proto_len,
                            const ip4_addr_t *src, const ip4_addr_t *dst) {
    uint32_t acc = sum_pbuf_be(p);
    if (src) {
        const uint8_t *s = (const uint8_t *)&src->addr;
        acc += ((uint32_t)s[0] << 8) | s[1];
        acc += ((uint32_t)s[2] << 8) | s[3];
    }
    if (dst) {
        const uint8_t *d = (const uint8_t *)&dst->addr;
        acc += ((uint32_t)d[0] << 8) | d[1];
        acc += ((uint32_t)d[2] << 8) | d[3];
    }
    acc += (uint32_t)proto;
    acc += (uint32_t)proto_len;
    return fold_sum(acc);
}
