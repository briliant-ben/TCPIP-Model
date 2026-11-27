#include <string.h>
#include "tcpip/icmp.h"
#include "tcpip/inet_chksum.h"
#include "tcpip/memp.h"
#include "tcpip/opt.h"
#include "tcpip/udp.h"

static struct udp_pcb *udp_pcbs = NULL;
static uint16_t udp_ephemeral_port = 49152U;

static inline uint16_t rd16be(const uint8_t *p) {
    return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}

static inline void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}

static int udp_port_in_use(uint16_t port) {
    for (struct udp_pcb *u = udp_pcbs; u != NULL; u = u->next) {
        if (u->local_port == port) return 1;
    }
    return 0;
}

static uint16_t udp_new_port(void) {
    for (uint32_t i = 0; i < 16384U; i++) {
        uint16_t port = udp_ephemeral_port++;
        if (udp_ephemeral_port < 49152U) udp_ephemeral_port = 49152U;
        if (!udp_port_in_use(port)) return port;
    }
    return 0;
}

void udp_init(void) {
    udp_reset();
    ip4_register_udp_input(udp_input);
}

void udp_reset(void) {
    while (udp_pcbs != NULL) {
        struct udp_pcb *next = udp_pcbs->next;
        memp_free(MEMP_UDP_PCB, udp_pcbs);
        udp_pcbs = next;
    }
    udp_ephemeral_port = 49152U;
}

struct udp_pcb *udp_new(void) {
    struct udp_pcb *pcb = (struct udp_pcb *)memp_malloc(MEMP_UDP_PCB);
    if (!pcb) return NULL;
    memset(pcb, 0, sizeof(*pcb));
    pcb->ttl = 64U;
    pcb->next = udp_pcbs;
    udp_pcbs = pcb;
    return pcb;
}

void udp_remove(struct udp_pcb *pcb) {
    if (!pcb) return;
    struct udp_pcb **pp = &udp_pcbs;
    while (*pp != NULL) {
        if (*pp == pcb) {
            *pp = pcb->next;
            memp_free(MEMP_UDP_PCB, pcb);
            return;
        }
        pp = &(*pp)->next;
    }
}

err_t udp_bind(struct udp_pcb *pcb, const ip4_addr_t *ipaddr, uint16_t port) {
    if (!pcb) return ERR_ARG;
    if (port == 0U) {
        port = udp_new_port();
        if (port == 0U) return ERR_USE;
    } else {
        for (struct udp_pcb *u = udp_pcbs; u != NULL; u = u->next) {
            if (u != pcb && u->local_port == port) {
                if (ip4_addr_isany(&u->local_ip) || !ipaddr || ip4_addr_isany(ipaddr) ||
                    ip4_addr_cmp(&u->local_ip, ipaddr)) {
                    return ERR_USE;
                }
            }
        }
    }
    pcb->local_ip.addr = ipaddr ? ipaddr->addr : 0U;
    pcb->local_port = port;
    return ERR_OK;
}

err_t udp_connect(struct udp_pcb *pcb, const ip4_addr_t *ipaddr, uint16_t port) {
    if (!pcb || !ipaddr || port == 0U) return ERR_ARG;
    if (pcb->local_port == 0U) {
        err_t err = udp_bind(pcb, &pcb->local_ip, 0U);
        if (err != ERR_OK) return err;
    }
    pcb->remote_ip = *ipaddr;
    pcb->remote_port = port;
    pcb->flags |= UDP_FLAGS_CONNECTED;
    return ERR_OK;
}

void udp_disconnect(struct udp_pcb *pcb) {
    if (!pcb) return;
    pcb->remote_ip.addr = 0U;
    pcb->remote_port = 0U;
    pcb->flags &= (uint8_t)(~UDP_FLAGS_CONNECTED);
}

void udp_recv(struct udp_pcb *pcb, udp_recv_fn recv, void *recv_arg) {
    if (!pcb) return;
    pcb->recv = recv;
    pcb->recv_arg = recv_arg;
}

