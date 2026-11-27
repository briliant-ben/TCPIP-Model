#ifndef TCPIP_TCP_H
#define TCPIP_TCP_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/ip4.h"
#include "tcpip/ip4_addr.h"
#include "tcpip/netif.h"
#include "tcpip/opt.h"
#include "tcpip/pbuf.h"

#if TCPIP_VERIFY_FSM
#include "tcp_fsm.h"
#endif

#define TCP_HLEN_MIN 20U

#define TCP_FIN 0x01U
#define TCP_SYN 0x02U
#define TCP_RST 0x04U
#define TCP_PSH 0x08U
#define TCP_ACK 0x10U
#define TCP_URG 0x20U

#define TCP_WRITE_FLAG_COPY 0x01U
#define TCP_WRITE_FLAG_MORE 0x02U

#define TCP_SEQ_LT(a, b)  ((int32_t)((uint32_t)(a) - (uint32_t)(b)) < 0)
#define TCP_SEQ_LEQ(a, b) ((int32_t)((uint32_t)(a) - (uint32_t)(b)) <= 0)
#define TCP_SEQ_GT(a, b)  ((int32_t)((uint32_t)(a) - (uint32_t)(b)) > 0)
#define TCP_SEQ_GEQ(a, b) ((int32_t)((uint32_t)(a) - (uint32_t)(b)) >= 0)

typedef enum {
    CLOSED      = 0,
    LISTEN      = 1,
    SYN_SENT    = 2,
    SYN_RCVD    = 3,
    ESTABLISHED = 4,
    FIN_WAIT_1  = 5,
    FIN_WAIT_2  = 6,
    CLOSE_WAIT  = 7,
    CLOSING     = 8,
    LAST_ACK    = 9,
    TIME_WAIT   = 10
} tcp_state_t;

struct tcp_pcb;

typedef err_t (*tcp_accept_fn)(void *arg, struct tcp_pcb *newpcb, err_t err);
typedef err_t (*tcp_recv_fn)(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err);
typedef err_t (*tcp_sent_fn)(void *arg, struct tcp_pcb *tpcb, uint16_t len);
typedef err_t (*tcp_connected_fn)(void *arg, struct tcp_pcb *tpcb, err_t err);
typedef void  (*tcp_err_fn)(void *arg, err_t err);
typedef err_t (*tcp_poll_fn)(void *arg, struct tcp_pcb *tpcb);

typedef struct {
    uint32_t seq;
    struct pbuf *p;
} tcp_ooo_seg_t;

struct tcp_pcb_listen {
    struct tcp_pcb_listen *next;
    ip4_addr_t local_ip;
    uint16_t local_port;
    uint8_t state;
    uint8_t backlog;
    uint8_t accepts_pending;
    void *callback_arg;
    tcp_accept_fn accept;
#if TCPIP_VERIFY_FSM
    tcp_fsm_machine_t fsm;
#endif
};

struct tcp_pcb {
    struct tcp_pcb *next;
    ip4_addr_t local_ip;
    ip4_addr_t remote_ip;
    uint16_t local_port;
    uint16_t remote_port;
    tcp_state_t state;
    uint8_t ttl;
    uint8_t tos;
    uint8_t flags;

    /* Sequence numbers & sliding windows */
    uint32_t rcv_nxt;
    uint32_t rcv_wnd;
    uint32_t snd_una;
    uint32_t snd_nxt;
    uint32_t snd_lbb; /* next byte sequence to buffer in snd_buf */
    uint32_t snd_wnd;
    uint16_t mss;

    /* Congestion control (RFC 5681) */
    uint32_t cwnd;
    uint32_t ssthresh;
    uint32_t recover;
    uint8_t dupacks;
    uint8_t in_fast_recovery;

    /* RTT / RTO / Retransmit / Persist / TIME_WAIT timers (RFC 6298) */
    int32_t srtt_ms;      /* scaled << 3, or -1 if unmeasured */
    int32_t rttvar_ms;    /* scaled << 2 */
    uint32_t rto_ms;
    uint32_t rtt_seq;
    uint32_t rtt_ts_ms;
    uint8_t rtt_active;
    uint8_t nrtx;

    uint32_t rtx_deadline_ms;
    uint8_t rtx_active;
    uint32_t persist_deadline_ms;
    uint8_t persist_active;
    uint8_t persist_backoff;
    uint32_t timewait_deadline_ms;
    uint32_t last_poll_ms;
    uint32_t delayed_ack_deadline_ms;
    uint8_t delayed_ack_active;
    uint32_t fin_seq;
    uint32_t fin_rx_seq;
    uint8_t fin_queued;
    uint8_t fin_acked;

