#include <string.h>
#include "tcpip/inet_chksum.h"
#include "tcpip/memp.h"
#include "tcpip/netif.h"
#include "tcpip/sys.h"
#include "tcpip/tcp.h"

extern struct tcp_pcb *tcp_active_pcbs;
extern struct tcp_pcb_listen *tcp_listen_pcbs;
extern struct tcp_pcb *tcp_tw_pcbs;

static inline uint16_t rd16be(const uint8_t *p) {
    return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}

static inline uint32_t rd32be(const uint8_t *p) {
    return ((uint32_t)p[0] << 24) | ((uint32_t)p[1] << 16) |
           ((uint32_t)p[2] << 8) | (uint32_t)p[3];
}

static uint16_t parse_mss_option(const uint8_t *hdr, uint16_t hlen) {
    uint16_t mss = TCPIP_TCP_MSS;
    uint16_t off = TCP_HLEN_MIN;
    while (off < hlen) {
        uint8_t kind = hdr[off];
        if (kind == 0U) break;
        if (kind == 1U) {
            off++;
            continue;
        }
        if (off + 1U >= hlen) break;
        uint8_t len = hdr[off + 1U];
        if (len < 2U || off + len > hlen) break;
        if (kind == 2U && len == 4U) {
            uint16_t opt_mss = rd16be(hdr + off + 2U);
            if (opt_mss >= 536U && opt_mss < mss) mss = opt_mss;
        }
        off = (uint16_t)(off + len);
    }
    return mss;
}

static void update_rtt_rto(struct tcp_pcb *pcb, uint32_t now_ms) {
    int32_t m = (int32_t)(now_ms - pcb->rtt_ts_ms);
    if (m < 1) m = 1;
    if (pcb->srtt_ms < 0) {
        pcb->srtt_ms = m << 3;
        pcb->rttvar_ms = (m << 2) / 2;
    } else {
        int32_t err = m - (pcb->srtt_ms >> 3);
        pcb->srtt_ms += err; /* g = 1/8 */
        int32_t abs_err = err < 0 ? -err : err;
        pcb->rttvar_ms += (abs_err - (pcb->rttvar_ms >> 2)); /* h = 1/4 */
    }
    int32_t rto = (pcb->srtt_ms >> 3) + (pcb->rttvar_ms > 0 ? pcb->rttvar_ms : 200);
    if (rto < 200) rto = 200;
    if (rto > 60000) rto = 60000;
    pcb->rto_ms = (uint32_t)rto;
}

static void advance_snd_buf(struct tcp_pcb *pcb, uint16_t data_acked) {
    if (data_acked == 0U) return;
    if (data_acked > pcb->snd_buf_used) data_acked = pcb->snd_buf_used;
    pcb->snd_buf_head = (pcb->snd_buf_head + data_acked) % TCPIP_TCP_SND_BUF;
    pcb->snd_buf_used = (uint16_t)(pcb->snd_buf_used - data_acked);
}

static void move_to_time_wait(struct tcp_pcb *pcb, uint32_t now_ms) {
    /* Unlink from active list and insert into TIME_WAIT list */
    struct tcp_pcb **pp = &tcp_active_pcbs;
    while (*pp != NULL) {
        if (*pp == pcb) {
            *pp = pcb->next;
            break;
        }
        pp = &(*pp)->next;
    }
    tcp_clear_rtx_timer(pcb);
    tcp_clear_persist_timer(pcb);
    tcp_pcb_purge_ooo(pcb);
    pcb->delayed_ack_active = 0U;
    pcb->recv = NULL;
    pcb->sent = NULL;
    pcb->errf = NULL;
    pcb->poll = NULL;
    pcb->connected = NULL;
    pcb->state = TIME_WAIT;
    pcb->timewait_deadline_ms = now_ms + 4000U;
    pcb->next = tcp_tw_pcbs;
    tcp_tw_pcbs = pcb;
}

static struct pbuf *slice_pbuf_copy(const struct pbuf *src, uint16_t offset, uint16_t len) {
    struct pbuf *out = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
    if (!out) return NULL;
    uint16_t rem = len;
    uint16_t cur = offset;
    struct pbuf *q = out;
    while (q != NULL && rem > 0U) {
        uint16_t n = rem < q->len ? rem : q->len;
        if (pbuf_copy_partial(src, q->payload, n, cur) != n) {
            pbuf_free(out);
            return NULL;
        }
        cur = (uint16_t)(cur + n);
        rem = (uint16_t)(rem - n);
        q = q->next;
    }
    return out;
}

