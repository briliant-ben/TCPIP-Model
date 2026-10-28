/* Independent lwIP application stimulus and netif observation, never an IR executor.
 * Reuse the existing raw capture/checksum/netif helpers with a separate build.
 */
#define main baseline_handshake_main
#include "../lwip/harness.c"
#undef main

static unsigned acknowledged_bytes;
static err_t on_sent(void *arg, struct tcp_pcb *pcb, u16_t count) {
  (void)arg; (void)pcb; acknowledged_bytes += count; return ERR_OK;
}
static void inject_peer(struct netif *n, unsigned flags, uint32_t seq, uint32_t ack) {
  unsigned char raw[40] = {0}, pseudo[32] = {0};
  struct pbuf *p;
  raw[0]=0x45; put16(raw+2,40); raw[8]=64; raw[9]=6;
  raw[12]=192; raw[14]=2; raw[15]=2; raw[16]=192; raw[18]=2; raw[19]=1;
  put16(raw+20,8080); put16(raw+22,40000); put32(raw+24,seq); put32(raw+28,ack);
  raw[32]=0x50; raw[33]=(unsigned char)flags; put16(raw+34,8);
  memcpy(pseudo,raw+12,8); pseudo[9]=6; put16(pseudo+10,20); memcpy(pseudo+12,raw+20,20);
  put16(raw+36,check(pseudo,sizeof(pseudo))); put16(raw+10,check(raw,20));
  frame(raw,sizeof(raw)); p=pbuf_alloc(PBUF_RAW,sizeof(raw),PBUF_RAM);
  if (!p || pbuf_take(p,raw,sizeof(raw)) != ERR_OK) exit(3);
  if (n->input(p,n) != ERR_OK) exit(4);
}
static int hex_digit(char c) {
  if(c>='0'&&c<='9')return c-'0';
  if(c>='a'&&c<='f')return c-'a'+10;
  if(c>='A'&&c<='F')return c-'A'+10;
  return -1;
}
int main(int argc,char **argv) {
  struct netif netif; struct tcp_pcb *pcb;
  ip4_addr_t local,mask,gateway; ip_addr_t peer;
  unsigned char data[4]; unsigned i;
  if(argc!=3 || strlen(argv[2])!=8)return 2;
  for(i=0;i<4;i++) {
    int hi=hex_digit(argv[2][2*i]),lo=hex_digit(argv[2][2*i+1]);
    if(hi<0||lo<0)return 2; data[i]=(unsigned char)((hi<<4)|lo);
  }
  capture=fopen(argv[1],"wb");if(!capture)return 3;
  le32(0xa1b2c3d4);le16(2);le16(4);le32(0);le32(0);le32(65535);le32(101);
  lwip_init(); IP4_ADDR(&local,192,0,2,1);IP4_ADDR(&mask,255,255,255,0);IP4_ADDR(&gateway,0,0,0,0);
  if(!netif_add(&netif,&local,&mask,&gateway,NULL,init_netif,ip_input))return 4;
  netif_set_default(&netif);netif_set_up(&netif);IP_ADDR4(&peer,192,0,2,2);
  pcb=tcp_new();
  if(!pcb||tcp_bind(pcb,NULL,40000)!=ERR_OK||tcp_connect(pcb,&peer,8080,on_connected)!=ERR_OK)return 4;
  tcp_sent(pcb,on_sent);
  clock_ms=10;sys_check_timeouts();inject_peer(&netif,18,9000,local_iss+1u);
  if(connected_count!=1)return 6;
  clock_ms=20;sys_check_timeouts();
  /* MORE deliberately excludes PSH from this finite no-PSH IR profile. */
  if(tcp_write(pcb,data,4,TCP_WRITE_FLAG_COPY|TCP_WRITE_FLAG_MORE)!=ERR_OK)return 7;
  clock_ms=21;sys_check_timeouts();if(tcp_output(pcb)!=ERR_OK)return 7;
  clock_ms=30;sys_check_timeouts();inject_peer(&netif,16,9001,local_iss+5u);
  if(fclose(capture))return 3;
  printf("{\"implementation\":\"lwIP-2.2.1\",\"clock\":\"virtual_ms\",\"connected\":%u,\"acknowledged_bytes\":%u,\"mss\":%u,\"receive_window\":%u}\n",connected_count,acknowledged_bytes,(unsigned)TCP_MSS,(unsigned)TCP_WND);
  return connected_count==1&&acknowledged_bytes==4?0:8;
}
