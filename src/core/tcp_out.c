#include <string.h>
#include "tcpip/inet_chksum.h"
#include "tcpip/netif.h"
#include "tcpip/sys.h"
#include "tcpip/tcp.h"

static inline void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}

static inline void wr32be(uint8_t *p, uint32_t v) {
    p[0] = (uint8_t)(v >> 24);
    p[1] = (uint8_t)((v >> 16) & 0xFFU);
    p[2] = (uint8_t)((v >> 8) & 0xFFU);
    p[3] = (uint8_t)(v & 0xFFU);
}

static void copy_from_ring(const struct tcp_pcb *pcb, uint32_t offset_from_una, uint8_t *dst, uint16_t len) {
    uint32_t pos = (pcb->snd_buf_head + offset_from_una) % TCPIP_TCP_SND_BUF;
    uint16_t first = (uint16_t)(TCPIP_TCP_SND_BUF - pos);
    if (first > len) first = len;
    memcpy(dst, pcb->snd_buf + pos, first);
    if (len > first) {
        memcpy(dst + first, pcb->snd_buf, (uint16_t)(len - first));
    }
}

static err_t tcp_ip_send(struct pbuf *seg, const ip4_addr_t *src, const ip4_addr_t *dst,
                         uint8_t ttl, uint8_t tos, struct netif *netif_hint) {
    struct netif *outif = netif_hint ? netif_hint : netif_route(dst);
    if (!outif) return ERR_RTE;
    ip4_addr_t chosen_src = (!src || ip4_addr_isany(src)) ? outif->ip_addr : *src;
    uint16_t chk = inet_chksum_pseudo(seg, IP_PROTO_TCP, seg->tot_len, &chosen_src, dst);
    wr16be(seg->payload + 16, chk);
    return ip4_output_if(seg, &chosen_src, dst, ttl ? ttl : (uint8_t)64, tos, IP_PROTO_TCP, outif);
}

err_t tcp_send_ctrl(const ip4_addr_t *src, const ip4_addr_t *dst,
                    uint16_t sport, uint16_t dport,
                    uint32_t seq, uint32_t ack, uint8_t flags, uint16_t wnd,
                    struct netif *netif_hint) {
    struct pbuf *seg = pbuf_alloc(PBUF_IP, TCP_HLEN_MIN, PBUF_POOL);
    if (!seg) return ERR_MEM;
    uint8_t *h = seg->payload;
    memset(h, 0, TCP_HLEN_MIN);
    wr16be(h + 0, sport);
    wr16be(h + 2, dport);
    wr32be(h + 4, seq);
    wr32be(h + 8, ack);
    h[12] = (uint8_t)(5U << 4);
    h[13] = flags;
    wr16be(h + 14, wnd);
    err_t err = tcp_ip_send(seg, src, dst, 64U, 0U, netif_hint);
    pbuf_free(seg);
    return err;
}

err_t tcp_send_empty_ack(struct tcp_pcb *pcb) {
    if (!pcb) return ERR_ARG;
    uint16_t wnd = pcb->rcv_wnd > 65535U ? 65535U : (uint16_t)pcb->rcv_wnd;
    pcb->delayed_ack_active = 0U;
    pcb->flags &= (uint8_t)(~(TF_ACK_NOW | TF_ACK_DELAY));
    return tcp_send_ctrl(&pcb->local_ip, &pcb->remote_ip, pcb->local_port, pcb->remote_port,
                         pcb->snd_nxt, pcb->rcv_nxt, TCP_ACK, wnd, NULL);
}

err_t tcp_send_syn(struct tcp_pcb *pcb, uint8_t flags) {
    if (!pcb) return ERR_ARG;
    uint16_t hlen = TCP_HLEN_MIN + 4U; /* MSS option (4 bytes) */
    struct pbuf *seg = pbuf_alloc(PBUF_IP, hlen, PBUF_POOL);
    if (!seg) return ERR_MEM;
    uint8_t *h = seg->payload;
    memset(h, 0, hlen);
    wr16be(h + 0, pcb->local_port);
    wr16be(h + 2, pcb->remote_port);
    wr32be(h + 4, pcb->snd_una);
    wr32be(h + 8, (flags & TCP_ACK) ? pcb->rcv_nxt : 0U);
    h[12] = (uint8_t)((hlen / 4U) << 4);
    h[13] = flags;
    uint16_t wnd = pcb->rcv_wnd > 65535U ? 65535U : (uint16_t)pcb->rcv_wnd;
    wr16be(h + 14, wnd);
    /* MSS Option: kind=2, len=4, value=pcb->mss */
    h[20] = 2U;
    h[21] = 4U;
    wr16be(h + 22, pcb->mss ? pcb->mss : TCPIP_TCP_MSS);

    err_t err = tcp_ip_send(seg, &pcb->local_ip, &pcb->remote_ip, pcb->ttl, pcb->tos, NULL);
    pbuf_free(seg);
    return err;
}

