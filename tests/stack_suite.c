/* End-to-end verification suite for the generated 10-module C99 TCP/IPv4 stack. */
#if !defined(FSA_HOST_NO_SYS) || (FSA_HOST_NO_SYS == 0)
#ifndef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE 200809L
#endif
#endif

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if !FSA_HOST_NO_SYS
#include <pthread.h>
#include <time.h>
#endif

#include "host_runtime.h"

#define CHECK(cond, msg)                                                                   \
    do {                                                                                   \
        if (!(cond)) {                                                                     \
            fprintf(stderr, "[FAIL] %s:%d: %s (%s)\n", __FILE__, __LINE__, (msg), #cond);  \
            return 1;                                                                      \
        }                                                                                  \
    } while (0)

static uint16_t inet_csum16(const uint8_t *buf, size_t len) {
    uint32_t sum = 0U;
    size_t i;
    for (i = 0U; i + 1U < len; i += 2U) {
        sum += ((uint32_t)buf[i] << 8) | (uint32_t)buf[i + 1U];
    }
    if ((len & 1U) != 0U) {
        sum += (uint32_t)buf[len - 1U] << 8;
    }
    while ((sum >> 16) != 0U) {
        sum = (sum & 0xFFFFU) + (sum >> 16);
    }
    return (uint16_t)(~sum & 0xFFFFU);
}

static size_t build_dhcp_reply(uint8_t *out, uint8_t msg_type, uint32_t xid,
                               const uint8_t yiaddr[4], const uint8_t srv_ip[4],
                               const uint8_t mask[4], const uint8_t gw[4],
                               const uint8_t dns_ip[4], const uint8_t mac[6]) {
    size_t pos = 240U;
    memset(out, 0, 300U);
    out[0] = 2U; /* BOOTREPLY */
    out[1] = 1U;
    out[2] = 6U;
    out[4] = (uint8_t)((xid >> 24) & 0xFFU);
    out[5] = (uint8_t)((xid >> 16) & 0xFFU);
    out[6] = (uint8_t)((xid >> 8) & 0xFFU);
    out[7] = (uint8_t)(xid & 0xFFU);
    out[10] = 0x80U;
    memcpy(out + 16, yiaddr, 4U);
    memcpy(out + 28, mac, 6U);
    out[236] = 99U;
    out[237] = 130U;
    out[238] = 83U;
    out[239] = 99U;

    out[pos++] = 53U; out[pos++] = 1U; out[pos++] = msg_type;
    out[pos++] = 54U; out[pos++] = 4U; memcpy(out + pos, srv_ip, 4U); pos += 4U;
    out[pos++] = 1U;  out[pos++] = 4U; memcpy(out + pos, mask, 4U);   pos += 4U;
    out[pos++] = 3U;  out[pos++] = 4U; memcpy(out + pos, gw, 4U);     pos += 4U;
    out[pos++] = 6U;  out[pos++] = 4U; memcpy(out + pos, dns_ip, 4U); pos += 4U;
    out[pos++] = 255U;
    return pos;
}

static size_t build_dns_a_reply(uint8_t *out, const uint8_t *query, size_t qlen,
                                const uint8_t ans_ip[4], uint32_t ttl_s) {
    size_t pos = 0U;
    if (qlen < 17U) return 0U;
    memcpy(out, query, qlen);
    out[2] = 0x81U;
    out[3] = 0x80U;
    out[4] = 0x00U; out[5] = 0x01U; /* QDCOUNT=1 */
    out[6] = 0x00U; out[7] = 0x01U; /* ANCOUNT=1 */
    out[8] = 0x00U; out[9] = 0x00U;
    out[10] = 0x00U; out[11] = 0x00U;
    pos = qlen;
    out[pos++] = 0xC0U; out[pos++] = 0x0CU; /* compressed pointer to QNAME */
    out[pos++] = 0x00U; out[pos++] = 0x01U; /* TYPE A */
    out[pos++] = 0x00U; out[pos++] = 0x01U; /* CLASS IN */
    out[pos++] = (uint8_t)((ttl_s >> 24) & 0xFFU);
    out[pos++] = (uint8_t)((ttl_s >> 16) & 0xFFU);
    out[pos++] = (uint8_t)((ttl_s >> 8) & 0xFFU);
    out[pos++] = (uint8_t)(ttl_s & 0xFFU);
    out[pos++] = 0x00U; out[pos++] = 0x04U; /* RDLENGTH=4 */
    memcpy(out + pos, ans_ip, 4U);
    pos += 4U;
    return pos;
}

/* 1. Software-architecture state machines: sys_port, frame_pool, stack_actor. */
static int test_arch_accounting(void) {
    static const uint8_t ip_a[4] = {10, 0, 0, 2};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t gw[4] = {10, 0, 0, 1};
    static const uint8_t mac_a[6] = {0x02, 0x00, 0x00, 0x00, 0x00, 0x02};
    fsa_host_stack_t *st = fsa_host_create(NULL, NULL, NULL);
    int port_state = -1, pool_state = -1, actor_state = -1;
    int64_t sem_live = -1, mbox_live = -1, threads_live = -1;
    int64_t pool_free = -1, pool_used = -1, actor_q = -1, actor_disp = -1;

    CHECK(st != NULL, "create host stack");
    CHECK(fsa_host_init_if(st, 10, ip_a, mask, gw, mac_a, 1500U) == FSA_OK, "init_if");

    fsa_host_get_arch_snapshot(st, &port_state, &sem_live, &mbox_live, &threads_live,
                               &pool_state, &pool_free, &pool_used,
                               &actor_state, &actor_q, &actor_disp);
    CHECK(port_state == FSA_SYS_PORT_STATE_READY, "sys_port READY");
    CHECK(pool_state == FSA_FRAME_POOL_STATE_ACTIVE, "frame_pool ACTIVE");
    CHECK(pool_free + pool_used == 128, "frame_pool conservation invariant");
    CHECK(pool_used == 0, "frame_pool balanced after init_if");
    CHECK(actor_state == FSA_STACK_ACTOR_STATE_IDLE, "stack_actor IDLE");
    CHECK(actor_q == 0, "stack_actor queue drained");
    CHECK(actor_disp >= 1, "stack_actor dispatched init_if");
#if FSA_HOST_NO_SYS
    CHECK(sem_live == 0 && mbox_live == 0 && threads_live == 0, "NO_SYS zero OS primitives");
#else
    CHECK(sem_live == 2 && mbox_live == 1 && threads_live == 0, "POSIX initial primitives");
    CHECK(fsa_host_start_actor(st, 20) == 0, "start actor thread");
    fsa_host_get_arch_snapshot(st, NULL, NULL, NULL, &threads_live, NULL, NULL, NULL, NULL, NULL, NULL);
    CHECK(threads_live == 1, "threads_live == 1 while actor running");
    CHECK(fsa_host_stop_actor(st, 30) == 0, "stop actor thread");
    fsa_host_get_arch_snapshot(st, NULL, NULL, NULL, &threads_live, NULL, NULL, NULL, NULL, NULL, NULL);
    CHECK(threads_live == 0, "threads_live == 0 after stop");
#endif
    fsa_host_destroy(st, 40);
    return 0;
}

/* Wire sniffer context for inspecting ICMP Echo Reply, ICMP Unreachable, and TCP RST frames. */
typedef struct {
    fsa_host_veth_link_t *veth;
    int side_dir;
    int saw_icmp_echo_reply;
    int saw_icmp_port_unreach;
    int saw_tcp_rst;
    int saw_arp_req;
    int saw_arp_rep;
} wire_tap_t;

static void tap_tx_cb(void *ctx, const uint8_t *frame, uint16_t len, int64_t now_ms) {
    wire_tap_t *tap = (wire_tap_t *)ctx;
    if (len >= 14U) {
        uint16_t eth = (uint16_t)(((uint16_t)frame[12] << 8) | frame[13]);
        if (eth == 0x0806U && len >= 42U) {
            uint16_t op = (uint16_t)(((uint16_t)frame[20] << 8) | frame[21]);
            if (op == 1U) tap->saw_arp_req++;
            if (op == 2U) tap->saw_arp_rep++;
        } else if (eth == 0x0800U && len >= 34U) {
            uint8_t ihl = (uint8_t)((frame[14] & 0x0FU) * 4U);
            uint8_t proto = frame[23];
            if (14U + ihl < len) {
                const uint8_t *l4 = frame + 14U + ihl;
                size_t l4_len = (size_t)len - 14U - ihl;
                if (proto == 1U && l4_len >= 8U) {
                    if (l4[0] == 0U && l4[1] == 0U) tap->saw_icmp_echo_reply++;
                    if (l4[0] == 3U && l4[1] == 3U) tap->saw_icmp_port_unreach++;
                } else if (proto == 6U && l4_len >= 20U) {
                    if ((l4[13] & 0x04U) != 0U) tap->saw_tcp_rst++;
                }
            }
        }
    }
    if (tap->side_dir == 0) {
        fsa_host_veth_tx_fn_a()(tap->veth, frame, len, now_ms);
    } else {
        fsa_host_veth_tx_fn_b()(tap->veth, frame, len, now_ms);
    }
}

/* 2. ARP resolution + pending flush + retry timeout, ICMP Echo, UDP Unreachable, TCP RST. */
static int test_arp_icmp_and_unreach(void) {
    static const uint8_t ip_a[4] = {10, 0, 1, 2};
    static const uint8_t ip_b[4] = {10, 0, 1, 1};
    static const uint8_t ip_ghost[4] = {10, 0, 1, 99};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_a[6] = {0x02, 0x00, 0x00, 0x01, 0x00, 0x02};
    static const uint8_t mac_b[6] = {0x02, 0x00, 0x00, 0x01, 0x00, 0x01};
    fsa_host_veth_link_t veth;
    wire_tap_t tap_a, tap_b;
    fsa_host_stack_t *a, *b;
    uint8_t icmp_req[16];
    uint16_t csum;
    int64_t now = 100;
    int u_slot, t_slot, i;

    fsa_host_veth_init(&veth, NULL);
    memset(&tap_a, 0, sizeof(tap_a));
    memset(&tap_b, 0, sizeof(tap_b));
    tap_a.veth = &veth; tap_a.side_dir = 0;
    tap_b.veth = &veth; tap_b.side_dir = 1;

    a = fsa_host_create(tap_tx_cb, &tap_a, NULL);
    b = fsa_host_create(tap_tx_cb, &tap_b, NULL);
    CHECK(a != NULL && b != NULL, "create stacks");
    fsa_host_veth_attach(&veth, a, b);
    CHECK(fsa_host_init_if(a, now, ip_a, mask, ip_b, mac_a, 1500U) == FSA_OK, "init_if a");
    CHECK(fsa_host_init_if(b, now, ip_b, mask, ip_b, mac_b, 1500U) == FSA_OK, "init_if b");

    /* Send ICMP Echo Request from A -> B (triggers ARP Request + Reply + queued ICMP flush + Echo Reply). */
    memset(icmp_req, 0, sizeof(icmp_req));
    icmp_req[0] = 8U; /* Echo Request */
    icmp_req[4] = 0x12U; icmp_req[5] = 0x34U;
    icmp_req[6] = 0x00U; icmp_req[7] = 0x01U;
    memcpy(icmp_req + 8, "PINGDATA", 8U);
    csum = inet_csum16(icmp_req, sizeof(icmp_req));
    icmp_req[2] = (uint8_t)(csum >> 8);
    icmp_req[3] = (uint8_t)(csum & 0xFFU);

    CHECK(fsa_host_tx_ip(a, now, ip_a, ip_b, 1U, icmp_req, sizeof(icmp_req)) == FSA_OK, "tx_ip icmp");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(tap_a.saw_arp_req >= 1, "ARP Request emitted");
    CHECK(tap_b.saw_arp_rep >= 1, "ARP Reply emitted");
    CHECK(tap_b.saw_icmp_echo_reply == 1, "ICMP Echo Reply emitted");

    /* Send UDP to closed port 9999 on B -> B must reply with ICMP Port Unreachable. */
    u_slot = fsa_host_udp_open(a);
    CHECK(u_slot >= 0, "alloc udp");
    CHECK(fsa_host_udp_bind(a, now, u_slot, ip_a, 5000U) == FSA_OK, "bind udp");
    CHECK(fsa_host_udp_sendto(a, now, u_slot, ip_a, ip_b, 9999U, (const uint8_t *)"hello", 5U) == FSA_OK, "sendto closed");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(tap_b.saw_icmp_port_unreach == 1, "ICMP Destination Port Unreachable emitted");

    /* Connect TCP to closed port 7777 on B -> B must reply with TCP RST and A transitions to CLOSED. */
    t_slot = fsa_host_tcp_open(a);
    CHECK(t_slot >= 0, "alloc tcp");
    CHECK(fsa_host_tcp_connect(a, now, t_slot, ip_a, 41000U, ip_b, 7777U, 1000U) == FSA_OK, "connect closed");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(tap_b.saw_tcp_rst >= 1, "TCP RST emitted on closed port");
    CHECK(fsa_host_tcp_state(a, t_slot) == FSA_TCP_STATE_CLOSED, "TCP reset to CLOSED");

    /* Send UDP to non-existent host 10.0.1.99 -> ARP retries and expires back to FREE. */
    CHECK(fsa_host_udp_sendto(a, now, u_slot, ip_a, ip_ghost, 9000U, (const uint8_t *)"x", 1U) == FSA_OK, "sendto ghost");
    for (i = 0; i < 6; i++) {
        now += 1000;
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 8);
    }
    {
        const tcpip_stack_system_t *raw = fsa_host_raw_system_unsafe(a);
        int any_pending = 0, s;
        for (s = 0; s < 16; s++) {
            if (tcpip_stack_get_arp_neighbor_state(raw, s) == FSA_ARP_STATE_PENDING) any_pending = 1;
        }
        CHECK(!any_pending, "ARP pending entry expired back to FREE");
    }

    fsa_host_destroy(a, now + 10);
    fsa_host_destroy(b, now + 10);
    return 0;
}

