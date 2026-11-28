/* Live traffic driver exercising DHCPv4 DORA, DNS A lookup, ARP, ICMP Echo, UDP,
 * and multi-connection TCP over real POSIX 127.0.0.1 UDP sockets with PCAP capture.
 */
#ifndef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE 200809L
#endif

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "host_runtime.h"

#define LIVE_CHECK(cond, msg)                                                       \
    do {                                                                            \
        if (!(cond)) {                                                              \
            fprintf(stderr, "[LIVE-FAIL] line %d: %s\n", __LINE__, (msg));          \
            return 1;                                                               \
        }                                                                           \
    } while (0)

static uint16_t csum16(const uint8_t *buf, size_t len) {
    uint32_t sum = 0U;
    size_t i;
    for (i = 0U; i + 1U < len; i += 2U) sum += ((uint32_t)buf[i] << 8) | buf[i + 1U];
    if (len & 1U) sum += (uint32_t)buf[len - 1U] << 8;
    while (sum >> 16) sum = (sum & 0xFFFFU) + (sum >> 16);
    return (uint16_t)(~sum & 0xFFFFU);
}

static size_t make_dhcp_reply(uint8_t *out, uint8_t msg_type, uint32_t xid,
                              const uint8_t yiaddr[4], const uint8_t srv_ip[4],
                              const uint8_t mask[4], const uint8_t mac[6]) {
    size_t p = 240U;
    memset(out, 0, 300U);
    out[0] = 2U; out[1] = 1U; out[2] = 6U;
    out[4] = (uint8_t)(xid >> 24); out[5] = (uint8_t)(xid >> 16);
    out[6] = (uint8_t)(xid >> 8);  out[7] = (uint8_t)xid;
    out[10] = 0x80U;
    memcpy(out + 16, yiaddr, 4U);
    memcpy(out + 28, mac, 6U);
    out[236] = 99U; out[237] = 130U; out[238] = 83U; out[239] = 99U;
    out[p++] = 53U; out[p++] = 1U; out[p++] = msg_type;
    out[p++] = 54U; out[p++] = 4U; memcpy(out + p, srv_ip, 4U); p += 4U;
    out[p++] = 1U;  out[p++] = 4U; memcpy(out + p, mask, 4U);   p += 4U;
    out[p++] = 3U;  out[p++] = 4U; memcpy(out + p, srv_ip, 4U); p += 4U;
    out[p++] = 6U;  out[p++] = 4U; memcpy(out + p, srv_ip, 4U); p += 4U;
    out[p++] = 255U;
    return p;
}

static size_t make_dns_reply(uint8_t *out, const uint8_t *q, size_t qlen, const uint8_t ip[4]) {
    size_t p = qlen;
    memcpy(out, q, qlen);
    out[2] = 0x81U; out[3] = 0x80U;
    out[6] = 0x00U; out[7] = 0x01U;
    out[p++] = 0xC0U; out[p++] = 0x0CU;
    out[p++] = 0x00U; out[p++] = 0x01U;
    out[p++] = 0x00U; out[p++] = 0x01U;
    out[p++] = 0x00U; out[p++] = 0x00U; out[p++] = 0x00U; out[p++] = 0x3CU;
    out[p++] = 0x00U; out[p++] = 0x04U;
    memcpy(out + p, ip, 4U);
    return p + 4U;
}

static void pump_live(fsa_host_udp_wire_t *w, fsa_host_stack_t *a, fsa_host_stack_t *b, int64_t *now_ms) {
    int r, idle = 0;
    for (r = 0; r < 64; r++) {
        int n;
        *now_ms += 2;
        (void)fsa_host_tick(a, *now_ms);
        (void)fsa_host_tick(b, *now_ms);
        n = fsa_host_udp_wire_pump(w, a, b, *now_ms);
        if (n == 0) {
            struct timespec ts = {0, 250000L}; /* 0.25 ms */
            (void)nanosleep(&ts, NULL);
            idle++;
            if (idle >= 6) break;
        } else {
            idle = 0;
        }
    }
}

