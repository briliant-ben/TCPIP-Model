/* Protocol-agnostic host runtime, actor synchronization, virtual Ethernet wire,
 * and PCAP capture adapter around the generated tcpip_stack_system_t.
 */
#ifndef FSA_HOST_RUNTIME_H
#define FSA_HOST_RUNTIME_H

#include <stddef.h>
#include <stdint.h>

#include "generated/stack/tcpip_stack.h"

#ifndef FSA_HOST_NO_SYS
#define FSA_HOST_NO_SYS 0
#endif

#define FSA_HOST_MAX_FRAME_LEN      2048U
#define FSA_HOST_TX_STAGING_CAP     64U
#define FSA_HOST_RX_MBOX_CAP        64U
#define FSA_HOST_ACCEPT_CAP         12U
#define FSA_HOST_TCP_RX_BUF_CAP     65536U
#define FSA_HOST_UDP_QUEUE_CAP      32U
#define FSA_HOST_UDP_MAX_PAYLOAD    2048U
#define FSA_HOST_VETH_QUEUE_CAP     256U

typedef void (*fsa_host_wire_tx_fn)(void *ctx, const uint8_t *frame, uint16_t len, int64_t now_ms);

typedef struct fsa_host_pcap {
    void *fp;
    uint64_t packets_written;
    uint64_t bytes_written;
} fsa_host_pcap_t;

int fsa_host_pcap_open(fsa_host_pcap_t *pcap, const char *path);
int fsa_host_pcap_write(fsa_host_pcap_t *pcap, const uint8_t *frame, uint16_t len, int64_t ts_ms);
void fsa_host_pcap_close(fsa_host_pcap_t *pcap);

typedef struct fsa_host_accept_item {
    int child_slot;
    uint8_t remote_ip[4];
    uint16_t remote_port;
} fsa_host_accept_item_t;

typedef struct fsa_host_tcp_slot {
    int reserved;
    int connected;
    int peer_eof;
    int closed;
    int close_reason;
    uint16_t mss;
    fsa_host_accept_item_t accept_q[FSA_HOST_ACCEPT_CAP];
    uint16_t accept_head;
    uint16_t accept_count;
    uint8_t rx_buf[FSA_HOST_TCP_RX_BUF_CAP];
    uint32_t rx_head;
    uint32_t rx_len;
    uint64_t total_rx_bytes;
} fsa_host_tcp_slot_t;

typedef struct fsa_host_udp_dgram {
    uint8_t src_ip[4];
    uint16_t src_port;
    uint16_t dst_port;
    uint16_t len;
    uint8_t data[FSA_HOST_UDP_MAX_PAYLOAD];
} fsa_host_udp_dgram_t;

typedef struct fsa_host_udp_slot {
    int reserved;
    fsa_host_udp_dgram_t q[FSA_HOST_UDP_QUEUE_CAP];
    uint16_t head;
    uint16_t count;
} fsa_host_udp_slot_t;

typedef struct fsa_host_dhcp_info {
    int bound;
    uint8_t ip[4];
    uint8_t mask[4];
    uint8_t gw[4];
    uint8_t dns_ip[4];
} fsa_host_dhcp_info_t;

typedef struct fsa_host_dns_slot {
    int status; /* 0 = pending/idle, 1 = resolved, -1 = failed */
    uint8_t ip[4];
    int64_t ttl_s;
    uint16_t qname_len;
    uint8_t qname_wire[256];
} fsa_host_dns_slot_t;

typedef struct fsa_host_stats {
    uint64_t wire_rx_frames;
    uint64_t wire_rx_bytes;
    uint64_t wire_tx_frames;
    uint64_t wire_tx_bytes;
    uint64_t pool_alloc_ops;
    uint64_t pool_free_ops;
} fsa_host_stats_t;

typedef struct fsa_host_stack fsa_host_stack_t;

int64_t fsa_host_monotonic_ms(void);

fsa_host_stack_t *fsa_host_create(fsa_host_wire_tx_fn tx_fn, void *tx_ctx, fsa_host_pcap_t *pcap);
void fsa_host_destroy(fsa_host_stack_t *st, int64_t now_ms);

