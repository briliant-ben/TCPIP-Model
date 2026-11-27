#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "tcpip/dhcp.h"
#include "tcpip/dns.h"
#include "tcpip/etharp.h"
#include "tcpip/netif.h"
#include "tcpip/netif_veth.h"
#include "tcpip/pcap.h"
#include "tcpip/sys.h"
#include "tcpip/tcpip.h"
#include "tcpip/udp.h"

static struct netif ifA, ifB;
static veth_link_t linkA, linkB;
static ip4_addr_t ipA_zero, ipB_srv, mask, gw, dns_ip, leased_ip;
static tcpip_pcap_t *g_pcap = NULL;
static struct udp_pcb *mock_dhcp_srv = NULL;
static struct udp_pcb *mock_dns_srv = NULL;

static void wr16be(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v >> 8);
    p[1] = (uint8_t)(v & 0xFFU);
}
static void wr32be(uint8_t *p, uint32_t v) {
    p[0] = (uint8_t)(v >> 24);
    p[1] = (uint8_t)((v >> 16) & 0xFFU);
    p[2] = (uint8_t)((v >> 8) & 0xFFU);
    p[3] = (uint8_t)(v & 0xFFU);
}
static uint16_t rd16be(const uint8_t *p) {
    return (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
}

static void on_mock_dhcp_rx(void *arg, struct udp_pcb *pcb, struct pbuf *p,
                            const ip4_addr_t *addr, uint16_t port) {
    (void)arg; (void)addr; (void)port;
    if (!p || p->tot_len < 244U) { if (p) pbuf_free(p); return; }
    uint8_t req[512];
    uint16_t n = p->tot_len < sizeof(req) ? p->tot_len : (uint16_t)sizeof(req);
    pbuf_copy_partial(p, req, n, 0U);
    pbuf_free(p);

    uint8_t msg_type = 0U;
    for (uint16_t pos = 240U; pos < n;) {
        uint8_t opt = req[pos++];
        if (opt == 0U) continue;
        if (opt == 255U || pos >= n) break;
        uint8_t olen = req[pos++];
        if (pos + olen > n) break;
        if (opt == 53U && olen >= 1U) msg_type = req[pos];
        pos = (uint16_t)(pos + olen);
    }
    if (msg_type != 1U && msg_type != 3U) return;

    uint8_t resp[300];
    memset(resp, 0, sizeof(resp));
    resp[0] = 2U; /* BOOTREPLY */
    resp[1] = 1U; resp[2] = 6U;
    memcpy(resp + 4, req + 4, 4);   /* XID */
    memcpy(resp + 10, req + 10, 2); /* flags */
    memcpy(resp + 16, &leased_ip.addr, 4); /* yiaddr */
    memcpy(resp + 20, &ipB_srv.addr, 4);   /* siaddr */
    memcpy(resp + 28, req + 28, 6);        /* chaddr */
    wr32be(resp + 236, 0x63825363UL);

    uint16_t i = 240U;
    resp[i++] = 53U; resp[i++] = 1U; resp[i++] = (msg_type == 1U) ? 2U : 5U; /* OFFER / ACK */
    resp[i++] = 54U; resp[i++] = 4U; memcpy(resp + i, &ipB_srv.addr, 4); i += 4U;
    resp[i++] = 1U;  resp[i++] = 4U; memcpy(resp + i, &mask.addr, 4); i += 4U;
    resp[i++] = 3U;  resp[i++] = 4U; memcpy(resp + i, &ipB_srv.addr, 4); i += 4U;
    resp[i++] = 6U;  resp[i++] = 4U; memcpy(resp + i, &dns_ip.addr, 4); i += 4U;
    resp[i++] = 51U; resp[i++] = 4U; wr32be(resp + i, 3600U); i += 4U;
    resp[i++] = 255U;

    struct pbuf *rp = pbuf_alloc(PBUF_TRANSPORT, i, PBUF_POOL);
    if (!rp) return;
    pbuf_take(rp, resp, i);
    ip4_addr_t bcast = { 0xFFFFFFFFUL };
    udp_sendto_if(pcb, rp, &bcast, 68U, &ifB);
    pbuf_free(rp);
}

static void on_mock_dns_rx(void *arg, struct udp_pcb *pcb, struct pbuf *p,
                           const ip4_addr_t *addr, uint16_t port) {
    (void)arg;
    if (!p || p->tot_len < 16U) { if (p) pbuf_free(p); return; }
    uint8_t req[256];
    uint16_t n = p->tot_len < sizeof(req) ? p->tot_len : (uint16_t)sizeof(req);
    pbuf_copy_partial(p, req, n, 0U);
    pbuf_free(p);

    uint16_t txid = rd16be(req + 0);
    uint16_t qend = 12U;
    while (qend < n && req[qend] != 0U) qend = (uint16_t)(qend + 1U + req[qend]);
    if (qend + 5U > n) return;
    qend = (uint16_t)(qend + 5U);

    uint8_t resp[256];
    memset(resp, 0, sizeof(resp));
    memcpy(resp, req, qend);
    wr16be(resp + 0, txid);
    wr16be(resp + 2, 0x8180U); /* standard query response, noerror */
    wr16be(resp + 4, 1U);      /* QDCOUNT */
    wr16be(resp + 6, 1U);      /* ANCOUNT */

    uint16_t off = qend;
    resp[off++] = 0xC0U; resp[off++] = 0x0CU; /* compressed pointer to qname at offset 12 */
    wr16be(resp + off, 1U); off += 2U;        /* TYPE A */
    wr16be(resp + off, 1U); off += 2U;        /* CLASS IN */
    wr32be(resp + off, 120U); off += 4U;      /* TTL 120s */
    wr16be(resp + off, 4U); off += 2U;        /* RDLENGTH */
    ip4_addr_t ans;
    IP4_ADDR(&ans, 93, 184, 216, 34);
    memcpy(resp + off, &ans.addr, 4); off += 4U;

    struct pbuf *rp = pbuf_alloc(PBUF_TRANSPORT, off, PBUF_POOL);
    if (!rp) return;
    pbuf_take(rp, resp, off);
    udp_sendto_if(pcb, rp, addr, port, &ifB);
    pbuf_free(rp);
}

static int dns_done = 0;
static ip4_addr_t dns_result = {0};

static void on_dns_found(const char *name, const ip4_addr_t *ipaddr, void *arg) {
    (void)name; (void)arg;
    if (ipaddr) {
        dns_result = *ipaddr;
        dns_done = 1;
    }
}

static void on_dhcp_tmr(void *ctx, uint32_t now_ms) {
    (void)ctx;
    dhcp_tmr(now_ms);
    dns_tmr(now_ms);
}

static err_t api_setup(void *v) {
    (void)v;
    etharp_reset();
    netif_reset_all();
    udp_init();
    dhcp_reset_all();
    dns_init();
    tcpip_set_rx_handler(ethernet_input);

    veth_link_init(&linkA, &ifB, g_pcap, 1U);
    veth_link_init(&linkB, &ifA, g_pcap, 1U);

    assert(netif_add(&ifA, &ipA_zero, &mask, &gw, &linkA, veth_netif_init, ethernet_input) == &ifA);
    assert(netif_add(&ifB, &ipB_srv, &mask, &gw, &linkB, veth_netif_init, ethernet_input) == &ifB);
    ifA.hwaddr[0] = 0x02; ifA.hwaddr[5] = 0xA1;
    ifB.hwaddr[0] = 0x02; ifB.hwaddr[5] = 0xB2;
    ifA.output = etharp_output;
    ifB.output = etharp_output;
    netif_set_up(&ifA); netif_set_up(&ifB);
    netif_set_default(&ifA);

    mock_dhcp_srv = udp_new();
    assert(udp_bind(mock_dhcp_srv, &ipA_zero, 67U) == ERR_OK);
    udp_recv(mock_dhcp_srv, on_mock_dhcp_rx, NULL);

    mock_dns_srv = udp_new();
    assert(udp_bind(mock_dns_srv, &ipB_srv, 53U) == ERR_OK);
    udp_recv(mock_dns_srv, on_mock_dns_rx, NULL);

    assert(dhcp_start(&ifA) == ERR_OK);
    return ERR_OK;
}

static err_t api_start_dns(void *v) {
    (void)v;
    ip4_addr_t tmp = {0};
    return dns_gethostbyname("example.org", &tmp, on_dns_found, NULL);
}

static err_t api_teardown(void *v) {
    (void)v;
    dhcp_stop(&ifA);
    dns_reset();
    if (mock_dhcp_srv) { udp_remove(mock_dhcp_srv); mock_dhcp_srv = NULL; }
    if (mock_dns_srv)  { udp_remove(mock_dns_srv);  mock_dns_srv = NULL; }
    udp_reset();
    netif_reset_all();
    return ERR_OK;
}

int main(void) {
    IP4_ADDR(&ipA_zero, 0, 0, 0, 0);
    IP4_ADDR(&ipB_srv, 10, 50, 0, 2);
    IP4_ADDR(&leased_ip, 10, 50, 0, 100);
    IP4_ADDR(&dns_ip, 10, 50, 0, 2);
    IP4_ADDR(&mask, 255, 255, 255, 0);
    IP4_ADDR(&gw, 0, 0, 0, 0);

    tcpip_init(NULL, NULL);
    assert(tcpip_pcap_open(&g_pcap, "build/dhcp_dns_demo.pcap") == ERR_OK);
    assert(tcpip_api_call(api_setup, NULL) == ERR_OK);
    tcpip_timer_add(50U, on_dhcp_tmr, NULL);

    for (int i = 0; i < 100 && !dhcp_supplied_address(&ifA); i++) {
        sys_msleep(10U);
    }
    assert(dhcp_supplied_address(&ifA) == 1U);
    assert(ip4_addr_cmp(&ifA.ip_addr, &leased_ip));

    assert(tcpip_api_call(api_start_dns, NULL) == ERR_INPROGRESS);
    for (int i = 0; i < 100 && !dns_done; i++) {
        sys_msleep(10U);
    }
    assert(dns_done == 1);
    ip4_addr_t exp_ip;
    IP4_ADDR(&exp_ip, 93, 184, 216, 34);
    assert(ip4_addr_cmp(&dns_result, &exp_ip));

    /* Verify cached hit is immediate ERR_OK */
    ip4_addr_t cached = {0};
    assert(dns_gethostbyname("example.org", &cached, NULL, NULL) == ERR_OK);
    assert(ip4_addr_cmp(&cached, &exp_ip));

    uint32_t pkts = tcpip_pcap_packet_count(g_pcap);
    assert(pkts >= 6U);
    assert(tcpip_api_call(api_teardown, NULL) == ERR_OK);
    tcpip_pcap_close(g_pcap);
    tcpip_shutdown();

    char ipbuf[24], dnsbuf[24];
    printf("dhcp_dns_demo OK: leased=%s dns(example.org)=%s (pcap_pkts=%u -> build/dhcp_dns_demo.pcap)\n",
           ip4addr_ntoa_r(&ifA.ip_addr, ipbuf, sizeof(ipbuf)),
           ip4addr_ntoa_r(&dns_result, dnsbuf, sizeof(dnsbuf)),
           pkts);
    return 0;
}
