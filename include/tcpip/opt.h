#ifndef TCPIP_OPT_H
#define TCPIP_OPT_H

/* 0 = multithreaded tcpip_thread actor (port/posix or port/freertos),
 * 1 = bare-metal single-threaded polled Raw API (port/nosys). */
#ifndef TCPIP_NO_SYS
#define TCPIP_NO_SYS 0
#endif

/* Optional runtime invocation of Lean-verified *_fsm shadow state machines */
#ifndef TCPIP_VERIFY_FSM
#define TCPIP_VERIFY_FSM 1
#endif

#ifndef TCPIP_CHECKSUM_FAST
#define TCPIP_CHECKSUM_FAST 1
#endif

#ifndef TCPIP_NETIF_MAX
#define TCPIP_NETIF_MAX 4
#endif

#ifndef TCPIP_ETH_MAX_FRAME
#define TCPIP_ETH_MAX_FRAME 1536
#endif

#ifndef TCPIP_PBUF_HEADROOM
#define TCPIP_PBUF_HEADROOM 64
#endif

#ifndef TCPIP_PBUF_POOL_BUFSIZE
#define TCPIP_PBUF_POOL_BUFSIZE 1600
#endif

#ifndef TCPIP_MEMP_NUM_PBUF
#define TCPIP_MEMP_NUM_PBUF 96
#endif

#ifndef TCPIP_MEMP_NUM_PBUF_POOL
#define TCPIP_MEMP_NUM_PBUF_POOL 96
#endif

#ifndef TCPIP_ARP_TABLE_SIZE
#define TCPIP_ARP_TABLE_SIZE 16
#endif

#ifndef TCPIP_ARP_QUEUE_LEN
#define TCPIP_ARP_QUEUE_LEN 4
#endif

#ifndef TCPIP_IP_REASS_MAX_SLOTS
#define TCPIP_IP_REASS_MAX_SLOTS 4
#endif

#ifndef TCPIP_IP_REASS_MAX_LEN
#define TCPIP_IP_REASS_MAX_LEN 8192
#endif

#ifndef TCPIP_MEMP_NUM_UDP_PCB
#define TCPIP_MEMP_NUM_UDP_PCB 16
#endif

#ifndef TCPIP_MEMP_NUM_TCP_PCB
#define TCPIP_MEMP_NUM_TCP_PCB 16
#endif

#ifndef TCPIP_MEMP_NUM_TCP_PCB_LISTEN
#define TCPIP_MEMP_NUM_TCP_PCB_LISTEN 8
#endif

#ifndef TCPIP_TCP_MSS
#define TCPIP_TCP_MSS 1460
#endif

#ifndef TCPIP_TCP_WND
#define TCPIP_TCP_WND 32768
#endif

#ifndef TCPIP_TCP_SND_BUF
#define TCPIP_TCP_SND_BUF 32768
#endif

#ifndef TCPIP_TCP_OOO_MAX
#define TCPIP_TCP_OOO_MAX 16
#endif

#ifndef TCPIP_MEMP_NUM_NETCONN
#define TCPIP_MEMP_NUM_NETCONN 24
#endif

#ifndef TCPIP_MBOX_SIZE
#define TCPIP_MBOX_SIZE 64
#endif

#ifndef TCPIP_DNS_CACHE_SIZE
#define TCPIP_DNS_CACHE_SIZE 8
#endif

#endif /* TCPIP_OPT_H */
