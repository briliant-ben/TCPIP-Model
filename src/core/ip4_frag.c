#include <string.h>
#include "tcpip/etharp.h"
#include "tcpip/icmp.h"
#include "tcpip/inet_chksum.h"
#include "tcpip/ip4.h"
#if TCPIP_VERIFY_FSM
#include "ip_reass_fsm.h"
#endif

#define IP_REASS_TMO_MS   30000U
#define IP_REASS_MAX_SPAN 32

typedef struct {
    uint16_t start;
    uint16_t end;
} reass_span_t;

typedef struct {
    int used;
    ip4_addr_t src;
    ip4_addr_t dst;
    uint16_t id;
    uint8_t proto;
    uint8_t hdr_len;
    uint8_t has_last;
    uint8_t nspans;
    uint16_t tot_payload;
    uint16_t rcv_bytes;
    uint32_t ts_ms;
    uint8_t hdr[60];
    uint8_t data[TCPIP_IP_REASS_MAX_LEN];
    reass_span_t spans[IP_REASS_MAX_SPAN];
#if TCPIP_VERIFY_FSM
    ip_reass_fsm_machine_t fsm;
#endif
} ip_reass_slot_t;

static ip_reass_slot_t reass_slots[TCPIP_IP_REASS_MAX_SLOTS];

static inline uint16_t rd16be(const uint8_t *p) {
    return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}

static inline void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}

void ip4_reass_reset(void) {
    memset(reass_slots, 0, sizeof(reass_slots));
#if TCPIP_VERIFY_FSM
    for (int i = 0; i < TCPIP_IP_REASS_MAX_SLOTS; i++) {
        ip_reass_fsm_init(&reass_slots[i].fsm);
    }
#endif
}

static uint16_t insert_span(ip_reass_slot_t *s, uint16_t start, uint16_t end) {
    uint16_t old_total = s->rcv_bytes;
    uint16_t new_start = start;
    uint16_t new_end = end;
    reass_span_t merged[IP_REASS_MAX_SPAN];
    uint8_t mcount = 0;
    int inserted = 0;

    for (uint8_t i = 0; i < s->nspans; i++) {
        uint16_t a = s->spans[i].start;
        uint16_t b = s->spans[i].end;
        if (b < new_start) {
            if (mcount < IP_REASS_MAX_SPAN) merged[mcount++] = s->spans[i];
        } else if (new_end < a) {
            if (!inserted) {
                if (mcount >= IP_REASS_MAX_SPAN) return 0;
                merged[mcount].start = new_start;
                merged[mcount].end = new_end;
                mcount++;
                inserted = 1;
            }
            if (mcount < IP_REASS_MAX_SPAN) merged[mcount++] = s->spans[i];
        } else {
            if (a < new_start) new_start = a;
            if (b > new_end) new_end = b;
        }
    }
    if (!inserted) {
        if (mcount >= IP_REASS_MAX_SPAN) return 0;
        merged[mcount].start = new_start;
        merged[mcount].end = new_end;
        mcount++;
    }
    memcpy(s->spans, merged, mcount * sizeof(reass_span_t));
    s->nspans = mcount;
    uint16_t total = 0;
    for (uint8_t i = 0; i < s->nspans; i++) {
        total = (uint16_t)(total + (s->spans[i].end - s->spans[i].start));
    }
    s->rcv_bytes = total;
    return (uint16_t)(total > old_total ? total - old_total : 0U);
}

struct pbuf *ip4_reass(struct pbuf *p, uint32_t now_ms) {
    if (!p || p->len < IP_HLEN_MIN) {
        if (p) pbuf_free(p);
        return NULL;
    }
    const uint8_t *hdr = p->payload;
    uint8_t hlen = (uint8_t)((hdr[0] & 0x0FU) * 4U);
    uint16_t tot_len = rd16be(hdr + 2);
    uint16_t id = rd16be(hdr + 4);
    uint16_t frag_off = rd16be(hdr + 6);
    uint8_t proto = hdr[9];
    uint16_t offset = (uint16_t)((frag_off & IP_OFFMASK) * 8U);
    int mf = (frag_off & IP_MF) != 0U;

    if (hlen < IP_HLEN_MIN || hlen > 60U || tot_len <= hlen || tot_len > p->tot_len) {
        pbuf_free(p);
        return NULL;
    }
    uint16_t plen = (uint16_t)(tot_len - hlen);
    if (mf && (plen & 7U) != 0U) {
        pbuf_free(p);
        return NULL;
    }
    if ((uint32_t)offset + (uint32_t)plen > TCPIP_IP_REASS_MAX_LEN) {
        pbuf_free(p);
        return NULL;
    }