static int deliver_in_order(struct tcp_pcb *pcb, struct pbuf *seg, uint32_t seg_seq,
                            uint16_t pay_off, uint16_t pay_len) {
    uint32_t trim_left = pcb->rcv_nxt - seg_seq;
    if (trim_left >= pay_len) return 0;
    uint16_t off = (uint16_t)(pay_off + trim_left);
    uint16_t avail = (uint16_t)(pay_len - trim_left);
    if ((uint32_t)avail > pcb->rcv_wnd) avail = (uint16_t)pcb->rcv_wnd;
    if (avail == 0U) return 0;

    struct pbuf *dp = slice_pbuf_copy(seg, off, avail);
    if (!dp) return -1;

    pcb->rcv_nxt += avail;
    pcb->rcv_wnd -= avail;
    pcb->flags |= TF_ACK_NOW;
    if (pcb->recv) {
        (void)pcb->recv(pcb->callback_arg, pcb, dp, ERR_OK);
    } else {
        pbuf_free(dp);
    }
    return tcp_pcb_is_active(pcb) ? 1 : -1;
}

static void insert_ooo_segment(struct tcp_pcb *pcb, struct pbuf *seg, uint32_t seg_seq,
                               uint16_t pay_off, uint16_t pay_len) {
    if (pcb->ooo_count >= TCPIP_TCP_OOO_MAX) return;
    if (TCP_SEQ_GEQ(seg_seq, pcb->rcv_nxt + pcb->rcv_wnd)) return;
    /* Drop duplicate start seq already queued */
    for (uint8_t i = 0; i < pcb->ooo_count; i++) {
        if (pcb->ooo[i].seq == seg_seq) return;
    }
    struct pbuf *cp = slice_pbuf_copy(seg, pay_off, pay_len);
    if (!cp) return;
    uint8_t pos = pcb->ooo_count;
    while (pos > 0U && TCP_SEQ_GT(pcb->ooo[pos - 1U].seq, seg_seq)) {
        pcb->ooo[pos] = pcb->ooo[pos - 1U];
        pos--;
    }
    pcb->ooo[pos].seq = seg_seq;
    pcb->ooo[pos].p = cp;
    pcb->ooo_count++;
}

static void drain_ooo_segments(struct tcp_pcb *pcb) {
    while (pcb->ooo_count > 0U) {
        tcp_ooo_seg_t *head = &pcb->ooo[0];
        uint32_t end_seq = head->seq + head->p->tot_len;
        if (TCP_SEQ_LEQ(end_seq, pcb->rcv_nxt)) {
            pbuf_free(head->p);
            for (uint8_t i = 1U; i < pcb->ooo_count; i++) pcb->ooo[i - 1U] = pcb->ooo[i];
            pcb->ooo_count--;
            continue;
        }
        if (TCP_SEQ_LEQ(head->seq, pcb->rcv_nxt)) {
            struct pbuf *hp = head->p;
            uint32_t hseq = head->seq;
            for (uint8_t i = 1U; i < pcb->ooo_count; i++) pcb->ooo[i - 1U] = pcb->ooo[i];
            pcb->ooo_count--;
            if (deliver_in_order(pcb, hp, hseq, 0U, hp->tot_len) < 0) {
                pbuf_free(hp);
                break;
            }
            pbuf_free(hp);
            continue;
        }
        break;
    }
}

