#ifndef TCPIP_IP4_H
#define TCPIP_IP4_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/ip4_addr.h"
#include "tcpip/netif.h"
#include "tcpip/pbuf.h"

#define IP_PROTO_ICMP 1U
#define IP_PROTO_TCP  6U
#define IP_PROTO_UDP  17U

#define IP_HLEN_MIN   20U
#define IP_DF         0x4000U
#define IP_MF         0x2000U
#define IP_OFFMASK    0x1FFFU

typedef struct {
    ip4_addr_t src;
    ip4_addr_t dst;
    uint8_t ttl;
    uint8_t tos;
    uint8_t proto;
    uint16_t id;
    uint16_t hdr_len;
    uint16_t tot_len;
    const ip4_addr_t *src_ip;
    const ip4_addr_t *dst_ip;
} ip4_rx_info_t;

typedef void (*ip4_l4_input_fn)(struct pbuf *p, struct netif *inp, const ip4_addr_t *src, const ip4_addr_t *dst);

void ip4_register_udp_input(ip4_l4_input_fn fn);
void ip4_register_tcp_input(ip4_l4_input_fn fn);

err_t ip4_input(struct pbuf *p, struct netif *inp);
err_t ip4_output(struct pbuf *p, const ip4_addr_t *src, const ip4_addr_t *dst,
                 uint8_t ttl, uint8_t tos, uint8_t proto);
err_t ip4_output_if(struct pbuf *p, const ip4_addr_t *src, const ip4_addr_t *dst,
                    uint8_t ttl, uint8_t tos, uint8_t proto, struct netif *netif);
err_t ip4_frag(struct pbuf *p, struct netif *netif, const ip4_addr_t *dest);
struct pbuf *ip4_reass(struct pbuf *p, uint32_t now_ms);
void ip4_reass_tmr(uint32_t now_ms);
void ip4_reass_reset(void);

#endif /* TCPIP_IP4_H */
