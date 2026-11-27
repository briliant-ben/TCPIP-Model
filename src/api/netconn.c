#include <string.h>
#include "tcpip/memp.h"
#include "tcpip/netconn.h"
#include "tcpip/opt.h"
#include "tcpip/tcp.h"
#include "tcpip/tcpip.h"
#include "tcpip/udp.h"

#if !TCPIP_NO_SYS

static struct netconn netconn_pool[TCPIP_MEMP_NUM_NETCONN];
static uint8_t netconn_used[TCPIP_MEMP_NUM_NETCONN];
static struct netbuf netbuf_pool[TCPIP_MEMP_NUM_PBUF];
static uint8_t netbuf_used[TCPIP_MEMP_NUM_PBUF];
static pthread_mutex_t netconn_pool_lock = PTHREAD_MUTEX_INITIALIZER;

static struct netconn *netconn_pool_alloc(void) {
    pthread_mutex_lock(&netconn_pool_lock);
    for (int i = 0; i < TCPIP_MEMP_NUM_NETCONN; i++) {
        if (!netconn_used[i]) {
            netconn_used[i] = 1U;
            memset(&netconn_pool[i], 0, sizeof(netconn_pool[i]));
            pthread_mutex_unlock(&netconn_pool_lock);
            return &netconn_pool[i];
        }
    }
    pthread_mutex_unlock(&netconn_pool_lock);
    return NULL;
}

static void netconn_pool_free(struct netconn *c) {
    if (!c) return;
    ptrdiff_t idx = c - netconn_pool;
    if (idx >= 0 && idx < TCPIP_MEMP_NUM_NETCONN) {
        pthread_mutex_lock(&netconn_pool_lock);
        netconn_used[idx] = 0U;
        pthread_mutex_unlock(&netconn_pool_lock);
    }
}

/* Sentinel message for EOF/closed recvmbox */
static struct netbuf netbuf_eof_sentinel;

static err_t conn_tcp_recv_cb(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
    (void)tpcb;
    struct netconn *conn = (struct netconn *)arg;
    if (!conn || !conn->recvmbox_valid) {
        if (p) pbuf_free(p);
        return ERR_OK;
    }
    if (!p || err != ERR_OK) {
        if (p) pbuf_free(p);
        conn->shut_rd = 1U;
        (void)sys_mbox_trypost(&conn->recvmbox, &netbuf_eof_sentinel);
        return ERR_OK;
    }
    struct netbuf *nb = netbuf_new();
    if (!nb) {
        pbuf_free(p);
        return ERR_MEM;
    }
    nb->p = p;
    nb->addr = tpcb->remote_ip;
    nb->port = tpcb->remote_port;
    if (sys_mbox_trypost(&conn->recvmbox, nb) != ERR_OK) {
        netbuf_delete(nb);
        return ERR_MEM;
    }
    return ERR_OK;
}

static void conn_tcp_err_cb(void *arg, err_t err) {
    struct netconn *conn = (struct netconn *)arg;
    if (!conn) return;
    conn->pcb.tcp = NULL;
    conn->last_err = err;
    conn->shut_rd = 1U;
    conn->shut_wr = 1U;
    if (conn->recvmbox_valid) {
        (void)sys_mbox_trypost(&conn->recvmbox, &netbuf_eof_sentinel);
    }
    if (conn->op_sem_valid) {
        sys_sem_signal(&conn->op_completed);
    }
}

static err_t conn_tcp_connected_cb(void *arg, struct tcp_pcb *tpcb, err_t err) {
    (void)tpcb;
    struct netconn *conn = (struct netconn *)arg;
    if (!conn) return ERR_OK;
    conn->last_err = err;
    if (conn->op_sem_valid) {
        sys_sem_signal(&conn->op_completed);
    }
    return ERR_OK;
}

