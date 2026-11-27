#include <string.h>
#include "tcpip/memp.h"
#include "tcpip/opt.h"
#include "tcpip/pbuf.h"

#if TCPIP_VERIFY_FSM
#include "pbuf_fsm.h"
#endif

#if !TCPIP_NO_SYS
#include <pthread.h>
static pthread_mutex_t pbuf_lock = PTHREAD_MUTEX_INITIALIZER;
#define PBUF_LOCK()   pthread_mutex_lock(&pbuf_lock)
#define PBUF_UNLOCK() pthread_mutex_unlock(&pbuf_lock)
#else
#define PBUF_LOCK()   ((void)0)
#define PBUF_UNLOCK() ((void)0)
#endif

static uint16_t layer_offset(pbuf_layer layer) {
    switch (layer) {
        case PBUF_TRANSPORT: return 56U; /* 14 Eth + 2 align + 20 IP + 20 TCP */
        case PBUF_IP:        return 36U; /* 14 Eth + 2 align + 20 IP */
        case PBUF_LINK:      return 16U; /* 14 Eth + 2 align */
        case PBUF_RAW:
        default:             return 0U;
    }
}

#if TCPIP_VERIFY_FSM
static void pbuf_verify_init(pbuf_fsm_machine_t *fsm, uint16_t cap, uint16_t hdr, uint16_t len) {
    pbuf_fsm_init(fsm);
    fsa_val_t args[3] = { fsa_val_int((int64_t)cap), fsa_val_int((int64_t)hdr), fsa_val_int((int64_t)len) };
    (void)pbuf_fsm_step(fsm, 0, PBUF_FSM_EV_PBUF_ALLOC, args, 3, NULL, NULL, NULL);
}
#endif

struct pbuf *pbuf_alloc(pbuf_layer layer, uint16_t length, pbuf_type type) {
    uint16_t off = layer_offset(layer);
    if (type == PBUF_REF) {
        struct pbuf *p = (struct pbuf *)memp_malloc(MEMP_PBUF_HDR);
        if (!p) return NULL;
        memset(p, 0, sizeof(*p));
        p->ref = 1;
        p->type = (uint8_t)type;
        p->tot_len = length;
        p->len = length;
        p->cap = length;
        return p;
    }

    uint16_t first_avail = (uint16_t)(TCPIP_PBUF_POOL_BUFSIZE > off ? (uint16_t)(TCPIP_PBUF_POOL_BUFSIZE - off) : (uint16_t)0);
    if (first_avail == 0 && length > 0) return NULL;

    struct pbuf *head = NULL;
    struct pbuf *tail = NULL;
    uint16_t rem = length;
    int first = 1;

    do {
        uint16_t cur_off = first ? off : (uint16_t)0;
        uint16_t cur_avail = (uint16_t)(TCPIP_PBUF_POOL_BUFSIZE - cur_off);
        uint16_t chunk = rem > cur_avail ? cur_avail : rem;

        struct pbuf *p = (struct pbuf *)memp_malloc(MEMP_PBUF_POOL);
        if (!p) {
            if (head) pbuf_free(head);
            return NULL;
        }
        uint8_t *base = (uint8_t *)p + ((sizeof(struct pbuf) + 15U) & ~(size_t)15U);
        memset(p, 0, sizeof(*p));
        p->buf_base = base;
        p->payload = base + cur_off;
        p->cap = (uint16_t)TCPIP_PBUF_POOL_BUFSIZE;
        p->len = chunk;
        p->tot_len = length;
        p->ref = 1;
        p->type = (uint8_t)type;

#if TCPIP_VERIFY_FSM
        {
            pbuf_fsm_machine_t fsm;
            pbuf_verify_init(&fsm, p->cap, cur_off, chunk);
        }
#endif

        if (!head) {
            head = p;
            tail = p;
        } else {
            tail->next = p;
            tail = p;
        }
        rem = (uint16_t)(rem - chunk);
        first = 0;
    } while (rem > 0);

    /* Fix chained tot_len descending along chain */
    uint16_t acc = length;
    for (struct pbuf *q = head; q != NULL; q = q->next) {
        q->tot_len = acc;
        acc = (uint16_t)(acc - q->len);
    }
    return head;
}

struct pbuf *pbuf_alloc_ref(uint8_t *data, uint16_t length) {
    struct pbuf *p = pbuf_alloc(PBUF_RAW, length, PBUF_REF);
    if (!p) return NULL;
    p->payload = data;
    p->buf_base = data;
    return p;
}

void pbuf_ref(struct pbuf *p) {
    if (!p) return;
    PBUF_LOCK();
    if (p->ref < UINT16_MAX) {
        p->ref++;
    }
    PBUF_UNLOCK();
}

