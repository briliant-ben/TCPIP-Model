#include <string.h>
#include "tcpip/memp.h"
#include "tcpip/netif.h"
#include "tcpip/sys.h"
#include "tcpip/tcp.h"

struct tcp_pcb *tcp_active_pcbs = NULL;
struct tcp_pcb_listen *tcp_listen_pcbs = NULL;
struct tcp_pcb *tcp_tw_pcbs = NULL;

static uint16_t tcp_ephemeral_port = 49152U;
static uint32_t tcp_isn_seed = 0x10203040U;

static inline uint32_t tcp_next_isn(void) {
    tcp_isn_seed = tcp_isn_seed * 1664525U + 1013904223U + sys_now();
    return tcp_isn_seed;
}

static int tcp_port_in_use(uint16_t port) {
    for (struct tcp_pcb *p = tcp_active_pcbs; p != NULL; p = p->next) {
        if (p->local_port == port) return 1;
    }
    for (struct tcp_pcb *p = tcp_tw_pcbs; p != NULL; p = p->next) {
        if (p->local_port == port) return 1;
    }
    for (struct tcp_pcb_listen *l = tcp_listen_pcbs; l != NULL; l = l->next) {
        if (l->local_port == port) return 1;
    }
    return 0;
}

static uint16_t tcp_new_port(void) {
    for (uint32_t i = 0; i < 16384U; i++) {
        uint16_t port = tcp_ephemeral_port++;
        if (tcp_ephemeral_port < 49152U) tcp_ephemeral_port = 49152U;
        if (!tcp_port_in_use(port)) return port;
    }
    return 0;
}

static void tcp_list_remove(struct tcp_pcb **head, struct tcp_pcb *pcb) {
    while (*head != NULL) {
        if (*head == pcb) {
            *head = pcb->next;
            pcb->next = NULL;
            return;
        }
        head = &(*head)->next;
    }
}

void tcp_pcb_purge_ooo(struct tcp_pcb *pcb) {
    if (!pcb) return;
    for (uint8_t i = 0; i < pcb->ooo_count && i < TCPIP_TCP_OOO_MAX; i++) {
        if (pcb->ooo[i].p) {
            pbuf_free(pcb->ooo[i].p);
            pcb->ooo[i].p = NULL;
        }
    }
    pcb->ooo_count = 0U;
}

int tcp_pcb_is_active(const struct tcp_pcb *pcb) {
    for (const struct tcp_pcb *p = tcp_active_pcbs; p != NULL; p = p->next) {
        if (p == pcb) return 1;
    }
    return 0;
}

void tcp_pcb_unlink_and_free(struct tcp_pcb *pcb) {
    if (!pcb) return;
    int found = 0;
    for (struct tcp_pcb *p = tcp_active_pcbs; p != NULL; p = p->next) {
        if (p == pcb) { found = 1; break; }
    }
    if (!found) {
        for (struct tcp_pcb *p = tcp_tw_pcbs; p != NULL; p = p->next) {
            if (p == pcb) { found = 1; break; }
        }
    }
    if (!found && pcb->state == CLOSED) {
        return;
    }
    tcp_list_remove(&tcp_active_pcbs, pcb);
    tcp_list_remove(&tcp_tw_pcbs, pcb);
    tcp_pcb_purge_ooo(pcb);
    pcb->state = CLOSED;
    pcb->fin_acked = 0U;
    pcb->recv = NULL;
    pcb->sent = NULL;
    pcb->errf = NULL;
    pcb->poll = NULL;
    pcb->connected = NULL;
    memp_free(MEMP_TCP_PCB, pcb);
}

void tcp_set_rtx_timer(struct tcp_pcb *pcb, uint32_t now_ms) {
    if (!pcb) return;
    uint32_t rto = pcb->rto_ms;
    if (rto < 200U) rto = 200U;
    if (rto > 60000U) rto = 60000U;
    pcb->rtx_active = 1U;
    pcb->rtx_deadline_ms = now_ms + rto;
}

void tcp_clear_rtx_timer(struct tcp_pcb *pcb) {
    if (!pcb) return;
    pcb->rtx_active = 0U;
}

void tcp_set_persist_timer(struct tcp_pcb *pcb, uint32_t now_ms) {
    if (!pcb) return;
    uint32_t d = pcb->rto_ms;
    if (pcb->persist_backoff > 0U && pcb->persist_backoff < 8U) {
        d <<= (pcb->persist_backoff > 4U ? 4U : pcb->persist_backoff);
    }
    if (d < 200U) d = 200U;
    if (d > 60000U) d = 60000U;
    pcb->persist_active = 1U;
    pcb->persist_deadline_ms = now_ms + d;
}

