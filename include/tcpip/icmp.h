#ifndef TCPIP_ICMP_H
#define TCPIP_ICMP_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/ip4_addr.h"
#include "tcpip/netif.h"
#include "tcpip/pbuf.h"

#define ICMP_ER   0U   /* Echo Reply */
#define ICMP_DUR  3U   /* Destination Unreachable */
#define ICMP_ECHO 8U   /* Echo Request */
#define ICMP_TE   11U  /* Time Exceeded */

#define ICMP_DUR_PORT 3U
#define ICMP_DUR_FRAG 4U
#define ICMP_TE_TTL   0U
#define ICMP_TE_FRAG  1U

typedef void (*icmp_echo_reply_fn)(void *ctx, const ip4_addr_t *src, uint16_t id, uint16_t seq, uint16_t pay_len);

void icmp_input(struct pbuf *p, struct netif *inp, const ip4_addr_t *src, const ip4_addr_t *dst);
void icmp_dest_unreach(struct pbuf *p, uint8_t code);
void icmp_time_exceeded(struct pbuf *p, uint8_t code);
err_t icmp_send_echo(const ip4_addr_t *dst, uint16_t id, uint16_t seq, const uint8_t *payload, uint16_t len);
void icmp_set_echo_reply_cb(icmp_echo_reply_fn cb, void *ctx);

#endif /* TCPIP_ICMP_H */
