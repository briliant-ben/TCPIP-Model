/* Real lwIP 2.2.1 execution over an in-memory IPv4 netif.
 * The peer is a scripted responder; lwIP decides local state, timers and output.
 * Captured packets are implementation observations, never model encoder output.
 */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lwip/init.h"
#include "lwip/netif.h"
#include "lwip/ip.h"
#include "lwip/ip4.h"
#include "lwip/tcp.h"
#include "lwip/timeouts.h"

static u32_t clock_ms;
static FILE *capture;
static unsigned syn_count;
static unsigned connected_count;
static uint32_t local_iss;
static uint32_t retransmit_ms;

u32_t sys_now(void) { return clock_ms; }

static void le16(uint16_t n) {
  unsigned char b[2] = {(unsigned char)n, (unsigned char)(n >> 8)};
  if (fwrite(b, 1, 2, capture) != 2) exit(3);
}
static void le32(uint32_t n) {
  unsigned char b[4] = {(unsigned char)n, (unsigned char)(n >> 8),
                       (unsigned char)(n >> 16), (unsigned char)(n >> 24)};
  if (fwrite(b, 1, 4, capture) != 4) exit(3);
}
static void frame(const unsigned char *bytes, size_t n) {
  le32(clock_ms / 1000); le32((clock_ms % 1000) * 1000);
  le32((uint32_t)n); le32((uint32_t)n);
  if (fwrite(bytes, 1, n, capture) != n) exit(3);
}
static uint32_t be32(const unsigned char *b) {
  return ((uint32_t)b[0] << 24) | ((uint32_t)b[1] << 16) |
         ((uint32_t)b[2] << 8) | b[3];
}
static void put16(unsigned char *b, uint16_t n) { b[0] = (unsigned char)(n >> 8); b[1] = (unsigned char)n; }
static void put32(unsigned char *b, uint32_t n) {
  b[0] = (unsigned char)(n >> 24); b[1] = (unsigned char)(n >> 16);
  b[2] = (unsigned char)(n >> 8); b[3] = (unsigned char)n;
}
static uint16_t check(const unsigned char *b, size_t n) {
  uint32_t sum = 0;
  while (n > 1) { sum += ((uint32_t)b[0] << 8) | b[1]; b += 2; n -= 2; }
  if (n) sum += (uint32_t)b[0] << 8;
  while (sum >> 16) sum = (sum & 65535) + (sum >> 16);
  return (uint16_t)~sum;
}

static err_t output(struct netif *n, struct pbuf *p, const ip4_addr_t *destination) {
  unsigned char *bytes = malloc(p->tot_len);
  size_t h;
  (void)n; (void)destination;
  if (!bytes || pbuf_copy_partial(p, bytes, p->tot_len, 0) != p->tot_len) exit(3);
  frame(bytes, p->tot_len);
  h = (bytes[0] & 15) * 4;
  if (p->tot_len >= h + 20 && bytes[9] == 6 && bytes[h + 13] == 2) {
    syn_count++;
    if (syn_count == 1) local_iss = be32(bytes + h + 4);
    if (syn_count == 2) retransmit_ms = clock_ms;
  }
  free(bytes);
  return ERR_OK; /* The environment silently withholds the first SYN response in loss mode. */
}
static err_t init_netif(struct netif *n) {
  n->name[0] = 'm'; n->name[1] = 'e'; n->mtu = 1500;
  n->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_LINK_UP;
  n->output = output;
  return ERR_OK;
}
static err_t on_connected(void *arg, struct tcp_pcb *pcb, err_t error) {
  (void)arg; (void)pcb;
  if (error == ERR_OK) connected_count++;
  return ERR_OK;
}
static void inject_synack(struct netif *n) {
  unsigned char raw[40] = {0}, pseudo[32] = {0};
  struct pbuf *p;
  raw[0] = 0x45; put16(raw + 2, 40); raw[8] = 64; raw[9] = 6;
  raw[12] = 192; raw[14] = 2; raw[15] = 2;
  raw[16] = 192; raw[18] = 2; raw[19] = 1;
  put16(raw + 20, 8080); put16(raw + 22, 40000);
  put32(raw + 24, 9000); put32(raw + 28, local_iss + 1u);
  raw[32] = 0x50; raw[33] = 18; put16(raw + 34, 65535);
  memcpy(pseudo, raw + 12, 8); pseudo[9] = 6; put16(pseudo + 10, 20);
  memcpy(pseudo + 12, raw + 20, 20);
  put16(raw + 36, check(pseudo, sizeof(pseudo)));
  put16(raw + 10, check(raw, 20));
  frame(raw, sizeof(raw));
  p = pbuf_alloc(PBUF_RAW, sizeof(raw), PBUF_RAM);
  if (!p || pbuf_take(p, raw, sizeof(raw)) != ERR_OK) exit(3);
  if (n->input(p, n) != ERR_OK) exit(4);
}

int main(int argc, char **argv) {
  struct netif netif;
  struct tcp_pcb *pcb;
  ip4_addr_t local, mask, gateway;
  ip_addr_t peer;
  int loss;
  if (argc != 3 || (strcmp(argv[1], "handshake") && strcmp(argv[1], "syn-loss"))) return 2;
  loss = !strcmp(argv[1], "syn-loss");
  capture = fopen(argv[2], "wb");
  if (!capture) return 3;
  le32(0xa1b2c3d4); le16(2); le16(4); le32(0); le32(0); le32(65535); le32(101);
  lwip_init();
  IP4_ADDR(&local,192,0,2,1); IP4_ADDR(&mask,255,255,255,0); IP4_ADDR(&gateway,0,0,0,0);
  if (!netif_add(&netif,&local,&mask,&gateway,NULL,init_netif,ip_input)) return 4;
  netif_set_default(&netif); netif_set_up(&netif);
  IP_ADDR4(&peer,192,0,2,2);
  pcb = tcp_new();
  if (!pcb || tcp_bind(pcb,NULL,40000) != ERR_OK || tcp_connect(pcb,&peer,8080,on_connected) != ERR_OK) return 4;
  if (syn_count != 1) return 5;
  if (loss) {
    for (clock_ms = 10; clock_ms <= 10000 && syn_count < 2; clock_ms += 10) sys_check_timeouts();
    if (syn_count < 2) return 5;
    /* Loop increment already advances ten milliseconds after the observed retransmission. */
  } else { clock_ms = 10; sys_check_timeouts(); }
  inject_synack(&netif);
  if (fclose(capture)) return 3;
  printf("{\"implementation\":\"lwIP-2.2.1\",\"clock\":\"virtual_ms\",\"mode\":\"%s\",\"connected\":%u,\"syn_count\":%u,\"first_retransmit_ms\":%u}\n",
         argv[1],connected_count,syn_count,retransmit_ms);
  return connected_count == 1 ? 0 : 6;
}
