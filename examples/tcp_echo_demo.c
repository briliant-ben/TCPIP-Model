#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include "tcpip/etharp.h"
#include "tcpip/netif.h"
#include "tcpip/netif_veth.h"
#include "tcpip/pcap.h"
#include "tcpip/sockets.h"
#include "tcpip/sys.h"
#include "tcpip/tcp.h"
#include "tcpip/tcpip.h"
#include "tcpip/udp.h"

static struct netif ifA, ifB;
static veth_link_t linkA, linkB;
static ip4_addr_t ipA, ipB, mask, gw;
static tcpip_pcap_t *g_pcap = NULL;

static void on_tcp_tmr(void *ctx, uint32_t now_ms) {
    (void)ctx;
    tcp_tmr(now_ms);
}

static void on_arp_tmr(void *ctx, uint32_t now_ms) {
    (void)ctx;
    etharp_tmr(now_ms);
}

static err_t setup_net(void *arg) {
    (void)arg;
    etharp_reset();
    netif_reset_all();
    udp_init();
    tcp_init();
    tcpip_set_rx_handler(ethernet_input);

    veth_link_init(&linkA, &ifB, g_pcap, 1U);
    veth_link_init(&linkB, &ifA, g_pcap, 1U);

    assert(netif_add(&ifA, &ipA, &mask, &gw, &linkA, veth_netif_init, ethernet_input) == &ifA);
    assert(netif_add(&ifB, &ipB, &mask, &gw, &linkB, veth_netif_init, ethernet_input) == &ifB);
    ifA.hwaddr[0] = 0x02; ifA.hwaddr[5] = 0x11;
    ifB.hwaddr[0] = 0x02; ifB.hwaddr[5] = 0x22;
    ifA.output = etharp_output;
    ifB.output = etharp_output;
    netif_set_up(&ifA); netif_set_up(&ifB);
    netif_set_default(&ifA);
    return ERR_OK;
}

static err_t teardown_net(void *arg) {
    (void)arg;
    tcp_reset();
    udp_reset();
    netif_reset_all();
    return ERR_OK;
}

static void *echo_server_thread(void *arg) {
    int lfd = *(int *)arg;
    tcpip_sockaddr_in_t peer;
    int cfd = tcpip_accept(lfd, &peer);
    assert(cfd >= 0);

    uint8_t buf[512];
    for (;;) {
        int n = tcpip_recv(cfd, buf, sizeof(buf), 0);
        if (n <= 0) break;
        int sent = 0;
        while (sent < n) {
            int w = tcpip_send(cfd, buf + sent, (uint32_t)(n - sent), 0);
            assert(w > 0);
            sent += w;
        }
    }
    tcpip_close(cfd);
    return NULL;
}

int main(void) {
    IP4_ADDR(&ipA, 10, 42, 0, 1);
    IP4_ADDR(&ipB, 10, 42, 0, 2);
    IP4_ADDR(&mask, 255, 255, 255, 0);
    IP4_ADDR(&gw, 0, 0, 0, 0);

    tcpip_init(NULL, NULL);
    assert(tcpip_pcap_open(&g_pcap, "build/tcp_echo_demo.pcap") == ERR_OK);
    assert(tcpip_api_call(setup_net, NULL) == ERR_OK);
    tcpip_timer_add(25U, on_arp_tmr, NULL);
    tcpip_timer_add(25U, on_tcp_tmr, NULL);

    int lfd = tcpip_socket(TCPIP_AF_INET, TCPIP_SOCK_STREAM, 0);
    assert(lfd >= 0);
    tcpip_sockaddr_in_t srv_addr = { TCPIP_AF_INET, tcpip_htons(9090U), ipB };
    assert(tcpip_bind(lfd, &srv_addr) == 0);
    assert(tcpip_listen(lfd, 4) == 0);

    pthread_t srv_thr;
    assert(pthread_create(&srv_thr, NULL, echo_server_thread, &lfd) == 0);

    int cfd = tcpip_socket(TCPIP_AF_INET, TCPIP_SOCK_STREAM, 0);
    assert(cfd >= 0);
    assert(tcpip_connect(cfd, &srv_addr) == 0);

    const char *msg = "Hello from Formal-Spec-Agent verified lwIP-class TCP/IP stack!";
    uint32_t mlen = (uint32_t)strlen(msg);
    assert(tcpip_send(cfd, msg, mlen, 0) == (int)mlen);

    char rx[128];
    uint32_t got = 0U;
    while (got < mlen) {
        int r = tcpip_recv(cfd, rx + got, sizeof(rx) - 1U - got, 0);
        assert(r > 0);
        got += (uint32_t)r;
    }
    rx[got] = '\0';
    assert(strcmp(rx, msg) == 0);

    tcpip_close(cfd);
    pthread_join(srv_thr, NULL);
    tcpip_close(lfd);

    uint32_t pkts = tcpip_pcap_packet_count(g_pcap);
    assert(pkts >= 6U);
    assert(tcpip_api_call(teardown_net, NULL) == ERR_OK);
    tcpip_pcap_close(g_pcap);
    tcpip_shutdown();

    printf("tcp_echo_demo OK: echoed %u bytes via BSD sockets (pcap_pkts=%u -> build/tcp_echo_demo.pcap)\n",
           got, pkts);
    return 0;
}
