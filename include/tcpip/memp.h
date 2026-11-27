#ifndef TCPIP_MEMP_H
#define TCPIP_MEMP_H

#include <stddef.h>
#include <stdint.h>

typedef enum {
    MEMP_PBUF_HDR = 0,
    MEMP_PBUF_POOL,
    MEMP_UDP_PCB,
    MEMP_TCP_PCB,
    MEMP_TCP_PCB_LISTEN,
    MEMP_NETCONN,
    MEMP_API_MSG,
    MEMP_MAX
} memp_t;

void memp_init(void);
void *memp_malloc(memp_t type);
void memp_free(memp_t type, void *mem);
uint32_t memp_avail(memp_t type);
uint32_t memp_used(memp_t type);

#endif /* TCPIP_MEMP_H */