uint8_t pbuf_free(struct pbuf *p) {
    uint8_t freed = 0;
    while (p != NULL) {
        struct pbuf *next = NULL;
        uint16_t new_ref;
        PBUF_LOCK();
        if (p->ref > 0) p->ref--;
        new_ref = p->ref;
        if (new_ref == 0) {
            next = p->next;
            p->next = NULL;
        }
        PBUF_UNLOCK();

        if (new_ref == 0) {
            memp_t pool = (p->type == PBUF_REF) ? MEMP_PBUF_HDR : MEMP_PBUF_POOL;
            memp_free(pool, p);
            freed++;
            p = next;
        } else {
            break;
        }
    }
    return freed;
}

uint8_t pbuf_header(struct pbuf *p, int16_t header_size_increment) {
    if (!p || p->type == PBUF_REF || !p->buf_base) return 1;
    if (header_size_increment < 0) {
        uint16_t dec = (uint16_t)(-header_size_increment);
        size_t headroom = (size_t)(p->payload - p->buf_base);
        if (dec > headroom) return 1;
        p->payload -= dec;
        p->len = (uint16_t)(p->len + dec);
        p->tot_len = (uint16_t)(p->tot_len + dec);
        return 0;
    } else if (header_size_increment > 0) {
        uint16_t inc = (uint16_t)header_size_increment;
        if (inc > p->len) return 1;
        p->payload += inc;
        p->len = (uint16_t)(p->len - inc);
        p->tot_len = (uint16_t)(p->tot_len - inc);
        return 0;
    }
    return 0;
}

void pbuf_cat(struct pbuf *head, struct pbuf *tail) {
    if (!head || !tail) return;
    struct pbuf *q = head;
    while (q->next != NULL) {
        q->tot_len = (uint16_t)(q->tot_len + tail->tot_len);
        q = q->next;
    }
    q->tot_len = (uint16_t)(q->tot_len + tail->tot_len);
    q->next = tail;
}

void pbuf_chain(struct pbuf *head, struct pbuf *tail) {
    pbuf_ref(tail);
    pbuf_cat(head, tail);
}

err_t pbuf_take(struct pbuf *buf, const void *dataptr, uint16_t len) {
    return pbuf_take_at(buf, dataptr, len, 0U);
}

err_t pbuf_take_at(struct pbuf *buf, const void *dataptr, uint16_t len, uint16_t offset) {
    if (!buf || (!dataptr && len > 0) || (uint32_t)offset + (uint32_t)len > buf->tot_len) {
        return ERR_VAL;
    }
    const uint8_t *src = (const uint8_t *)dataptr;
    uint16_t rem = len;
    uint16_t skip = offset;
    for (struct pbuf *q = buf; q && rem > 0; q = q->next) {
        if (skip >= q->len) {
            skip = (uint16_t)(skip - q->len);
            continue;
        }
        uint16_t avail = (uint16_t)(q->len - skip);
        uint16_t n = rem < avail ? rem : avail;
        if (n > 0) {
            memcpy(q->payload + skip, src, n);
            src += n;
            rem = (uint16_t)(rem - n);
        }
        skip = 0;
    }
    return rem == 0 ? ERR_OK : ERR_BUF;
}

err_t pbuf_copy(struct pbuf *dst, const struct pbuf *src) {
    if (!dst || !src || src->tot_len > dst->tot_len) return ERR_VAL;
    uint16_t dst_off = 0;
    for (const struct pbuf *q = src; q != NULL; q = q->next) {
        if (q->len > 0) {
            err_t err = pbuf_take_at(dst, q->payload, q->len, dst_off);
            if (err != ERR_OK) return err;
            dst_off = (uint16_t)(dst_off + q->len);
        }
    }
    return ERR_OK;
}

uint16_t pbuf_copy_partial(const struct pbuf *buf, void *dataptr, uint16_t len, uint16_t offset) {
    if (!buf || !dataptr || len == 0) return 0;
    uint8_t *dst = (uint8_t *)dataptr;
    uint16_t copied = 0;
    uint16_t off = offset;
    for (const struct pbuf *q = buf; q && copied < len; q = q->next) {
        if (off >= q->len) {
            off = (uint16_t)(off - q->len);
            continue;
        }
        uint16_t avail = (uint16_t)(q->len - off);
        uint16_t n = (uint16_t)(len - copied);
        if (n > avail) n = avail;
        memcpy(dst + copied, q->payload + off, n);
        copied = (uint16_t)(copied + n);
        off = 0;
    }
    return copied;
}

void pbuf_realloc(struct pbuf *p, uint16_t new_len) {
    if (!p || new_len >= p->tot_len) return;
    uint16_t rem = new_len;
    struct pbuf *q = p;
    while (q != NULL) {
        if (rem <= q->len) {
            q->len = rem;
            q->tot_len = rem;
            if (q->next) {
                pbuf_free(q->next);
                q->next = NULL;
            }
            break;
        }
        q->tot_len = rem;
        rem = (uint16_t)(rem - q->len);
        q = q->next;
    }
}

uint8_t pbuf_clen(const struct pbuf *p) {
    uint8_t n = 0;
    for (const struct pbuf *q = p; q != NULL && n < UINT8_MAX; q = q->next) n++;
    return n;
}
