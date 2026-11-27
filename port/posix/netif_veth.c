#include <string.h>
#include "tcpip/netif_veth.h"
#include "tcpip/sys.h"
#include "tcpip/tcpip.h"

void veth_link_init(veth_link_t *cfg, struct netif *peer, tcpip_pcap_t *pcap, uint8_t use_tcpip_input) {
    if (!cfg) return;
    memset(cfg, 0, sizeof(*cfg));
    cfg->peer = peer;
    cfg->pcap = pcap;
    cfg->use_tcpip_input = use_tcpip_input ? 1U : 0U;
}

static struct pbuf *clone_to_pool(const struct pbuf *src) {
    if (!src || src->tot_len == 0) return NULL;
    struct pbuf *cp = pbuf_alloc(PBUF_RAW, src->tot_len, PBUF_POOL);
    if (!cp) return NULL;
    if (pbuf_copy(cp, src) != ERR_OK) {
        pbuf_free(cp);
        return NULL;
    }
    return cp;
}

static void deliver_frame(veth_link_t *cfg, struct netif *target, struct pbuf *frame) {
    if (!frame) return;
    if (!target || !target->input) {
        pbuf_free(frame);
        return;
    }
    cfg->rx_frames++;
    err_t err;
    if (cfg->use_tcpip_input) {
        err = tcpip_input(frame, target);
    } else {
        err = target->input(frame, target);
    }
    if (err != ERR_OK) {
        /* target->input takes ownership on ERR_OK; free on error */
        pbuf_free(frame);
    }
}

void veth_link_flush(veth_link_t *cfg, struct netif *from) {
    if (!cfg || !cfg->held_frame) return;
    struct pbuf *held = cfg->held_frame;
    cfg->held_frame = NULL;
    struct netif *target = cfg->peer ? cfg->peer : from;
    deliver_frame(cfg, target, held);
}

static err_t veth_linkoutput(struct netif *netif, struct pbuf *p) {
    if (!netif || !p || !netif->state) return ERR_ARG;
    veth_link_t *cfg = (veth_link_t *)netif->state;
    struct netif *target = cfg->peer ? cfg->peer : netif;
    uint32_t seq = ++cfg->tx_frames;

    if (cfg->pcap) {
        if (p->next == NULL) {
            tcpip_pcap_write(cfg->pcap, (uint64_t)sys_now() * 1000ULL, p->payload, p->len);
        } else {
            uint8_t flat[TCPIP_ETH_MAX_FRAME];
            uint16_t n = p->tot_len <= TCPIP_ETH_MAX_FRAME ? p->tot_len : TCPIP_ETH_MAX_FRAME;
            uint16_t copied = pbuf_copy_partial(p, flat, n, 0U);
            tcpip_pcap_write(cfg->pcap, (uint64_t)sys_now() * 1000ULL, flat, copied);
        }
    }

    if ((cfg->drop_every_n && (seq % cfg->drop_every_n) == 0) ||
        (cfg->drop_mask && seq <= 32U && ((cfg->drop_mask >> (seq - 1U)) & 1U) != 0U)) {
        cfg->dropped_frames++;
        return ERR_OK;
    }

    struct pbuf *cp = clone_to_pool(p);
    if (!cp) return ERR_MEM;

    if (cfg->reorder_every_n && !cfg->held_frame && (seq % cfg->reorder_every_n) == 0) {
        cfg->held_frame = cp;
        cfg->reordered_frames++;
        return ERR_OK;
    }

    if (cfg->dup_every_n && (seq % cfg->dup_every_n) == 0) {
        struct pbuf *dup = clone_to_pool(cp);
        if (dup) {
            cfg->duped_frames++;
            deliver_frame(cfg, target, dup);
        }
    }

    deliver_frame(cfg, target, cp);
    if (cfg->held_frame) {
        struct pbuf *held = cfg->held_frame;
        cfg->held_frame = NULL;
        deliver_frame(cfg, target, held);
    }
    return ERR_OK;
}

err_t veth_netif_init(struct netif *netif) {
    if (!netif) return ERR_ARG;
    netif->name[0] = 'v';
    netif->name[1] = 'e';
    netif->mtu = 1500U;
    netif->hwaddr_len = 6U;
    netif->flags |= NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
    netif->linkoutput = veth_linkoutput;
    return ERR_OK;
}