/* 3. IPv4 2-fragment & 3-fragment TX split + in-order & out-of-order RX reassembly + timeout. */
static int test_ipv4_frag_and_ooo_reassembly(void) {
    static const uint8_t ip_a[4] = {10, 0, 2, 2};
    static const uint8_t ip_b[4] = {10, 0, 2, 1};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_a[6] = {0x02, 0x00, 0x00, 0x02, 0x00, 0x02};
    static const uint8_t mac_b[6] = {0x02, 0x00, 0x00, 0x02, 0x00, 0x01};
    fsa_host_veth_link_t veth;
    fsa_host_stack_t *a, *b;
    uint8_t big_payload[1350];
    fsa_host_udp_dgram_t rx;
    int ua, ub;
    size_t i;
    int64_t now = 100;

    for (i = 0U; i < sizeof(big_payload); i++) {
        big_payload[i] = (uint8_t)((i * 37U + 11U) & 0xFFU);
    }

    fsa_host_veth_init(&veth, NULL);
    a = fsa_host_create(fsa_host_veth_tx_fn_a(), &veth, NULL);
    b = fsa_host_create(fsa_host_veth_tx_fn_b(), &veth, NULL);
    CHECK(a != NULL && b != NULL, "create stacks");
    fsa_host_veth_attach(&veth, a, b);

    /* MTU 576 => max fragment payload 552 bytes => 900B splits into 2 frags, 1350B splits into 3 frags! */
    CHECK(fsa_host_init_if(a, now, ip_a, mask, ip_b, mac_a, 576U) == FSA_OK, "init_if a mtu=576");
    CHECK(fsa_host_init_if(b, now, ip_b, mask, ip_b, mac_b, 1500U) == FSA_OK, "init_if b mtu=1500");

    ua = fsa_host_udp_open(a);
    ub = fsa_host_udp_open(b);
    CHECK(fsa_host_udp_bind(a, now, ua, ip_a, 6001U) == FSA_OK, "bind ua");
    CHECK(fsa_host_udp_bind(b, now, ub, ip_b, 6002U) == FSA_OK, "bind ub");

    /* Warm ARP cache first with small datagram so fragmentation sequence numbers are exact. */
    CHECK(fsa_host_udp_sendto(a, now, ua, ip_a, ip_b, 6002U, big_payload, 32U) == FSA_OK, "warm arp");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(fsa_host_udp_recv(b, ub, &rx, 0U) == 32, "recv warm dgram");

    /* 2-fragment UDP datagram (900 B) in-order. */
    now += 10;
    CHECK(fsa_host_udp_sendto(a, now, ua, ip_a, ip_b, 6002U, big_payload, 900U) == FSA_OK, "sendto 900B");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(fsa_host_udp_recv(b, ub, &rx, 0U) == 900, "reassembled 900B 2-frag");
    CHECK(memcmp(rx.data, big_payload, 900U) == 0, "900B payload match");

    /* 3-fragment UDP datagram (1350 B) with OUT-OF-ORDER wire delivery (delay first 2 frags behind 3rd). */
    now += 10;
    veth.tx_seq[0] = 0ULL;
    veth.dir_cfg[0].reorder_seq_mask = (1ULL << 0) | (1ULL << 1); /* frag0 & frag1 arrive AFTER frag2 */
    veth.dir_cfg[0].reorder_extra_ms = 5;
    CHECK(fsa_host_udp_sendto(a, now, ua, ip_a, ip_b, 6002U, big_payload, 1350U) == FSA_OK, "sendto 1350B OOO");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 8);
    now += 10;
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(veth.reordered[0] == 2ULL, "wire reordered 2 fragments");
    CHECK(fsa_host_udp_recv(b, ub, &rx, 0U) == 1350, "reassembled 1350B 3-frag OOO");
    CHECK(memcmp(rx.data, big_payload, 1350U) == 0, "1350B OOO payload match");

    /* Drop middle fragment -> ipv4_reass slot enters COLLECTING, then expires back to IDLE after 5s. */
    now += 10;
    veth.tx_seq[0] = 0ULL;
    veth.dir_cfg[0].reorder_seq_mask = 0ULL;
    veth.dir_cfg[0].drop_seq_mask = (1ULL << 1);
    CHECK(fsa_host_udp_sendto(a, now, ua, ip_a, ip_b, 6002U, big_payload, 1350U) == FSA_OK, "sendto 1350B drop");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(tcpip_stack_get_ipv4_reass_state(fsa_host_raw_system_unsafe(b), 0) == FSA_REASS_STATE_COLLECTING,
          "reass slot COLLECTING");
    now += 5500;
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(tcpip_stack_get_ipv4_reass_state(fsa_host_raw_system_unsafe(b), 0) == FSA_REASS_STATE_IDLE,
          "reass slot timed out to IDLE");

    fsa_host_destroy(a, now + 10);
    fsa_host_destroy(b, now + 10);
    return 0;
}