/* Start/stop background actor thread in NO_SYS=0 / FreeRTOS modes (no-op in NO_SYS=1). */
int fsa_host_start_actor(fsa_host_stack_t *st, int64_t now_ms);
int fsa_host_stop_actor(fsa_host_stack_t *st, int64_t now_ms);

/* Direct system inspection (acquires lock in actor mode). */
const tcpip_stack_system_t *fsa_host_raw_system_unsafe(const fsa_host_stack_t *st);
void fsa_host_get_stats(fsa_host_stack_t *st, fsa_host_stats_t *out);
void fsa_host_get_arch_snapshot(fsa_host_stack_t *st,
                                int *port_state, int64_t *sem_live, int64_t *mbox_live, int64_t *threads_live,
                                int *pool_state, int64_t *pool_free, int64_t *pool_used,
                                int *actor_state, int64_t *actor_q_depth, int64_t *actor_dispatched);
void fsa_host_get_if_config(fsa_host_stack_t *st,
                            uint8_t ip_out[4], uint8_t mask_out[4], uint8_t gw_out[4], uint8_t dns_out[4]);

/* Interface, RX wire input, and timer advancement. */
int fsa_host_init_if(fsa_host_stack_t *st, int64_t now_ms,
                     const uint8_t ip[4], const uint8_t mask[4], const uint8_t gw[4],
                     const uint8_t mac[6], uint16_t mtu);
int fsa_host_input_frame(fsa_host_stack_t *st, int64_t now_ms, const uint8_t *frame, uint16_t len);
int fsa_host_tick(fsa_host_stack_t *st, int64_t now_ms);
int64_t fsa_host_next_due_ms(fsa_host_stack_t *st);
int fsa_host_tx_ip(fsa_host_stack_t *st, int64_t now_ms,
                   const uint8_t src_ip[4], const uint8_t dst_ip[4],
                   uint8_t proto, const uint8_t *payload, uint16_t len);

/* UDP endpoint operations. */
int fsa_host_udp_open(fsa_host_stack_t *st);
int fsa_host_udp_bind(fsa_host_stack_t *st, int64_t now_ms, int slot,
                      const uint8_t *local_ip_or_null, uint16_t local_port);
int fsa_host_udp_connect(fsa_host_stack_t *st, int64_t now_ms, int slot,
                         const uint8_t remote_ip[4], uint16_t remote_port);
int fsa_host_udp_sendto(fsa_host_stack_t *st, int64_t now_ms, int slot,
                        const uint8_t src_ip[4], const uint8_t dst_ip[4], uint16_t dst_port,
                        const uint8_t *data, uint16_t len);
int fsa_host_udp_send(fsa_host_stack_t *st, int64_t now_ms, int slot,
                      const uint8_t src_ip[4], const uint8_t *data, uint16_t len);
int fsa_host_udp_recv(fsa_host_stack_t *st, int slot, fsa_host_udp_dgram_t *out, uint32_t timeout_ms);
int fsa_host_udp_close(fsa_host_stack_t *st, int64_t now_ms, int slot);

/* TCP connection operations. */
int fsa_host_tcp_open(fsa_host_stack_t *st);
int fsa_host_tcp_state(fsa_host_stack_t *st, int slot);
int fsa_host_tcp_listen(fsa_host_stack_t *st, int64_t now_ms, int slot,
                        const uint8_t *local_ip_or_null, uint16_t local_port);
int fsa_host_tcp_accept(fsa_host_stack_t *st, int listen_slot, fsa_host_accept_item_t *out, uint32_t timeout_ms);
int fsa_host_tcp_connect(fsa_host_stack_t *st, int64_t now_ms, int slot,
                         const uint8_t local_ip[4], uint16_t local_port,
                         const uint8_t remote_ip[4], uint16_t remote_port, uint32_t iss);
int fsa_host_tcp_is_connected(fsa_host_stack_t *st, int slot);
int fsa_host_tcp_wait_connected(fsa_host_stack_t *st, int slot, uint32_t timeout_ms);
int fsa_host_tcp_write(fsa_host_stack_t *st, int64_t now_ms, int slot, const uint8_t *data, uint32_t len);
int fsa_host_tcp_pump(fsa_host_stack_t *st, int64_t now_ms, int slot);
int fsa_host_tcp_recv(fsa_host_stack_t *st, int64_t now_ms, int slot,
                      uint8_t *dst, uint32_t cap, int *eof_out, uint32_t timeout_ms);