void tcp_clear_persist_timer(struct tcp_pcb *pcb) {
    if (!pcb) return;
    pcb->persist_active = 0U;
    pcb->persist_backoff = 0U;
}

void tcp_init(void) {
    tcp_reset();
    ip4_register_tcp_input(tcp_input);
}

void tcp_reset(void) {
    while (tcp_active_pcbs != NULL) {
        struct tcp_pcb *n = tcp_active_pcbs->next;
        tcp_pcb_purge_ooo(tcp_active_pcbs);
        memp_free(MEMP_TCP_PCB, tcp_active_pcbs);
        tcp_active_pcbs = n;
    }
    while (tcp_tw_pcbs != NULL) {
        struct tcp_pcb *n = tcp_tw_pcbs->next;
        tcp_pcb_purge_ooo(tcp_tw_pcbs);
        memp_free(MEMP_TCP_PCB, tcp_tw_pcbs);
        tcp_tw_pcbs = n;
    }
    while (tcp_listen_pcbs != NULL) {
        struct tcp_pcb_listen *n = tcp_listen_pcbs->next;
        memp_free(MEMP_TCP_PCB_LISTEN, tcp_listen_pcbs);
        tcp_listen_pcbs = n;
    }
    tcp_ephemeral_port = 49152U;
}

struct tcp_pcb *tcp_new(void) {
    struct tcp_pcb *pcb = (struct tcp_pcb *)memp_malloc(MEMP_TCP_PCB);
    if (!pcb) return NULL;
    memset(pcb, 0, sizeof(*pcb));
    pcb->state = CLOSED;
    pcb->ttl = 64U;
    pcb->mss = TCPIP_TCP_MSS;
    pcb->rcv_wnd = TCPIP_TCP_WND;
    pcb->snd_wnd = TCPIP_TCP_WND;
    pcb->cwnd = (uint32_t)(2U * TCPIP_TCP_MSS);
    pcb->ssthresh = 65535U;
    pcb->srtt_ms = -1;
    pcb->rttvar_ms = 0;
    pcb->rto_ms = 1000U;
#if TCPIP_VERIFY_FSM
    tcp_fsm_init(&pcb->fsm);
#endif
    return pcb;
}

err_t tcp_bind(struct tcp_pcb *pcb, const ip4_addr_t *ipaddr, uint16_t port) {
    if (!pcb || pcb->state != CLOSED) return ERR_VAL;
    if (port == 0U) {
        port = tcp_new_port();
        if (port == 0U) return ERR_USE;
    } else {
        for (struct tcp_pcb_listen *l = tcp_listen_pcbs; l != NULL; l = l->next) {
            if (l->local_port == port) {
                if (!ipaddr || ip4_addr_isany(ipaddr) || ip4_addr_isany(&l->local_ip) ||
                    ip4_addr_cmp(ipaddr, &l->local_ip)) {
                    return ERR_USE;
                }
            }
        }
        for (struct tcp_pcb *p = tcp_active_pcbs; p != NULL; p = p->next) {
            if (p != pcb && p->local_port == port) {
                if (!ipaddr || ip4_addr_isany(ipaddr) || ip4_addr_isany(&p->local_ip) ||
                    ip4_addr_cmp(ipaddr, &p->local_ip)) {
                    return ERR_USE;
                }
            }
        }
    }
    pcb->local_ip.addr = ipaddr ? ipaddr->addr : 0U;
    pcb->local_port = port;
    return ERR_OK;
}

struct tcp_pcb *tcp_listen_with_backlog(struct tcp_pcb *pcb, uint8_t backlog) {
    if (!pcb || pcb->state != CLOSED) return NULL;
    if (pcb->local_port == 0U) return NULL;
    struct tcp_pcb_listen *lpcb = (struct tcp_pcb_listen *)memp_malloc(MEMP_TCP_PCB_LISTEN);
    if (!lpcb) return NULL;
    memset(lpcb, 0, sizeof(*lpcb));
    lpcb->local_ip = pcb->local_ip;
    lpcb->local_port = pcb->local_port;
    lpcb->state = LISTEN;
    lpcb->backlog = backlog ? backlog : (uint8_t)8;
    lpcb->callback_arg = pcb->callback_arg;
    lpcb->next = tcp_listen_pcbs;
    tcp_listen_pcbs = lpcb;
#if TCPIP_VERIFY_FSM
    tcp_fsm_init(&lpcb->fsm);
    (void)tcp_fsm_step(&lpcb->fsm, (int64_t)sys_now(), TCP_FSM_EV_APP_LISTEN, NULL, 0, NULL, NULL, NULL);
#endif
    memp_free(MEMP_TCP_PCB, pcb);
    return (struct tcp_pcb *)lpcb;
}

