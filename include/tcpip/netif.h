#ifndef TCPIP_NETIF_H
#define TCPIP_NETIF_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/ip4_addr.h"
#include "tcpip/opt.h"
#include "tcpip/pbuf.h"

#define NETIF_FLAG_UP        0x01U
#define NETIF_FLAG_BROADCAST 0x02U
#define NETIF_FLAG_LINK_UP   0x04U
#define NETIF_FLAG_ETHARP    0x08U
#define NETIF_FLAG_IGMP      0x10U

struct netif;

typedef err_t (*netif_init_fn)(struct netif *netif);
typedef err_t (*netif_input_fn)(struct pbuf *p, struct netif *inp);
typedef err_t (*netif_output_fn)(struct netif *netif, struct pbuf *p, const ip4_addr_t *ipaddr);
typedef err_t (*netif_linkoutput_fn)(struct netif *netif, struct pbuf *p);

struct netif {
    struct netif *next;
    ip4_addr_t ip_addr;
    ip4_addr_t netmask;
    ip4_addr_t gw;
    netif_input_fn input;
    netif_output_fn output;
    netif_linkoutput_fn linkoutput;
    void *state;
    uint16_t mtu;
    uint8_t hwaddr_len;
    uint8_t hwaddr[6];
    uint8_t flags;
    char name[2];
    uint8_t num;
};

struct netif *netif_add(struct netif *netif,
                        const ip4_addr_t *ipaddr,
                        const ip4_addr_t *netmask,
                        const ip4_addr_t *gw,
                        void *state,
                        netif_init_fn init,
                        netif_input_fn input);
void netif_remove(struct netif *netif);
void netif_set_default(struct netif *netif);
struct netif *netif_get_default(void);
void netif_set_up(struct netif *netif);
void netif_set_down(struct netif *netif);
void netif_set_link_up(struct netif *netif);
void netif_set_link_down(struct netif *netif);
void netif_set_addr(struct netif *netif,
                    const ip4_addr_t *ipaddr,
                    const ip4_addr_t *netmask,
                    const ip4_addr_t *gw);
struct netif *netif_find(const char *name);
struct netif *netif_route(const ip4_addr_t *dest);
struct netif *netif_list_head(void);
void netif_reset_all(void);

#define netif_is_up(netif) (((netif)->flags & NETIF_FLAG_UP) != 0U)
#define netif_is_link_up(netif) (((netif)->flags & NETIF_FLAG_LINK_UP) != 0U)

#endif /* TCPIP_NETIF_H */
