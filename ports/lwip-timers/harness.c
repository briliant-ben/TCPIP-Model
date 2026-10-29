/* Public raw API timer event driver; 1ms clock advancement, bounded at12000ms. Local output is exclusively lwIP netif pbufs. */
#define main baseline_handshake_main
#include "../lwip/harness.c"
#undef main
#include <errno.h>
#include <limits.h>

static unsigned acknowledged_bytes, written_bytes, commands, received_bytes, receive_events;
static int app_closed;
static unsigned clock_checks;
static unsigned peer_text_bytes;
static struct { uint32_t time; unsigned len, eof; unsigned char data[16]; } deliveries[64];
static err_t stream_received(void *arg, struct tcp_pcb *pcb, struct pbuf *p, err_t error) {
  unsigned len=p?p->tot_len:0;
  (void)arg;(void)pcb;
  if(error!=ERR_OK||receive_events>=64||len>16||received_bytes+len>16)exit(9);
  deliveries[receive_events].time=clock_ms;deliveries[receive_events].len=len;
  deliveries[receive_events].eof=p?0:1;
  if(p) {
    if(pbuf_copy_partial(p,deliveries[receive_events].data,(u16_t)len,0)!=len)exit(9);
    pbuf_free(p); /* Intentionally no tcp_recved: model bytes remain unread. */
  }
  received_bytes+=len;receive_events++;return ERR_OK;
}
static err_t stream_sent(void *arg, struct tcp_pcb *pcb, u16_t count) {
  (void)arg; (void)pcb; acknowledged_bytes+=count; return ERR_OK;
}
static uint32_t number(const char *s, uint32_t maximum) {
  unsigned long value; char *end; const char *p;
  if(!*s)exit(2);
  for(p=s;*p;p++)if(*p<'0'||*p>'9')exit(2);
  errno=0;value=strtoul(s,&end,10);
  if(errno||*end||value>maximum)exit(2);
  return (uint32_t)value;
}
static int digit(char c) {
  if(c>='0'&&c<='9')return c-'0';
  if(c>='a'&&c<='f')return c-'a'+10;
  if(c>='A'&&c<='F')return c-'A'+10;
  return -1;
}
static void peer_input(struct netif *n, unsigned flags, uint32_t seq,
                       uint32_t canonical_ack, uint32_t window, const char *hex) {
  unsigned char raw[56]={0},pseudo[48]={0};struct pbuf *p;
  size_t length=hex?strlen(hex):0,i,total;
  if(length%2||length>32)exit(2);
  for(i=0;i<length/2;i++) {
    int hi=digit(hex[2*i]),lo=digit(hex[2*i+1]);
    if(hi<0||lo<0)exit(2);raw[40+i]=(unsigned char)((hi<<4)|lo);
  }
  length/=2;if(peer_text_bytes+length>64)exit(2);peer_text_bytes+=(unsigned)length;total=40+length;
  raw[0]=0x45;put16(raw+2,(uint16_t)total);raw[8]=64;raw[9]=6;
  raw[12]=192;raw[14]=2;raw[15]=2;raw[16]=192;raw[18]=2;raw[19]=1;
  put16(raw+20,8080);put16(raw+22,40000);put32(raw+24,seq);
  /* Fixed canonical local ISS=1000 is an input coordinate, not an oracle. */
  put32(raw+28,local_iss+(canonical_ack-1000u));
  raw[32]=0x50;raw[33]=(unsigned char)flags;put16(raw+34,(uint16_t)window);
  memcpy(pseudo,raw+12,8);pseudo[9]=6;put16(pseudo+10,(uint16_t)(20+length));memcpy(pseudo+12,raw+20,20+length);
  put16(raw+36,check(pseudo,32+length));put16(raw+10,check(raw,20));
  frame(raw,total);p=pbuf_alloc(PBUF_RAW,(u16_t)total,PBUF_RAM);
  if(!p||pbuf_take(p,raw,(u16_t)total)!=ERR_OK)exit(3);
  if(n->input(p,n)!=ERR_OK)exit(4);
}
int main(int argc,char **argv) {
  FILE *plan;char line[256],t[7][64];unsigned n;
  struct netif netif;struct tcp_pcb *pcb=NULL;
  ip4_addr_t local,mask,gateway;ip_addr_t peer;
  if(argc!=3)return 2;
  plan=fopen(argv[2],"r");capture=fopen(argv[1],"wb");if(!plan||!capture)return 3;
  le32(0xa1b2c3d4);le16(2);le16(4);le32(0);le32(0);le32(65535);le32(101);
  lwip_init();IP4_ADDR(&local,192,0,2,1);IP4_ADDR(&mask,255,255,255,0);IP4_ADDR(&gateway,0,0,0,0);
  if(!netif_add(&netif,&local,&mask,&gateway,NULL,init_netif,ip_input))return 4;
  netif_set_default(&netif);netif_set_up(&netif);IP_ADDR4(&peer,192,0,2,2);
  while(fgets(line,sizeof(line),plan)) {
    uint32_t time;
    if(!strchr(line,'\n')||++commands>64)return 2;
    n=(unsigned)sscanf(line,"%63s %63s %63s %63s %63s %63s %63s",t[0],t[1],t[2],t[3],t[4],t[5],t[6]);
    if(n<2||n>6)return 2;
    time=number(t[0],12000);if(time<clock_ms)return 2;
    while(clock_ms<time){clock_ms++;sys_check_timeouts();clock_checks++;}
    sys_check_timeouts();clock_checks++;
    if(!strcmp(t[1],"CONNECT")&&n==2) {
      if(pcb||time!=0)return 2;
      pcb=tcp_new();
      if(!pcb||tcp_bind(pcb,NULL,40000)!=ERR_OK||tcp_connect(pcb,&peer,8080,on_connected)!=ERR_OK)return 4;
      tcp_sent(pcb,stream_sent);tcp_recv(pcb,stream_received);
    } else if(!pcb)return 2;
    else if(!strcmp(t[1],"SYNACK")&&n==5) {
      if(commands!=2||time!=10||number(t[2],UINT32_MAX)!=9000||number(t[3],UINT32_MAX)!=1001)return 2;
      peer_input(&netif,18,9000,1001,number(t[4],65535),NULL);
      if(connected_count!=1)return 6;
    } else if(connected_count!=1)return 2;
    else if(!strcmp(t[1],"TICK")&&n==2) {
      /* All callbacks already ran during bounded clock advancement. */
    } else if(!strcmp(t[1],"ACK")&&n==5) {
      peer_input(&netif,16,number(t[2],UINT32_MAX),number(t[3],UINT32_MAX),number(t[4],65535),NULL);
    } else if((!strcmp(t[1],"DATA")||!strcmp(t[1],"FIN"))&&n==6) {
      int fin=!strcmp(t[1],"FIN");const char *hex=!strcmp(t[5],"-")?NULL:t[5];
      if(!fin&&!hex)return 2;
      peer_input(&netif,fin?17:16,number(t[2],UINT32_MAX),number(t[3],UINT32_MAX),number(t[4],65535),hex);
    } else if(!strcmp(t[1],"CLOSE")&&n==2&&!app_closed) {
      if(tcp_close(pcb)!=ERR_OK)return 7;app_closed=1;
    } else if(!strcmp(t[1],"TRANSMIT")&&n==2&&!app_closed) {
      if(tcp_output(pcb)!=ERR_OK)return 7;
    } else if(!strcmp(t[1],"SEND")&&n==3&&!app_closed) {
      size_t length=strlen(t[2]),i;unsigned char data[16];
      if(!length||length%2||length>32||written_bytes+length/2>16)return 2;
      for(i=0;i<length/2;i++) {
        int hi=digit(t[2][2*i]),lo=digit(t[2][2*i+1]);
        if(hi<0||lo<0)return 2;data[i]=(unsigned char)((hi<<4)|lo);
      }
      if(tcp_write(pcb,data,(u16_t)(length/2),TCP_WRITE_FLAG_COPY|TCP_WRITE_FLAG_MORE)!=ERR_OK)return 7;
      written_bytes+=(unsigned)(length/2);
    } else return 2;
  }
  if(ferror(plan)||fclose(plan)||fclose(capture))return 3;
  printf("{\"implementation\":\"lwIP-2.2.1\",\"clock\":\"virtual_ms\",\"connected\":%u,\"acknowledged_bytes\":%u,\"written_bytes\":%u,\"commands\":%u,\"mss\":%u,\"receive_window\":%u,\"received_bytes\":%u,\"receiver_events\":[",connected_count,acknowledged_bytes,written_bytes,commands,(unsigned)TCP_MSS,(unsigned)TCP_WND,received_bytes);
  for(n=0;n<receive_events;n++) {
    unsigned i;if(n)putchar(',');
    printf("{\"time_ms\":%u,\"eof\":%s,\"data\":[",(unsigned)deliveries[n].time,deliveries[n].eof?"true":"false");
    for(i=0;i<deliveries[n].len;i++)printf("%s%u",i?",":"",deliveries[n].data[i]);
    printf("]}");
  }
  printf("],\"end_ms\":%u,\"clock_checks\":%u,\"clock_step_ms\":1}\n",(unsigned)clock_ms,clock_checks);
  return connected_count==1?0:8;
}
