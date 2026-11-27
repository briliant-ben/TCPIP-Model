#define _POSIX_C_SOURCE 200809L
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "tcpip/etharp.h"
#include "tcpip/inet_chksum.h"
#include "tcpip/ip4.h"
#include "tcpip/netif.h"
#include "tcpip/netif_veth.h"
#include "tcpip/sys.h"
#include "tcpip/tcp.h"
#include "tcpip/tcpip.h"
#include "tcpip/udp.h"

static uint64_t hr_ns(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
}

/* 1. Checksum benchmark */
static void bench_checksum(void) {
    static uint8_t buf[1500];
    for (int i = 0; i < (int)sizeof(buf); i++) buf[i] = (uint8_t)(i * 31U);
    volatile uint16_t sink = 0U;
    const uint32_t iters = 200000U;
    uint64_t t0 = hr_ns();
    for (uint32_t i = 0; i < iters; i++) {
        sink ^= inet_chksum(buf, sizeof(buf));
    }
    uint64_t dt = hr_ns() - t0;
    double mb = ((double)iters * (double)sizeof(buf)) / (1024.0 * 1024.0);
    double mbps = mb / ((double)dt / 1e9);
    printf("bench inet_chksum (1500B x %u): %.1f MiB/s (%.2f ms, sink=0x%04x)\n",
           iters, mbps, (double)dt / 1e6, (unsigned)sink);
}

/* 2. UDP throughput benchmark (NO_SYS=1 polled veth) */
static uint32_t udp_rx_cnt = 0U;
static void on_bench_udp(void *arg, struct udp_pcb *pcb, struct pbuf *p,
                         const ip4_addr_t *addr, uint16_t port) {
    (void)arg; (void)pcb; (void)addr; (void)port;
    udp_rx_cnt++;
    pbuf_free(p);
}

/* 3. TCP bulk & RTT benchmark */
static uint32_t tcp_srv_rx = 0U;
static uint32_t tcp_cli_rx = 0U;
static int tcp_cli_connected = 0;
static int tcp_cli_done = 0;

static err_t bench_srv_recv_echo(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
    (void)arg; (void)err;
    if (!p) {
        tcp_close(tpcb);
        return ERR_OK;
    }
    tcp_srv_rx += p->tot_len;
    tcp_recved(tpcb, p->tot_len);
    pbuf_free(p);
    return ERR_OK;
}

static err_t bench_srv_ping_recv(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
    (void)arg; (void)err;
    if (!p) {
        tcp_close(tpcb);
        return ERR_OK;
    }
    uint8_t buf[64];
    uint16_t n = p->tot_len < sizeof(buf) ? p->tot_len : (uint16_t)sizeof(buf);
    pbuf_copy_partial(p, buf, n, 0U);
    tcp_recved(tpcb, p->tot_len);
    pbuf_free(p);
    if (tcp_write(tpcb, buf, n, TCP_WRITE_FLAG_COPY) == ERR_OK) {
        (void)tcp_output(tpcb);
    }
    return ERR_OK;
}

static err_t (*g_bench_srv_recv)(void *, struct tcp_pcb *, struct pbuf *, err_t) = bench_srv_recv_echo;

static err_t bench_srv_accept(void *arg, struct tcp_pcb *newpcb, err_t err) {
    (void)arg; (void)err;
    tcp_recv(newpcb, g_bench_srv_recv);
    return ERR_OK;
}

static err_t bench_cli_connected(void *arg, struct tcp_pcb *tpcb, err_t err) {
    (void)arg; (void)tpcb; (void)err;
    tcp_cli_connected = 1;
    return ERR_OK;
}

static err_t bench_cli_recv(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
    (void)arg; (void)err;
    if (!p) {
        tcp_cli_done = 1;
        tcp_close(tpcb);
        return ERR_OK;
    }
    tcp_cli_rx += p->tot_len;
    tcp_recved(tpcb, p->tot_len);
    pbuf_free(p);
    return ERR_OK;
}