struct tcp_pcb *tcp_listen(struct tcp_pcb *pcb) {
    return tcp_listen_with_backlog(pcb, 8U);
}

void tcp_accept(struct tcp_pcb *lpcb, tcp_accept_fn accept) {
    if (!lpcb) return;
    struct tcp_pcb_listen *lp = (struct tcp_pcb_listen *)lpcb;
    lp->accept = accept;
}

void tcp_accepted(struct tcp_pcb *lpcb) {
    struct tcp_pcb_listen *lp = (struct tcp_pcb_listen *)lpcb;
    if (lp && lp->accepts_pending > 0U) lp->accepts_pending--;
}

err_t tcp_connect(struct tcp_pcb *pcb, const ip4_addr_t *ipaddr, uint16_t port, tcp_connected_fn connected) {
    if (!pcb || !ipaddr || port == 0U || pcb->state != CLOSED) return ERR_ARG;
    struct netif *rt = netif_route(ipaddr);
    if (!rt) return ERR_RTE;
    if (ip4_addr_isany(&pcb->local_ip)) {
        pcb->local_ip = rt->ip_addr;
    }
    if (pcb->local_port == 0U) {
        err_t berr = tcp_bind(pcb, &pcb->local_ip, 0U);
        if (berr != ERR_OK) return berr;
    }
    pcb->remote_ip = *ipaddr;
    pcb->remote_port = port;
    pcb->connected = connected;
    uint32_t isn = tcp_next_isn();
    pcb->snd_una = isn;
    pcb->snd_nxt = isn + 1U;
    pcb->snd_lbb = isn + 1U;
    pcb->snd_buf_head = 0U;
    pcb->snd_buf_used = 0U;
    pcb->nrtx = 0U;
    pcb->state = SYN_SENT;
    uint32_t now_ms = sys_now();
#if TCPIP_VERIFY_FSM
    (void)tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_APP_CONNECT, NULL, 0, NULL, NULL, NULL);
#endif
    pcb->next = tcp_active_pcbs;
    tcp_active_pcbs = pcb;
    tcp_set_rtx_timer(pcb, now_ms);
    return tcp_send_syn(pcb, TCP_SYN);
}

err_t tcp_write(struct tcp_pcb *pcb, const void *dataptr, uint16_t len, uint8_t apiflags) {
    (void)apiflags;
    if (!pcb || (!dataptr && len > 0U)) return ERR_ARG;
    if (pcb->state != ESTABLISHED && pcb->state != CLOSE_WAIT) return ERR_CONN;
    if (pcb->fin_queued) return ERR_VAL;
    if (len == 0U) return ERR_OK;
    if ((uint32_t)pcb->snd_buf_used + (uint32_t)len > TCPIP_TCP_SND_BUF) {
        return ERR_MEM;
    }

    uint32_t start_off = pcb->snd_lbb - pcb->snd_una;
    uint32_t wpos = (pcb->snd_buf_head + start_off) % TCPIP_TCP_SND_BUF;
    uint16_t first = (uint16_t)(TCPIP_TCP_SND_BUF - wpos);
    if (first > len) first = len;
    memcpy(pcb->snd_buf + wpos, dataptr, first);
    if (len > first) {
        memcpy(pcb->snd_buf, (const uint8_t *)dataptr + first, (uint16_t)(len - first));
    }
    pcb->snd_buf_used = (uint16_t)(pcb->snd_buf_used + len);
    pcb->snd_lbb += len;
    return ERR_OK;
}

void tcp_recved(struct tcp_pcb *pcb, uint16_t len) {
    if (!pcb || len == 0U) return;
    uint32_t old_wnd = pcb->rcv_wnd;
    pcb->rcv_wnd += len;
    if (pcb->rcv_wnd > TCPIP_TCP_WND) pcb->rcv_wnd = TCPIP_TCP_WND;
    if ((pcb->state == ESTABLISHED || pcb->state == FIN_WAIT_1 || pcb->state == FIN_WAIT_2) &&
        old_wnd < (uint32_t)pcb->mss && pcb->rcv_wnd >= (uint32_t)pcb->mss) {
        tcp_send_empty_ack(pcb);
    }
}

static struct tcp_pcb_listen *tcp_find_listen_pcb(const struct tcp_pcb *pcb) {
    for (struct tcp_pcb_listen *l = tcp_listen_pcbs; l != NULL; l = l->next) {
        if ((const void *)l == (const void *)pcb) return l;
    }
    return NULL;
}

