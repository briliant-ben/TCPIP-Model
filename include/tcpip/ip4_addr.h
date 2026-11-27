#ifndef TCPIP_IP4_ADDR_H
#define TCPIP_IP4_ADDR_H

#include <stdint.h>

/* IPv4 address stored in network byte order (big-endian 32-bit word). */
typedef struct {
    uint32_t addr;
} ip4_addr_t;

static inline uint16_t tcpip_htons(uint16_t v) {
    return (uint16_t)(((v & 0x00FFU) << 8) | ((v & 0xFF00U) >> 8));
}

static inline uint16_t tcpip_ntohs(uint16_t v) {
    return tcpip_htons(v);
}

static inline uint32_t tcpip_htonl(uint32_t v) {
    return ((v & 0x000000FFUL) << 24) |
           ((v & 0x0000FF00UL) << 8) |
           ((v & 0x00FF0000UL) >> 8) |
           ((v & 0xFF000000UL) >> 24);
}

static inline uint32_t tcpip_ntohl(uint32_t v) {
    return tcpip_htonl(v);
}

static inline ip4_addr_t ip4_addr_make(uint8_t a, uint8_t b, uint8_t c, uint8_t d) {
    ip4_addr_t out;
    uint8_t *bytes = (uint8_t *)&out.addr;
    bytes[0] = a;
    bytes[1] = b;
    bytes[2] = c;
    bytes[3] = d;
    return out;
}

#define IP4_ADDR(ip, a, b, c, d) (*(ip) = ip4_addr_make((uint8_t)(a), (uint8_t)(b), (uint8_t)(c), (uint8_t)(d)))

static inline uint32_t ip4_addr_get_u32(const ip4_addr_t *ip) {
    return ip ? ip->addr : 0U;
}

static inline void ip4_addr_set_u32(ip4_addr_t *ip, uint32_t v) {
    if (ip) ip->addr = v;
}

static inline int ip4_addr_cmp(const ip4_addr_t *a, const ip4_addr_t *b) {
    return a && b && a->addr == b->addr;
}

static inline int ip4_addr_netcmp(const ip4_addr_t *a, const ip4_addr_t *b, const ip4_addr_t *mask) {
    return a && b && mask && ((a->addr & mask->addr) == (b->addr & mask->addr));
}

static inline int ip4_addr_isany(const ip4_addr_t *ip) {
    return !ip || ip->addr == 0U;
}

static inline int ip4_addr_isbroadcast_u32(uint32_t addr, const ip4_addr_t *net_ip, const ip4_addr_t *mask) {
    if (addr == 0xFFFFFFFFUL) return 1;
    if (!net_ip || !mask || mask->addr == 0U || mask->addr == 0xFFFFFFFFUL) return 0;
    return (addr & mask->addr) == (net_ip->addr & mask->addr) &&
           (addr | mask->addr) == 0xFFFFFFFFUL;
}

static inline uint8_t ip4_addr_byte(const ip4_addr_t *ip, int idx) {
    const uint8_t *b = (const uint8_t *)&ip->addr;
    return b[idx & 3];
}

int ip4addr_aton(const char *cp, ip4_addr_t *addr);
char *ip4addr_ntoa_r(const ip4_addr_t *addr, char *buf, int buflen);

#endif /* TCPIP_IP4_ADDR_H */