    ip4_addr_t src, dst;
    memcpy(&src.addr, hdr + 12, 4);
    memcpy(&dst.addr, hdr + 16, 4);

    ip_reass_slot_t *slot = NULL;
    ip_reass_slot_t *free_slot = NULL;
    for (int i = 0; i < TCPIP_IP_REASS_MAX_SLOTS; i++) {
        ip_reass_slot_t *s = &reass_slots[i];
        if (!s->used) {
            if (!free_slot) free_slot = s;
        } else if (s->id == id && s->proto == proto &&
                   ip4_addr_cmp(&s->src, &src) && ip4_addr_cmp(&s->dst, &dst)) {
            slot = s;
            break;
        }
    }

    int is_new = 0;
    if (!slot) {
        if (!free_slot) {
            /* Evict oldest incomplete slot */
            ip_reass_slot_t *oldest = &reass_slots[0];
            for (int i = 1; i < TCPIP_IP_REASS_MAX_SLOTS; i++) {
                if ((uint32_t)(now_ms - reass_slots[i].ts_ms) > (uint32_t)(now_ms - oldest->ts_ms)) {
                    oldest = &reass_slots[i];
                }
            }
#if TCPIP_VERIFY_FSM
            ip_reass_fsm_step(&oldest->fsm, (int64_t)now_ms, IP_REASS_FSM_EV_RELEASE, NULL, 0, NULL, NULL, NULL);
#endif
            memset(oldest, 0, sizeof(*oldest));
#if TCPIP_VERIFY_FSM
            ip_reass_fsm_init(&oldest->fsm);
#endif
            free_slot = oldest;
        }
        slot = free_slot;
        is_new = 1;
        memset(slot, 0, sizeof(*slot));
        slot->used = 1;
        slot->src = src;
        slot->dst = dst;
        slot->id = id;
        slot->proto = proto;
        slot->ts_ms = now_ms;
#if TCPIP_VERIFY_FSM
        ip_reass_fsm_init(&slot->fsm);
#endif
    }

    if (offset == 0 || slot->hdr_len == 0) {
        slot->hdr_len = hlen;
        memcpy(slot->hdr, hdr, hlen);
    }

    if (pbuf_copy_partial(p, slot->data + offset, plen, hlen) != plen) {
        pbuf_free(p);
        return NULL;
    }

    uint16_t end = (uint16_t)(offset + plen);
    uint16_t added = insert_span(slot, offset, end);
    if (!mf) {
        slot->has_last = 1;
        slot->tot_payload = end;
    }

    int done = slot->has_last && slot->nspans == 1 &&
               slot->spans[0].start == 0 && slot->spans[0].end == slot->tot_payload;

#if TCPIP_VERIFY_FSM
    if (is_new) {
        fsa_val_t args[3] = {
            fsa_val_int((int64_t)added),
            fsa_val_bool(!mf ? 1 : 0),
            fsa_val_int((int64_t)(!mf ? end : 0))
        };
        ip_reass_fsm_step(&slot->fsm, (int64_t)now_ms, IP_REASS_FSM_EV_ALLOC_FRAG, args, 3, NULL, NULL, NULL);
    } else {
        int64_t flen = slot->has_last ? (int64_t)slot->tot_payload : 0;
        fsa_val_t args[4] = {
            fsa_val_int((int64_t)added),
            fsa_val_bool(!mf ? 1 : 0),
            fsa_val_int(flen),
            fsa_val_bool(done ? 1 : 0)
        };
        ip_reass_fsm_step(&slot->fsm, (int64_t)now_ms, IP_REASS_FSM_EV_ADD_FRAG, args, 4, NULL, NULL, NULL);
    }
#else
    (void)is_new;
    (void)added;
#endif

    pbuf_free(p);
    if (!done) return NULL;

