#ifndef TCPIP_DHCP_H
#define TCPIP_DHCP_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/ip4_addr.h"
#include "tcpip/netif.h"

#if TCPIP_VERIFY_FSM
#include "dhcp_fsm.h"
#endif

typedef enum {
    DHCP_STATE_INIT       = 0,
    DHCP_STATE_SELECTING  = 1,
    DHCP_STATE_REQUESTING = 2,
    DHCP_STATE_BOUND      = 3,
    DHCP_STATE_RENEWING   = 4,
    DHCP_STATE_REBINDING  = 5
} dhcp_state_t;

err_t dhcp_start(struct netif *netif);
void dhcp_stop(struct netif *netif);
void dhcp_tmr(uint32_t now_ms);
uint8_t dhcp_supplied_address(const struct netif *netif);
dhcp_state_t dhcp_state_get(const struct netif *netif);
void dhcp_reset_all(void);

#endif /* TCPIP_DHCP_H */