    /* Circular send buffer covering [snd_una .. snd_lbb) */
    uint32_t snd_buf_head; /* ring index corresponding to snd_una */
    uint16_t snd_buf_used; /* bytes from snd_una to snd_lbb */
    uint8_t snd_buf[TCPIP_TCP_SND_BUF];

    /* Out-of-order segment list */
    tcp_ooo_seg_t ooo[TCPIP_TCP_OOO_MAX];
    uint8_t ooo_count;

    /* Parent listen PCB if passive open still needs accept delivery */
    struct tcp_pcb_listen *listener;

    /* Callbacks */
    void *callback_arg;
    tcp_recv_fn recv;
    tcp_sent_fn sent;
    tcp_err_fn errf;
    tcp_poll_fn poll;
    tcp_connected_fn connected;
    uint8_t poll_interval_ticks;

#if TCPIP_VERIFY_FSM
    tcp_fsm_machine_t fsm;
#endif
};

#define TF_ACK_NOW   0x01U
#define TF_ACK_DELAY 0x02U
#define TF_FIN       0x04U
#define TF_RST       0x08U
#define TF_GOT_FIN   0x10U

void tcp_init(void);
void tcp_reset(void);
struct tcp_pcb *tcp_new(void);
err_t tcp_bind(struct tcp_pcb *pcb, const ip4_addr_t *ipaddr, uint16_t port);
struct tcp_pcb *tcp_listen(struct tcp_pcb *pcb);
struct tcp_pcb *tcp_listen_with_backlog(struct tcp_pcb *pcb, uint8_t backlog);
void tcp_accept(struct tcp_pcb *lpcb, tcp_accept_fn accept);
void tcp_accepted(struct tcp_pcb *lpcb);
err_t tcp_connect(struct tcp_pcb *pcb, const ip4_addr_t *ipaddr, uint16_t port, tcp_connected_fn connected);
err_t tcp_write(struct tcp_pcb *pcb, const void *dataptr, uint16_t len, uint8_t apiflags);
err_t tcp_output(struct tcp_pcb *pcb);
void tcp_recved(struct tcp_pcb *pcb, uint16_t len);
err_t tcp_close(struct tcp_pcb *pcb);
void tcp_abort(struct tcp_pcb *pcb);

void tcp_arg(struct tcp_pcb *pcb, void *arg);
void tcp_recv(struct tcp_pcb *pcb, tcp_recv_fn recv);
void tcp_sent(struct tcp_pcb *pcb, tcp_sent_fn sent);
void tcp_err(struct tcp_pcb *pcb, tcp_err_fn err);
void tcp_poll(struct tcp_pcb *pcb, tcp_poll_fn poll, uint8_t interval);

uint16_t tcp_sndbuf(const struct tcp_pcb *pcb);
tcp_state_t tcp_state_get(const struct tcp_pcb *pcb);

void tcp_input(struct pbuf *p, struct netif *inp, const ip4_addr_t *src, const ip4_addr_t *dst);
void tcp_tmr(uint32_t now_ms);

/* Internal helpers shared across tcp.c / tcp_in.c / tcp_out.c */
int tcp_pcb_is_active(const struct tcp_pcb *pcb);
err_t tcp_send_ctrl(const ip4_addr_t *src, const ip4_addr_t *dst,
                    uint16_t sport, uint16_t dport,
                    uint32_t seq, uint32_t ack, uint8_t flags, uint16_t wnd,
                    struct netif *netif_hint);
err_t tcp_send_empty_ack(struct tcp_pcb *pcb);
err_t tcp_send_syn(struct tcp_pcb *pcb, uint8_t flags);
err_t tcp_send_fin_only(struct tcp_pcb *pcb, uint32_t seq);
err_t tcp_retransmit_una(struct tcp_pcb *pcb);
void tcp_pcb_purge_ooo(struct tcp_pcb *pcb);
void tcp_pcb_unlink_and_free(struct tcp_pcb *pcb);
void tcp_set_rtx_timer(struct tcp_pcb *pcb, uint32_t now_ms);
void tcp_clear_rtx_timer(struct tcp_pcb *pcb);
void tcp_set_persist_timer(struct tcp_pcb *pcb, uint32_t now_ms);
void tcp_clear_persist_timer(struct tcp_pcb *pcb);

#endif /* TCPIP_TCP_H */