err_t udp_sendto_if(struct udp_pcb *pcb, struct pbuf *p,
                    const ip4_addr_t *dst_ip, uint16_t dst_port, struct netif *netif) {
    if (!pcb || !p || !dst_ip || !netif || dst_port == 0U) return ERR_ARG;
    if (pcb->local_port == 0U) {
        err_t berr = udp_bind(pcb, &pcb->local_ip, 0U);
        if (berr != ERR_OK) return berr;
    }

    ip4_addr_t chosen_src = ip4_addr_isany(&pcb->local_ip) ? netif->ip_addr : pcb->local_ip;
    struct pbuf *q = p;
    int allocated = 0;
    if (pbuf_header(p, -(int16_t)UDP_HLEN) != 0) {
        q = pbuf_alloc(PBUF_IP, (uint16_t)(UDP_HLEN + p->tot_len), PBUF_POOL);
        if (!q) return ERR_MEM;
        /* Copy payload starting at offset UDP_HLEN */
        uint16_t dst_off = UDP_HLEN;
        for (struct pbuf *s = p; s != NULL; s = s->next) {
            if (s->len > 0 && pbuf_take_at(q, s->payload, s->len, dst_off) != ERR_OK) {
                pbuf_free(q);
                return ERR_BUF;
            }
            dst_off = (uint16_t)(dst_off + s->len);
        }
        allocated = 1;
    }

    uint8_t *uh = q->payload;
    wr16be(uh + 0, pcb->local_port);
    wr16be(uh + 2, dst_port);
    wr16be(uh + 4, q->tot_len);
    wr16be(uh + 6, 0U);
    uint16_t chk = inet_chksum_pseudo(q, IP_PROTO_UDP, q->tot_len, &chosen_src, dst_ip);
    wr16be(uh + 6, chk == 0U ? 0xFFFFU : chk);

    err_t err = ip4_output_if(q, &chosen_src, dst_ip, pcb->ttl ? pcb->ttl : (uint8_t)64, pcb->tos, IP_PROTO_UDP, netif);
    if (allocated) {
        pbuf_free(q);
    } else {
        pbuf_header(p, (int16_t)UDP_HLEN);
    }
    return err;
}

err_t udp_sendto(struct udp_pcb *pcb, struct pbuf *p, const ip4_addr_t *dst_ip, uint16_t dst_port) {
    if (!pcb || !p || !dst_ip) return ERR_ARG;
    struct netif *netif = netif_route(dst_ip);
    if (!netif) return ERR_RTE;
    return udp_sendto_if(pcb, p, dst_ip, dst_port, netif);
}

err_t udp_send(struct udp_pcb *pcb, struct pbuf *p) {
    if (!pcb || !(pcb->flags & UDP_FLAGS_CONNECTED)) return ERR_CONN;
    return udp_sendto(pcb, p, &pcb->remote_ip, pcb->remote_port);
}

void udp_input(struct pbuf *p, struct netif *inp, const ip4_addr_t *src, const ip4_addr_t *dst) {
    if (!p || !inp || !src || !dst || p->len < UDP_HLEN || p->tot_len < UDP_HLEN) {
        if (p) pbuf_free(p);
        return;
    }
    const uint8_t *uh = p->payload;
    uint16_t sport = rd16be(uh + 0);
    uint16_t dport = rd16be(uh + 2);
    uint16_t ulen  = rd16be(uh + 4);
    uint16_t rchk  = rd16be(uh + 6);

    if (ulen < UDP_HLEN || ulen > p->tot_len) {
        pbuf_free(p);
        return;
    }
    if (ulen < p->tot_len) {
        pbuf_realloc(p, ulen);
    }
    if (rchk != 0U) {
        if (inet_chksum_pseudo(p, IP_PROTO_UDP, ulen, src, dst) != 0U) {
            pbuf_free(p);
            return;
        }
    }

    struct udp_pcb *uncon_exact = NULL;
    struct udp_pcb *uncon_any = NULL;
    struct udp_pcb *matched = NULL;

    for (struct udp_pcb *u = udp_pcbs; u != NULL; u = u->next) {
        if (u->local_port != dport) continue;
        int local_exact = ip4_addr_cmp(&u->local_ip, dst);
        int local_ok = local_exact || ip4_addr_isany(&u->local_ip);
        if (!local_ok) continue;

        if ((u->flags & UDP_FLAGS_CONNECTED) != 0U) {
            if (u->remote_port == sport && ip4_addr_cmp(&u->remote_ip, src)) {
                matched = u;
                if (local_exact) break;
            }
        } else {
            if (local_exact && !uncon_exact) uncon_exact = u;
            else if (!uncon_any) uncon_any = u;
        }
    }

    if (!matched) matched = uncon_exact ? uncon_exact : uncon_any;
    if (matched) {
        if (pbuf_header(p, (int16_t)UDP_HLEN) != 0) {
            pbuf_free(p);
            return;
        }
        if (matched->recv) {
            matched->recv(matched->recv_arg, matched, p, src, sport);
        } else {
            pbuf_free(p);
        }
        return;
    }

    /* No matching PCB: send ICMP Port Unreachable for non-broadcast destination */
    if (!ip4_addr_isbroadcast_u32(dst->addr, &inp->ip_addr, &inp->netmask)) {
        if (pbuf_header(p, -(int16_t)IP_HLEN_MIN) == 0) {
            icmp_dest_unreach(p, ICMP_DUR_PORT);
        }
    }
    pbuf_free(p);
}