/* 4. Multi-endpoint UDP bind / connect / send / sendto / close. */
static int test_udp_multi_endpoint(void) {
    static const uint8_t ip_a[4] = {10, 0, 3, 2};
    static const uint8_t ip_b[4] = {10, 0, 3, 1};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_a[6] = {0x02, 0x00, 0x00, 0x03, 0x00, 0x02};
    static const uint8_t mac_b[6] = {0x02, 0x00, 0x00, 0x03, 0x00, 0x01};
    fsa_host_veth_link_t veth;
    fsa_host_stack_t *a, *b;
    int a_s[4], b_s[4], k;
    int64_t now = 100;

    fsa_host_veth_init(&veth, NULL);
    a = fsa_host_create(fsa_host_veth_tx_fn_a(), &veth, NULL);
    b = fsa_host_create(fsa_host_veth_tx_fn_b(), &veth, NULL);
    fsa_host_veth_attach(&veth, a, b);
    CHECK(fsa_host_init_if(a, now, ip_a, mask, ip_b, mac_a, 1500U) == FSA_OK, "init a");
    CHECK(fsa_host_init_if(b, now, ip_b, mask, ip_b, mac_b, 1500U) == FSA_OK, "init b");

    for (k = 0; k < 4; k++) {
        a_s[k] = fsa_host_udp_open(a);
        b_s[k] = fsa_host_udp_open(b);
        CHECK(a_s[k] >= 0 && b_s[k] >= 0, "open udp slots");
        CHECK(fsa_host_udp_bind(a, now, a_s[k], ip_a, (uint16_t)(7100 + k)) == FSA_OK, "bind a");
        CHECK(fsa_host_udp_connect(a, now, a_s[k], ip_b, (uint16_t)(8100 + k)) == FSA_OK, "connect a");
        CHECK(fsa_host_udp_bind(b, now, b_s[k], NULL, (uint16_t)(8100 + k)) == FSA_OK, "bind wildcard b");
    }

    for (k = 0; k < 4; k++) {
        uint8_t msg[32];
        fsa_host_udp_dgram_t dgram;
        snprintf((char *)msg, sizeof(msg), "udp-chan-%d", k);
        now += 5;
        CHECK(fsa_host_udp_send(a, now, a_s[k], ip_a, msg, (uint16_t)strlen((char *)msg)) == FSA_OK, "udp_send");
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        CHECK(fsa_host_udp_recv(b, b_s[k], &dgram, 0U) == (int)strlen((char *)msg), "udp_recv b");
        CHECK(memcmp(dgram.data, msg, dgram.len) == 0, "udp payload match");
        CHECK(dgram.src_port == (uint16_t)(7100 + k), "udp src_port match");
        CHECK(fsa_host_udp_close(a, now, a_s[k]) == FSA_OK, "udp close a");
        CHECK(fsa_host_udp_close(b, now, b_s[k]) == FSA_OK, "udp close b");
    }

    fsa_host_destroy(a, now + 10);
    fsa_host_destroy(b, now + 10);
    return 0;
}