static void handle_listen_segment(struct tcp_pcb_listen *lpcb, struct netif *inp,
                                  const ip4_addr_t *src, const ip4_addr_t *dst,
                                  uint16_t sport, uint16_t dport,
                                  uint32_t seq, uint32_t ack, uint8_t flags, uint16_t wnd,
                                  const uint8_t *hdr, uint16_t hlen, uint32_t now_ms) {
    if (flags & TCP_RST) return;
    if (flags & TCP_ACK) {
        tcp_send_ctrl(dst, src, dport, sport, ack, 0U, TCP_RST, 0U, inp);
        return;
    }
    if (!(flags & TCP_SYN)) return;
    if (lpcb->accepts_pending >= lpcb->backlog) return;

    struct tcp_pcb *npcb = tcp_new();
    if (!npcb) return;
    npcb->local_ip = *dst;
    npcb->remote_ip = *src;
    npcb->local_port = dport;
    npcb->remote_port = sport;
    npcb->listener = lpcb;
    npcb->callback_arg = lpcb->callback_arg;
    npcb->mss = parse_mss_option(hdr, hlen);
    npcb->snd_wnd = wnd;
    npcb->rcv_nxt = seq + 1U;
    uint32_t isn = 0x51A00001U + (now_ms * 131U) + ((uint32_t)sport << 8);
    npcb->snd_una = isn;
    npcb->snd_nxt = isn + 1U;
    npcb->snd_lbb = isn + 1U;
    npcb->state = SYN_RCVD;
    lpcb->accepts_pending++;

#if TCPIP_VERIFY_FSM
    tcp_fsm_init(&npcb->fsm);
    (void)tcp_fsm_step(&npcb->fsm, (int64_t)now_ms, TCP_FSM_EV_APP_LISTEN, NULL, 0, NULL, NULL, NULL);
    {
        fsa_val_t args[1] = { fsa_val_int((int64_t)wnd) };
        (void)tcp_fsm_step(&npcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_SYN, args, 1, NULL, NULL, NULL);
    }
#endif

    npcb->next = tcp_active_pcbs;
    tcp_active_pcbs = npcb;
    tcp_set_rtx_timer(npcb, now_ms);
    tcp_send_syn(npcb, TCP_SYN | TCP_ACK);
}

