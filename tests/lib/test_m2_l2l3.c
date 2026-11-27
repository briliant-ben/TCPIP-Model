#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "tcpip/etharp.h"
#include "tcpip/icmp.h"
#include "tcpip/inet_chksum.h"
#include "tcpip/ip4.h"
#include "tcpip/memp.h"
#include "tcpip/netif.h"
#include "tcpip/netif_veth.h"
#include "tcpip/pcap.h"
#include "tcpip/sys.h"
#include "tcpip/tcpip.h"

static void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}

static void test_lpm_routing(void) {
    netif_reset_all();
    struct netif n0, n1, n2;
    ip4_addr_t ip0, m0, ip1, m1, ip2, m2, gw, dst;
    IP4_ADDR(&gw, 0, 0, 0, 0);

    IP4_ADDR(&ip0, 10, 0, 0, 1); IP4_ADDR(&m0, 255, 0, 0, 0);
    IP4_ADDR(&ip1, 10, 1, 0, 1); IP4_ADDR(&m1, 255, 255, 0, 0);
    IP4_ADDR(&ip2, 10, 1, 2, 1); IP4_ADDR(&m2, 255, 255, 255, 0);

    assert(netif_add(&n0, &ip0, &m0, &gw, NULL, NULL, NULL) == &n0);
    assert(netif_add(&n1, &ip1, &m1, &gw, NULL, NULL, NULL) == &n1);
    assert(netif_add(&n2, &ip2, &m2, &gw, NULL, NULL, NULL) == &n2);
    netif_set_up(&n0); netif_set_link_up(&n0);
    netif_set_up(&n1); netif_set_link_up(&n1);
    netif_set_up(&n2); netif_set_link_up(&n2);
    netif_set_default(&n0);

    IP4_ADDR(&dst, 10, 1, 2, 99);  assert(netif_route(&dst) == &n2);
    IP4_ADDR(&dst, 10, 1, 9, 9);   assert(netif_route(&dst) == &n1);
    IP4_ADDR(&dst, 10, 99, 0, 5);  assert(netif_route(&dst) == &n0);
    IP4_ADDR(&dst, 8, 8, 8, 8);    assert(netif_route(&dst) == &n0);
    IP4_ADDR(&dst, 10, 1, 0, 1);   assert(netif_route(&dst) == &n1);

    char abuf[24];
    assert(ip4addr_aton("192.168.10.25", &dst) == 1);
    assert(strcmp(ip4addr_ntoa_r(&dst, abuf, sizeof(abuf)), "192.168.10.25") == 0);
    assert(ip4addr_aton("999.1.1.1", &dst) == 0);
    netif_reset_all();
}

typedef struct {
    int count;
    uint16_t last_id;
    uint16_t last_seq;
    uint16_t last_len;
} echo_tracker_t;

static void on_echo_reply(void *ctx, const ip4_addr_t *src, uint16_t id, uint16_t seq, uint16_t pay_len) {
    (void)src;
    echo_tracker_t *t = (echo_tracker_t *)ctx;
    t->count++;
    t->last_id = id;
    t->last_seq = seq;
    t->last_len = pay_len;
}

typedef struct {
    struct netif *outif;
    ip4_addr_t dst;
    uint16_t id;
    uint16_t seq;
    uint16_t pay_len;
} send_echo_arg_t;

static err_t send_echo_on_if(void *varg) {
    send_echo_arg_t *a = (send_echo_arg_t *)varg;
    struct pbuf *p = pbuf_alloc(PBUF_IP, (uint16_t)(8U + a->pay_len), PBUF_POOL);
    if (!p) return ERR_MEM;
    p->payload[0] = ICMP_ECHO;
    p->payload[1] = 0;
    wr16be(p->payload + 2, 0U);
    wr16be(p->payload + 4, a->id);
    wr16be(p->payload + 6, a->seq);
    uint8_t pattern[4096];
    for (uint16_t i = 0; i < a->pay_len; i++) {
        pattern[i] = (uint8_t)((i * 7U + a->seq) & 0xFFU);
    }
    if (a->pay_len > 0) {
        assert(pbuf_take_at(p, pattern, a->pay_len, 8U) == ERR_OK);
    }
    wr16be(p->payload + 2, inet_chksum_pbuf(p));
    err_t err = ip4_output_if(p, &a->outif->ip_addr, &a->dst, 64U, 0U, IP_PROTO_ICMP, a->outif);
    pbuf_free(p);
    return err;
}

typedef struct {
    veth_link_t *a;
    veth_link_t *b;
    struct netif *ifA;
    struct netif *ifB;
} flush_arg_t;