/* 5. 8 concurrent TCP connections: passive listen/fork, bidirectional echo, clean FIN -> TIME_WAIT -> CLOSED. */
static int test_tcp_8_concurrent_connections(void) {
    static const uint8_t ip_cli[4] = {10, 0, 4, 2};
    static const uint8_t ip_srv[4] = {10, 0, 4, 1};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_cli[6] = {0x02, 0x00, 0x00, 0x04, 0x00, 0x02};
    static const uint8_t mac_srv[6] = {0x02, 0x00, 0x00, 0x04, 0x00, 0x01};
    fsa_host_veth_link_t veth;
    fsa_host_stack_t *cli, *srv;
    int listen_slot;
    int cli_slots[8];
    int srv_slots[8];
    int i;
    int64_t now = 100;

    fsa_host_veth_init(&veth, NULL);
    cli = fsa_host_create(fsa_host_veth_tx_fn_a(), &veth, NULL);
    srv = fsa_host_create(fsa_host_veth_tx_fn_b(), &veth, NULL);
    fsa_host_veth_attach(&veth, cli, srv);
    CHECK(fsa_host_init_if(cli, now, ip_cli, mask, ip_srv, mac_cli, 1500U) == FSA_OK, "init cli");
    CHECK(fsa_host_init_if(srv, now, ip_srv, mask, ip_srv, mac_srv, 1500U) == FSA_OK, "init srv");

    listen_slot = fsa_host_tcp_open(srv);
    CHECK(listen_slot == 0, "srv listen slot 0");
    CHECK(fsa_host_tcp_listen(srv, now, listen_slot, NULL, 8080U) == FSA_OK, "srv listen 8080");

    for (i = 0; i < 8; i++) {
        fsa_host_accept_item_t acc;
        cli_slots[i] = fsa_host_tcp_open(cli);
        CHECK(cli_slots[i] >= 0, "open cli tcp slot");
        now += 5;
        CHECK(fsa_host_tcp_connect(cli, now, cli_slots[i], ip_cli, (uint16_t)(42000 + i),
                                   ip_srv, 8080U, (uint32_t)(10000U + (uint32_t)i * 5000U)) == FSA_OK,
              "cli connect");
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        CHECK(fsa_host_tcp_is_connected(cli, cli_slots[i]) == 1, "cli connected");
        srv_slots[i] = fsa_host_tcp_accept(srv, listen_slot, &acc, 0U);
        CHECK(srv_slots[i] > 0, "srv accepted child slot");
        CHECK(acc.remote_port == (uint16_t)(42000 + i), "accepted remote_port");
    }

    /* Echo distinct payloads across all 8 concurrent connections simultaneously. */
    for (i = 0; i < 8; i++) {
        uint8_t tx[256], rx[256];
        size_t k;
        int n, eof = 0;
        for (k = 0U; k < sizeof(tx); k++) tx[k] = (uint8_t)((k + (size_t)i * 19U) & 0xFFU);
        now += 5;
        CHECK(fsa_host_tcp_write(cli, now, cli_slots[i], tx, sizeof(tx)) == (int)sizeof(tx), "cli write");
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        n = fsa_host_tcp_recv(srv, now, srv_slots[i], rx, sizeof(rx), &eof, 0U);
        CHECK(n == (int)sizeof(tx) && memcmp(tx, rx, sizeof(tx)) == 0, "srv recv exact");
        CHECK(fsa_host_tcp_write(srv, now, srv_slots[i], rx, (uint32_t)n) == n, "srv echo write");
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        n = fsa_host_tcp_recv(cli, now, cli_slots[i], rx, sizeof(rx), &eof, 0U);
        CHECK(n == (int)sizeof(tx) && memcmp(tx, rx, sizeof(tx)) == 0, "cli echo recv exact");
    }

    /* Clean 4-way FIN close on all 8 connections, then advance 2*MSL to reclaim TIME_WAIT slots. */
    for (i = 0; i < 8; i++) {
        uint8_t dummy[8];
        int eof = 0;
        now += 5;
        CHECK(fsa_host_tcp_close(cli, now, cli_slots[i]) == FSA_OK, "cli close");
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        (void)fsa_host_tcp_recv(srv, now, srv_slots[i], dummy, sizeof(dummy), &eof, 0U);
        CHECK(eof == 1, "srv observed peer EOF");
        CHECK(fsa_host_tcp_close(srv, now, srv_slots[i]) == FSA_OK, "srv close");
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        CHECK(fsa_host_tcp_state(cli, cli_slots[i]) == FSA_TCP_STATE_TIME_WAIT, "cli entered TIME_WAIT");
        CHECK(fsa_host_tcp_state(srv, srv_slots[i]) == FSA_TCP_STATE_CLOSED, "srv returned to CLOSED");
    }

    now += 15000;
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    for (i = 0; i < 8; i++) {
        CHECK(fsa_host_tcp_state(cli, cli_slots[i]) == FSA_TCP_STATE_CLOSED, "cli TIME_WAIT reclaimed to CLOSED");
    }

    fsa_host_destroy(cli, now + 10);
    fsa_host_destroy(srv, now + 10);
    return 0;
}

/* 6. Impaired link chaos: SYN drop, data drop + 3-dupACK fast retransmit + OOO coalescing,
 *    zero-window persist probe + window update, and FIN drop recovery.
 */