static err_t conn_tcp_accept_cb(void *arg, struct tcp_pcb *newpcb, err_t err) {
    struct netconn *lconn = (struct netconn *)arg;
    if (!lconn || !lconn->acceptmbox_valid || err != ERR_OK || !newpcb) {
        if (newpcb) tcp_abort(newpcb);
        return ERR_ABRT;
    }
    struct netconn *nconn = netconn_pool_alloc();
    if (!nconn) {
        tcp_abort(newpcb);
        return ERR_ABRT;
    }
    nconn->type = NETCONN_TCP;
    nconn->state = NETCONN_NONE;
    nconn->pcb.tcp = newpcb;
    if (sys_mbox_new(&nconn->recvmbox, TCPIP_MBOX_SIZE) != ERR_OK) {
        netconn_pool_free(nconn);
        tcp_abort(newpcb);
        return ERR_ABRT;
    }
    nconn->recvmbox_valid = 1U;
    if (sys_sem_new(&nconn->op_completed, 0U) == ERR_OK) {
        nconn->op_sem_valid = 1U;
    }
    tcp_arg(newpcb, nconn);
    tcp_recv(newpcb, conn_tcp_recv_cb);
    tcp_err(newpcb, conn_tcp_err_cb);
    if (sys_mbox_trypost(&lconn->acceptmbox, nconn) != ERR_OK) {
        sys_mbox_free(&nconn->recvmbox);
        if (nconn->op_sem_valid) sys_sem_free(&nconn->op_completed);
        netconn_pool_free(nconn);
        tcp_abort(newpcb);
        return ERR_ABRT;
    }
    return ERR_OK;
}

static void conn_udp_recv_cb(void *arg, struct udp_pcb *upcb, struct pbuf *p,
                             const ip4_addr_t *addr, uint16_t port) {
    (void)upcb;
    struct netconn *conn = (struct netconn *)arg;
    if (!conn || !conn->recvmbox_valid) {
        if (p) pbuf_free(p);
        return;
    }
    struct netbuf *nb = netbuf_new();
    if (!nb) {
        pbuf_free(p);
        return;
    }
    nb->p = p;
    if (addr) nb->addr = *addr;
    nb->port = port;
    if (sys_mbox_trypost(&conn->recvmbox, nb) != ERR_OK) {
        netbuf_delete(nb);
    }
}

/* Actor marshaled operations */
typedef struct {
    struct netconn *conn;
    const ip4_addr_t *addr;
    uint16_t port;
    uint8_t backlog;
    const void *data;
    uint32_t size;
    uint32_t *out_len;
    struct netbuf *buf;
    ip4_addr_t *out_addr;
    uint16_t *out_port;
    uint8_t local;
} netconn_api_arg_t;

static err_t do_new(void *v) {
    netconn_api_arg_t *a = (netconn_api_arg_t *)v;
    struct netconn *c = a->conn;
    if (c->type == NETCONN_TCP) {
        c->pcb.tcp = tcp_new();
        if (!c->pcb.tcp) return ERR_MEM;
        tcp_arg(c->pcb.tcp, c);
        tcp_recv(c->pcb.tcp, conn_tcp_recv_cb);
        tcp_err(c->pcb.tcp, conn_tcp_err_cb);
    } else if (c->type == NETCONN_UDP) {
        c->pcb.udp = udp_new();
        if (!c->pcb.udp) return ERR_MEM;
        udp_recv(c->pcb.udp, conn_udp_recv_cb, c);
    } else {
        return ERR_ARG;
    }
    return ERR_OK;
}

static err_t do_del(void *v) {
    struct netconn *c = (struct netconn *)v;
    if (c->type == NETCONN_TCP && c->pcb.tcp) {
        tcp_arg(c->pcb.tcp, NULL);
        tcp_recv(c->pcb.tcp, NULL);
        tcp_err(c->pcb.tcp, NULL);
        if (c->state == NETCONN_LISTEN) {
            tcp_accept(c->pcb.tcp, NULL);
        }
        tcp_close(c->pcb.tcp);
        c->pcb.tcp = NULL;
    } else if (c->type == NETCONN_UDP && c->pcb.udp) {
        udp_recv(c->pcb.udp, NULL, NULL);
        udp_remove(c->pcb.udp);
        c->pcb.udp = NULL;
    }
    return ERR_OK;
}

static err_t do_bind(void *v) {
    netconn_api_arg_t *a = (netconn_api_arg_t *)v;
    struct netconn *c = a->conn;
    if (c->type == NETCONN_TCP) {
        if (!c->pcb.tcp) return ERR_CLSD;
        return tcp_bind(c->pcb.tcp, a->addr, a->port);
    }
    if (!c->pcb.udp) return ERR_CLSD;
    return udp_bind(c->pcb.udp, a->addr, a->port);
}