int main(void) {
    bench_checksum();

    tcpip_init(NULL, NULL);
    etharp_reset();
    netif_reset_all();
    udp_init();
    tcp_init();
    tcpip_set_rx_handler(ethernet_input);

    struct netif ifA, ifB;
    veth_link_t linkA, linkB;
    ip4_addr_t ipA, ipB, mask, gw;
    IP4_ADDR(&ipA, 10, 70, 0, 1);
    IP4_ADDR(&ipB, 10, 70, 0, 2);
    IP4_ADDR(&mask, 255, 255, 255, 0);
    IP4_ADDR(&gw, 0, 0, 0, 0);

    veth_link_init(&linkA, &ifB, NULL, 0U);
    veth_link_init(&linkB, &ifA, NULL, 0U);
    assert(netif_add(&ifA, &ipA, &mask, &gw, &linkA, veth_netif_init, ethernet_input) == &ifA);
    assert(netif_add(&ifB, &ipB, &mask, &gw, &linkB, veth_netif_init, ethernet_input) == &ifB);
    ifA.hwaddr[0] = 0x02; ifA.hwaddr[5] = 0x51;
    ifB.hwaddr[0] = 0x02; ifB.hwaddr[5] = 0x52;
    ifA.output = etharp_output;
    ifB.output = etharp_output;
    netif_set_up(&ifA); netif_set_up(&ifB);
    netif_set_default(&ifA);

    /* Warm up ARP */
    struct udp_pcb *us = udp_new();
    struct udp_pcb *uc = udp_new();
    assert(udp_bind(us, &ipB, 7500U) == ERR_OK);
    udp_recv(us, on_bench_udp, NULL);
    assert(udp_connect(uc, &ipB, 7500U) == ERR_OK);
    struct pbuf *up = pbuf_alloc(PBUF_TRANSPORT, 1400U, PBUF_POOL);
    memset(up->payload, 0x5A, 1400U);
    assert(udp_send(uc, up) == ERR_OK);
    udp_rx_cnt = 0U;

    const uint32_t udp_pkts = 20000U;
    uint64_t ut0 = hr_ns();
    for (uint32_t i = 0; i < udp_pkts; i++) {
        assert(udp_send(uc, up) == ERR_OK);
    }
    uint64_t udt = hr_ns() - ut0;
    pbuf_free(up);
    udp_remove(uc);
    udp_remove(us);
    assert(udp_rx_cnt == udp_pkts);
    double udp_sec = (double)udt / 1e9;
    double udp_kpps = ((double)udp_pkts / udp_sec) / 1000.0;
    double udp_mbps = ((double)udp_pkts * 1400.0 * 8.0 / udp_sec) / 1e6;
    printf("bench UDP (1400B x %u): %.1f kpps, %.1f Mbps (%.2f ms)\n",
           udp_pkts, udp_kpps, udp_mbps, (double)udt / 1e6);

    /* TCP bulk unidirectional stream (8 MiB) */
    g_bench_srv_recv = bench_srv_recv_echo;
    struct tcp_pcb *lpcb = tcp_new();
    assert(tcp_bind(lpcb, &ipB, 7501U) == ERR_OK);
    lpcb = tcp_listen(lpcb);
    tcp_accept(lpcb, bench_srv_accept);

    struct tcp_pcb *cpcb = tcp_new();
    tcp_cli_connected = 0;
    tcp_srv_rx = 0U;
    assert(tcp_connect(cpcb, &ipB, 7501U, bench_cli_connected) == ERR_OK);
    assert(tcp_cli_connected == 1);

    static uint8_t bulk_chunk[16384];
    memset(bulk_chunk, 0xA5, sizeof(bulk_chunk));
    const uint32_t tcp_bytes = 8U * 1024U * 1024U;
    uint32_t sent = 0U;
    uint64_t tt0 = hr_ns();
    while (sent < tcp_bytes) {
        uint16_t sp = tcp_sndbuf(cpcb);
        if (sp == 0U) {
            (void)tcp_output(cpcb);
            continue;
        }
        uint32_t rem = tcp_bytes - sent;
        uint16_t n = rem < sp ? (uint16_t)rem : sp;
        if (n > sizeof(bulk_chunk)) n = sizeof(bulk_chunk);
        assert(tcp_write(cpcb, bulk_chunk, n, TCP_WRITE_FLAG_COPY) == ERR_OK);
        sent += n;
        (void)tcp_output(cpcb);
    }
    uint64_t tdt = hr_ns() - tt0;
    assert(tcp_srv_rx == tcp_bytes);
    double tcp_sec = (double)tdt / 1e9;
    double tcp_mbps = ((double)tcp_bytes * 8.0 / tcp_sec) / 1e6;
    printf("bench TCP bulk TX (8 MiB): %.1f Mbps (%.2f ms)\n", tcp_mbps, (double)tdt / 1e6);
    tcp_close(cpcb);

    /* TCP RTT ping-pong (1000 x 32B) */
    g_bench_srv_recv = bench_srv_ping_recv;
    cpcb = tcp_new();
    tcp_cli_connected = 0;
    tcp_recv(cpcb, bench_cli_recv);
    assert(tcp_connect(cpcb, &ipB, 7501U, bench_cli_connected) == ERR_OK);
    assert(tcp_cli_connected == 1);

    uint8_t ping[32] = "tcpip-model-rtt-ping-frame-0001";
    const uint32_t rtts = 1000U;
    uint64_t rt0 = hr_ns();
    for (uint32_t i = 0; i < rtts; i++) {
        uint32_t before = tcp_cli_rx;
        assert(tcp_write(cpcb, ping, sizeof(ping), TCP_WRITE_FLAG_COPY) == ERR_OK);
        assert(tcp_output(cpcb) == ERR_OK);
        assert(tcp_cli_rx == before + sizeof(ping));
    }
    uint64_t rdt = hr_ns() - rt0;
    double avg_rtt_us = ((double)rdt / (double)rtts) / 1000.0;
    printf("bench TCP RTT (32B ping-pong x %u): %.2f us/RTT\n", rtts, avg_rtt_us);

    tcp_close(cpcb);
    tcp_close(lpcb);
    tcp_reset();
    udp_reset();
    netif_reset_all();
    tcpip_shutdown();
    return 0;
}
