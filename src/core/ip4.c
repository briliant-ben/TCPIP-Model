#include <string.h>
#include "tcpip/etharp.h"
#include "tcpip/icmp.h"
#include "tcpip/inet_chksum.h"
#include "tcpip/ip4.h"

static ip4_l4_input_fn udp_rx_hook = NULL;
static ip4_l4_input_fn tcp_rx_hook = NULL;
static uint16_t ip_id_seq = 1;

void ip4_register_udp_input(ip4_l4_input_fn fn) {
    udp_rx_hook = fn;
}

void ip4_register_tcp_input(ip4_l4_input_fn fn) {
    tcp_rx_hook = fn;
}

static inline uint16_t rd16be(const uint8_t *p) {
    return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}

static inline void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}

err_t ip4_input(struct pbuf *p, struct netif *inp) {
    if (!p || !inp) {
        if (p) pbuf_free(p);
        return ERR_ARG;
    }
    if (p->len < IP_HLEN_MIN) {
        pbuf_free(p);
        return ERR_BUF;
    }
    const uint8_t *hdr = p->payload;
    uint8_t ver_ihl = hdr[0];
    if ((ver_ihl >> 4) != 4U) {
        pbuf_free(p);
        return ERR_VAL;
    }
    uint16_t hlen = (uint16_t)((ver_ihl & 0x0FU) * 4U);
    uint16_t tot_len = rd16be(hdr + 2);
    if (hlen < IP_HLEN_MIN || hlen > tot_len || tot_len > p->tot_len) {
        pbuf_free(p);
        return ERR_BUF;
    }
    if (inet_chksum(hdr, hlen) != 0U) {
        pbuf_free(p);
        return ERR_VAL;
    }
    if (tot_len < p->tot_len) {
        pbuf_realloc(p, tot_len);
    }

    ip4_addr_t src, dst;
    memcpy(&src.addr, hdr + 12, 4);
    memcpy(&dst.addr, hdr + 16, 4);

    /* Accept exact netif match, broadcast, or DHCP 0.0.0.0 bootstrap */
    int accept = ip4_addr_isbroadcast_u32(dst.addr, &inp->ip_addr, &inp->netmask) ||
                 (!ip4_addr_isany(&inp->ip_addr) && ip4_addr_cmp(&dst, &inp->ip_addr)) ||
                 ip4_addr_isany(&inp->ip_addr);
    if (!accept) {
        for (struct netif *n = netif_list_head(); n != NULL; n = n->next) {
            if (netif_is_up(n) && ip4_addr_cmp(&dst, &n->ip_addr)) {
                accept = 1;
                break;
            }
        }
    }
    if (!accept) {
        pbuf_free(p);
        return ERR_OK;
    }

    uint16_t frag_off = rd16be(hdr + 6);
    if ((frag_off & (IP_MF | IP_OFFMASK)) != 0U) {
        extern uint32_t sys_now(void);
        p = ip4_reass(p, sys_now());
        if (!p) return ERR_OK;
        hdr = p->payload;
        hlen = (uint16_t)((hdr[0] & 0x0FU) * 4U);
        memcpy(&src.addr, hdr + 12, 4);
        memcpy(&dst.addr, hdr + 16, 4);
    }

    uint8_t proto = hdr[9];
    if (pbuf_header(p, (int16_t)hlen) != 0) {
        pbuf_free(p);
        return ERR_BUF;
    }

    switch (proto) {
        case IP_PROTO_ICMP:
            icmp_input(p, inp, &src, &dst);
            break;
        case IP_PROTO_UDP:
            if (udp_rx_hook) {
                udp_rx_hook(p, inp, &src, &dst);
            } else {
                pbuf_header(p, -(int16_t)hlen);
                icmp_dest_unreach(p, ICMP_DUR_PORT);
                pbuf_free(p);
            }
            break;
        case IP_PROTO_TCP:
            if (tcp_rx_hook) {
                tcp_rx_hook(p, inp, &src, &dst);
            } else {
                pbuf_free(p);
            }
            break;
        default:
            pbuf_free(p);
            break;
    }
    return ERR_OK;
}

err_t ip4_output_if(struct pbuf *p, const ip4_addr_t *src, const ip4_addr_t *dst,
                    uint8_t ttl, uint8_t tos, uint8_t proto, struct netif *netif) {
    if (!p || !dst || !netif) return ERR_ARG;
    if (pbuf_header(p, -(int16_t)IP_HLEN_MIN) != 0) return ERR_BUF;

    ip4_addr_t chosen_src = src ? *src : netif->ip_addr;
    uint8_t *hdr = p->payload;
    hdr[0] = 0x45U;
    hdr[1] = tos;
    wr16be(hdr + 2, p->tot_len);
    wr16be(hdr + 4, ip_id_seq++);
    wr16be(hdr + 6, 0U);
    hdr[8] = ttl ? ttl : 64U;
    hdr[9] = proto;
    hdr[10] = 0;
    hdr[11] = 0;
    memcpy(hdr + 12, &chosen_src.addr, 4);
    memcpy(hdr + 16, &dst->addr, 4);
    wr16be(hdr + 10, inet_chksum(hdr, IP_HLEN_MIN));

    err_t err;
    if (netif->mtu > 0 && p->tot_len > netif->mtu) {
        err = ip4_frag(p, netif, dst);
    } else if (netif->output) {
        err = netif->output(netif, p, dst);
    } else {
        err = ERR_IF;
    }
    pbuf_header(p, (int16_t)IP_HLEN_MIN);
    return err;
}

err_t ip4_output(struct pbuf *p, const ip4_addr_t *src, const ip4_addr_t *dst,
                 uint8_t ttl, uint8_t tos, uint8_t proto) {
    struct netif *netif = netif_route(dst);
    if (!netif) return ERR_RTE;
    return ip4_output_if(p, src, dst, ttl, tos, proto, netif);
}