static void process_ack_and_data(struct tcp_pcb *pcb, struct pbuf *p, uint16_t hlen,
                                 uint32_t seq, uint32_t ack, uint8_t flags, uint16_t wnd,
                                 uint32_t now_ms) {
    uint16_t pay_len = (uint16_t)(p->tot_len - hlen);

    /* 1. ACK handling */
    if (flags & TCP_ACK) {
        if (ack == pcb->snd_una && pay_len == 0U && !(flags & TCP_FIN) &&
            TCP_SEQ_GT(pcb->snd_nxt, pcb->snd_una) && wnd == pcb->snd_wnd && wnd > 0U) {
            if (pcb->dupacks < 255U) pcb->dupacks++;
#if TCPIP_VERIFY_FSM
            if (pcb->fsm.state == TCP_FSM_STATE_ESTABLISHED) {
                tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_DUPACK, NULL, 0, NULL, NULL, NULL);
            }
#endif
            if (pcb->dupacks == 3U && !pcb->in_fast_recovery) {
                uint32_t eff = pcb->cwnd < pcb->snd_wnd ? pcb->cwnd : pcb->snd_wnd;
                pcb->ssthresh = (eff / 2U) > (uint32_t)(2U * pcb->mss) ? (eff / 2U) : (uint32_t)(2U * pcb->mss);
                pcb->cwnd = pcb->ssthresh + 3U * (uint32_t)pcb->mss;
                if (pcb->cwnd > 65535U) pcb->cwnd = 65535U;
                pcb->in_fast_recovery = 1U;
                pcb->recover = pcb->snd_nxt;
                tcp_retransmit_una(pcb);
            } else if (pcb->dupacks > 3U && pcb->in_fast_recovery) {
                pcb->cwnd += pcb->mss;
                if (pcb->cwnd > 65535U) pcb->cwnd = 65535U;
            }
        } else if (TCP_SEQ_GT(ack, pcb->snd_una) &&
                   TCP_SEQ_LEQ(ack, pcb->snd_una + pcb->snd_buf_used + (pcb->fin_queued ? 1U : 0U))) {
            uint32_t total_acked = ack - pcb->snd_una;
            uint16_t data_acked = (uint16_t)(total_acked <= pcb->snd_buf_used ? total_acked : pcb->snd_buf_used);
            if (pcb->fin_queued && TCP_SEQ_GT(ack, pcb->fin_seq)) {
                pcb->fin_acked = 1U;
            }
            if (pcb->rtt_active && TCP_SEQ_GT(ack, pcb->rtt_seq) && pcb->nrtx == 0U) {
                update_rtt_rto(pcb, now_ms);
                pcb->rtt_active = 0U;
            } else if (pcb->nrtx > 0U) {
                /* Restore normal RTO after backoff recovery so subsequent losses don't stay backed off at 16-60s */
                if (pcb->srtt_ms >= 0) {
                    int32_t base_rto = (pcb->srtt_ms >> 3) + (pcb->rttvar_ms > 0 ? pcb->rttvar_ms : 200);
                    if (base_rto < 200) base_rto = 200;
                    if (base_rto > 60000) base_rto = 60000;
                    pcb->rto_ms = (uint32_t)base_rto;
                } else {
                    pcb->rto_ms = 1000U;
                }
            }
            advance_snd_buf(pcb, data_acked);
            pcb->snd_una = ack;
            if (TCP_SEQ_LT(pcb->snd_nxt, pcb->snd_una)) pcb->snd_nxt = pcb->snd_una;
            pcb->snd_wnd = wnd;
            if (wnd > 0U) tcp_clear_persist_timer(pcb);

            /* RFC 5681 congestion window evolution */
            if (pcb->in_fast_recovery) {
                pcb->cwnd = pcb->ssthresh;
                pcb->in_fast_recovery = 0U;
            } else if (data_acked > 0U) {
                if (pcb->cwnd < pcb->ssthresh) {
                    uint32_t inc = data_acked < pcb->mss ? data_acked : pcb->mss;
                    pcb->cwnd += inc;
                } else {
                    uint32_t inc = ((uint32_t)pcb->mss * (uint32_t)pcb->mss) / (pcb->cwnd ? pcb->cwnd : pcb->mss);
                    if (inc == 0U) inc = 1U;
                    pcb->cwnd += inc;
                }
            }
            if (pcb->cwnd < pcb->mss) pcb->cwnd = pcb->mss;
            if (pcb->cwnd > 65535U) pcb->cwnd = 65535U;
            if (pcb->ssthresh < 2920U) pcb->ssthresh = 2920U;
            if (pcb->ssthresh > 65535U) pcb->ssthresh = 65535U;
            pcb->nrtx = 0U;
            pcb->dupacks = 0U;

#if TCPIP_VERIFY_FSM
            if (pcb->fsm.state == TCP_FSM_STATE_ESTABLISHED && data_acked > 0U) {
                int64_t fsm_una = pcb->fsm.v[TCP_FSM_SVAR_UNACKED];
                int64_t step_ack = (int64_t)data_acked;
                if (step_ack > fsm_una) step_ack = fsm_una;
                if (step_ack >= 1) {
                    fsa_val_t args[5] = {
                        fsa_val_int(step_ack),
                        fsa_val_int((int64_t)(wnd <= 65535U ? wnd : 65535U)),
                        fsa_val_int((int64_t)(pcb->cwnd < 1460U ? 1460U : (pcb->cwnd > 65535U ? 65535U : pcb->cwnd))),
                        fsa_val_int((int64_t)(pcb->ssthresh < 2920U ? 2920U : (pcb->ssthresh > 65535U ? 65535U : pcb->ssthresh))),
                        fsa_val_int((int64_t)(pcb->rto_ms < 200U ? 200U : (pcb->rto_ms > 60000U ? 60000U : pcb->rto_ms)))
                    };
                    tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_ACK_DATA, args, 5, NULL, NULL, NULL);
                }
            }
#endif
            if (TCP_SEQ_GT(pcb->snd_nxt, pcb->snd_una)) {
                tcp_set_rtx_timer(pcb, now_ms);
            } else {
                tcp_clear_rtx_timer(pcb);
            }
            if (pcb->state == FIN_WAIT_1 && pcb->fin_acked) {
                pcb->state = FIN_WAIT_2;
#if TCPIP_VERIFY_FSM
                if (pcb->fsm.state == TCP_FSM_STATE_FIN_WAIT_1) {
                    tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_ACK, NULL, 0, NULL, NULL, NULL);
                }
#endif
            } else if (pcb->state == CLOSING && pcb->fin_acked) {
#if TCPIP_VERIFY_FSM
                if (pcb->fsm.state == TCP_FSM_STATE_CLOSING) {
                    tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_ACK, NULL, 0, NULL, NULL, NULL);
                }