static int test_tcp_impairment_chaos_and_persist(void) {
    static const uint8_t ip_cli[4] = {10, 0, 5, 2};
    static const uint8_t ip_srv[4] = {10, 0, 5, 1};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_cli[6] = {0x02, 0x00, 0x00, 0x05, 0x00, 0x02};
    static const uint8_t mac_srv[6] = {0x02, 0x00, 0x00, 0x05, 0x00, 0x01};
    fsa_host_veth_link_t veth;
    fsa_host_stack_t *cli, *srv;
    int lslot, cslot, sslot;
    uint8_t tx_data[7000], rx_accum[16384];
    size_t i, rx_off = 0U;
    int64_t now = 100;
    int step;

    for (i = 0U; i < sizeof(tx_data); i++) tx_data[i] = (uint8_t)((i * 13U + 7U) & 0xFFU);

    fsa_host_veth_init(&veth, NULL);
    cli = fsa_host_create(fsa_host_veth_tx_fn_a(), &veth, NULL);
    srv = fsa_host_create(fsa_host_veth_tx_fn_b(), &veth, NULL);
    fsa_host_veth_attach(&veth, cli, srv);
    CHECK(fsa_host_init_if(cli, now, ip_cli, mask, ip_srv, mac_cli, 1500U) == FSA_OK, "init cli");
    CHECK(fsa_host_init_if(srv, now, ip_srv, mask, ip_srv, mac_srv, 1500U) == FSA_OK, "init srv");

    /* Warm ARP first so tx_seq[0] frame 0 is the TCP SYN. */
    {
        int ua = fsa_host_udp_open(cli), ub = fsa_host_udp_open(srv);
        fsa_host_udp_dgram_t dg;
        (void)fsa_host_udp_bind(cli, now, ua, ip_cli, 5100U);
        (void)fsa_host_udp_bind(srv, now, ub, ip_srv, 5101U);
        (void)fsa_host_udp_sendto(cli, now, ua, ip_cli, ip_srv, 5101U, (const uint8_t *)"w", 1U);
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        (void)fsa_host_udp_recv(srv, ub, &dg, 0U);
    }

    lslot = fsa_host_tcp_open(srv);
    CHECK(fsa_host_tcp_listen(srv, now, lslot, NULL, 9090U) == FSA_OK, "listen 9090");

    /* Drop initial SYN (seq 0 on cli->srv) -> client recovers via SYN RTO timer. */
    veth.tx_seq[0] = 0ULL;
    veth.dir_cfg[0].drop_seq_mask = (1ULL << 0);
    cslot = fsa_host_tcp_open(cli);
    CHECK(fsa_host_tcp_connect(cli, now, cslot, ip_cli, 43000U, ip_srv, 9090U, 50000U) == FSA_OK, "connect");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 8);
    CHECK(fsa_host_tcp_is_connected(cli, cslot) == 0, "SYN was dropped");
    for (step = 0; step < 15 && !fsa_host_tcp_is_connected(cli, cslot); step++) {
        now += 300;
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    }
    CHECK(fsa_host_tcp_is_connected(cli, cslot) == 1, "SYN RTO recovered connection");
    sslot = fsa_host_tcp_accept(srv, lslot, NULL, 0U);
    CHECK(sslot > 0, "srv accepted after SYN RTO");

    /* Grow cwnd to >= 5*MSS first, then drop 1st segment of a 4-segment burst:
     * segments 2, 3, 4 arrive out-of-order -> segment 2 cached in ooo_buf + 3 dupACKs ->
     * client performs RFC 5681 fast retransmit without waiting for RTO!
     */
    veth.dir_cfg[0].drop_seq_mask = 0ULL;
    CHECK(fsa_host_tcp_write(cli, now, cslot, tx_data, 2920U) == 2920, "warmup cwnd write");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    {
        int n = fsa_host_tcp_recv(srv, now, sslot, rx_accum, sizeof(rx_accum), NULL, 0U);
        CHECK(n == 2920 && memcmp(rx_accum, tx_data, 2920U) == 0, "warmup recv");
    }
    CHECK(fsa_host_tcp_write(cli, now, cslot, tx_data, 2920U) == 2920, "warmup cwnd write 2");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    {
        int n = fsa_host_tcp_recv(srv, now, sslot, rx_accum, sizeof(rx_accum), NULL, 0U);
        CHECK(n == 2920 && memcmp(rx_accum, tx_data, 2920U) == 0, "warmup recv 2");
    }

    /* Now cwnd >= 6*MSS! Drop frame 0 of a 6000-byte write (4 segments) + reorder frame 2. */
    veth.tx_seq[0] = 0ULL;
    veth.dir_cfg[0].drop_seq_mask = (1ULL << 0);
    veth.dir_cfg[0].reorder_seq_mask = (1ULL << 2);
    rx_off = 0U;
    {
        int w = fsa_host_tcp_write(cli, now, cslot, tx_data, 6000U);
        CHECK(w == 6000, "write 6000B under loss+reorder");
    }
    for (step = 0; step < 25 && rx_off < 6000U; step++) {
        int n;
        now += 150;
        (void)fsa_host_tcp_pump(cli, now, cslot);
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        n = fsa_host_tcp_recv(srv, now, sslot, rx_accum + rx_off, (uint32_t)(sizeof(rx_accum) - rx_off), NULL, 0U);
        if (n > 0) rx_off += (size_t)n;
    }
    CHECK(rx_off == 6000U, "all 6000B delivered across fast-retransmit + OOO + RTO");
    CHECK(memcmp(rx_accum, tx_data, 6000U) == 0, "6000B exact byte integrity after loss/OOO");

    /* Zero-window persist test: fill server's 8192B receive window WITHOUT calling fsa_host_tcp_recv,
     * then queue more bytes so client arms ZWP timer, probes zero window, and resumes once server reads!
     */
    veth.dir_cfg[0].drop_seq_mask = 0ULL;
    veth.dir_cfg[0].reorder_seq_mask = 0ULL;
    {
        size_t sent = 0U, got = 0U;
        uint8_t zbuf[12000], zrx[12000];
        for (i = 0U; i < sizeof(zbuf); i++) zbuf[i] = (uint8_t)((i * 29U + 3U) & 0xFFU);
        while (sent < 8192U) {
            int w = fsa_host_tcp_write(cli, now, cslot, zbuf + sent, (uint32_t)(8192U - sent));
            if (w > 0) sent += (size_t)w;
            now += 20;
            (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
            if (w == 0) break;
        }
        CHECK(tcpip_stack_get_tcp_connection_var_int(fsa_host_raw_system_unsafe(srv), sslot, FSA_TCP_SVAR_RCV_WND) == 0,
              "server rcv_wnd reached 0");
        /* Queue additional bytes while snd_wnd == 0 -> triggers ZWP probe timer! */
        {
            int w = fsa_host_tcp_write(cli, now, cslot, zbuf + sent, (uint32_t)(sizeof(zbuf) - sent));
            CHECK(w > 0, "queued bytes into zero window");
            sent += (size_t)w;
        }
        now += 300; /* fire ZWP probe */
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        /* Now drain server receive buffer -> triggers TCP.RECVED_UPD window update ACK and completes stream! */
        for (step = 0; step < 30 && got < sizeof(zbuf); step++) {
            int n = fsa_host_tcp_recv(srv, now, sslot, zrx + got, (uint32_t)(sizeof(zrx) - got), NULL, 0U);
            if (n > 0) got += (size_t)n;
            if (sent < sizeof(zbuf)) {
                int w = fsa_host_tcp_write(cli, now, cslot, zbuf + sent, (uint32_t)(sizeof(zbuf) - sent));
                if (w > 0) sent += (size_t)w;
            }
            now += 50;
            (void)fsa_host_tcp_pump(cli, now, cslot);
            (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        }
        CHECK(got == sizeof(zbuf) && memcmp(zbuf, zrx, sizeof(zbuf)) == 0,
              "zero-window probe + window update completed full 12000B transfer");
    }

    /* Drop FIN on close -> recovers via FIN retransmission! */
    veth.tx_seq[0] = 0ULL;
    veth.dir_cfg[0].drop_seq_mask = (1ULL << 0);
    CHECK(fsa_host_tcp_close(cli, now, cslot) == FSA_OK, "cli close with FIN drop");
    for (step = 0; step < 15; step++) {
        uint8_t tmp[8];
        int eof = 0;
        now += 300;
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        (void)fsa_host_tcp_recv(srv, now, sslot, tmp, sizeof(tmp), &eof, 0U);
        if (eof) break;
    }
    CHECK(fsa_host_tcp_state(srv, sslot) == FSA_TCP_STATE_CLOSE_WAIT, "FIN retransmit reached CLOSE_WAIT");
    CHECK(fsa_host_tcp_close(srv, now, sslot) == FSA_OK, "srv close");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);

    fsa_host_destroy(cli, now + 10);
    fsa_host_destroy(srv, now + 10);
    return 0;
}

