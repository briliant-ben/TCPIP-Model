#include <string.h>
#include "tcpip/netconn.h"
#include "tcpip/opt.h"
#include "tcpip/sockets.h"
#include "tcpip/sys.h"

#if !TCPIP_NO_SYS

typedef struct {
    int in_use;
    int last_err;
    struct netconn *conn;
} sock_slot_t;

static sock_slot_t sock_table[TCPIP_MEMP_NUM_NETCONN];
static pthread_mutex_t sock_lock = PTHREAD_MUTEX_INITIALIZER;

static int alloc_sock(struct netconn *conn) {
    pthread_mutex_lock(&sock_lock);
    for (int i = 0; i < TCPIP_MEMP_NUM_NETCONN; i++) {
        if (!sock_table[i].in_use) {
            sock_table[i].in_use = 1;
            sock_table[i].last_err = 0;
            sock_table[i].conn = conn;
            pthread_mutex_unlock(&sock_lock);
            return i;
        }
    }
    pthread_mutex_unlock(&sock_lock);
    return -1;
}

static sock_slot_t *get_sock(int s) {
    if (s < 0 || s >= TCPIP_MEMP_NUM_NETCONN) return NULL;
    if (!sock_table[s].in_use || !sock_table[s].conn) return NULL;
    return &sock_table[s];
}

int tcpip_socket(int domain, int type, int protocol) {
    (void)protocol;
    if (domain != TCPIP_AF_INET) return -1;
    netconn_type_t nt = (type == TCPIP_SOCK_STREAM) ? NETCONN_TCP :
                        (type == TCPIP_SOCK_DGRAM)  ? NETCONN_UDP : NETCONN_INVALID;
    if (nt == NETCONN_INVALID) return -1;
    struct netconn *c = netconn_new(nt);
    if (!c) return -1;
    int fd = alloc_sock(c);
    if (fd < 0) {
        netconn_delete(c);
        return -1;
    }
    return fd;
}

int tcpip_bind(int s, const tcpip_sockaddr_in_t *addr) {
    sock_slot_t *sk = get_sock(s);
    if (!sk || !addr) return -1;
    err_t err = netconn_bind(sk->conn, &addr->sin_addr, tcpip_ntohs(addr->sin_port));
    sk->last_err = (int)err;
    return err == ERR_OK ? 0 : -1;
}

int tcpip_listen(int s, int backlog) {
    sock_slot_t *sk = get_sock(s);
    if (!sk) return -1;
    err_t err = netconn_listen_with_backlog(sk->conn, (uint8_t)(backlog > 0 ? backlog : 8));
    sk->last_err = (int)err;
    return err == ERR_OK ? 0 : -1;
}

int tcpip_accept(int s, tcpip_sockaddr_in_t *addr) {
    sock_slot_t *sk = get_sock(s);
    if (!sk) return -1;
    struct netconn *nc = NULL;
    err_t err = netconn_accept(sk->conn, &nc);
    sk->last_err = (int)err;
    if (err != ERR_OK || !nc) return -1;
    int fd = alloc_sock(nc);
    if (fd < 0) {
        netconn_delete(nc);
        return -1;
    }
    if (addr) {
        ip4_addr_t rip = {0};
        uint16_t rport = 0U;
        (void)netconn_getaddr(nc, &rip, &rport, 0U);
        addr->sin_family = TCPIP_AF_INET;
        addr->sin_addr = rip;
        addr->sin_port = tcpip_htons(rport);
    }
    return fd;
}

int tcpip_connect(int s, const tcpip_sockaddr_in_t *addr) {
    sock_slot_t *sk = get_sock(s);
    if (!sk || !addr) return -1;
    err_t err = netconn_connect(sk->conn, &addr->sin_addr, tcpip_ntohs(addr->sin_port));
    sk->last_err = (int)err;
    return err == ERR_OK ? 0 : -1;
}

int tcpip_send(int s, const void *data, uint32_t size, int flags) {
    (void)flags;
    sock_slot_t *sk = get_sock(s);
    if (!sk || (!data && size > 0U)) return -1;
    if (sk->conn->type == NETCONN_UDP) {
        struct netbuf *nb = netbuf_new();
        if (!nb) return -1;
        if (netbuf_take(nb, data, (uint16_t)size) != ERR_OK) {
            netbuf_delete(nb);
            return -1;
        }
        err_t err = netconn_send(sk->conn, nb);
        netbuf_delete(nb);
        sk->last_err = (int)err;
        return err == ERR_OK ? (int)size : -1;
    }
    uint32_t written = 0U;
    err_t err = netconn_write(sk->conn, data, size, 0U, &written);
    sk->last_err = (int)err;
    if (written > 0U) return (int)written;
    return err == ERR_OK ? (int)written : -1;
}