#endif
                move_to_time_wait(pcb, now_ms);
                return;
            } else if (pcb->state == LAST_ACK && pcb->fin_acked) {
#if TCPIP_VERIFY_FSM
                if (pcb->fsm.state == TCP_FSM_STATE_LAST_ACK) {
                    tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_ACK, NULL, 0, NULL, NULL, NULL);
                }
#endif
                tcp_pcb_unlink_and_free(pcb);
                return;
            }
            if (data_acked > 0U && pcb->sent) {
                if (pcb->sent(pcb->callback_arg, pcb, data_acked) != ERR_OK) {
                    return;
                }
                if (!tcp_pcb_is_active(pcb)) {
                    return;
                }
            }
        } else if (ack == pcb->snd_una) {
            pcb->snd_wnd = wnd;
            if (wnd > 0U) tcp_clear_persist_timer(pcb);
            pcb->dupacks = 0U;
        }
    }

    /* 2. Payload & OOO delivery (plus ZWP probe reply when seq < rcv_nxt) */
    if (pay_len > 0U && (pcb->state == ESTABLISHED || pcb->state == FIN_WAIT_1 || pcb->state == FIN_WAIT_2)) {
        if (seq == pcb->rcv_nxt || (TCP_SEQ_LT(seq, pcb->rcv_nxt) && TCP_SEQ_GT(seq + pay_len, pcb->rcv_nxt))) {
            (void)deliver_in_order(pcb, p, seq, hlen, pay_len);
            if (!tcp_pcb_is_active(pcb)) return;
            drain_ooo_segments(pcb);
            if (!tcp_pcb_is_active(pcb)) return;
        } else if (TCP_SEQ_GT(seq, pcb->rcv_nxt)) {
            insert_ooo_segment(pcb, p, seq, hlen, pay_len);
            pcb->flags |= TF_ACK_NOW;
        } else {
            /* Duplicate/old segment: ACK immediately so peer catches up */
            pcb->flags |= TF_ACK_NOW;
        }
    } else if (pay_len == 0U && !(flags & (TCP_SYN | TCP_FIN | TCP_RST)) &&
               TCP_SEQ_LT(seq, pcb->rcv_nxt)) {
        /* Zero-Window Probe or keepalive with old seq: reply with current rcv_wnd */
        pcb->flags |= TF_ACK_NOW;
    }

    /* 3. FIN tracking (deferred if payload came out-of-order ahead of rcv_nxt) */
    if ((flags & TCP_FIN) != 0U) {
        pcb->flags |= TF_GOT_FIN;
        pcb->fin_rx_seq = seq + pay_len;
    }

    if ((pcb->flags & TF_GOT_FIN) != 0U && pcb->rcv_nxt == pcb->fin_rx_seq) {
        pcb->flags &= (uint8_t)(~TF_GOT_FIN);
        pcb->rcv_nxt = pcb->fin_rx_seq + 1U;
        pcb->flags |= TF_ACK_NOW;
        if (pcb->state == ESTABLISHED) {
            pcb->state = CLOSE_WAIT;
#if TCPIP_VERIFY_FSM
            if (pcb->fsm.state == TCP_FSM_STATE_ESTABLISHED) {
                tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_FIN, NULL, 0, NULL, NULL, NULL);
            }
#endif
            if (pcb->recv) (void)pcb->recv(pcb->callback_arg, pcb, NULL, ERR_OK);
            if (!tcp_pcb_is_active(pcb)) return;
        } else if (pcb->state == FIN_WAIT_1) {
            if (pcb->fin_acked) {
                tcp_send_empty_ack(pcb);
#if TCPIP_VERIFY_FSM
                if (pcb->fsm.state == TCP_FSM_STATE_FIN_WAIT_1) {
                    tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_FINACK, NULL, 0, NULL, NULL, NULL);
                }
#endif
                if (pcb->recv) (void)pcb->recv(pcb->callback_arg, pcb, NULL, ERR_OK);
                if (tcp_pcb_is_active(pcb)) move_to_time_wait(pcb, now_ms);
                return;
            }
            pcb->state = CLOSING;