static err_t flush_veth_api(void *varg) {
    flush_arg_t *f = (flush_arg_t *)varg;
    veth_link_flush(f->a, f->ifA);
    veth_link_flush(f->b, f->ifB);
    return ERR_OK;
}

int main(void) {
    test_lpm_routing();

    tcpip_init(NULL, NULL);
    etharp_reset();
    ip4_reass_reset();
    netif_reset_all();
    tcpip_set_rx_handler(ethernet_input);

    tcpip_pcap_t *pcap = NULL;
    assert(tcpip_pcap_open(&pcap, "build/m2_l2l3.pcap") == ERR_OK);

    struct netif ifA, ifB;
    veth_link_t linkA, linkB;
    ip4_addr_t ipA, ipB, mask, gw;
    IP4_ADDR(&ipA, 192, 168, 10, 1);
    IP4_ADDR(&ipB, 192, 168, 10, 2);
    IP4_ADDR(&mask, 255, 255, 255, 0);
    IP4_ADDR(&gw, 0, 0, 0, 0);

    uint8_t use_mbox = TCPIP_NO_SYS ? 0U : 1U;
    veth_link_init(&linkA, &ifB, pcap, use_mbox);
    veth_link_init(&linkB, &ifA, pcap, use_mbox);

    assert(netif_add(&ifA, &ipA, &mask, &gw, &linkA, veth_netif_init, ethernet_input) == &ifA);
    assert(netif_add(&ifB, &ipB, &mask, &gw, &linkB, veth_netif_init, ethernet_input) == &ifB);
    ifA.hwaddr[0] = 0x02; ifA.hwaddr[5] = 0x01;
    ifB.hwaddr[0] = 0x02; ifB.hwaddr[5] = 0x02;
    ifA.output = etharp_output;
    ifB.output = etharp_output;
    netif_set_up(&ifA); netif_set_up(&ifB);
    netif_set_default(&ifA);

    echo_tracker_t tracker;
    memset(&tracker, 0, sizeof(tracker));
    icmp_set_echo_reply_cb(on_echo_reply, &tracker);

    /* 1. Cold ARP resolution + queued pending Echo Requests */
    send_echo_arg_t e1 = { &ifA, ipB, 0x1234U, 1U, 32U };
    send_echo_arg_t e2 = { &ifA, ipB, 0x1234U, 2U, 48U };
    assert(tcpip_api_call(send_echo_on_if, &e1) == ERR_OK);
    assert(tcpip_api_call(send_echo_on_if, &e2) == ERR_OK);

#if !TCPIP_NO_SYS
    for (int i = 0; i < 40 && tracker.count < 2; i++) sys_msleep(5);
#endif
    assert(tracker.count == 2);
    assert(tracker.last_id == 0x1234U && tracker.last_seq == 2U && tracker.last_len == 48U);

    uint8_t mac_b[6];
    assert(etharp_find_addr(&ifA, &ipB, mac_b) >= 0);
    assert(memcmp(mac_b, ifB.hwaddr, 6) == 0);

    /* 2. 4000-byte IPv4 MTU fragmentation + out-of-order RFC 815 reassembly */
    linkA.reorder_every_n = 2;
    linkB.reorder_every_n = 2;
    send_echo_arg_t big = { &ifA, ipB, 0xCAFEU, 42U, 4000U };
    assert(tcpip_api_call(send_echo_on_if, &big) == ERR_OK);

    flush_arg_t fl = { &linkA, &linkB, &ifA, &ifB };
    for (int round = 0; round < 6; round++) {
        tcpip_api_call(flush_veth_api, &fl);
#if !TCPIP_NO_SYS
        sys_msleep(10);
#endif
        if (tracker.count >= 3) break;
    }
    assert(tracker.count == 3);
    assert(tracker.last_id == 0xCAFEU && tracker.last_seq == 42U && tracker.last_len == 4000U);
    assert(linkA.reordered_frames >= 1 && linkB.reordered_frames >= 1);

    uint32_t pkts = tcpip_pcap_packet_count(pcap);
    assert(pkts >= 10);
    tcpip_pcap_close(pcap);
    icmp_set_echo_reply_cb(NULL, NULL);
    netif_reset_all();
    tcpip_shutdown();

    printf("M2 L2/L3 NO_SYS=%d OK (pcap_pkts=%u, reordered=%u+%u)\n",
           TCPIP_NO_SYS, pkts, linkA.reordered_frames, linkB.reordered_frames);
    return 0;
}
