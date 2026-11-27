#ifndef TCPIP_SOCKETS_H
#define TCPIP_SOCKETS_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/ip4_addr.h"

#define TCPIP_AF_INET     2
#define TCPIP_SOCK_STREAM 1
#define TCPIP_SOCK_DGRAM  2

#define TCPIP_SOL_SOCKET  1
#define TCPIP_SO_RCVTIMEO 1
#define TCPIP_SO_REUSEADDR 2

#define TCPIP_POLLIN  0x01
#define TCPIP_POLLOUT 0x02
#define TCPIP_POLLERR 0x04

typedef struct {
    uint16_t sin_family;
    uint16_t sin_port;   /* network byte order (big-endian) */
    ip4_addr_t sin_addr; /* network byte order (big-endian) */
} tcpip_sockaddr_in_t;

typedef struct {
    int fd;
    int16_t events;
    int16_t revents;
} tcpip_pollfd_t;

int tcpip_socket(int domain, int type, int protocol);
int tcpip_bind(int s, const tcpip_sockaddr_in_t *addr);
int tcpip_listen(int s, int backlog);
int tcpip_accept(int s, tcpip_sockaddr_in_t *addr);
int tcpip_connect(int s, const tcpip_sockaddr_in_t *addr);
int tcpip_send(int s, const void *data, uint32_t size, int flags);
int tcpip_recv(int s, void *mem, uint32_t len, int flags);
int tcpip_sendto(int s, const void *data, uint32_t size, int flags, const tcpip_sockaddr_in_t *to);
int tcpip_recvfrom(int s, void *mem, uint32_t len, int flags, tcpip_sockaddr_in_t *from);
int tcpip_close(int s);
int tcpip_setsockopt(int s, int level, int optname, const void *optval, uint32_t optlen);
int tcpip_poll_fds(tcpip_pollfd_t *fds, uint32_t nfds, int timeout_ms);
int tcpip_socket_errno(int s);

#endif /* TCPIP_SOCKETS_H */