#if TCPIP_VERIFY_FSM
            if (pcb->fsm.state == TCP_FSM_STATE_FIN_WAIT_1) {
                tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_FIN, NULL, 0, NULL, NULL, NULL);
            }
#endif
            if (pcb->recv) (void)pcb->recv(pcb->callback_arg, pcb, NULL, ERR_OK);
            if (!tcp_pcb_is_active(pcb)) return;
        } else if (pcb->state == FIN_WAIT_2) {
            tcp_send_empty_ack(pcb);
#if TCPIP_VERIFY_FSM
            if (pcb->fsm.state == TCP_FSM_STATE_FIN_WAIT_2) {
                tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_FIN, NULL, 0, NULL, NULL, NULL);
            }
#endif
            if (pcb->recv) (void)pcb->recv(pcb->callback_arg, pcb, NULL, ERR_OK);
            if (tcp_pcb_is_active(pcb)) move_to_time_wait(pcb, now_ms);
            return;
        }
    }

    if (tcp_pcb_is_active(pcb)) {
        (void)tcp_output(pcb);
    }
}

void tcp_input(struct pbuf *p, struct netif *inp, const ip4_addr_t *src, const ip4_addr_t *dst) {
    if (!p || !inp || !src || !dst || p->len < TCP_HLEN_MIN || p->tot_len < TCP_HLEN_MIN) {
        if (p) pbuf_free(p);
        return;
    }
    const uint8_t *hdr = p->payload;
    uint16_t hlen = (uint16_t)((hdr[12] >> 4) * 4U);
    if (hlen < TCP_HLEN_MIN || hlen > p->len || hlen > p->tot_len) {
        pbuf_free(p);
        return;
    }
    if (inet_chksum_pseudo(p, IP_PROTO_TCP, p->tot_len, src, dst) != 0U) {
        pbuf_free(p);
        return;
    }

    uint16_t sport = rd16be(hdr + 0);
    uint16_t dport = rd16be(hdr + 2);
    uint32_t seq   = rd32be(hdr + 4);
    uint32_t ack   = rd32be(hdr + 8);
    uint8_t  flags = hdr[13];
    uint16_t wnd   = rd16be(hdr + 14);
    uint32_t now_ms = sys_now();

    /* 1. Active PCBs exact 4-tuple lookup */
    struct tcp_pcb *pcb = NULL;
    for (struct tcp_pcb *c = tcp_active_pcbs; c != NULL; c = c->next) {
        if (c->local_port == dport && c->remote_port == sport &&
            ip4_addr_cmp(&c->local_ip, dst) && ip4_addr_cmp(&c->remote_ip, src)) {
            pcb = c;
            break;
        }
    }

    if (pcb != NULL) {
        if (flags & TCP_RST) {
            if (pcb->state == SYN_SENT ? ((flags & TCP_ACK) && ack == pcb->snd_nxt) :
                TCP_SEQ_GEQ(seq, pcb->rcv_nxt)) {
#if TCPIP_VERIFY_FSM
                (void)tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_RST, NULL, 0, NULL, NULL, NULL);
#endif
                tcp_err_fn ef = pcb->errf;
                void *arg = pcb->callback_arg;
                tcp_pcb_unlink_and_free(pcb);
                if (ef) ef(arg, ERR_RST);
            }
            pbuf_free(p);
            return;
        }

        if (pcb->state == SYN_SENT) {
            if ((flags & (TCP_SYN | TCP_ACK)) == (TCP_SYN | TCP_ACK) && ack == pcb->snd_nxt) {
                pcb->mss = parse_mss_option(hdr, hlen);
                pcb->snd_una = ack;
                pcb->snd_wnd = wnd;
                pcb->rcv_nxt = seq + 1U;
                pcb->nrtx = 0U;
                pcb->dupacks = 0U;
                tcp_clear_rtx_timer(pcb);
                pcb->state = ESTABLISHED;
#if TCPIP_VERIFY_FSM
                {
                    fsa_val_t args[1] = { fsa_val_int((int64_t)wnd) };
                    (void)tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_SYNACK, args, 1, NULL, NULL, NULL);
                }
#endif
                tcp_send_empty_ack(pcb);
                if (pcb->connected) {
                    (void)pcb->connected(pcb->callback_arg, pcb, ERR_OK);
                }
            }
            pbuf_free(p);
            return;
        }

        if (pcb->state == SYN_RCVD) {
            if ((flags & TCP_ACK) != 0U && ack == pcb->snd_nxt) {
                pcb->snd_una = ack;
                pcb->snd_wnd = wnd;
                pcb->nrtx = 0U;
                pcb->dupacks = 0U;
                tcp_clear_rtx_timer(pcb);
                pcb->state = ESTABLISHED;
#if TCPIP_VERIFY_FSM
                {
                    fsa_val_t args[1] = { fsa_val_int((int64_t)wnd) };
                    (void)tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_RX_ACK_EST, args, 1, NULL, NULL, NULL);
                }
#endif
                struct tcp_pcb_listen *lp = pcb->listener;
                pcb->listener = NULL;
                if (lp) {
                    if (lp->accepts_pending > 0U) lp->accepts_pending--;
                    if (lp->accept) {
                        (void)lp->accept(lp->callback_arg, pcb, ERR_OK);
                    }
                }
                /* Process any piggybacked payload on final handshake ACK */
                if (p->tot_len > hlen || (flags & TCP_FIN)) {
                    process_ack_and_data(pcb, p, hlen, seq, ack, flags, wnd, now_ms);
                }
            } else if ((flags & TCP_SYN) != 0U && !(flags & TCP_ACK)) {
                /* Retransmitted client SYN: re-send SYN-ACK */
                tcp_send_syn(pcb, TCP_SYN | TCP_ACK);
            }
            pbuf_free(p);
            return;
        }

        process_ack_and_data(pcb, p, hlen, seq, ack, flags, wnd, now_ms);
        pbuf_free(p);
        return;
    }

    /* 2. TIME_WAIT list lookup */
    struct tcp_pcb *tw = NULL;
    for (struct tcp_pcb *c = tcp_tw_pcbs; c != NULL; c = c->next) {
        if (c->local_port == dport && c->remote_port == sport &&
            ip4_addr_cmp(&c->local_ip, dst) && ip4_addr_cmp(&c->remote_ip, src)) {
            tw = c;
            break;
        }
    }
    if (tw != NULL) {
        if ((flags & TCP_SYN) != 0U && !(flags & TCP_ACK)) {
            /* Recycle TIME_WAIT PCB for new connection matching a listener */
#if TCPIP_VERIFY_FSM
            (void)tcp_fsm_step(&tw->fsm, (int64_t)now_ms, TCP_FSM_EV_APP_ABORT, NULL, 0, NULL, NULL, NULL);
#endif
            tcp_pcb_unlink_and_free(tw);
        } else if (!(flags & TCP_RST)) {
            tcp_send_empty_ack(tw);
            pbuf_free(p);
            return;
        } else {
            pbuf_free(p);
            return;
        }
    }

    /* 3. Listen PCBs lookup */
    struct tcp_pcb_listen *exact_l = NULL;
    struct tcp_pcb_listen *any_l = NULL;
    for (struct tcp_pcb_listen *l = tcp_listen_pcbs; l != NULL; l = l->next) {
        if (l->local_port != dport) continue;
        if (ip4_addr_cmp(&l->local_ip, dst)) {
            exact_l = l;
            break;
        }
        if (ip4_addr_isany(&l->local_ip) && !any_l) any_l = l;
    }
    struct tcp_pcb_listen *lpcb = exact_l ? exact_l : any_l;
    if (lpcb != NULL) {
        handle_listen_segment(lpcb, inp, src, dst, sport, dport, seq, ack, flags, wnd, hdr, hlen, now_ms);
        pbuf_free(p);
        return;
    }

    /* 4. Unmatched port: send RFC 9293 RST */
    if (!(flags & TCP_RST)) {
        if (flags & TCP_ACK) {
            tcp_send_ctrl(dst, src, dport, sport, ack, 0U, TCP_RST, 0U, inp);
        } else {
            uint32_t seg_len = (uint32_t)(p->tot_len - hlen) + ((flags & TCP_SYN) ? 1U : 0U) + ((flags & TCP_FIN) ? 1U : 0U);
            tcp_send_ctrl(dst, src, dport, sport, 0U, seq + seg_len, TCP_RST | TCP_ACK, 0U, inp);
        }
    }
    pbuf_free(p);
}