err_t tcp_send_fin_only(struct tcp_pcb *pcb, uint32_t seq) {
    uint16_t wnd = pcb->rcv_wnd > 65535U ? 65535U : (uint16_t)pcb->rcv_wnd;
    return tcp_send_ctrl(&pcb->local_ip, &pcb->remote_ip, pcb->local_port, pcb->remote_port,
                         seq, pcb->rcv_nxt, TCP_FIN | TCP_ACK, wnd, NULL);
}

static err_t tcp_send_data_segment(struct tcp_pcb *pcb, uint32_t seq, uint16_t len, uint8_t extra_flags) {
    uint32_t off = seq - pcb->snd_una;
    if (off + len > pcb->snd_buf_used) return ERR_VAL;
    struct pbuf *seg = pbuf_alloc(PBUF_IP, (uint16_t)(TCP_HLEN_MIN + len), PBUF_POOL);
    if (!seg) return ERR_MEM;
    uint8_t *h = seg->payload;
    memset(h, 0, TCP_HLEN_MIN);
    wr16be(h + 0, pcb->local_port);
    wr16be(h + 2, pcb->remote_port);
    wr32be(h + 4, seq);
    wr32be(h + 8, pcb->rcv_nxt);
    h[12] = (uint8_t)(5U << 4);
    h[13] = (uint8_t)(TCP_ACK | extra_flags);
    uint16_t wnd = pcb->rcv_wnd > 65535U ? 65535U : (uint16_t)pcb->rcv_wnd;
    wr16be(h + 14, wnd);
    if (len > 0U) {
        uint8_t tmp[TCPIP_TCP_MSS + 64U];
        uint16_t chunk = len;
        if (chunk > sizeof(tmp)) chunk = sizeof(tmp);
        copy_from_ring(pcb, off, tmp, chunk);
        if (pbuf_take_at(seg, tmp, chunk, TCP_HLEN_MIN) != ERR_OK) {
            pbuf_free(seg);
            return ERR_BUF;
        }
    }
    err_t err = tcp_ip_send(seg, &pcb->local_ip, &pcb->remote_ip, pcb->ttl, pcb->tos, NULL);
    pbuf_free(seg);
    return err;
}

err_t tcp_retransmit_una(struct tcp_pcb *pcb) {
    if (!pcb) return ERR_ARG;
    uint32_t now_ms = sys_now();
    if (pcb->state == SYN_SENT) {
        return tcp_send_syn(pcb, TCP_SYN);
    }
    if (pcb->state == SYN_RCVD) {
        return tcp_send_syn(pcb, TCP_SYN | TCP_ACK);
    }
    uint32_t unsent_off = pcb->snd_nxt - pcb->snd_una;
    uint16_t data_unacked = (uint16_t)(pcb->snd_buf_used > unsent_off ? unsent_off : pcb->snd_buf_used);
    if (data_unacked > 0U) {
        uint16_t mss = pcb->mss ? pcb->mss : TCPIP_TCP_MSS;
        uint16_t chunk = data_unacked > mss ? mss : data_unacked;
        err_t err = tcp_send_data_segment(pcb, pcb->snd_una, chunk, TCP_PSH);
        pcb->rtt_active = 0U; /* Karn's algorithm */
        tcp_set_rtx_timer(pcb, now_ms);
        return err;
    }
    if (pcb->fin_queued && !pcb->fin_acked) {
        err_t err = tcp_send_fin_only(pcb, pcb->fin_seq);
        tcp_set_rtx_timer(pcb, now_ms);
        return err;
    }
    tcp_clear_rtx_timer(pcb);
    return ERR_OK;
}

