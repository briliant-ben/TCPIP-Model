#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tcpip/etharp.h"
#include "tcpip/icmp.h"
#include "tcpip/ip4.h"
#include "tcpip/netif.h"
#include "tcpip/netif_veth.h"
#include "tcpip/pcap.h"
#include "tcpip/sys.h"
#include "tcpip/tcp.h"
#include "tcpip/tcpip.h"
#include "tcpip/udp.h"

/* ---------------- Test 1: Multi-PCB UDP + ICMP Port Unreachable ---------------- */

typedef struct {
    int rx_count;
    uint16_t last_port;
    uint16_t last_len;
    uint8_t buf[256];
} udp_rx_track_t;

static void on_udp_echo(void *arg, struct udp_pcb *pcb, struct pbuf *p,
                        const ip4_addr_t *addr, uint16_t port) {
    (void)pcb;
    (void)addr;
    udp_rx_track_t *t = (udp_rx_track_t *)arg;
    uint16_t n = p->tot_len < sizeof(t->buf) ? p->tot_len : (uint16_t)sizeof(t->buf);
    pbuf_copy_partial(p, t->buf, n, 0U);
    t->last_len = n;
    t->last_port = port;
    t->rx_count++;
    pbuf_free(p);
}

static void on_udp_server_echo(void *arg, struct udp_pcb *pcb, struct pbuf *p,
                               const ip4_addr_t *addr, uint16_t port) {
    udp_rx_track_t *t = (udp_rx_track_t *)arg;
    t->rx_count++;
    t->last_port = port;
    udp_sendto(pcb, p, addr, port);
    pbuf_free(p);
}

/* ---------------- Test 2/3/4: TCP Multi-Stream / Chaos / 4 MiB Bulk ---------------- */

typedef struct {
    uint32_t expected_len;
    uint32_t tx_off;
    uint32_t rx_off;
    int connected;
    int closed;
    int hold_window;
    uint32_t held_bytes;
    int fail;
    struct tcp_pcb *pcb;
    uint32_t seed;
} tcp_client_ctx_t;

typedef struct {
    struct tcp_pcb *pcb;
    int hold_recv;
    uint32_t held_total;
    uint32_t rx_bytes;
    int closed;
    uint8_t *echo_q;
    uint32_t echo_cap;
    uint32_t echo_rd;
    uint32_t echo_wr;
} tcp_srv_conn_t;

static inline uint8_t pattern_byte(uint32_t seed, uint32_t idx) {
    return (uint8_t)(((seed * 17U) ^ (idx * 131U) ^ (idx >> 8)) & 0xFFU);
}

static void drive_client_write(tcp_client_ctx_t *c) {
    while (c->connected && !c->closed && c->tx_off < c->expected_len) {
        uint16_t space = tcp_sndbuf(c->pcb);
        if (space == 0U) break;
        uint32_t rem = c->expected_len - c->tx_off;
        uint16_t chunk = (uint16_t)(rem < space ? rem : space);
        if (chunk > 2048U) chunk = 2048U;
        uint8_t buf[2048];
        for (uint16_t i = 0; i < chunk; i++) {
            buf[i] = pattern_byte(c->seed, c->tx_off + i);
        }
        if (tcp_write(c->pcb, buf, chunk, TCP_WRITE_FLAG_COPY) != ERR_OK) break;
        c->tx_off += chunk;
    }
    (void)tcp_output(c->pcb);
}

static err_t cli_sent(void *arg, struct tcp_pcb *tpcb, uint16_t len) {
    (void)tpcb;
    (void)len;
    drive_client_write((tcp_client_ctx_t *)arg);
    return ERR_OK;
}

static err_t cli_recv(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
    tcp_client_ctx_t *c = (tcp_client_ctx_t *)arg;
    if (err != ERR_OK) {
        c->fail = 1;
        return ERR_OK;
    }
    if (!p) {
        c->closed = 1;
        tcp_err(tpcb, NULL);
        tcp_close(tpcb);
        return ERR_OK;
    }
    uint8_t chunk[2048];
    uint16_t pos = 0U;
    while (pos < p->tot_len) {
        uint16_t n = (uint16_t)(p->tot_len - pos);
        if (n > sizeof(chunk)) n = sizeof(chunk);
        pbuf_copy_partial(p, chunk, n, pos);
        for (uint16_t i = 0; i < n; i++) {
            uint8_t exp = pattern_byte(c->seed, c->rx_off + i);
            if (chunk[i] != exp) {
                c->fail = 1;
                break;
            }
        }
        c->rx_off += n;
        pos = (uint16_t)(pos + n);
    }
    uint16_t tot = p->tot_len;
    pbuf_free(p);
    tcp_recved(tpcb, tot);
    if (c->rx_off == c->expected_len && !c->closed) {
        c->closed = 1;
        tcp_err(tpcb, NULL);
        tcp_close(tpcb);
    }
    return ERR_OK;
}