static err_t do_listen(void *v) {
    netconn_api_arg_t *a = (netconn_api_arg_t *)v;
    struct netconn *c = a->conn;
    if (c->type != NETCONN_TCP || !c->pcb.tcp) return ERR_VAL;
    if (c->state == NETCONN_LISTEN) return ERR_OK;
    struct tcp_pcb *lp = tcp_listen_with_backlog(c->pcb.tcp, a->backlog ? a->backlog : 8U);
    if (!lp) return ERR_MEM;
    c->pcb.tcp = lp;
    c->state = NETCONN_LISTEN;
    tcp_arg(lp, c);
    tcp_accept(lp, conn_tcp_accept_cb);
    return ERR_OK;
}

static err_t do_connect(void *v) {
    netconn_api_arg_t *a = (netconn_api_arg_t *)v;
    struct netconn *c = a->conn;
    if (c->type == NETCONN_UDP) {
        if (!c->pcb.udp) return ERR_CLSD;
        return udp_connect(c->pcb.udp, a->addr, a->port);
    }
    if (!c->pcb.tcp) return ERR_CLSD;
    c->state = NETCONN_CONNECT;
    c->last_err = ERR_INPROGRESS;
    return tcp_connect(c->pcb.tcp, a->addr, a->port, conn_tcp_connected_cb);
}

static err_t do_write_chunk(void *v) {
    netconn_api_arg_t *a = (netconn_api_arg_t *)v;
    struct netconn *c = a->conn;
    if (c->type != NETCONN_TCP || !c->pcb.tcp) return ERR_CLSD;
    uint16_t space = tcp_sndbuf(c->pcb.tcp);
    if (space == 0U) {
        *a->out_len = 0U;
        (void)tcp_output(c->pcb.tcp);
        return ERR_WOULDBLOCK;
    }
    uint16_t chunk = (uint16_t)(a->size < space ? a->size : space);
    err_t err = tcp_write(c->pcb.tcp, a->data, chunk, TCP_WRITE_FLAG_COPY);
    if (err != ERR_OK) return err;
    *a->out_len = chunk;
    return tcp_output(c->pcb.tcp);
}

static err_t do_recved(void *v) {
    netconn_api_arg_t *a = (netconn_api_arg_t *)v;
    if (a->conn->pcb.tcp && a->size > 0U) {
        uint16_t chunk = a->size > 65535U ? 65535U : (uint16_t)a->size;
        tcp_recved(a->conn->pcb.tcp, chunk);
    }
    return ERR_OK;
}

static err_t do_udp_send(void *v) {
    netconn_api_arg_t *a = (netconn_api_arg_t *)v;
    struct netconn *c = a->conn;
    if (!c->pcb.udp || !a->buf || !a->buf->p) return ERR_ARG;
    if (a->addr) {
        return udp_sendto(c->pcb.udp, a->buf->p, a->addr, a->port);
    }
    return udp_send(c->pcb.udp, a->buf->p);
}

static err_t do_close(void *v) {
    struct netconn *c = (struct netconn *)v;
    c->state = NETCONN_CLOSE;
    if (c->type == NETCONN_TCP && c->pcb.tcp) {
        err_t err = tcp_close(c->pcb.tcp);
        c->pcb.tcp = NULL;
        return err;
    }
    return ERR_OK;
}

static err_t do_getaddr(void *v) {
    netconn_api_arg_t *a = (netconn_api_arg_t *)v;
    struct netconn *c = a->conn;
    if (c->type == NETCONN_TCP && c->pcb.tcp) {
        if (a->local) {
            if (a->out_addr) *a->out_addr = c->pcb.tcp->local_ip;
            if (a->out_port) *a->out_port = c->pcb.tcp->local_port;
        } else {
            if (a->out_addr) *a->out_addr = c->pcb.tcp->remote_ip;
            if (a->out_port) *a->out_port = c->pcb.tcp->remote_port;
        }
        return ERR_OK;
    }
    if (c->type == NETCONN_UDP && c->pcb.udp) {
        if (a->local) {
            if (a->out_addr) *a->out_addr = c->pcb.udp->local_ip;
            if (a->out_port) *a->out_port = c->pcb.udp->local_port;
        } else {
            if (a->out_addr) *a->out_addr = c->pcb.udp->remote_ip;
            if (a->out_port) *a->out_port = c->pcb.udp->remote_port;
        }
        return ERR_OK;
    }
    return ERR_CONN;
}