/* 7. Multi-MiB (2 MiB = 2,097,152 B) TCP bulk transfer with exact byte-by-byte verification. */
static int test_tcp_multi_mib_bulk_integrity(void) {
    enum { TOTAL_BYTES = 2 * 1024 * 1024 };
    static const uint8_t ip_cli[4] = {10, 0, 6, 2};
    static const uint8_t ip_srv[4] = {10, 0, 6, 1};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_cli[6] = {0x02, 0x00, 0x00, 0x06, 0x00, 0x02};
    static const uint8_t mac_srv[6] = {0x02, 0x00, 0x00, 0x06, 0x00, 0x01};
    fsa_host_veth_link_t veth;
    fsa_host_stack_t *cli, *srv;
    uint8_t *src_buf = (uint8_t *)malloc(TOTAL_BYTES);
    uint8_t *dst_buf = (uint8_t *)malloc(TOTAL_BYTES);
    int lslot, cslot, sslot;
    size_t i, sent = 0U, recvd = 0U;
    int64_t now = 100;
    int guard = 0;

    CHECK(src_buf != NULL && dst_buf != NULL, "alloc 2 MiB buffers");
    for (i = 0U; i < (size_t)TOTAL_BYTES; i++) {
        src_buf[i] = (uint8_t)(((i * 1315423911ULL) >> 13) ^ (i & 0xFFU));
    }

    fsa_host_veth_init(&veth, NULL);
    cli = fsa_host_create(fsa_host_veth_tx_fn_a(), &veth, NULL);
    srv = fsa_host_create(fsa_host_veth_tx_fn_b(), &veth, NULL);
    fsa_host_veth_attach(&veth, cli, srv);
    CHECK(fsa_host_init_if(cli, now, ip_cli, mask, ip_srv, mac_cli, 1500U) == FSA_OK, "init cli");
    CHECK(fsa_host_init_if(srv, now, ip_srv, mask, ip_srv, mac_srv, 1500U) == FSA_OK, "init srv");

    lslot = fsa_host_tcp_open(srv);
    cslot = fsa_host_tcp_open(cli);
    CHECK(fsa_host_tcp_listen(srv, now, lslot, NULL, 7000U) == FSA_OK, "listen");
    CHECK(fsa_host_tcp_connect(cli, now, cslot, ip_cli, 44000U, ip_srv, 7000U, 90000U) == FSA_OK, "connect");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    sslot = fsa_host_tcp_accept(srv, lslot, NULL, 0U);
    CHECK(sslot > 0 && fsa_host_tcp_is_connected(cli, cslot) == 1, "connected");

    while (recvd < (size_t)TOTAL_BYTES && guard < 200000) {
        int n;
        guard++;
        if (sent < (size_t)TOTAL_BYTES) {
            uint32_t rem = (uint32_t)((size_t)TOTAL_BYTES - sent);
            if (rem > 8192U) rem = 8192U;
            n = fsa_host_tcp_write(cli, now, cslot, src_buf + sent, rem);
            if (n > 0) sent += (size_t)n;
        }
        (void)fsa_host_tcp_pump(cli, now, cslot);
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
        n = fsa_host_tcp_recv(srv, now, sslot, dst_buf + recvd, (uint32_t)((size_t)TOTAL_BYTES - recvd), NULL, 0U);
        if (n > 0) recvd += (size_t)n;
        now += 1;
    }

    CHECK(sent == (size_t)TOTAL_BYTES && recvd == (size_t)TOTAL_BYTES, "transferred full 2 MiB");
    CHECK(memcmp(src_buf, dst_buf, TOTAL_BYTES) == 0, "exact 2 MiB byte-for-byte integrity");

    free(src_buf);
    free(dst_buf);
    fsa_host_destroy(cli, now + 10);
    fsa_host_destroy(srv, now + 10);
    return 0;
}

