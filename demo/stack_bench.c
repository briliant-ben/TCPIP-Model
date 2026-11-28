/* -O2 micro- and end-to-end throughput benchmark for the generated C99 TCP/IPv4 stack. */
#ifndef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE 200809L
#endif

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "host_runtime.h"

static uint64_t mono_ns(void) {
    struct timespec ts;
    (void)clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
}

int main(void) {
    static const uint8_t ip_a[4] = {10, 99, 0, 2};
    static const uint8_t ip_b[4] = {10, 99, 0, 1};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_a[6] = {0x02, 0x99, 0x00, 0x00, 0x00, 0x02};
    static const uint8_t mac_b[6] = {0x02, 0x99, 0x00, 0x00, 0x00, 0x01};

    uint8_t csum_buf[1460];
    volatile uint16_t csum_sink = 0U;
    uint64_t t0, dt_ns;
    double csum_mibs, udp_kpps, udp_mbps, tcp_mbps, tcp_rtt_us;
    size_t i;

    for (i = 0U; i < sizeof(csum_buf); i++) csum_buf[i] = (uint8_t)(i * 31U + 7U);

    /* 1. Generated runtime RFC 1071 Internet checksum throughput */
    {
        enum { CSUM_ITERS = 200000 };
        int it, csum_err = 0;
        t0 = mono_ns();
        for (it = 0; it < CSUM_ITERS; it++) {
            csum_sink ^= (uint16_t)fsa_checksum16(fsa_slice_make(csum_buf, sizeof(csum_buf)), 8192U, &csum_err);
        }
        dt_ns = mono_ns() - t0;
        csum_mibs = ((double)CSUM_ITERS * (double)sizeof(csum_buf) / (1024.0 * 1024.0)) /
                    ((double)(dt_ns > 0 ? dt_ns : 1ULL) * 1e-9);
    }

    /* Set up pair of generated stack instances on virtual Ethernet wire */
    {
        fsa_host_veth_link_t veth;
        fsa_host_stack_t *a, *b;
        int ua, ub, lslot, cslot, sslot;
        fsa_host_udp_dgram_t dg;
        int64_t now = 100;

        fsa_host_veth_init(&veth, NULL);
        a = fsa_host_create(fsa_host_veth_tx_fn_a(), &veth, NULL);
        b = fsa_host_create(fsa_host_veth_tx_fn_b(), &veth, NULL);
        fsa_host_veth_attach(&veth, a, b);
        (void)fsa_host_init_if(a, now, ip_a, mask, ip_b, mac_a, 1500U);
        (void)fsa_host_init_if(b, now, ip_b, mask, ip_b, mac_b, 1500U);

        ua = fsa_host_udp_open(a);
        ub = fsa_host_udp_open(b);
        (void)fsa_host_udp_bind(a, now, ua, ip_a, 17000U);
        (void)fsa_host_udp_connect(a, now, ua, ip_b, 17001U);
        (void)fsa_host_udp_bind(b, now, ub, ip_b, 17001U);
        (void)fsa_host_udp_send(a, now, ua, ip_a, csum_buf, 64U);
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        (void)fsa_host_udp_recv(b, ub, &dg, 0U);

        /* 2. End-to-end UDP 1400B datagram throughput */
        {
            enum { UDP_ITERS = 20000, UDP_PAY = 1400 };
            int it;
            t0 = mono_ns();
            for (it = 0; it < UDP_ITERS; it++) {
                (void)fsa_host_udp_send(a, now, ua, ip_a, csum_buf, UDP_PAY);
                (void)fsa_host_veth_pump(&veth, now);
                (void)fsa_host_udp_recv(b, ub, &dg, 0U);
            }
            dt_ns = mono_ns() - t0;
            udp_kpps = ((double)UDP_ITERS / 1000.0) / ((double)(dt_ns > 0 ? dt_ns : 1ULL) * 1e-9);
            udp_mbps = ((double)UDP_ITERS * (double)UDP_PAY * 8.0 / 1e6) /
                       ((double)(dt_ns > 0 ? dt_ns : 1ULL) * 1e-9);
        }

        /* Establish TCP connection for bulk & RTT benchmarks */
        lslot = fsa_host_tcp_open(b);
        cslot = fsa_host_tcp_open(a);
        (void)fsa_host_tcp_listen(b, now, lslot, NULL, 18080U);
        (void)fsa_host_tcp_connect(a, now, cslot, ip_a, 49000U, ip_b, 18080U, 100000U);
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        sslot = fsa_host_tcp_accept(b, lslot, NULL, 0U);

        /* 3. End-to-end TCP bulk streaming throughput (8 MiB) */
        {
            enum { TCP_TOTAL = 8 * 1024 * 1024 };
            uint8_t chunk[8192], sink[8192];
            size_t sent = 0U, recvd = 0U;
            memcpy(chunk, csum_buf, sizeof(csum_buf));
            t0 = mono_ns();
            while (recvd < (size_t)TCP_TOTAL) {
                int w = 0, n = 0;
                if (sent < (size_t)TCP_TOTAL) {
                    uint32_t rem = (uint32_t)((size_t)TCP_TOTAL - sent);
                    if (rem > 8192U) rem = 8192U;
                    w = fsa_host_tcp_write(a, now, cslot, chunk, rem);
                    if (w > 0) sent += (size_t)w;
                }
                (void)fsa_host_tcp_pump(a, now, cslot);
                (void)fsa_host_veth_pump(&veth, now);
                (void)fsa_host_veth_pump(&veth, now);
                n = fsa_host_tcp_recv(b, now, sslot, sink, sizeof(sink), NULL, 0U);
                if (n > 0) recvd += (size_t)n;
                if (fsa_host_veth_pump(&veth, now) == 0 && w <= 0 && n <= 0) {
                    now += 45;
                    (void)fsa_host_veth_step_until_quiescent(&veth, now, 8);
                }
            }
            dt_ns = mono_ns() - t0;
            tcp_mbps = ((double)TCP_TOTAL * 8.0 / 1e6) / ((double)(dt_ns > 0 ? dt_ns : 1ULL) * 1e-9);
        }

        /* 4. End-to-end TCP 64-byte ping-pong loopback RTT */
        {
            enum { RTT_ITERS = 5000 };
            uint8_t ping[64], pong[64];
            int it;
            memset(ping, 0x5AU, sizeof(ping));
            t0 = mono_ns();
            for (it = 0; it < RTT_ITERS; it++) {
                (void)fsa_host_tcp_write(a, now, cslot, ping, sizeof(ping));
                (void)fsa_host_veth_pump(&veth, now);
                if (fsa_host_tcp_recv(b, now, sslot, pong, sizeof(pong), NULL, 0U) <= 0) {
                    now += 45;
                    (void)fsa_host_veth_step_until_quiescent(&veth, now, 4);
                    (void)fsa_host_tcp_recv(b, now, sslot, pong, sizeof(pong), NULL, 0U);
                }
                (void)fsa_host_veth_pump(&veth, now);
                (void)fsa_host_tcp_write(b, now, sslot, pong, sizeof(pong));
                (void)fsa_host_veth_pump(&veth, now);
                if (fsa_host_tcp_recv(a, now, cslot, pong, sizeof(pong), NULL, 0U) <= 0) {
                    now += 45;
                    (void)fsa_host_veth_step_until_quiescent(&veth, now, 4);
                    (void)fsa_host_tcp_recv(a, now, cslot, pong, sizeof(pong), NULL, 0U);
                }
                (void)fsa_host_veth_pump(&veth, now);
            }
            dt_ns = mono_ns() - t0;
            tcp_rtt_us = ((double)dt_ns / 1000.0) / (double)RTT_ITERS;
        }

        fsa_host_destroy(a, now + 10);
        fsa_host_destroy(b, now + 10);
    }

    (void)csum_sink;
    printf("{\"schema\":\"tcpip-stack-bench-v1\",\"checksum_mib_s\":%.2f,"
           "\"udp_1400b_kpps\":%.2f,\"udp_1400b_mbps\":%.2f,"
           "\"tcp_bulk_8mib_mbps\":%.2f,\"tcp_pingpong_rtt_us\":%.2f}\n",
           csum_mibs, udp_kpps, udp_mbps, tcp_mbps, tcp_rtt_us);
    return 0;
}
