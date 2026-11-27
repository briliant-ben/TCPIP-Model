#ifndef TCPIP_UDP_H
#define TCPIP_UDP_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/ip4.h"
#include "tcpip/ip4_addr.h"
#include "tcpip/netif.h"
#include "tcpip/pbuf.h"

#define UDP_HLEN 8U

struct udp_pcb;

typedef void (*udp_recv_fn)(void *arg, struct udp_pcb *pcb, struct pbuf *p,
                            const ip4_addr_t *addr, uint16_t port);

struct udp_pcb {
    struct udp_pcb *next;
    ip4_addr_t local_ip;
    ip4_addr_t remote_ip;
    uint16_t local_port;
    uint16_t remote_port;
    uint8_t flags;
    uint8_t ttl;
    uint8_t tos;
    udp_recv_fn recv;
    void *recv_arg;
};

#define UDP_FLAGS_CONNECTED 0x01U
#define UDP_FLAGS_BROADCAST 0x02U

void udp_init(void);
void udp_reset(void);
struct udp_pcb *udp_new(void);
void udp_remove(struct udp_pcb *pcb);
err_t udp_bind(struct udp_pcb *pcb, const ip4_addr_t *ipaddr, uint16_t port);
err_t udp_connect(struct udp_pcb *pcb, const ip4_addr_t *ipaddr, uint16_t port);
void udp_disconnect(struct udp_pcb *pcb);
void udp_recv(struct udp_pcb *pcb, udp_recv_fn recv, void *recv_arg);
err_t udp_send(struct udp_pcb *pcb, struct pbuf *p);
err_t udp_sendto(struct udp_pcb *pcb, struct pbuf *p, const ip4_addr_t *dst_ip, uint16_t dst_port);
err_t udp_sendto_if(struct udp_pcb *pcb, struct pbuf *p, const ip4_addr_t *dst_ip, uint16_t dst_port, struct netif *netif);
void udp_input(struct pbuf *p, struct netif *inp, const ip4_addr_t *src, const ip4_addr_t *dst);

#endif /* TCPIP_UDP_H */
