#ifndef TCPIP_ETHARP_H
#define TCPIP_ETHARP_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/netif.h"
#include "tcpip/pbuf.h"

#define ETHTYPE_IP  0x0800U
#define ETHTYPE_ARP 0x0806U
#define SIZEOF_ETH_HDR 14U

err_t ethernet_input(struct pbuf *p, struct netif *netif);
err_t ethernet_output(struct netif *netif, struct pbuf *p,
                      const uint8_t src[6], const uint8_t dst[6], uint16_t ethertype);

err_t etharp_output(struct netif *netif, struct pbuf *q, const ip4_addr_t *ipaddr);
err_t etharp_query(struct netif *netif, const ip4_addr_t *ipaddr, struct pbuf *q);
err_t etharp_request(struct netif *netif, const ip4_addr_t *ipaddr);
int etharp_find_addr(struct netif *netif, const ip4_addr_t *ipaddr, uint8_t mac_out[6]);
void etharp_tmr(uint32_t now_ms);
void etharp_reset(void);
void etharp_update_entry(struct netif *netif, const ip4_addr_t *ipaddr, const uint8_t mac[6]);

#endif /* TCPIP_ETHARP_H */