struct netconn *netconn_new(netconn_type_t type) {
    struct netconn *c = netconn_pool_alloc();
    if (!c) return NULL;
    c->type = type;
    c->state = NETCONN_NONE;
    if (sys_mbox_new(&c->recvmbox, TCPIP_MBOX_SIZE) != ERR_OK) {
        netconn_pool_free(c);
        return NULL;
    }
    c->recvmbox_valid = 1U;
    if (sys_sem_new(&c->op_completed, 0U) != ERR_OK) {
        sys_mbox_free(&c->recvmbox);
        netconn_pool_free(c);
        return NULL;
    }
    c->op_sem_valid = 1U;
    netconn_api_arg_t arg = { .conn = c };
    if (tcpip_api_call(do_new, &arg) != ERR_OK) {
        sys_sem_free(&c->op_completed);
        sys_mbox_free(&c->recvmbox);
        netconn_pool_free(c);
        return NULL;
    }
    return c;
}

err_t netconn_delete(struct netconn *conn) {
    if (!conn) return ERR_ARG;
    (void)tcpip_api_call(do_del, conn);
    if (conn->pending_rx) {
        netbuf_delete(conn->pending_rx);
        conn->pending_rx = NULL;
    }
    if (conn->recvmbox_valid) {
        void *msg = NULL;
        while (sys_arch_mbox_tryfetch(&conn->recvmbox, &msg) != SYS_ARCH_TIMEOUT) {
            if (msg && msg != &netbuf_eof_sentinel) {
                netbuf_delete((struct netbuf *)msg);
            }
        }
        sys_mbox_free(&conn->recvmbox);
        conn->recvmbox_valid = 0U;
    }
    if (conn->acceptmbox_valid) {
        void *msg = NULL;
        while (sys_arch_mbox_tryfetch(&conn->acceptmbox, &msg) != SYS_ARCH_TIMEOUT) {
            if (msg) netconn_delete((struct netconn *)msg);
        }
        sys_mbox_free(&conn->acceptmbox);
        conn->acceptmbox_valid = 0U;
    }
    if (conn->op_sem_valid) {
        sys_sem_free(&conn->op_completed);
        conn->op_sem_valid = 0U;
    }
    netconn_pool_free(conn);
    return ERR_OK;
}

err_t netconn_bind(struct netconn *conn, const ip4_addr_t *addr, uint16_t port) {
    if (!conn) return ERR_ARG;
    netconn_api_arg_t arg = { .conn = conn, .addr = addr, .port = port };
    return tcpip_api_call(do_bind, &arg);
}

err_t netconn_listen_with_backlog(struct netconn *conn, uint8_t backlog) {
    if (!conn || conn->type != NETCONN_TCP) return ERR_ARG;
    if (!conn->acceptmbox_valid) {
        if (sys_mbox_new(&conn->acceptmbox, TCPIP_MBOX_SIZE) != ERR_OK) return ERR_MEM;
        conn->acceptmbox_valid = 1U;
    }
    netconn_api_arg_t arg = { .conn = conn, .backlog = backlog };
    return tcpip_api_call(do_listen, &arg);
}

err_t netconn_listen(struct netconn *conn) {
    return netconn_listen_with_backlog(conn, 8U);
}

err_t netconn_accept(struct netconn *conn, struct netconn **new_conn) {
    if (!conn || !new_conn || !conn->acceptmbox_valid) return ERR_ARG;
    void *msg = NULL;
    uint32_t t = sys_arch_mbox_fetch(&conn->acceptmbox, &msg, conn->recv_timeout_ms);
    if (t == SYS_ARCH_TIMEOUT || !msg) return ERR_TIMEOUT;
    *new_conn = (struct netconn *)msg;
    return ERR_OK;
}