static void cli_err(void *arg, err_t err) {
    (void)err;
    tcp_client_ctx_t *c = (tcp_client_ctx_t *)arg;
    c->fail = 1;
    c->closed = 1;
}

static err_t cli_connected(void *arg, struct tcp_pcb *tpcb, err_t err) {
    (void)tpcb;
    tcp_client_ctx_t *c = (tcp_client_ctx_t *)arg;
    if (err != ERR_OK) {
        c->fail = 1;
        return ERR_OK;
    }
    c->connected = 1;
    drive_client_write(c);
    return ERR_OK;
}

static void drain_srv_echo(tcp_srv_conn_t *s) {
    if (!s->pcb || !s->echo_q) return;
    while (s->echo_rd < s->echo_wr) {
        uint16_t space = tcp_sndbuf(s->pcb);
        if (space == 0U) break;
        uint32_t rem = s->echo_wr - s->echo_rd;
        uint16_t chunk = (uint16_t)(rem < space ? rem : space);
        if (chunk > 2048U) chunk = 2048U;
        if (tcp_write(s->pcb, s->echo_q + s->echo_rd, chunk, TCP_WRITE_FLAG_COPY) != ERR_OK) break;
        s->echo_rd += chunk;
    }
    tcp_output(s->pcb);
    if (s->closed && s->echo_rd == s->echo_wr && s->pcb) {
        tcp_close(s->pcb);
        s->pcb = NULL;
    }
}

static err_t srv_sent(void *arg, struct tcp_pcb *tpcb, uint16_t len) {
    (void)tpcb;
    (void)len;
    drain_srv_echo((tcp_srv_conn_t *)arg);
    return ERR_OK;
}

static err_t srv_recv(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
    tcp_srv_conn_t *s = (tcp_srv_conn_t *)arg;
    (void)err;
    if (!p) {
        s->closed = 1;
        drain_srv_echo(s);
        return ERR_OK;
    }
    if (!s->echo_q) {
        s->echo_cap = 131072U;
        s->echo_q = (uint8_t *)malloc(s->echo_cap);
        assert(s->echo_q != NULL);
    }
    /* Compact buffer if needed before appending */
    if (s->echo_wr + p->tot_len > s->echo_cap) {
        uint32_t unread = s->echo_wr - s->echo_rd;
        if (unread > 0U && s->echo_rd > 0U) {
            memmove(s->echo_q, s->echo_q + s->echo_rd, unread);
        }
        s->echo_rd = 0U;
        s->echo_wr = unread;
        if (s->echo_wr + p->tot_len > s->echo_cap) {
            uint32_t new_cap = s->echo_cap * 2U;
            while (new_cap < s->echo_wr + p->tot_len) new_cap *= 2U;
            s->echo_q = (uint8_t *)realloc(s->echo_q, new_cap);
            assert(s->echo_q != NULL);
            s->echo_cap = new_cap;
        }
    }
    pbuf_copy_partial(p, s->echo_q + s->echo_wr, p->tot_len, 0U);
    s->echo_wr += p->tot_len;
    s->rx_bytes += p->tot_len;
    if (s->hold_recv) {
        s->held_total += p->tot_len;
    } else {
        tcp_recved(tpcb, p->tot_len);
    }
    pbuf_free(p);
    drain_srv_echo(s);
    return ERR_OK;
}

static tcp_srv_conn_t srv_conns[16];
static int srv_conn_count = 0;
static int g_srv_hold_next = 0;

static void reset_srv_conns(void) {
    for (int i = 0; i < 16; i++) {
        free(srv_conns[i].echo_q);
        memset(&srv_conns[i], 0, sizeof(srv_conns[i]));
    }
    srv_conn_count = 0;
}

static err_t srv_accept(void *arg, struct tcp_pcb *newpcb, err_t err) {
    (void)arg;
    (void)err;
    int idx = srv_conn_count++;
    assert(idx < 16);
    free(srv_conns[idx].echo_q);
    memset(&srv_conns[idx], 0, sizeof(srv_conns[idx]));
    srv_conns[idx].pcb = newpcb;
    srv_conns[idx].hold_recv = g_srv_hold_next;
    tcp_arg(newpcb, &srv_conns[idx]);
    tcp_recv(newpcb, srv_recv);
    tcp_sent(newpcb, srv_sent);
    return ERR_OK;
}

