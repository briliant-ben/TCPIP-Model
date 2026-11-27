#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include "tcpip/dhcp.h"
#include "tcpip/dns.h"
#include "tcpip/etharp.h"
#include "tcpip/netconn.h"
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

static void on_tmr(void *ctx, uint32_t now_ms) {
    (void)ctx;
    etharp_tmr(now_ms);
    tcp_tmr(now_ms);
    dhcp_tmr(now_ms);
    dns_tmr(now_ms);
}

static err_t api_init_stack(void *v) {
    (void)v;
    etharp_reset();
    netif_reset_all();
    udp_init();
    tcp_init();
    dhcp_reset_all();
    dns_init();
    tcpip_set_rx_handler(ethernet_input);

    veth_link_init(&linkA, &ifB, NULL, 1U);
    veth_link_init(&linkB, &ifA, NULL, 1U);
    assert(netif_add(&ifA, &ipA, &mask, &gw, &linkA, veth_netif_init, ethernet_input) == &ifA);
    assert(netif_add(&ifB, &ipB, &mask, &gw, &linkB, veth_netif_init, ethernet_input) == &ifB);
    ifA.hwaddr[0] = 0x02; ifA.hwaddr[5] = 0x31;
    ifB.hwaddr[0] = 0x02; ifB.hwaddr[5] = 0x32;
    ifA.output = etharp_output;
    ifB.output = etharp_output;
    netif_set_up(&ifA); netif_set_up(&ifB);
    netif_set_default(&ifA);
    return ERR_OK;
}

static err_t api_fini_stack(void *v) {
    (void)v;
    dns_reset();
    tcp_reset();
    udp_reset();
    netif_reset_all();
    return ERR_OK;
}

/* Multi-threaded Netconn TCP bulk test */
static void *netconn_srv_thread(void *arg) {
    struct netconn *l = (struct netconn *)arg;
    struct netconn *c = NULL;
    assert(netconn_accept(l, &c) == ERR_OK);
    uint8_t buf[1024];
    uint32_t total = 0U;
    for (;;) {
        uint32_t r = 0U;
        err_t err = netconn_recv_data(c, buf, sizeof(buf), &r);
        if (err != ERR_OK || r == 0U) break;
        total += r;
        uint32_t wr = 0U;
        assert(netconn_write(c, buf, r, 0U, &wr) == ERR_OK);
        if (total >= 32768U) break;
    }
    netconn_close(c);
    netconn_delete(c);
    return NULL;
}

/* BSD Socket server thread (UDP + TCP + poll) */
static void *sock_srv_thread(void *arg) {
    int lfd = *(int *)arg;
    int cfd = tcpip_accept(lfd, NULL);
    assert(cfd >= 0);
    tcpip_pollfd_t pfd = { cfd, TCPIP_POLLIN, 0 };
    (void)tcpip_poll_fds(&pfd, 1U, 200);
    char msg[64];
    int r = tcpip_recv(cfd, msg, sizeof(msg) - 1U, 0);
    assert(r > 0);
    assert(tcpip_send(cfd, msg, (uint32_t)r, 0) == r);
    tcpip_close(cfd);
    return NULL;
}

int main(void) {
    IP4_ADDR(&ipA, 10, 60, 0, 1);
    IP4_ADDR(&ipB, 10, 60, 0, 2);
    IP4_ADDR(&mask, 255, 255, 255, 0);
    IP4_ADDR(&gw, 0, 0, 0, 0);

    tcpip_init(NULL, NULL);
    assert(tcpip_api_call(api_init_stack, NULL) == ERR_OK);
    tcpip_timer_add(25U, on_tmr, NULL);

    /* 1. Netconn TCP 32 KiB concurrent echo */
    struct netconn *nc_listen = netconn_new(NETCONN_TCP);
    assert(nc_listen != NULL);
    assert(netconn_bind(nc_listen, &ipB, 7700U) == ERR_OK);
    assert(netconn_listen(nc_listen) == ERR_OK);

    pthread_t th_nc;
    assert(pthread_create(&th_nc, NULL, netconn_srv_thread, nc_listen) == 0);

    struct netconn *nc_cli = netconn_new(NETCONN_TCP);
    assert(nc_cli != NULL);
    assert(netconn_connect(nc_cli, &ipB, 7700U) == ERR_OK);

    uint8_t tx[32768], rx[32768];
    for (uint32_t i = 0; i < sizeof(tx); i++) tx[i] = (uint8_t)((i * 29U) & 0xFFU);
    uint32_t wr = 0U;
    assert(netconn_write(nc_cli, tx, sizeof(tx), 0U, &wr) == ERR_OK && wr == sizeof(tx));
    uint32_t got = 0U;
    while (got < sizeof(rx)) {
        uint32_t r = 0U;
        assert(netconn_recv_data(nc_cli, rx + got, sizeof(rx) - got, &r) == ERR_OK);
        got += r;
    }
    assert(memcmp(tx, rx, sizeof(tx)) == 0);
    netconn_close(nc_cli);
    netconn_delete(nc_cli);
    pthread_join(th_nc, NULL);
    netconn_delete(nc_listen);

    /* 2. BSD Socket TCP + UDP datagram + setsockopt timeout */
    int lfd = tcpip_socket(TCPIP_AF_INET, TCPIP_SOCK_STREAM, 0);
    assert(lfd >= 0);
    tcpip_sockaddr_in_t sa = { TCPIP_AF_INET, tcpip_htons(7701U), ipB };
    assert(tcpip_bind(lfd, &sa) == 0);
    assert(tcpip_listen(lfd, 4) == 0);
    pthread_t th_sk;
    assert(pthread_create(&th_sk, NULL, sock_srv_thread, &lfd) == 0);

    int cfd = tcpip_socket(TCPIP_AF_INET, TCPIP_SOCK_STREAM, 0);
    assert(cfd >= 0);
    uint32_t tmo = 2000U;
    assert(tcpip_setsockopt(cfd, TCPIP_SOL_SOCKET, TCPIP_SO_RCVTIMEO, &tmo, sizeof(tmo)) == 0);
    assert(tcpip_connect(cfd, &sa) == 0);
    assert(tcpip_send(cfd, "socket-ping", 11U, 0) == 11);
    char sbuf[32] = {0};
    assert(tcpip_recv(cfd, sbuf, sizeof(sbuf), 0) == 11);
    assert(strcmp(sbuf, "socket-ping") == 0);
    tcpip_close(cfd);
    pthread_join(th_sk, NULL);
    tcpip_close(lfd);

    int usrv = tcpip_socket(TCPIP_AF_INET, TCPIP_SOCK_DGRAM, 0);
    int ucli = tcpip_socket(TCPIP_AF_INET, TCPIP_SOCK_DGRAM, 0);
    tcpip_sockaddr_in_t usa = { TCPIP_AF_INET, tcpip_htons(7702U), ipB };
    assert(tcpip_bind(usrv, &usa) == 0);
    assert(tcpip_sendto(ucli, "dgram-ok", 8U, 0, &usa) == 8);
    char ubuf[32] = {0};
    tcpip_sockaddr_in_t from = {0};
    assert(tcpip_recvfrom(usrv, ubuf, sizeof(ubuf), 0, &from) == 8);
    assert(strcmp(ubuf, "dgram-ok") == 0);
    tcpip_close(ucli);
    tcpip_close(usrv);

    assert(tcpip_api_call(api_fini_stack, NULL) == ERR_OK);
    tcpip_shutdown();
    printf("M4 Netconn/Socket/DHCP/DNS test OK\n");
    return 0;
}