err_t netconn_connect(struct netconn *conn, const ip4_addr_t *addr, uint16_t port) {
    if (!conn || !addr || port == 0U) return ERR_ARG;
    netconn_api_arg_t arg = { .conn = conn, .addr = addr, .port = port };
    err_t err = tcpip_api_call(do_connect, &arg);
    if (err != ERR_OK) return err;
    if (conn->type == NETCONN_TCP) {
        uint32_t wait_ms = conn->recv_timeout_ms ? conn->recv_timeout_ms : 15000U;
        if (sys_arch_sem_wait(&conn->op_completed, wait_ms) == SYS_ARCH_TIMEOUT) {
            return ERR_TIMEOUT;
        }
        return conn->last_err;
    }
    return ERR_OK;
}

err_t netconn_write(struct netconn *conn, const void *dataptr, uint32_t size, uint8_t apiflags, uint32_t *written) {
    (void)apiflags;
    if (!conn || (!dataptr && size > 0U)) return ERR_ARG;
    uint32_t total = 0U;
    const uint8_t *p = (const uint8_t *)dataptr;
    int retries = 0;
    while (total < size) {
        uint32_t chunk_written = 0U;
        uint32_t rem = size - total;
        uint32_t req = rem > 16384U ? 16384U : rem;
        netconn_api_arg_t arg = { .conn = conn, .data = p + total, .size = req, .out_len = &chunk_written };
        err_t err = tcpip_api_call(do_write_chunk, &arg);
        if (err == ERR_OK && chunk_written > 0U) {
            total += chunk_written;
            retries = 0;
        } else if (err == ERR_WOULDBLOCK || err == ERR_MEM) {
            if (++retries > 2000) {
                if (written) *written = total;
                return ERR_TIMEOUT;
            }
            sys_msleep(2U);
        } else {
            if (written) *written = total;
            return err;
        }
    }
    if (written) *written = total;
    return ERR_OK;
}

err_t netconn_recv(struct netconn *conn, struct netbuf **new_buf) {
    if (!conn || !new_buf || !conn->recvmbox_valid) return ERR_ARG;
    if (conn->pending_rx) {
        *new_buf = conn->pending_rx;
        conn->pending_rx = NULL;
        conn->pending_off = 0U;
        if (conn->type == NETCONN_TCP && (*new_buf)->p) {
            netconn_api_arg_t arg = { .conn = conn, .size = (*new_buf)->p->tot_len };
            (void)tcpip_api_call(do_recved, &arg);
        }
        return ERR_OK;
    }
    void *msg = NULL;
    uint32_t t = sys_arch_mbox_fetch(&conn->recvmbox, &msg, conn->recv_timeout_ms);
    if (t == SYS_ARCH_TIMEOUT) return ERR_TIMEOUT;
    if (!msg || msg == &netbuf_eof_sentinel) {
        *new_buf = NULL;
        return conn->last_err ? conn->last_err : ERR_CLSD;
    }
    struct netbuf *nb = (struct netbuf *)msg;
    if (conn->type == NETCONN_TCP && nb->p) {
        netconn_api_arg_t arg = { .conn = conn, .size = nb->p->tot_len };
        (void)tcpip_api_call(do_recved, &arg);
    }
    *new_buf = nb;
    return ERR_OK;
}

err_t netconn_recv_data(struct netconn *conn, void *dataptr, uint32_t max_len, uint32_t *received) {
    if (!conn || !dataptr || max_len == 0U || !received) return ERR_ARG;
    *received = 0U;
    if (!conn->pending_rx) {
        void *msg = NULL;
        uint32_t t = sys_arch_mbox_fetch(&conn->recvmbox, &msg, conn->recv_timeout_ms);
        if (t == SYS_ARCH_TIMEOUT) return ERR_TIMEOUT;
        if (!msg || msg == &netbuf_eof_sentinel) {
            return conn->last_err ? conn->last_err : ERR_CLSD;
        }
        conn->pending_rx = (struct netbuf *)msg;
        conn->pending_off = 0U;
    }
    struct netbuf *nb = conn->pending_rx;
    uint16_t avail = (uint16_t)(nb->p->tot_len - conn->pending_off);
    uint16_t take = (uint16_t)(max_len < avail ? max_len : avail);
    uint16_t copied = pbuf_copy_partial(nb->p, dataptr, take, conn->pending_off);
    conn->pending_off = (uint16_t)(conn->pending_off + copied);
    *received = copied;
    if (conn->type == NETCONN_TCP && copied > 0U) {
        netconn_api_arg_t arg = { .conn = conn, .size = copied };
        (void)tcpip_api_call(do_recved, &arg);
    }
    if (conn->pending_off >= nb->p->tot_len) {
        netbuf_delete(nb);
        conn->pending_rx = NULL;
        conn->pending_off = 0U;
    }
    return ERR_OK;
}