/* Global fixture for actor calls */
static struct netif ifA, ifB;
static veth_link_t linkA, linkB;
static ip4_addr_t ipA, ipB, mask, gw;
static tcpip_pcap_t *g_pcap = NULL;

static void step_stack(uint32_t *now_ms, uint32_t dt_ms) {
    *now_ms += dt_ms;
#if TCPIP_NO_SYS
    tcpip_poll(*now_ms);
    veth_link_flush(&linkA, &ifA);
    veth_link_flush(&linkB, &ifB);
#else
    (void)dt_ms;
    sys_msleep(2);
#endif
}

typedef struct {
    ip4_addr_t dst;
    uint16_t port;
    uint32_t seed;
    uint32_t len;
    tcp_client_ctx_t *ctx;
} start_cli_arg_t;

static err_t api_start_client(void *v) {
    start_cli_arg_t *a = (start_cli_arg_t *)v;
    struct tcp_pcb *c = tcp_new();
    if (!c) return ERR_MEM;
    memset(a->ctx, 0, sizeof(*a->ctx));
    a->ctx->pcb = c;
    a->ctx->expected_len = a->len;
    a->ctx->seed = a->seed;
    tcp_arg(c, a->ctx);
    tcp_recv(c, cli_recv);
    tcp_sent(c, cli_sent);
    tcp_err(c, cli_err);
    return tcp_connect(c, &a->dst, a->port, cli_connected);
}

static err_t api_release_held(void *v) {
    tcp_srv_conn_t *s = (tcp_srv_conn_t *)v;
    s->hold_recv = 0;
    uint32_t rel = s->held_total;
    s->held_total = 0U;
    while (rel > 0U) {
        uint16_t chunk = rel > 16384U ? 16384U : (uint16_t)rel;
        tcp_recved(s->pcb, chunk);
        rel -= chunk;
    }
    return ERR_OK;
}

typedef struct {
    tcp_client_ctx_t *clients;
    int count;
    int all_done;
    int any_fail;
} check_batch_arg_t;

static err_t api_check_batch(void *v) {
    check_batch_arg_t *b = (check_batch_arg_t *)v;
    b->all_done = 1;
    b->any_fail = 0;
    for (int i = 0; i < b->count; i++) {
        if (b->clients[i].fail) b->any_fail = 1;
        if (!b->clients[i].closed) {
            b->all_done = 0;
            if (b->clients[i].pcb) drive_client_write(&b->clients[i]);
        }
    }
    tcp_tmr(sys_now());
    return ERR_OK;
}

typedef struct {
    tcp_client_ctx_t *cli;
    int *released;
    int done;
    int fail;
} check_chaos_arg_t;

static err_t api_check_chaos(void *v) {
    check_chaos_arg_t *c = (check_chaos_arg_t *)v;
    veth_link_flush(&linkA, &ifA);
    veth_link_flush(&linkB, &ifB);
    if (!*c->released && srv_conn_count > 0 && srv_conns[0].held_total >= TCPIP_TCP_WND) {
        api_release_held(&srv_conns[0]);
        *c->released = 1;
    }
    if (c->cli && !c->cli->closed && c->cli->pcb) drive_client_write(c->cli);
    tcp_tmr(sys_now());
    c->fail = c->cli->fail;
    c->done = c->cli->closed;
    return ERR_OK;
}

typedef struct {
    int hold_next;
    uint32_t drop_n;
    uint32_t reorder_n;
    uint32_t dup_n;
    uint32_t out_drops;
    uint32_t out_reorders;
    uint32_t out_dups;
} phase_cfg_t;

static err_t api_configure_phase(void *v) {
    phase_cfg_t *p = (phase_cfg_t *)v;
    p->out_drops = linkA.dropped_frames + linkB.dropped_frames;
    p->out_reorders = linkA.reordered_frames + linkB.reordered_frames;
    p->out_dups = linkA.duped_frames + linkB.duped_frames;
    reset_srv_conns();
    g_srv_hold_next = p->hold_next;
    linkA.drop_every_n = p->drop_n;
    linkB.drop_every_n = p->drop_n;
    linkA.reorder_every_n = p->reorder_n;
    linkB.reorder_every_n = p->reorder_n;
    linkB.dup_every_n = p->dup_n;
    return ERR_OK;
}

