#ifndef TCPIP_PBUF_H
#define TCPIP_PBUF_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/opt.h"

typedef enum {
    PBUF_TRANSPORT = 0,
    PBUF_IP,
    PBUF_LINK,
    PBUF_RAW
} pbuf_layer;

typedef enum {
    PBUF_RAM = 0,
    PBUF_POOL,
    PBUF_REF
} pbuf_type;

struct pbuf {
    struct pbuf *next;
    uint8_t *payload;
    uint16_t tot_len;
    uint16_t len;
    uint16_t cap;
    uint16_t ref;
    uint8_t type;
    uint8_t flags;
    uint8_t *buf_base;
};

struct pbuf *pbuf_alloc(pbuf_layer layer, uint16_t length, pbuf_type type);
struct pbuf *pbuf_alloc_ref(uint8_t *data, uint16_t length);
void pbuf_ref(struct pbuf *p);
uint8_t pbuf_free(struct pbuf *p);
uint8_t pbuf_header(struct pbuf *p, int16_t header_size_increment);
void pbuf_cat(struct pbuf *head, struct pbuf *tail);
void pbuf_chain(struct pbuf *head, struct pbuf *tail);
err_t pbuf_take(struct pbuf *buf, const void *dataptr, uint16_t len);
err_t pbuf_take_at(struct pbuf *buf, const void *dataptr, uint16_t len, uint16_t offset);
err_t pbuf_copy(struct pbuf *dst, const struct pbuf *src);
uint16_t pbuf_copy_partial(const struct pbuf *buf, void *dataptr, uint16_t len, uint16_t offset);
void pbuf_realloc(struct pbuf *p, uint16_t new_len);
uint8_t pbuf_clen(const struct pbuf *p);

#endif /* TCPIP_PBUF_H */