/* 8. DHCPv4 DORA auto-configuration + DNS A resolution + DNS timeout fallback. */
static int test_dhcp_dora_and_dns_resolution(void) {
    static const uint8_t zero_ip[4] = {0, 0, 0, 0};
    static const uint8_t bcast_ip[4] = {255, 255, 255, 255};
    static const uint8_t srv_ip[4] = {10, 0, 7, 1};
    static const uint8_t lease_ip[4] = {10, 0, 7, 42};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t dns_target[4] = {10, 0, 7, 88};
    static const uint8_t mac_cli[6] = {0x02, 0x00, 0x00, 0x07, 0x00, 0x42};
    static const uint8_t mac_srv[6] = {0x02, 0x00, 0x00, 0x07, 0x00, 0x01};
    fsa_host_veth_link_t veth;
    fsa_host_stack_t *cli, *srv;
    int dhcp_srv_slot, dns_srv_slot, dslot, dslot_fail, i;
    fsa_host_udp_dgram_t dg;
    fsa_host_dhcp_info_t lease;
    fsa_host_dns_slot_t dns_res;
    uint8_t reply[320], cfg_ip[4], cfg_mask[4], cfg_gw[4], cfg_dns[4];
    size_t rlen;
    int64_t now = 100;

    fsa_host_veth_init(&veth, NULL);
    cli = fsa_host_create(fsa_host_veth_tx_fn_a(), &veth, NULL);
    srv = fsa_host_create(fsa_host_veth_tx_fn_b(), &veth, NULL);
    fsa_host_veth_attach(&veth, cli, srv);

    CHECK(fsa_host_init_if(cli, now, zero_ip, mask, zero_ip, mac_cli, 1500U) == FSA_OK, "cli unconfigured 0.0.0.0");
    CHECK(fsa_host_init_if(srv, now, srv_ip, mask, srv_ip, mac_srv, 1500U) == FSA_OK, "srv 10.0.7.1");

    dhcp_srv_slot = fsa_host_udp_open(srv);
    dns_srv_slot = fsa_host_udp_open(srv);
    CHECK(fsa_host_udp_bind(srv, now, dhcp_srv_slot, NULL, 67U) == FSA_OK, "bind dhcpd :67");
    CHECK(fsa_host_udp_bind(srv, now, dns_srv_slot, NULL, 53U) == FSA_OK, "bind dnsd :53");

    /* Start DHCPv4 DORA on client -> DISCOVER -> OFFER -> REQUEST -> ACK -> BOUND + cfg.set_ip! */
    CHECK(fsa_host_dhcp_start(cli, now, mac_cli, 0xCAFEBABEU) == FSA_OK, "dhcp_start");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(fsa_host_udp_recv(srv, dhcp_srv_slot, &dg, 0U) >= 244, "dhcpd received DISCOVER");

    rlen = build_dhcp_reply(reply, 2U, 0xCAFEBABEU, lease_ip, srv_ip, mask, srv_ip, srv_ip, mac_cli);
    CHECK(fsa_host_udp_sendto(srv, now, dhcp_srv_slot, srv_ip, bcast_ip, 68U, reply, (uint16_t)rlen) == FSA_OK,
          "dhcpd send OFFER");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(fsa_host_udp_recv(srv, dhcp_srv_slot, &dg, 0U) >= 244, "dhcpd received REQUEST");

    rlen = build_dhcp_reply(reply, 5U, 0xCAFEBABEU, lease_ip, srv_ip, mask, srv_ip, srv_ip, mac_cli);
    CHECK(fsa_host_udp_sendto(srv, now, dhcp_srv_slot, srv_ip, bcast_ip, 68U, reply, (uint16_t)rlen) == FSA_OK,
          "dhcpd send ACK");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);

    CHECK(fsa_host_dhcp_poll(cli, &lease) == 1, "DHCP lease BOUND");
    CHECK(memcmp(lease.ip, lease_ip, 4U) == 0, "DHCP leased IP 10.0.7.42");
    fsa_host_get_if_config(cli, cfg_ip, cfg_mask, cfg_gw, cfg_dns);
    CHECK(memcmp(cfg_ip, lease_ip, 4U) == 0 && memcmp(cfg_gw, srv_ip, 4U) == 0 && memcmp(cfg_dns, srv_ip, 4U) == 0,
          "eth_ipv4_icmp auto-configured via DHCP lease_assigned route");

    /* DNS A resolution using newly leased IP! */
    now += 20;
    dslot = fsa_host_dns_query(cli, now, cfg_ip, cfg_dns, "service.stack.test", 0x4242U);
    CHECK(dslot >= 0, "dns_query started");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(fsa_host_udp_recv(srv, dns_srv_slot, &dg, 0U) >= 20, "dnsd received query");
    rlen = build_dns_a_reply(reply, dg.data, dg.len, dns_target, 300U);
    CHECK(fsa_host_udp_sendto(srv, now, dns_srv_slot, srv_ip, cfg_ip, dg.src_port, reply, (uint16_t)rlen) == FSA_OK,
          "dnsd send A answer");
    (void)fsa_host_veth_step_until_quiescent(&veth, now, 16);
    CHECK(fsa_host_dns_poll(cli, dslot, &dns_res) == 1, "DNS resolved");
    CHECK(memcmp(dns_res.ip, dns_target, 4U) == 0, "DNS resolved IP 10.0.7.88");

    /* DNS retry + timeout fallback when server drops queries. */
    dslot_fail = fsa_host_dns_query(cli, now, cfg_ip, cfg_dns, "missing.stack.test", 0x5151U);
    CHECK(dslot_fail >= 0, "dns timeout query started");
    for (i = 0; i < 5; i++) {
        now += 1100;
        (void)fsa_host_veth_step_until_quiescent(&veth, now, 8);
    }
    CHECK(fsa_host_dns_poll(cli, dslot_fail, &dns_res) == -1, "DNS timed out cleanly to DNS_FAILED");

    fsa_host_destroy(cli, now + 10);
    fsa_host_destroy(srv, now + 10);
    return 0;
}

#if !FSA_HOST_NO_SYS
typedef struct {
    fsa_host_udp_wire_t *wire;
    fsa_host_stack_t *a;
    fsa_host_stack_t *b;
    pthread_mutex_t mu;
    int stop;
} wire_pump_ctx_t;

static void *wire_pump_thread(void *arg) {
    wire_pump_ctx_t *ctx = (wire_pump_ctx_t *)arg;
    for (;;) {
        int stop_now;
        int64_t now;
        int n;
        (void)pthread_mutex_lock(&ctx->mu);
        stop_now = ctx->stop;
        (void)pthread_mutex_unlock(&ctx->mu);
        if (stop_now) break;
        now = fsa_host_monotonic_ms();
        n = fsa_host_udp_wire_pump(ctx->wire, ctx->a, ctx->b, now);
        if (n == 0) {
            struct timespec ts = {0, 1000000L}; /* 1 ms */
            (void)nanosleep(&ts, NULL);
        }
    }
    return NULL;
}

typedef struct {
    fsa_host_stack_t *srv;
    int listen_slot;
    int udp_slot;
    int ok;
} mt_server_ctx_t;

static void *mt_server_thread(void *arg) {
    mt_server_ctx_t *sc = (mt_server_ctx_t *)arg;
    static const uint8_t srv_ip[4] = {10, 0, 9, 1};
    fsa_host_udp_dgram_t dg;
    fsa_host_accept_item_t acc;
    int child, got = 0;
    uint8_t buf[4096];

    if (fsa_host_udp_recv(sc->srv, sc->udp_slot, &dg, 3000U) != 7) return NULL;
    if (fsa_host_udp_sendto(sc->srv, -1, sc->udp_slot, srv_ip, dg.src_ip, dg.src_port,
                            (const uint8_t *)"UDPPONG", 7U) != FSA_OK) return NULL;

    child = fsa_host_tcp_accept(sc->srv, sc->listen_slot, &acc, 3000U);
    if (child < 0) return NULL;
    while (got < 2048) {
        int eof = 0;
        int n = fsa_host_tcp_recv(sc->srv, -1, child, buf + got, (uint32_t)(2048 - got), &eof, 2000U);
        if (n > 0) got += n;
        else if (eof) break;
    }
    if (got != 2048) return NULL;
    if (fsa_host_tcp_write(sc->srv, -1, child, buf, 2048U) != 2048) return NULL;
    (void)fsa_host_tcp_close(sc->srv, -1, child);
    sc->ok = 1;
    return NULL;
}

