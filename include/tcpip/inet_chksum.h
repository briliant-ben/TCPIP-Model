#ifndef TCPIP_INET_CHKSUM_H
#define TCPIP_INET_CHKSUM_H

#include <stdint.h>
#include "tcpip/ip4_addr.h"
#include "tcpip/pbuf.h"

uint16_t inet_chksum(const void *dataptr, uint16_t len);
uint16_t inet_chksum_pbuf(const struct pbuf *p);
uint16_t inet_chksum_pseudo(const struct pbuf *p, uint8_t proto, uint16_t proto_len,
                            const ip4_addr_t *src, const ip4_addr_t *dst);

#endif /* TCPIP_INET_CHKSUM_H */
