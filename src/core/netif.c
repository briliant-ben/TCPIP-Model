#include <stdio.h>
#include <string.h>
#include "tcpip/netif.h"

static struct netif *netif_list = NULL;
static struct netif *netif_default = NULL;
static uint8_t netif_num_seq = 0;

static int mask_prefix_len(uint32_t mask_net_order) {
    uint32_t m = tcpip_ntohl(mask_net_order);
    int bits = 0;
    while (m) {
        bits += (int)(m & 1U);
        m >>= 1;
    }
    return bits;
}

void netif_reset_all(void) {
    netif_list = NULL;
    netif_default = NULL;
    netif_num_seq = 0;
}

struct netif *netif_list_head(void) {
    return netif_list;
}

struct netif *netif_add(struct netif *netif,
                        const ip4_addr_t *ipaddr,
                        const ip4_addr_t *netmask,
                        const ip4_addr_t *gw,
                        void *state,
                        netif_init_fn init,
                        netif_input_fn input) {
    if (!netif) return NULL;
    memset(netif, 0, sizeof(*netif));
    if (ipaddr) netif->ip_addr = *ipaddr;
    if (netmask) netif->netmask = *netmask;
    if (gw) netif->gw = *gw;
    netif->state = state;
    netif->input = input;
    netif->mtu = 1500U;
    netif->num = netif_num_seq++;
    if (init && init(netif) != ERR_OK) {
        return NULL;
    }
    netif->next = netif_list;
    netif_list = netif;
    if (!netif_default) netif_default = netif;
    return netif;
}

void netif_remove(struct netif *netif) {
    if (!netif) return;
    struct netif **pp = &netif_list;
    while (*pp) {
        if (*pp == netif) {
            *pp = netif->next;
            netif->next = NULL;
            break;
        }
        pp = &(*pp)->next;
    }
    if (netif_default == netif) {
        netif_default = netif_list;
    }
}

void netif_set_default(struct netif *netif) {
    netif_default = netif;
}

struct netif *netif_get_default(void) {
    return netif_default;
}

void netif_set_up(struct netif *netif) {
    if (netif) netif->flags |= NETIF_FLAG_UP;
}

void netif_set_down(struct netif *netif) {
    if (netif) netif->flags = (uint8_t)(netif->flags & (uint8_t)~NETIF_FLAG_UP);
}

void netif_set_link_up(struct netif *netif) {
    if (netif) netif->flags |= NETIF_FLAG_LINK_UP;
}

void netif_set_link_down(struct netif *netif) {
    if (netif) netif->flags = (uint8_t)(netif->flags & (uint8_t)~NETIF_FLAG_LINK_UP);
}

void netif_set_addr(struct netif *netif,
                    const ip4_addr_t *ipaddr,
                    const ip4_addr_t *netmask,
                    const ip4_addr_t *gw) {
    if (!netif) return;
    if (ipaddr) netif->ip_addr = *ipaddr;
    if (netmask) netif->netmask = *netmask;
    if (gw) netif->gw = *gw;
}

struct netif *netif_find(const char *name) {
    if (!name || !name[0] || !name[1]) return NULL;
    int target_num = -1;
    if (name[2] >= '0' && name[2] <= '9') {
        target_num = name[2] - '0';
    }
    for (struct netif *n = netif_list; n != NULL; n = n->next) {
        if (n->name[0] == name[0] && n->name[1] == name[1] &&
            (target_num < 0 || n->num == (uint8_t)target_num)) {
            return n;
        }
    }
    return NULL;
}

struct netif *netif_route(const ip4_addr_t *dest) {
    if (!dest) return netif_default;
    struct netif *best = NULL;
    int best_prefix = -1;

    /* 1. Exact local interface IP match wins first */
    for (struct netif *n = netif_list; n != NULL; n = n->next) {
        if (!netif_is_up(n) || !netif_is_link_up(n)) continue;
        if (!ip4_addr_isany(&n->ip_addr) && ip4_addr_cmp(dest, &n->ip_addr)) {
            return n;
        }
    }
    /* 2. Longest-prefix subnet match */
    for (struct netif *n = netif_list; n != NULL; n = n->next) {
        if (!netif_is_up(n) || !netif_is_link_up(n)) continue;
        if (n->netmask.addr != 0U && ip4_addr_netcmp(dest, &n->ip_addr, &n->netmask)) {
            int pfx = mask_prefix_len(n->netmask.addr);
            if (pfx > best_prefix) {
                best_prefix = pfx;
                best = n;
            }
        }
    }
    if (best) return best;
    if (netif_default && netif_is_up(netif_default)) return netif_default;
    return netif_list;
}

int ip4addr_aton(const char *cp, ip4_addr_t *addr) {
    if (!cp || !addr) return 0;
    uint32_t parts[4] = {0, 0, 0, 0};
    int idx = 0;
    const char *p = cp;
    while (*p) {
        if (*p < '0' || *p > '9') return 0;
        uint32_t val = 0;
        while (*p >= '0' && *p <= '9') {
            val = val * 10U + (uint32_t)(*p - '0');
            if (val > 255U) return 0;
            p++;
        }
        if (idx >= 4) return 0;
        parts[idx++] = val;
        if (*p == '.') {
            p++;
            if (!*p) return 0;
        } else if (*p != '\0') {
            return 0;
        }
    }
    if (idx != 4) return 0;
    *addr = ip4_addr_make((uint8_t)parts[0], (uint8_t)parts[1], (uint8_t)parts[2], (uint8_t)parts[3]);
    return 1;
}

char *ip4addr_ntoa_r(const ip4_addr_t *addr, char *buf, int buflen) {
    if (!addr || !buf || buflen < 16) return NULL;
    snprintf(buf, (size_t)buflen, "%u.%u.%u.%u",
             (unsigned)ip4_addr_byte(addr, 0),
             (unsigned)ip4_addr_byte(addr, 1),
             (unsigned)ip4_addr_byte(addr, 2),
             (unsigned)ip4_addr_byte(addr, 3));
    return buf;
}
