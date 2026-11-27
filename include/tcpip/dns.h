#ifndef TCPIP_DNS_H
#define TCPIP_DNS_H

#include <stdint.h>
#include "tcpip/opt.h"
#include "tcpip/err.h"
#include "tcpip/ip4_addr.h"

#if TCPIP_VERIFY_FSM
#include "dns_fsm.h"
#endif

#define DNS_SERVER_PORT 53U
#define DNS_MAX_NAME_LEN 255U

typedef void (*dns_found_callback)(const char *name, const ip4_addr_t *ipaddr, void *callback_arg);

void dns_init(void);
void dns_reset(void);
void dns_setserver(uint8_t numdns, const ip4_addr_t *dnsserver);
ip4_addr_t dns_getserver(uint8_t numdns);
err_t dns_gethostbyname(const char *hostname, ip4_addr_t *addr,
                        dns_found_callback found, void *callback_arg);
void dns_tmr(uint32_t now_ms);

#endif /* TCPIP_DNS_H */