int main(int argc, char **argv) {
    static const uint8_t zero_ip[4] = {0, 0, 0, 0};
    static const uint8_t bcast_ip[4] = {255, 255, 255, 255};
    static const uint8_t srv_ip[4] = {10, 42, 0, 1};
    static const uint8_t cli_lease_ip[4] = {10, 42, 0, 10};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_cli[6] = {0x02, 0x42, 0x00, 0x00, 0x00, 0x10};
    static const uint8_t mac_srv[6] = {0x02, 0x42, 0x00, 0x00, 0x00, 0x01};
    const char *pcap_path;
    fsa_host_pcap_t pcap;
    fsa_host_udp_wire_t wire;
    fsa_host_stack_t *cli, *srv;
    int dhcp_s, dns_s, udp_srv_s, udp_cli_s, listen_s, dns_q, i;
    fsa_host_udp_dgram_t dg;
    fsa_host_dhcp_info_t lease;
    fsa_host_dns_slot_t dns_info;
    uint8_t pkt[320], icmp[16];
    uint16_t ck;
    int64_t now = 1000;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s <out.pcap>\n", argv[0]);
        return 2;
    }
    pcap_path = argv[1];
    if (fsa_host_pcap_open(&pcap, pcap_path) != 0) return 1;
    if (fsa_host_udp_wire_open(&wire, &pcap) != 0) return 1;

    cli = fsa_host_create(fsa_host_udp_wire_tx_a(), &wire, NULL);
    srv = fsa_host_create(fsa_host_udp_wire_tx_b(), &wire, NULL);
    if (!cli || !srv) return 1;

    (void)fsa_host_init_if(cli, now, zero_ip, mask, zero_ip, mac_cli, 1500U);
    (void)fsa_host_init_if(srv, now, srv_ip, mask, srv_ip, mac_srv, 1500U);

    dhcp_s = fsa_host_udp_open(srv);
    dns_s = fsa_host_udp_open(srv);
    udp_srv_s = fsa_host_udp_open(srv);
    listen_s = fsa_host_tcp_open(srv);
    (void)fsa_host_udp_bind(srv, now, dhcp_s, NULL, 67U);
    (void)fsa_host_udp_bind(srv, now, dns_s, NULL, 53U);
    (void)fsa_host_udp_bind(srv, now, udp_srv_s, NULL, 5005U);
    (void)fsa_host_tcp_listen(srv, now, listen_s, NULL, 8080U);

    /* 1. DHCPv4 DORA */
    (void)fsa_host_dhcp_start(cli, now, mac_cli, 0x13572468U);
    pump_live(&wire, cli, srv, &now);
    LIVE_CHECK(fsa_host_udp_recv(srv, dhcp_s, &dg, 0U) >= 244, "dhcp discover");
    (void)fsa_host_udp_sendto(srv, now, dhcp_s, srv_ip, bcast_ip, 68U, pkt,
                              (uint16_t)make_dhcp_reply(pkt, 2U, 0x13572468U, cli_lease_ip, srv_ip, mask, mac_cli));
    pump_live(&wire, cli, srv, &now);
    LIVE_CHECK(fsa_host_udp_recv(srv, dhcp_s, &dg, 0U) >= 244, "dhcp request");
    (void)fsa_host_udp_sendto(srv, now, dhcp_s, srv_ip, bcast_ip, 68U, pkt,
                              (uint16_t)make_dhcp_reply(pkt, 5U, 0x13572468U, cli_lease_ip, srv_ip, mask, mac_cli));
    pump_live(&wire, cli, srv, &now);
    LIVE_CHECK(fsa_host_dhcp_poll(cli, &lease) == 1, "dhcp bound");

    /* 2. DNS A query + ARP resolution */
    dns_q = fsa_host_dns_query(cli, now, lease.ip, lease.dns_ip, "echo.demo.local", 0x2233U);
    pump_live(&wire, cli, srv, &now);
    LIVE_CHECK(fsa_host_udp_recv(srv, dns_s, &dg, 0U) >= 20, "dns query rx");
    (void)fsa_host_udp_sendto(srv, now, dns_s, srv_ip, lease.ip, dg.src_port, pkt,
                              (uint16_t)make_dns_reply(pkt, dg.data, dg.len, srv_ip));
    pump_live(&wire, cli, srv, &now);
    LIVE_CHECK(fsa_host_dns_poll(cli, dns_q, &dns_info) == 1, "dns resolved");

    /* 3. ICMP Echo Request / Reply */
    memset(icmp, 0, sizeof(icmp));
    icmp[0] = 8U; icmp[4] = 0xABU; icmp[5] = 0xCDU; icmp[7] = 1U;
    memcpy(icmp + 8, "LIVEPING", 8U);
    ck = csum16(icmp, sizeof(icmp));
    icmp[2] = (uint8_t)(ck >> 8); icmp[3] = (uint8_t)(ck & 0xFFU);
    (void)fsa_host_tx_ip(cli, now, lease.ip, dns_info.ip, 1U, icmp, sizeof(icmp));
    pump_live(&wire, cli, srv, &now);

    /* 4. UDP echo */
    udp_cli_s = fsa_host_udp_open(cli);
    (void)fsa_host_udp_bind(cli, now, udp_cli_s, lease.ip, 55005U);
    (void)fsa_host_udp_sendto(cli, now, udp_cli_s, lease.ip, dns_info.ip, 5005U,
                              (const uint8_t *)"udp-live-request", 16U);
    pump_live(&wire, cli, srv, &now);
    LIVE_CHECK(fsa_host_udp_recv(srv, udp_srv_s, &dg, 0U) == 16, "udp req rx");
    (void)fsa_host_udp_sendto(srv, now, udp_srv_s, srv_ip, dg.src_ip, dg.src_port,
                              (const uint8_t *)"udp-live-reply", 14U);
    pump_live(&wire, cli, srv, &now);
    LIVE_CHECK(fsa_host_udp_recv(cli, udp_cli_s, &dg, 0U) == 14, "udp rep rx");

    /* 5. Two concurrent TCP connections (handshake, request/response, clean FIN close) */
    for (i = 0; i < 2; i++) {
        int cs = fsa_host_tcp_open(cli), ss;
        char req[128], resp[160], rx[160];
        int n;
        (void)fsa_host_tcp_connect(cli, now, cs, lease.ip, (uint16_t)(48000 + i),
                                   dns_info.ip, 8080U, (uint32_t)(30000U + (uint32_t)i * 10000U));
        pump_live(&wire, cli, srv, &now);
        ss = fsa_host_tcp_accept(srv, listen_s, NULL, 0U);
        LIVE_CHECK(ss >= 0, "tcp accept");
        snprintf(req, sizeof(req), "TCP-STREAM-%d: model-generated C99 stack", i);
        (void)fsa_host_tcp_write(cli, now, cs, (const uint8_t *)req, (uint32_t)strlen(req));
        pump_live(&wire, cli, srv, &now);
        n = fsa_host_tcp_recv(srv, now, ss, (uint8_t *)rx, sizeof(rx) - 1U, NULL, 0U);
        LIVE_CHECK(n > 0, "tcp srv recv");
        rx[n] = '\0';
        snprintf(resp, sizeof(resp), "ACK[%.120s]", rx);
        (void)fsa_host_tcp_write(srv, now, ss, (const uint8_t *)resp, (uint32_t)strlen(resp));
        pump_live(&wire, cli, srv, &now);
        n = fsa_host_tcp_recv(cli, now, cs, (uint8_t *)rx, sizeof(rx), NULL, 0U);
        LIVE_CHECK(n == (int)strlen(resp), "tcp cli recv");
        (void)fsa_host_tcp_close(cli, now, cs);
        pump_live(&wire, cli, srv, &now);
        (void)fsa_host_tcp_close(srv, now, ss);
        pump_live(&wire, cli, srv, &now);
    }

    printf("{\"status\":\"ok\",\"leased_ip\":\"%u.%u.%u.%u\",\"resolved_ip\":\"%u.%u.%u.%u\","
           "\"pcap_packets\":%" PRIu64 ",\"pcap_bytes\":%" PRIu64 ","
           "\"udp_sock_port_a\":%u,\"udp_sock_port_b\":%u}\n",
           lease.ip[0], lease.ip[1], lease.ip[2], lease.ip[3],
           dns_info.ip[0], dns_info.ip[1], dns_info.ip[2], dns_info.ip[3],
           pcap.packets_written, pcap.bytes_written,
           (unsigned)wire.port_a, (unsigned)wire.port_b);

    fsa_host_destroy(cli, now + 10);
    fsa_host_destroy(srv, now + 10);
    fsa_host_udp_wire_close(&wire);
    fsa_host_pcap_close(&pcap);
    return 0;
}