err_t tcp_output(struct tcp_pcb *pcb) {
    if (!pcb) return ERR_ARG;
    if (pcb->state != ESTABLISHED && pcb->state != CLOSE_WAIT &&
        pcb->state != FIN_WAIT_1 && pcb->state != CLOSING && pcb->state != LAST_ACK) {
        return ERR_OK;
    }

    uint32_t now_ms = sys_now();
    uint32_t sent_bytes = 0;
    uint16_t mss = pcb->mss ? pcb->mss : TCPIP_TCP_MSS;

    for (;;) {
        uint32_t eff_wnd = pcb->snd_wnd < pcb->cwnd ? pcb->snd_wnd : pcb->cwnd;
        uint32_t data_end_seq = pcb->snd_una + pcb->snd_buf_used;
        if (!TCP_SEQ_LT(pcb->snd_nxt, data_end_seq)) break;

        uint32_t in_flight = pcb->snd_nxt - pcb->snd_una;
        if (in_flight >= eff_wnd) {
            break;
        }
        uint32_t avail_wnd = eff_wnd - in_flight;
        uint32_t rem = data_end_seq - pcb->snd_nxt;
        uint16_t seg_len = (uint16_t)(rem < mss ? rem : mss);
        if ((uint32_t)seg_len > avail_wnd) {
            seg_len = (uint16_t)avail_wnd;
        }
        if (seg_len == 0U) break;

        uint32_t seg_seq = pcb->snd_nxt;
        uint8_t extra = (seg_len == rem) ? TCP_PSH : 0U;
        if (!pcb->rtt_active) {
            pcb->rtt_active = 1U;
            pcb->rtt_seq = seg_seq;
            pcb->rtt_ts_ms = now_ms;
        }
        pcb->snd_nxt = seg_seq + seg_len;
        pcb->delayed_ack_active = 0U;
        pcb->flags &= (uint8_t)(~(TF_ACK_NOW | TF_ACK_DELAY));

#if TCPIP_VERIFY_FSM
        {
            int64_t fsm_unacked = pcb->fsm.v[TCP_FSM_SVAR_UNACKED];
            if (pcb->fsm.state == TCP_FSM_STATE_ESTABLISHED && pcb->fsm.v[TCP_FSM_SVAR_SND_WND] >= 1 &&
                seg_len >= 1U && seg_len <= 1460U && fsm_unacked + (int64_t)seg_len <= 65535) {
                fsa_val_t args[1] = { fsa_val_int((int64_t)seg_len) };
                tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_APP_SEND, args, 1, NULL, NULL, NULL);
            }
        }
#endif

        err_t err = tcp_send_data_segment(pcb, seg_seq, seg_len, extra);
        if (!tcp_pcb_is_active(pcb)) return ERR_OK;
        if (err != ERR_OK) {
            /* Restore only if peer hasn't already advanced snd_una past seg_seq */
            if (TCP_SEQ_LT(pcb->snd_una, seg_seq + seg_len)) {
                pcb->snd_nxt = seg_seq;
            }
            return err;
        }
        sent_bytes += seg_len;
    }

    uint32_t end_seq_after = pcb->snd_una + pcb->snd_buf_used;
    /* Send FIN if all buffered bytes have been emitted and FIN not yet transmitted */
    if (pcb->fin_queued && TCP_SEQ_GEQ(pcb->snd_nxt, end_seq_after) &&
        pcb->snd_nxt == pcb->fin_seq) {
        pcb->snd_nxt = pcb->fin_seq + 1U;
        pcb->delayed_ack_active = 0U;
        pcb->flags &= (uint8_t)(~(TF_ACK_NOW | TF_ACK_DELAY));
        err_t ferr = tcp_send_fin_only(pcb, pcb->fin_seq);
        if (!tcp_pcb_is_active(pcb)) return ERR_OK;
        if (ferr != ERR_OK) {
            pcb->snd_nxt = pcb->fin_seq;
            return ferr;
        }
        sent_bytes += 1U;
    }

    if (sent_bytes > 0U || (TCP_SEQ_GT(pcb->snd_nxt, pcb->snd_una) && !pcb->rtx_active)) {
        tcp_set_rtx_timer(pcb, now_ms);
    }

    /* Enter Zero-Window Persist when send data waits on snd_wnd == 0 */
    if (pcb->snd_wnd == 0U && TCP_SEQ_LT(pcb->snd_nxt, end_seq_after) && !pcb->persist_active) {
        tcp_clear_rtx_timer(pcb);
        pcb->persist_backoff = 0U;
        tcp_set_persist_timer(pcb, now_ms);
#if TCPIP_VERIFY_FSM
        if (pcb->fsm.state == TCP_FSM_STATE_ESTABLISHED && pcb->fsm.v[TCP_FSM_SVAR_SND_WND] == 0) {
            tcp_fsm_step(&pcb->fsm, (int64_t)now_ms, TCP_FSM_EV_ENTER_ZWP, NULL, 0, NULL, NULL, NULL);
        }
#endif
    }

    if ((pcb->flags & TF_ACK_NOW) != 0U) {
        return tcp_send_empty_ack(pcb);
    }
    return ERR_OK;
}