err_t tcp_close(struct tcp_pcb *pcb) {
    if (!pcb) return ERR_ARG;
    struct tcp_pcb_listen *lp = tcp_find_listen_pcb(pcb);
    if (lp != NULL) {
        struct tcp_pcb_listen **pp = &tcp_listen_pcbs;
        while (*pp != NULL) {
            if (*pp == lp) {
                *pp = lp->next;
                memp_free(MEMP_TCP_PCB_LISTEN, lp);
                return ERR_OK;
            }
            pp = &(*pp)->next;
        }
        return ERR_VAL;
    }

    uint32_t now_ms = sys_now();
    pcb->recv = NULL;
    pcb->sent = NULL;
    pcb->poll = NULL;
    pcb->connected = NULL;

    switch (pcb->state) {
        case CLOSED:
            tcp_pcb_unlink_and_free(pcb);
            return ERR_OK;
        case SYN_SENT:
        case SYN_RCVD:
            tcp_send_ctrl(&pcb->local_ip, &pcb->remote_ip, pcb->local_port, pcb->remote_port,
                          pcb->snd_nxt, pcb->rcv_nxt, TCP_RST | TCP_ACK, 0U, NULL);
            tcp_pcb_unlink_and_free(pcb);
            return ERR_OK;
        case ESTABLISHED:
            pcb->state = FIN_WAIT_1;
            pcb->fin_queued = 1U;
            pcb->fin_seq = pcb->snd_lbb;
            pcb->nrtx = 0U;
            tcp_clear_persist_timer(pcb);
#if TCPIP_VERIFY_FSM
            if (pcb->fsm.state == ESTABLISHED) {
                (void)tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_APP_CLOSE, NULL, 0, NULL, NULL, NULL);
            }
#endif
            tcp_output(pcb);
            return ERR_OK;
        case CLOSE_WAIT:
            pcb->state = LAST_ACK;
            pcb->fin_queued = 1U;
            pcb->fin_seq = pcb->snd_lbb;
            pcb->nrtx = 0U;
            tcp_clear_persist_timer(pcb);
#if TCPIP_VERIFY_FSM
            if (pcb->fsm.state == CLOSE_WAIT) {
                (void)tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_APP_CLOSE, NULL, 0, NULL, NULL, NULL);
            }
#endif
            tcp_output(pcb);
            return ERR_OK;
        default:
            (void)now_ms;
            return ERR_OK;
    }
}

void tcp_abort(struct tcp_pcb *pcb) {
    if (!pcb) return;
    if (tcp_find_listen_pcb(pcb) != NULL) {
        tcp_close(pcb);
        return;
    }
    if (pcb->state != CLOSED && pcb->state != TIME_WAIT) {
        tcp_send_ctrl(&pcb->local_ip, &pcb->remote_ip, pcb->local_port, pcb->remote_port,
                      pcb->snd_nxt, pcb->rcv_nxt, TCP_RST | TCP_ACK, 0U, NULL);
    }
    tcp_err_fn ef = pcb->errf;
    void *arg = pcb->callback_arg;
    tcp_pcb_unlink_and_free(pcb);
    if (ef) ef(arg, ERR_ABRT);
}

void tcp_arg(struct tcp_pcb *pcb, void *arg) {
    if (!pcb) return;
    struct tcp_pcb_listen *lp = tcp_find_listen_pcb(pcb);
    if (lp != NULL) {
        lp->callback_arg = arg;
    } else {
        pcb->callback_arg = arg;
    }
}

void tcp_recv(struct tcp_pcb *pcb, tcp_recv_fn recv) {
    if (pcb && !tcp_find_listen_pcb(pcb)) pcb->recv = recv;
}

void tcp_sent(struct tcp_pcb *pcb, tcp_sent_fn sent) {
    if (pcb && !tcp_find_listen_pcb(pcb)) pcb->sent = sent;
}

void tcp_err(struct tcp_pcb *pcb, tcp_err_fn err) {
    if (pcb && !tcp_find_listen_pcb(pcb)) pcb->errf = err;
}

void tcp_poll(struct tcp_pcb *pcb, tcp_poll_fn poll, uint8_t interval) {
    if (pcb && !tcp_find_listen_pcb(pcb)) {
        pcb->poll = poll;
        pcb->poll_interval_ticks = interval;
    }
}

uint16_t tcp_sndbuf(const struct tcp_pcb *pcb) {
    if (!pcb || (pcb->state != ESTABLISHED && pcb->state != CLOSE_WAIT)) return 0U;
    return pcb->snd_buf_used >= TCPIP_TCP_SND_BUF ? (uint16_t)0 : (uint16_t)(TCPIP_TCP_SND_BUF - pcb->snd_buf_used);
}

