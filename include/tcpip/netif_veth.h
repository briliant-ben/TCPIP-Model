#ifndef TCPIP_NETIF_VETH_H
#define TCPIP_NETIF_VETH_H

#include <stdint.h>
#include "tcpip/netif.h"
#include "tcpip/pcap.h"

/* Virtual Ethernet L2 driver supporting point-to-point pairs, loopback,
 * optional PCAP capture, and deterministic loss/dup/reorder fault injection. */
typedef struct veth_link {
    struct netif *peer;
    tcpip_pcap_t *pcap;
    uint32_t drop_every_n;      /* 0 = disabled; drops every Nth transmitted frame */
    uint32_t dup_every_n;       /* 0 = disabled; duplicates every Nth kept frame */
    uint32_t reorder_every_n;   /* 0 = disabled; holds frame N and delivers after N+1 */
    uint32_t drop_mask;         /* bitmask for frames 1..32 if nonzero */
    uint32_t tx_frames;
    uint32_t rx_frames;
    uint32_t dropped_frames;
    uint32_t duped_frames;
    uint32_t reordered_frames;
    struct pbuf *held_frame;
    uint8_t use_tcpip_input;    /* 1 = deliver via peer->input(tcpip_input), 0 = direct peer->input */
} veth_link_t;

void veth_link_init(veth_link_t *cfg, struct netif *peer, tcpip_pcap_t *pcap, uint8_t use_tcpip_input);
void veth_link_flush(veth_link_t *cfg, struct netif *from);
err_t veth_netif_init(struct netif *netif);

#endif /* TCPIP_NETIF_VETH_H */