int tcpip_recv(int s, void *mem, uint32_t len, int flags) {
    (void)flags;
    sock_slot_t *sk = get_sock(s);
    if (!sk || !mem || len == 0U) return -1;
    uint32_t rcv = 0U;
    err_t err = netconn_recv_data(sk->conn, mem, len, &rcv);
    sk->last_err = (int)err;
    if (err == ERR_OK) return (int)rcv;
    if (err == ERR_CLSD) return 0;
    return -1;
}

int tcpip_sendto(int s, const void *data, uint32_t size, int flags, const tcpip_sockaddr_in_t *to) {
    (void)flags;
    sock_slot_t *sk = get_sock(s);
    if (!sk || !to || (!data && size > 0U)) return -1;
    struct netbuf *nb = netbuf_new();
    if (!nb) return -1;
    if (netbuf_take(nb, data, (uint16_t)size) != ERR_OK) {
        netbuf_delete(nb);
        return -1;
    }
    err_t err = netconn_sendto(sk->conn, nb, &to->sin_addr, tcpip_ntohs(to->sin_port));
    netbuf_delete(nb);
    sk->last_err = (int)err;
    return err == ERR_OK ? (int)size : -1;
}

int tcpip_recvfrom(int s, void *mem, uint32_t len, int flags, tcpip_sockaddr_in_t *from) {
    (void)flags;
    sock_slot_t *sk = get_sock(s);
    if (!sk || !mem || len == 0U) return -1;
    struct netbuf *nb = NULL;
    err_t err = netconn_recv(sk->conn, &nb);
    sk->last_err = (int)err;
    if (err == ERR_CLSD) return 0;
    if (err != ERR_OK || !nb) return -1;
    uint16_t copied = netbuf_copy(nb, mem, (uint16_t)(len > 65535U ? 65535U : len));
    if (from) {
        from->sin_family = TCPIP_AF_INET;
        from->sin_addr = *netbuf_fromaddr(nb);
        from->sin_port = tcpip_htons(netbuf_fromport(nb));
    }
    netbuf_delete(nb);
    return (int)copied;
}

int tcpip_close(int s) {
    sock_slot_t *sk = get_sock(s);
    if (!sk) return -1;
    struct netconn *c = sk->conn;
    pthread_mutex_lock(&sock_lock);
    sk->conn = NULL;
    sk->in_use = 0;
    pthread_mutex_unlock(&sock_lock);
    return netconn_delete(c) == ERR_OK ? 0 : -1;
}

int tcpip_setsockopt(int s, int level, int optname, const void *optval, uint32_t optlen) {
    sock_slot_t *sk = get_sock(s);
    if (!sk || !optval || level != TCPIP_SOL_SOCKET) return -1;
    if (optname == TCPIP_SO_RCVTIMEO && optlen >= sizeof(uint32_t)) {
        uint32_t ms = 0U;
        memcpy(&ms, optval, sizeof(uint32_t));
        netconn_set_recvtimeout(sk->conn, ms);
        return 0;
    }
    if (optname == TCPIP_SO_REUSEADDR) return 0;
    return -1;
}

int tcpip_poll_fds(tcpip_pollfd_t *fds, uint32_t nfds, int timeout_ms) {
    if (!fds || nfds == 0U) return 0;
    uint32_t start = sys_now();
    for (;;) {
        int ready = 0;
        for (uint32_t i = 0U; i < nfds; i++) {
            fds[i].revents = 0;
            sock_slot_t *sk = get_sock(fds[i].fd);
            if (!sk) {
                fds[i].revents = TCPIP_POLLERR;
                ready++;
                continue;
            }
            if ((fds[i].events & TCPIP_POLLIN) != 0) {
                if (sk->conn->pending_rx || sk->conn->shut_rd) {
                    fds[i].revents |= TCPIP_POLLIN;
                    ready++;
                }
            }
            if ((fds[i].events & TCPIP_POLLOUT) != 0) {
                if (sk->conn->type == NETCONN_UDP || sk->conn->pcb.tcp != NULL) {
                    fds[i].revents |= TCPIP_POLLOUT;
                    ready++;
                }
            }
        }
        if (ready > 0) return ready;
        if (timeout_ms == 0) return 0;
        if (timeout_ms > 0 && (int32_t)(sys_now() - start) >= timeout_ms) return 0;
        sys_msleep(1U);
    }
}

int tcpip_socket_errno(int s) {
    if (s < 0 || s >= TCPIP_MEMP_NUM_NETCONN) return ERR_ARG;
    return sock_table[s].last_err;
}

#endif /* !TCPIP_NO_SYS */