    uint16_t full_len = (uint16_t)(slot->hdr_len + slot->tot_payload);
    struct pbuf *out = pbuf_alloc(PBUF_RAW, full_len, PBUF_POOL);
    if (!out) {
#if TCPIP_VERIFY_FSM
        ip_reass_fsm_step(&slot->fsm, (int64_t)now_ms, IP_REASS_FSM_EV_RELEASE, NULL, 0, NULL, NULL, NULL);
#endif
        slot->used = 0;
        return NULL;
    }
    uint8_t *oh = out->payload;
    memcpy(oh, slot->hdr, slot->hdr_len);
    wr16be(oh + 2, full_len);
    wr16be(oh + 6, 0U);
    wr16be(oh + 10, 0U);
    wr16be(oh + 10, inet_chksum(oh, slot->hdr_len));
    if (pbuf_take_at(out, slot->data, slot->tot_payload, slot->hdr_len) != ERR_OK) {
        pbuf_free(out);
#if TCPIP_VERIFY_FSM
        ip_reass_fsm_step(&slot->fsm, (int64_t)now_ms, IP_REASS_FSM_EV_RELEASE, NULL, 0, NULL, NULL, NULL);
#endif
        slot->used = 0;
        return NULL;
    }

#if TCPIP_VERIFY_FSM
    ip_reass_fsm_step(&slot->fsm, (int64_t)now_ms, IP_REASS_FSM_EV_RELEASE, NULL, 0, NULL, NULL, NULL);
#endif
    slot->used = 0;
    return out;
}

void ip4_reass_tmr(uint32_t now_ms) {
    for (int i = 0; i < TCPIP_IP_REASS_MAX_SLOTS; i++) {
        ip_reass_slot_t *s = &reass_slots[i];
        if (!s->used) continue;
        if ((uint32_t)(now_ms - s->ts_ms) >= IP_REASS_TMO_MS) {
#if TCPIP_VERIFY_FSM
            ip_reass_fsm_tick(&s->fsm, (int64_t)now_ms, NULL, NULL);
#endif
            if (s->hdr_len >= IP_HLEN_MIN) {
                struct pbuf *orig = pbuf_alloc(PBUF_RAW, s->hdr_len + 8U, PBUF_POOL);
                if (orig) {
                    memcpy(orig->payload, s->hdr, s->hdr_len);
                    memcpy(orig->payload + s->hdr_len, s->data, 8U);
                    icmp_time_exceeded(orig, ICMP_TE_FRAG);
                    pbuf_free(orig);
                }
            }
            s->used = 0;
        }
    }
}

err_t ip4_frag(struct pbuf *p, struct netif *netif, const ip4_addr_t *dest) {
    if (!p || !netif || !dest || p->len < IP_HLEN_MIN) return ERR_ARG;
    const uint8_t *orig_hdr = p->payload;
    uint16_t hlen = (uint16_t)((orig_hdr[0] & 0x0FU) * 4U);
    if (hlen < IP_HLEN_MIN || hlen > p->tot_len) return ERR_BUF;
    uint16_t orig_flags = rd16be(orig_hdr + 6);
    if (orig_flags & IP_DF) {
        return ERR_VAL;
    }
    uint16_t mtu = netif->mtu ? netif->mtu : 1500U;
    if (mtu < hlen + 8U) return ERR_VAL;

    uint16_t max_pay = (uint16_t)(((mtu - hlen) / 8U) * 8U);
    uint16_t total_pay = (uint16_t)(p->tot_len - hlen);
    uint16_t off = 0;
    uint16_t base_off_units = (uint16_t)(orig_flags & IP_OFFMASK);
    int orig_mf = (orig_flags & IP_MF) != 0U;

    while (off < total_pay) {
        uint16_t rem = (uint16_t)(total_pay - off);
        uint16_t chunk = rem > max_pay ? max_pay : rem;
        int more = (off + chunk < total_pay) || orig_mf;

        struct pbuf *frag = pbuf_alloc(PBUF_LINK, (uint16_t)(hlen + chunk), PBUF_POOL);
        if (!frag) return ERR_MEM;
        uint8_t *fh = frag->payload;
        memcpy(fh, orig_hdr, hlen);
        wr16be(fh + 2, (uint16_t)(hlen + chunk));
        uint16_t foff_field = (uint16_t)(base_off_units + (off / 8U));
        if (more) foff_field |= IP_MF;
        wr16be(fh + 6, foff_field);
        wr16be(fh + 10, 0U);
        wr16be(fh + 10, inet_chksum(fh, hlen));
        if (pbuf_copy_partial(p, fh + hlen, chunk, (uint16_t)(hlen + off)) != chunk) {
            pbuf_free(frag);
            return ERR_BUF;
        }
        err_t err = netif->output ? netif->output(netif, frag, dest) : ERR_IF;
        pbuf_free(frag);
        if (err != ERR_OK) return err;
        off = (uint16_t)(off + chunk);
    }
    return ERR_OK;
}
