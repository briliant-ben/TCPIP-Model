#include "tcpip/memp.h"
#include "tcpip/opt.h"
#include "tcpip/pbuf.h"

#if !TCPIP_NO_SYS
#include <pthread.h>
static pthread_mutex_t memp_lock = PTHREAD_MUTEX_INITIALIZER;
#define MEMP_LOCK()   pthread_mutex_lock(&memp_lock)
#define MEMP_UNLOCK() pthread_mutex_unlock(&memp_lock)
#else
#define MEMP_LOCK()   ((void)0)
#define MEMP_UNLOCK() ((void)0)
#endif

typedef struct memp_node {
    struct memp_node *next;
} memp_node_t;

typedef struct {
    uint16_t elem_size;
    uint16_t count;
    uint16_t used;
    memp_node_t *free_list;
    uint8_t *base;
} memp_desc_t;

/* Aligned slab backing buffers */
#define ALIGN_SZ(sz) (((sz) + 15U) & ~(size_t)15U)

/* Conservative element sizes decoupling memp.c from internal API structs */
#define SZ_PBUF_HDR   ALIGN_SZ(sizeof(struct pbuf))
#define SZ_PBUF_POOL  ALIGN_SZ(sizeof(struct pbuf) + TCPIP_PBUF_POOL_BUFSIZE)
#define SZ_UDP_PCB    ALIGN_SZ(128U)
#define SZ_TCP_PCB    ALIGN_SZ(81920U) /* Holds send/recv rings + OOO segments for high throughput */
#define SZ_TCP_LISTEN ALIGN_SZ(128U)
#define SZ_NETCONN    ALIGN_SZ(256U)
#define SZ_API_MSG    ALIGN_SZ(256U)

static uint8_t slab_pbuf_hdr[TCPIP_MEMP_NUM_PBUF * SZ_PBUF_HDR];
static uint8_t slab_pbuf_pool[TCPIP_MEMP_NUM_PBUF_POOL * SZ_PBUF_POOL];
static uint8_t slab_udp_pcb[TCPIP_MEMP_NUM_UDP_PCB * SZ_UDP_PCB];
static uint8_t slab_tcp_pcb[TCPIP_MEMP_NUM_TCP_PCB * SZ_TCP_PCB];
static uint8_t slab_tcp_listen[TCPIP_MEMP_NUM_TCP_PCB_LISTEN * SZ_TCP_LISTEN];
static uint8_t slab_netconn[TCPIP_MEMP_NUM_NETCONN * SZ_NETCONN];
static uint8_t slab_api_msg[TCPIP_MBOX_SIZE * SZ_API_MSG];

static memp_desc_t memp_pools[MEMP_MAX];
static int memp_initialized = 0;

static void memp_init_locked(void) {
    struct {
        size_t esz;
        uint16_t cnt;
        uint8_t *buf;
    } cfg[MEMP_MAX] = {
        { SZ_PBUF_HDR,   TCPIP_MEMP_NUM_PBUF,           slab_pbuf_hdr },
        { SZ_PBUF_POOL,  TCPIP_MEMP_NUM_PBUF_POOL,      slab_pbuf_pool },
        { SZ_UDP_PCB,    TCPIP_MEMP_NUM_UDP_PCB,        slab_udp_pcb },
        { SZ_TCP_PCB,    TCPIP_MEMP_NUM_TCP_PCB,        slab_tcp_pcb },
        { SZ_TCP_LISTEN, TCPIP_MEMP_NUM_TCP_PCB_LISTEN, slab_tcp_listen },
        { SZ_NETCONN,    TCPIP_MEMP_NUM_NETCONN,        slab_netconn },
        { SZ_API_MSG,    TCPIP_MBOX_SIZE,               slab_api_msg },
    };
    for (int t = 0; t < MEMP_MAX; t++) {
        memp_desc_t *d = &memp_pools[t];
        d->elem_size = (uint16_t)(cfg[t].esz <= 65535U ? cfg[t].esz : 0U);
        d->count = cfg[t].cnt;
        d->used = 0;
        d->base = cfg[t].buf;
        d->free_list = NULL;
        for (int i = (int)cfg[t].cnt - 1; i >= 0; i--) {
            memp_node_t *node = (memp_node_t *)(cfg[t].buf + (size_t)i * cfg[t].esz);
            node->next = d->free_list;
            d->free_list = node;
        }
    }
    memp_initialized = 1;
}

void memp_init(void) {
    MEMP_LOCK();
    memp_init_locked();
    MEMP_UNLOCK();
}

void *memp_malloc(memp_t type) {
    if ((unsigned int)type >= (unsigned int)MEMP_MAX) return NULL;
    MEMP_LOCK();
    if (!memp_initialized) memp_init_locked();
    memp_desc_t *d = &memp_pools[type];
    memp_node_t *node = d->free_list;
    if (node) {
        d->free_list = node->next;
        d->used++;
    }
    MEMP_UNLOCK();
    return (void *)node;
}

void memp_free(memp_t type, void *mem) {
    if (!mem || (unsigned int)type >= (unsigned int)MEMP_MAX) return;
    MEMP_LOCK();
    memp_desc_t *d = &memp_pools[type];
    memp_node_t *node = (memp_node_t *)mem;
    node->next = d->free_list;
    d->free_list = node;
    if (d->used > 0) d->used--;
    MEMP_UNLOCK();
}

uint32_t memp_avail(memp_t type) {
    if ((unsigned int)type >= (unsigned int)MEMP_MAX) return 0;
    MEMP_LOCK();
    if (!memp_initialized) memp_init_locked();
    uint32_t avail = (uint32_t)(memp_pools[type].count - memp_pools[type].used);
    MEMP_UNLOCK();
    return avail;
}

uint32_t memp_used(memp_t type) {
    if ((unsigned int)type >= (unsigned int)MEMP_MAX) return 0;
    MEMP_LOCK();
    if (!memp_initialized) memp_init_locked();
    uint32_t used = memp_pools[type].used;
    MEMP_UNLOCK();
    return used;
}