int fsa_host_tcp_close(fsa_host_stack_t *st, int64_t now_ms, int slot);
int fsa_host_tcp_abort(fsa_host_stack_t *st, int64_t now_ms, int slot);

/* DHCPv4 & DNS operations. */
int fsa_host_dhcp_start(fsa_host_stack_t *st, int64_t now_ms, const uint8_t mac[6], uint32_t xid);
int fsa_host_dhcp_poll(fsa_host_stack_t *st, fsa_host_dhcp_info_t *out);
uint16_t fsa_host_dns_encode_qname(const char *hostname, uint8_t *out, uint16_t cap);
int fsa_host_dns_query(fsa_host_stack_t *st, int64_t now_ms,
                       const uint8_t src_ip[4], const uint8_t server_ip[4],
                       const char *hostname, uint16_t txid);
int fsa_host_dns_poll(fsa_host_stack_t *st, int slot, fsa_host_dns_slot_t *out);

/* Deterministic two-endpoint virtual Ethernet wire with impairment + optional PCAP. */
typedef struct fsa_host_veth_pkt {
    int valid;
    int dst_side; /* 0 = A->B, 1 = B->A */
    int64_t deliver_ms;
    uint16_t len;
    uint8_t data[FSA_HOST_MAX_FRAME_LEN];
} fsa_host_veth_pkt_t;

typedef struct fsa_host_impair_cfg {
    uint64_t drop_seq_mask;     /* bit k (k < 64): drop k-th frame in this direction */
    uint64_t reorder_seq_mask;  /* bit k (k < 64): delay k-th frame behind (k+1)-th */
    uint64_t dup_seq_mask;      /* bit k (k < 64): duplicate k-th frame */
    uint32_t drop_every_n;      /* if > 0, drop every N-th frame (1-based) */
    int64_t base_delay_ms;      /* base propagation latency */
    int64_t reorder_extra_ms;   /* extra delay when reordered (default 5 ms if 0) */
} fsa_host_impair_cfg_t;

typedef struct fsa_host_veth_link {
    fsa_host_stack_t *side[2];
    fsa_host_pcap_t *pcap;
    fsa_host_impair_cfg_t dir_cfg[2]; /* 0: side0->side1, 1: side1->side0 */
    uint64_t tx_seq[2];
    uint64_t dropped[2];
    uint64_t reordered[2];
    uint64_t duplicated[2];
    uint64_t delivered[2];
    fsa_host_veth_pkt_t q[FSA_HOST_VETH_QUEUE_CAP];
} fsa_host_veth_link_t;

void fsa_host_veth_init(fsa_host_veth_link_t *link, fsa_host_pcap_t *pcap);
void fsa_host_veth_attach(fsa_host_veth_link_t *link, fsa_host_stack_t *side_a, fsa_host_stack_t *side_b);
fsa_host_wire_tx_fn fsa_host_veth_tx_fn_a(void);
fsa_host_wire_tx_fn fsa_host_veth_tx_fn_b(void);
int fsa_host_veth_pump(fsa_host_veth_link_t *link, int64_t now_ms);
int fsa_host_veth_step_until_quiescent(fsa_host_veth_link_t *link, int64_t now_ms, int max_rounds);

/* Real POSIX UDP loopback wire bridge (127.0.0.1 ephemeral socket pair) for live socket traffic. */
typedef struct fsa_host_udp_wire {
    int fd_a;
    int fd_b;
    uint16_t port_a;
    uint16_t port_b;
    fsa_host_pcap_t *pcap;
    uint64_t tx_a_to_b;
    uint64_t tx_b_to_a;
} fsa_host_udp_wire_t;

int fsa_host_udp_wire_open(fsa_host_udp_wire_t *w, fsa_host_pcap_t *pcap);
void fsa_host_udp_wire_close(fsa_host_udp_wire_t *w);
fsa_host_wire_tx_fn fsa_host_udp_wire_tx_a(void);
fsa_host_wire_tx_fn fsa_host_udp_wire_tx_b(void);
int fsa_host_udp_wire_pump(fsa_host_udp_wire_t *w, fsa_host_stack_t *side_a, fsa_host_stack_t *side_b, int64_t now_ms);

#endif /* FSA_HOST_RUNTIME_H */