/* 9. POSIX multi-threaded NO_SYS=0 actor concurrency over real 127.0.0.1 UDP socket wire (TSan clean). */
static int test_posix_multithreaded_actor(void) {
    static const uint8_t ip_cli[4] = {10, 0, 9, 2};
    static const uint8_t ip_srv[4] = {10, 0, 9, 1};
    static const uint8_t mask[4] = {255, 255, 255, 0};
    static const uint8_t mac_cli[6] = {0x02, 0x00, 0x00, 0x09, 0x00, 0x02};
    static const uint8_t mac_srv[6] = {0x02, 0x00, 0x00, 0x09, 0x00, 0x01};
    fsa_host_udp_wire_t wire;
    fsa_host_stack_t *cli, *srv;
    wire_pump_ctx_t wctx;
    mt_server_ctx_t sctx;
    pthread_t pump_tid, srv_tid;
    int u_cli, t_cli, got = 0;
    fsa_host_udp_dgram_t dg;
    uint8_t tx[2048], rx[2048];
    size_t i;

    CHECK(fsa_host_udp_wire_open(&wire, NULL) == 0, "open UDP loopback wire");
    cli = fsa_host_create(fsa_host_udp_wire_tx_a(), &wire, NULL);
    srv = fsa_host_create(fsa_host_udp_wire_tx_b(), &wire, NULL);
    CHECK(cli != NULL && srv != NULL, "create stacks");

    CHECK(fsa_host_init_if(cli, -1, ip_cli, mask, ip_srv, mac_cli, 1500U) == FSA_OK, "init cli");
    CHECK(fsa_host_init_if(srv, -1, ip_srv, mask, ip_srv, mac_srv, 1500U) == FSA_OK, "init srv");

    memset(&sctx, 0, sizeof(sctx));
    sctx.srv = srv;
    sctx.udp_slot = fsa_host_udp_open(srv);
    sctx.listen_slot = fsa_host_tcp_open(srv);
    CHECK(fsa_host_udp_bind(srv, -1, sctx.udp_slot, NULL, 9100U) == FSA_OK, "srv bind udp");
    CHECK(fsa_host_tcp_listen(srv, -1, sctx.listen_slot, NULL, 9200U) == FSA_OK, "srv listen tcp");

    CHECK(fsa_host_start_actor(cli, -1) == 0, "start cli actor");
    CHECK(fsa_host_start_actor(srv, -1) == 0, "start srv actor");

    wctx.wire = &wire;
    wctx.a = cli;
    wctx.b = srv;
    (void)pthread_mutex_init(&wctx.mu, NULL);
    wctx.stop = 0;
    CHECK(pthread_create(&pump_tid, NULL, wire_pump_thread, &wctx) == 0, "spawn wire pump");
    CHECK(pthread_create(&srv_tid, NULL, mt_server_thread, &sctx) == 0, "spawn server app thread");

    u_cli = fsa_host_udp_open(cli);
    CHECK(fsa_host_udp_bind(cli, -1, u_cli, ip_cli, 59100U) == FSA_OK, "cli bind udp");
    CHECK(fsa_host_udp_sendto(cli, -1, u_cli, ip_cli, ip_srv, 9100U, (const uint8_t *)"UDPPING", 7U) == FSA_OK,
          "cli sendto");
    CHECK(fsa_host_udp_recv(cli, u_cli, &dg, 3000U) == 7 && memcmp(dg.data, "UDPPONG", 7U) == 0,
          "cli blocking udp_recv");

    for (i = 0U; i < sizeof(tx); i++) tx[i] = (uint8_t)((i * 41U + 5U) & 0xFFU);
    t_cli = fsa_host_tcp_open(cli);
    CHECK(fsa_host_tcp_connect(cli, -1, t_cli, ip_cli, 59200U, ip_srv, 9200U, 77777U) == FSA_OK, "cli tcp_connect");
    CHECK(fsa_host_tcp_wait_connected(cli, t_cli, 3000U) == 0, "cli blocking wait_connected");
    CHECK(fsa_host_tcp_write(cli, -1, t_cli, tx, sizeof(tx)) == (int)sizeof(tx), "cli tcp_write");
    while (got < (int)sizeof(rx)) {
        int eof = 0;
        int n = fsa_host_tcp_recv(cli, -1, t_cli, rx + got, (uint32_t)((int)sizeof(rx) - got), &eof, 2000U);
        if (n > 0) got += n;
        else if (eof) break;
    }
    CHECK(got == (int)sizeof(tx) && memcmp(tx, rx, sizeof(tx)) == 0, "mt tcp echo exact");
    (void)fsa_host_tcp_close(cli, -1, t_cli);

    (void)pthread_join(srv_tid, NULL);
    (void)pthread_mutex_lock(&wctx.mu);
    wctx.stop = 1;
    (void)pthread_mutex_unlock(&wctx.mu);
    (void)pthread_join(pump_tid, NULL);
    (void)pthread_mutex_destroy(&wctx.mu);
    (void)fsa_host_stop_actor(cli, -1);
    (void)fsa_host_stop_actor(srv, -1);
    CHECK(sctx.ok == 1, "server app thread succeeded");
    CHECK(wire.tx_a_to_b > 0ULL && wire.tx_b_to_a > 0ULL, "real UDP loopback frames exchanged");

    fsa_host_destroy(cli, -1);
    fsa_host_destroy(srv, -1);
    fsa_host_udp_wire_close(&wire);
    return 0;
}
#endif

int main(void) {
    struct {
        const char *name;
        int (*fn)(void);
    } cases[] = {
        {"arch_accounting", test_arch_accounting},
        {"arp_icmp_and_unreach", test_arp_icmp_and_unreach},
        {"ipv4_frag_and_ooo_reassembly", test_ipv4_frag_and_ooo_reassembly},
        {"udp_multi_endpoint", test_udp_multi_endpoint},
        {"tcp_8_concurrent_connections", test_tcp_8_concurrent_connections},
        {"tcp_impairment_chaos_and_persist", test_tcp_impairment_chaos_and_persist},
        {"tcp_multi_mib_bulk_integrity", test_tcp_multi_mib_bulk_integrity},
        {"dhcp_dora_and_dns_resolution", test_dhcp_dora_and_dns_resolution},
#if !FSA_HOST_NO_SYS
        {"posix_multithreaded_actor", test_posix_multithreaded_actor},
#endif
    };
    size_t i;
    for (i = 0U; i < sizeof(cases) / sizeof(cases[0]); i++) {
        int rc = cases[i].fn();
        if (rc != 0) return rc;
        printf("[PASS] %s\n", cases[i].name);
    }
    printf("ALL %zu STACK SUITE TESTS PASSED (NO_SYS=%d)\n",
           sizeof(cases) / sizeof(cases[0]), (int)FSA_HOST_NO_SYS);
    return 0;
}