err_t netconn_send(struct netconn *conn, struct netbuf *buf) {
    if (!conn || !buf) return ERR_ARG;
    netconn_api_arg_t arg = { .conn = conn, .buf = buf, .addr = NULL, .port = 0U };
    return tcpip_api_call(do_udp_send, &arg);
}

err_t netconn_sendto(struct netconn *conn, struct netbuf *buf, const ip4_addr_t *addr, uint16_t port) {
    if (!conn || !buf || !addr) return ERR_ARG;
    netconn_api_arg_t arg = { .conn = conn, .buf = buf, .addr = addr, .port = port };
    return tcpip_api_call(do_udp_send, &arg);
}

err_t netconn_close(struct netconn *conn) {
    if (!conn) return ERR_ARG;
    return tcpip_api_call(do_close, conn);
}

void netconn_set_recvtimeout(struct netconn *conn, uint32_t timeout_ms) {
    if (conn) conn->recv_timeout_ms = timeout_ms;
}

err_t netconn_getaddr(struct netconn *conn, ip4_addr_t *addr, uint16_t *port, uint8_t local) {
    if (!conn) return ERR_ARG;
    netconn_api_arg_t arg = { .conn = conn, .out_addr = addr, .out_port = port, .local = local };
    return tcpip_api_call(do_getaddr, &arg);
}

struct netbuf *netbuf_new(void) {
    pthread_mutex_lock(&netconn_pool_lock);
    for (int i = 0; i < TCPIP_MEMP_NUM_PBUF; i++) {
        if (!netbuf_used[i]) {
            netbuf_used[i] = 1U;
            memset(&netbuf_pool[i], 0, sizeof(netbuf_pool[i]));
            pthread_mutex_unlock(&netconn_pool_lock);
            return &netbuf_pool[i];
        }
    }
    pthread_mutex_unlock(&netconn_pool_lock);
    return NULL;
}

void netbuf_delete(struct netbuf *buf) {
    if (!buf) return;
    if (buf->p) {
        pbuf_free(buf->p);
        buf->p = NULL;
    }
    ptrdiff_t idx = buf - netbuf_pool;
    if (idx >= 0 && idx < TCPIP_MEMP_NUM_PBUF) {
        pthread_mutex_lock(&netconn_pool_lock);
        netbuf_used[idx] = 0U;
        pthread_mutex_unlock(&netconn_pool_lock);
    }
}

err_t netbuf_ref(struct netbuf *buf, const void *dataptr, uint16_t size) {
    if (!buf) return ERR_ARG;
    if (buf->p) pbuf_free(buf->p);
    buf->p = pbuf_alloc_ref((uint8_t *)dataptr, size);
    return buf->p ? ERR_OK : ERR_MEM;
}

err_t netbuf_take(struct netbuf *buf, const void *dataptr, uint16_t size) {
    if (!buf) return ERR_ARG;
    if (buf->p) pbuf_free(buf->p);
    buf->p = pbuf_alloc(PBUF_TRANSPORT, size, PBUF_POOL);
    if (!buf->p) return ERR_MEM;
    if (size > 0U) return pbuf_take(buf->p, dataptr, size);
    return ERR_OK;
}

uint16_t netbuf_len(const struct netbuf *buf) {
    return (buf && buf->p) ? buf->p->tot_len : 0U;
}

uint16_t netbuf_copy(const struct netbuf *buf, void *dataptr, uint16_t len) {
    if (!buf || !buf->p || !dataptr) return 0U;
    uint16_t n = len < buf->p->tot_len ? len : buf->p->tot_len;
    return pbuf_copy_partial(buf->p, dataptr, n, 0U);
}

const ip4_addr_t *netbuf_fromaddr(const struct netbuf *buf) {
    return buf ? &buf->addr : NULL;
}

uint16_t netbuf_fromport(const struct netbuf *buf) {
    return buf ? buf->port : 0U;
}

#endif /* !TCPIP_NO_SYS */