tcp_state_t tcp_state_get(const struct tcp_pcb *pcb) {
    if (!pcb) return CLOSED;
    if (tcp_find_listen_pcb(pcb) != NULL) return LISTEN;
    return pcb->state;
}

void tcp_tmr(uint32_t now_ms) {
    /* 1. Active PCBs: delayed ACK, retransmit (exponential backoff), persist (ZWP), poll */
    struct tcp_pcb *pcb = tcp_active_pcbs;
    while (pcb != NULL) {
        struct tcp_pcb *next = pcb->next;
        if (pcb->delayed_ack_active && (int32_t)(now_ms - pcb->delayed_ack_deadline_ms) >= 0) {
            tcp_send_empty_ack(pcb);
        }
        if (pcb->rtx_active && (int32_t)(now_ms - pcb->rtx_deadline_ms) >= 0) {
            if (pcb->nrtx >= 8U) {
#if TCPIP_VERIFY_FSM
                tcp_fsm_tick(&pcb->fsm, (int64_t)now_ms, NULL, NULL);
#endif
                tcp_err_fn ef = pcb->errf;
                void *arg = pcb->callback_arg;
                tcp_send_ctrl(&pcb->local_ip, &pcb->remote_ip, pcb->local_port, pcb->remote_port,
                              pcb->snd_nxt, pcb->rcv_nxt, TCP_RST | TCP_ACK, 0U, NULL);
                tcp_pcb_unlink_and_free(pcb);
                if (ef) ef(arg, ERR_ABRT);
                pcb = next;
                continue;
            }
            pcb->nrtx++;
            pcb->rto_ms = pcb->rto_ms <= 30000U ? pcb->rto_ms * 2U : 60000U;
            pcb->ssthresh = (pcb->cwnd / 2U) > (uint32_t)(2U * pcb->mss) ? (pcb->cwnd / 2U) : (uint32_t)(2U * pcb->mss);
            pcb->cwnd = pcb->mss;
            pcb->dupacks = 0U;
            pcb->in_fast_recovery = 0U;
#if TCPIP_VERIFY_FSM
            if (pcb->fsm.state == ESTABLISHED || pcb->fsm.state == SYN_SENT || pcb->fsm.state == SYN_RCVD ||
                pcb->fsm.state == FIN_WAIT_1 || pcb->fsm.state == CLOSING || pcb->fsm.state == LAST_ACK) {
                tcp_fsm_tick(&pcb->fsm, (int64_t)now_ms, NULL, NULL);
            }
#endif
            tcp_retransmit_una(pcb);
        } else if (pcb->persist_active && (int32_t)(now_ms - pcb->persist_deadline_ms) >= 0) {
            /* Zero-Window Probe (1 byte before snd_nxt or snd_una - 1 ACK probe) */
            uint16_t wnd = pcb->rcv_wnd > 65535U ? 65535U : (uint16_t)pcb->rcv_wnd;
            tcp_send_ctrl(&pcb->local_ip, &pcb->remote_ip, pcb->local_port, pcb->remote_port,
                          pcb->snd_nxt - 1U, pcb->rcv_nxt, TCP_ACK, wnd, NULL);
            if (pcb->persist_backoff < 7U) pcb->persist_backoff++;
            tcp_set_persist_timer(pcb, now_ms);
        }

        if (pcb->poll && pcb->poll_interval_ticks > 0U &&
            (int32_t)(now_ms - pcb->last_poll_ms) >= (int32_t)(pcb->poll_interval_ticks * 250U)) {
            pcb->last_poll_ms = now_ms;
            if (pcb->poll(pcb->callback_arg, pcb) != ERR_OK) {
                pcb = next;
                continue;
            }
        }
        pcb = next;
    }

    /* 2. TIME_WAIT expiry (use 4s accelerated 2*MSL for embed/test responsiveness;
     * or keep 60000ms configurable - define TCPIP_TCP_MSL_MS defaulting cleanly) */
    struct tcp_pcb *tw = tcp_tw_pcbs;
    while (tw != NULL) {
        struct tcp_pcb *next = tw->next;
        if ((int32_t)(now_ms - tw->timewait_deadline_ms) >= 0) {
#if TCPIP_VERIFY_FSM
            tcp_fsm_tick(&tw->fsm, (int64_t)now_ms, NULL, NULL);
#endif
            tcp_pcb_unlink_and_free(tw);
        }
        tw = next;
    }
}
