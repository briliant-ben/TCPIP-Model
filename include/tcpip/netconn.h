#ifndef TCPIP_NETCONN_H
#define TCPIP_NETCONN_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/ip4_addr.h"
#include "tcpip/pbuf.h"
#include "tcpip/sys.h"

typedef enum {
    NETCONN_INVALID = 0,
    NETCONN_TCP     = 0x10,
    NETCONN_UDP     = 0x20
} netconn_type_t;

typedef enum {
    NETCONN_NONE = 0,
    NETCONN_LISTEN,
    NETCONN_CONNECT,
    NETCONN_CLOSE
} netconn_state_t;

struct netbuf {
    struct pbuf *p;
    ip4_addr_t addr;
    uint16_t port;
};

struct tcp_pcb;
struct udp_pcb;

struct netconn {
    netconn_type_t type;
    netconn_state_t state;
    union {
        struct tcp_pcb *tcp;
        struct udp_pcb *udp;
    } pcb;
    err_t last_err;
    sys_mbox_t recvmbox;
    sys_mbox_t acceptmbox;
    sys_sem_t op_completed;
    uint8_t op_sem_valid;
    uint8_t recvmbox_valid;
    uint8_t acceptmbox_valid;
    uint8_t shut_rd;
    uint8_t shut_wr;
    uint32_t recv_timeout_ms;
    struct netbuf *pending_rx;
    uint16_t pending_off;
};

struct netconn *netconn_new(netconn_type_t type);
err_t netconn_delete(struct netconn *conn);
err_t netconn_bind(struct netconn *conn, const ip4_addr_t *addr, uint16_t port);
err_t netconn_listen(struct netconn *conn);
err_t netconn_listen_with_backlog(struct netconn *conn, uint8_t backlog);
err_t netconn_accept(struct netconn *conn, struct netconn **new_conn);
err_t netconn_connect(struct netconn *conn, const ip4_addr_t *addr, uint16_t port);
err_t netconn_write(struct netconn *conn, const void *dataptr, uint32_t size, uint8_t apiflags, uint32_t *written);
err_t netconn_recv(struct netconn *conn, struct netbuf **new_buf);
err_t netconn_recv_data(struct netconn *conn, void *dataptr, uint32_t max_len, uint32_t *received);
err_t netconn_send(struct netconn *conn, struct netbuf *buf);
err_t netconn_sendto(struct netconn *conn, struct netbuf *buf, const ip4_addr_t *addr, uint16_t port);
err_t netconn_close(struct netconn *conn);
void netconn_set_recvtimeout(struct netconn *conn, uint32_t timeout_ms);
err_t netconn_getaddr(struct netconn *conn, ip4_addr_t *addr, uint16_t *port, uint8_t local);

struct netbuf *netbuf_new(void);
void netbuf_delete(struct netbuf *buf);
err_t netbuf_ref(struct netbuf *buf, const void *dataptr, uint16_t size);
err_t netbuf_take(struct netbuf *buf, const void *dataptr, uint16_t size);
uint16_t netbuf_len(const struct netbuf *buf);
uint16_t netbuf_copy(const struct netbuf *buf, void *dataptr, uint16_t len);
const ip4_addr_t *netbuf_fromaddr(const struct netbuf *buf);
uint16_t netbuf_fromport(const struct netbuf *buf);

#endif /* TCPIP_NETCONN_H */