static err_t api_run_udp_tests(void *v) {
    (void)v;
    udp_rx_track_t s1 = {0}, s2 = {0}, c1 = {0};
    struct udp_pcb *up1 = udp_new();
    struct udp_pcb *up2 = udp_new();
    struct udp_pcb *uc1 = udp_new();
    struct udp_pcb *uc2 = udp_new();
    assert(up1 && up2 && uc1 && uc2);

    assert(udp_bind(up1, &ipB, 7001U) == ERR_OK);
    assert(udp_bind(up2, &ipB, 7002U) == ERR_OK);
    udp_recv(up1, on_udp_server_echo, &s1);
    udp_recv(up2, on_udp_server_echo, &s2);

    assert(udp_bind(uc1, &ipA, 0U) == ERR_OK);
    assert(udp_connect(uc1, &ipB, 7001U) == ERR_OK);
    udp_recv(uc1, on_udp_echo, &c1);

    assert(udp_bind(uc2, &ipA, 0U) == ERR_OK);
    udp_recv(uc2, on_udp_echo, &c1);

    struct pbuf *p1 = pbuf_alloc(PBUF_TRANSPORT, 11U, PBUF_POOL);
    assert(p1 != NULL);
    pbuf_take(p1, "hello-udp-1", 11U);
    assert(udp_send(uc1, p1) == ERR_OK);
    pbuf_free(p1);

    struct pbuf *p2 = pbuf_alloc(PBUF_TRANSPORT, 11U, PBUF_POOL);
    assert(p2 != NULL);
    pbuf_take(p2, "hello-udp-2", 11U);
    assert(udp_sendto(uc2, p2, &ipB, 7002U) == ERR_OK);
    pbuf_free(p2);

    /* Unmatched UDP port -> triggers ICMP Port Unreachable */
    struct pbuf *p3 = pbuf_alloc(PBUF_TRANSPORT, 8U, PBUF_POOL);
    assert(p3 != NULL);
    pbuf_take(p3, "deadport", 8U);
    assert(udp_sendto(uc2, p3, &ipB, 19999U) == ERR_OK);
    pbuf_free(p3);

    if (TCPIP_NO_SYS) {
        assert(s1.rx_count == 1 && s2.rx_count == 1);
        assert(c1.rx_count == 2);
    }
    /* Under NO_SYS=0 the replies arrive via actor mbox shortly after */
    (void)s1; (void)s2; (void)c1;
    udp_remove(up1); udp_remove(up2); udp_remove(uc1); udp_remove(uc2);
    return ERR_OK;
}

static struct tcp_pcb *g_lpcb = NULL;

static err_t api_setup_stack(void *v) {
    (void)v;
    etharp_reset();
    ip4_reass_reset();
    netif_reset_all();
    udp_init();
    tcp_init();
    tcpip_set_rx_handler(ethernet_input);

    uint8_t use_mbox = TCPIP_NO_SYS ? 0U : 1U;
    veth_link_init(&linkA, &ifB, g_pcap, use_mbox);
    veth_link_init(&linkB, &ifA, g_pcap, use_mbox);

    assert(netif_add(&ifA, &ipA, &mask, &gw, &linkA, veth_netif_init, ethernet_input) == &ifA);
    assert(netif_add(&ifB, &ipB, &mask, &gw, &linkB, veth_netif_init, ethernet_input) == &ifB);
    ifA.hwaddr[0] = 0x02; ifA.hwaddr[5] = 0x0A;
    ifB.hwaddr[0] = 0x02; ifB.hwaddr[5] = 0x0B;
    ifA.output = etharp_output;
    ifB.output = etharp_output;
    netif_set_up(&ifA); netif_set_up(&ifB);
    netif_set_default(&ifA);

    struct tcp_pcb *l = tcp_new();
    assert(l != NULL);
    assert(tcp_bind(l, &ipB, 8000U) == ERR_OK);
    g_lpcb = tcp_listen_with_backlog(l, 16U);
    assert(g_lpcb != NULL);
    tcp_accept(g_lpcb, srv_accept);
    return ERR_OK;
}

static err_t api_teardown_tcp(void *v) {
    (void)v;
    if (g_lpcb) {
        tcp_close(g_lpcb);
        g_lpcb = NULL;
    }
    tcp_reset();
    udp_reset();
    netif_reset_all();
    return ERR_OK;
}

static void on_arp_tmr(void *ctx, uint32_t now_ms) {
    (void)ctx;
    etharp_tmr(now_ms);
}

static void on_tcp_tmr(void *ctx, uint32_t now_ms) {
    (void)ctx;
    tcp_tmr(now_ms);
}

