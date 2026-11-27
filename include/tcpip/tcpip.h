#ifndef TCPIP_TCPIP_H
#define TCPIP_TCPIP_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/opt.h"
#include "tcpip/pbuf.h"

struct netif;

typedef void (*tcpip_init_done_fn)(void *arg);
typedef void (*tcpip_callback_fn)(void *ctx);
typedef err_t (*tcpip_api_fn)(void *arg);

void tcpip_init(tcpip_init_done_fn initfunc, void *arg);
void tcpip_shutdown(void);

typedef err_t (*tcpip_rx_dispatch_fn)(struct pbuf *p, struct netif *inp);
void tcpip_set_rx_handler(tcpip_rx_dispatch_fn fn);
err_t tcpip_input(struct pbuf *p, struct netif *inp);
err_t tcpip_callback(tcpip_callback_fn func, void *ctx);
err_t tcpip_try_callback(tcpip_callback_fn func, void *ctx);
err_t tcpip_api_call(tcpip_api_fn fn, void *arg);

/* Poll timers / pending events up to now_ms (useful in NO_SYS=1 or deterministic tests). */
void tcpip_poll(uint32_t now_ms);

/* Register a periodic timer executed by the tcpip core context. */
typedef void (*tcpip_timer_fn)(void *ctx, uint32_t now_ms);
err_t tcpip_timer_add(uint32_t interval_ms, tcpip_timer_fn fn, void *ctx);

/* Returns actor state enum (actor_fsm_state) under lock/atomic view */
int tcpip_actor_state(void);

#endif /* TCPIP_TCPIP_H */