int main(void) {
    IP4_ADDR(&ipA, 10, 20, 0, 1);
    IP4_ADDR(&ipB, 10, 20, 0, 2);
    IP4_ADDR(&mask, 255, 255, 255, 0);
    IP4_ADDR(&gw, 0, 0, 0, 0);

    tcpip_init(NULL, NULL);
    assert(tcpip_pcap_open(&g_pcap, "build/m3_tcp_udp.pcap") == ERR_OK);
    assert(tcpip_api_call(api_setup_stack, NULL) == ERR_OK);

    tcpip_timer_add(25U, on_arp_tmr, NULL);
    tcpip_timer_add(25U, on_tcp_tmr, NULL);

    /* 1. Multi-PCB UDP + ICMP Port Unreachable */
    if (TCPIP_NO_SYS) {
        assert(tcpip_api_call(api_run_udp_tests, NULL) == ERR_OK);
    } else {
        /* Test UDP within actor thread cleanly */
        assert(tcpip_api_call(api_run_udp_tests, NULL) == ERR_OK);
    }

    uint32_t now_ms = 0U;

    /* 2. 8 concurrent TCP streams (8 * 8 KiB) */
    tcp_client_ctx_t clients[8];
    phase_cfg_t cfg2 = { 0, 0U, 0U, 0U, 0U, 0U, 0U };
    assert(tcpip_api_call(api_configure_phase, &cfg2) == ERR_OK);
    for (int i = 0; i < 8; i++) {
        start_cli_arg_t arg = { ipB, 8000U, (uint32_t)(100 + i), 8192U, &clients[i] };
        assert(tcpip_api_call(api_start_client, &arg) == ERR_OK);
    }
    for (int step = 0; step < 500; step++) {
        check_batch_arg_t cb = { clients, 8, 0, 0 };
        tcpip_api_call(api_check_batch, &cb);
        assert(!cb.any_fail);
        if (cb.all_done) break;
        step_stack(&now_ms, 5U);
    }
    for (int i = 0; i < 8; i++) {
        assert(!clients[i].fail && clients[i].closed && clients[i].rx_off == 8192U);
    }

    /* 3. Impaired link chaos test: ~5% drop + OOO + dup + zero-window pause/resume */
    phase_cfg_t cfg3 = { 1, 20U, 7U, 11U, 0U, 0U, 0U };
    assert(tcpip_api_call(api_configure_phase, &cfg3) == ERR_OK);

    tcp_client_ctx_t chaos;
    start_cli_arg_t carg = { ipB, 8000U, 777U, 65536U, &chaos };
    assert(tcpip_api_call(api_start_client, &carg) == ERR_OK);

    int released = 0;
    for (int step = 0; step < 3000; step++) {
        check_chaos_arg_t cc = { &chaos, &released, 0, 0 };
        tcpip_api_call(api_check_chaos, &cc);
        assert(!cc.fail);
        if (cc.done) break;
        step_stack(&now_ms, 10U);
    }
    assert(!chaos.fail && chaos.closed && chaos.rx_off == 65536U);

    /* 4. 4 MiB bulk stream over clean link */
    phase_cfg_t cfg4 = { 0, 0U, 0U, 0U, 0U, 0U, 0U };
    assert(tcpip_api_call(api_configure_phase, &cfg4) == ERR_OK);
    assert(cfg4.out_drops >= 2U);
    assert(cfg4.out_reorders >= 1U);
    assert(cfg4.out_dups >= 1U);
    const uint32_t bulk_sz = 4U * 1024U * 1024U;
    tcp_client_ctx_t bulk;
    start_cli_arg_t barg = { ipB, 8000U, 9999U, bulk_sz, &bulk };
    assert(tcpip_api_call(api_start_client, &barg) == ERR_OK);
    for (int step = 0; step < 50000; step++) {
        check_batch_arg_t cb = { &bulk, 1, 0, 0 };
        tcpip_api_call(api_check_batch, &cb);
        assert(!cb.any_fail);
        if (cb.all_done) break;
        step_stack(&now_ms, 1U);
    }
    assert(!bulk.fail && bulk.closed && bulk.rx_off == bulk_sz);

    assert(tcpip_api_call(api_teardown_tcp, NULL) == ERR_OK);
    tcpip_shutdown();
    uint32_t pkts = tcpip_pcap_packet_count(g_pcap);
    assert(pkts >= 100U);
    reset_srv_conns();
    tcpip_pcap_close(g_pcap);

    printf("M3 L4 TCP/UDP NO_SYS=%d OK (8x8K + 64K-chaos + 4MiB, drops=%u+%u, pcap_pkts=%u)\n",
           TCPIP_NO_SYS, linkA.dropped_frames, linkB.dropped_frames, pkts);
    return 0;
}
