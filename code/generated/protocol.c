#define STRING_COUNT 47
/* Native support primitives. Protocol guards/actions are generated C below. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>
#include <limits.h>
#include <string.h>
#include <stdarg.h>
#include <errno.h>
#define LOG_CAP 131072
#define FIELD_CAP 64
#define SEQ_MOD INT64_C(4294967296)
typedef struct { char data[LOG_CAP]; size_t size; } Buffer;
const char *failure = NULL;
void text(Buffer *b, const char *s) {
    size_t n=strlen(s);
    if(n>=LOG_CAP-b->size) { failure="output_capacity"; return; }
    memcpy(b->data+b->size,s,n+1); b->size+=n;
}
void number(Buffer *b,int64_t n) { char s[32]; snprintf(s,sizeof(s),"%" PRId64,n); text(b,s); }
int64_t add(int64_t a,int64_t b) {
    if((b>0 && a>INT64_MAX-b)||(b<0 && a<INT64_MIN-b)) {failure="integer_overflow";return 0;}
    return a+b;
}
int64_t sub(int64_t a,int64_t b) {
    if((b>0 && a<INT64_MIN+b)||(b<0 && a>INT64_MAX+b)) {failure="integer_overflow";return 0;}
    return a-b;
}
int64_t mul(int64_t a,int64_t b) {
    if(a==0||b==0)return 0;
    if((a==-1&&b==INT64_MIN)||(b==-1&&a==INT64_MIN)) {failure="integer_overflow";return 0;}
    if((a>0 && b>0 && a>INT64_MAX/b)||(a>0 && b<0 && b<INT64_MIN/a)||
       (a<0 && b>0 && a<INT64_MIN/b)||(a<0 && b<0 && a<INT64_MAX/b)) {
        failure="integer_overflow";return 0;
    }
    return a*b;
}
int64_t seqadd(int64_t a,int64_t b) {
    int64_t n=(a+b%SEQ_MOD)%SEQ_MOD; return n<0?n+SEQ_MOD:n;
}
int64_t distance(int64_t a,int64_t b) { return (b-a+SEQ_MOD)%SEQ_MOD; }
int64_t minimum(int64_t a,int64_t b) { return a<b?a:b; }
int valid(int64_t n,int kind) {
    return kind==0 || (kind==1 && (n==0||n==1)) || (kind==2 && n>=0 && n<SEQ_MOD) || (kind==4 && n>=0 && n<STRING_COUNT);
}

void json_string(Buffer *out,const char *s) {
    const unsigned char *p=(const unsigned char *)s;char escaped[8];
    text(out,"\"");
    for(;*p;p++) {
        if(*p=='"'||*p=='\\'){escaped[0]='\\';escaped[1]=(char)*p;escaped[2]=0;text(out,escaped);}
        else if(*p<32){snprintf(escaped,sizeof(escaped),"\\u%04x",*p);text(out,escaped);}
        else {escaped[0]=(char)*p;escaped[1]=0;text(out,escaped);}
    }
    text(out,"\"");
}
/* Bytes are value types. Capacity is an explicit execution domain, never silent
   truncation. IR slice arguments are OFFSET and COUNT, clamped independently. */
#define BYTE_CAP 4096
#define INPUT_CAP (2*BYTE_CAP*FIELD_CAP+4096)
typedef struct { size_t len; unsigned char data[BYTE_CAP]; } Bytes;
Bytes byte_literal(const unsigned char *p,size_t n) {
    Bytes out={0};
    if(n>BYTE_CAP){failure="byte_capacity";return out;}
    out.len=n;if(n)memcpy(out.data,p,n);return out;
}
Bytes byte_concat(Bytes a,Bytes b) {
    Bytes out={0};
    if(a.len>BYTE_CAP||b.len>BYTE_CAP||b.len>BYTE_CAP-a.len){failure="byte_capacity";return out;}
    out.len=a.len+b.len;memcpy(out.data,a.data,a.len);memcpy(out.data+a.len,b.data,b.len);return out;
}
Bytes byte_slice(Bytes a,int64_t offset,int64_t count) {
    Bytes out={0};size_t start,n;
    if(a.len>BYTE_CAP){failure="byte_capacity";return out;}
    start=offset<0?0:(uint64_t)offset>a.len?a.len:(size_t)offset;
    n=count<0?0:(uint64_t)count>a.len-start?a.len-start:(size_t)count;
    out.len=n;if(n)memcpy(out.data,a.data+start,n);return out;
}
int byte_equal(Bytes a,Bytes b) {return a.len==b.len&&memcmp(a.data,b.data,a.len)==0;}
int64_t byte_at_or_zero(Bytes a,int64_t offset) {
    if(a.len>BYTE_CAP){failure="byte_capacity";return 0;}
    if(offset<0||(uint64_t)offset>=a.len)return 0;
    return a.data[(size_t)offset];
}
Bytes byte_pack8(int64_t n) {
    unsigned char b[1]={(uint8_t)n};return byte_literal(b,1);
}
Bytes byte_pack16be(int64_t n) {
    uint16_t v=(uint16_t)n;unsigned char b[2]={(unsigned char)(v>>8),(unsigned char)(v&255)};
    return byte_literal(b,2);
}
Bytes byte_pack32be(int64_t n) {
    uint32_t v=(uint32_t)n;unsigned char b[4]={(unsigned char)(v>>24),(unsigned char)(v>>16),(unsigned char)(v>>8),(unsigned char)(v&255)};
    return byte_literal(b,4);
}
int64_t byte_checksum16(Bytes a) {
    size_t i;uint32_t sum=0;
    if(a.len>BYTE_CAP){failure="byte_capacity";return 0;}
    for(i=0;i<a.len;i+=2){
        uint32_t word=((uint32_t)a.data[i]<<8)+(i+1<a.len?a.data[i+1]:0);
        sum+=word;sum=(sum&UINT32_C(65535))+(sum>>16);
    }
    return (int64_t)(UINT32_C(65535)-sum);
}
void byte_json(Buffer *out,Bytes a) {
    size_t i;text(out,"[");for(i=0;i<a.len;i++){if(i)text(out,",");number(out,a.data[i]);}text(out,"]");
}
int byte_nibble(char c) {
    if(c>='0'&&c<='9')return c-'0';
    if(c>='a'&&c<='f')return c-'a'+10;
    if(c>='A'&&c<='F')return c-'A'+10;
    return -1;
}
int parse_bytes(const char *s,Bytes *out) {
    size_t n,i;*out=(Bytes){0};
    if(!s||s[0]!='b'||s[1]!=':'){failure="invalid_bytes_token";return 0;}
    n=strlen(s+2);
    if(n%2){failure="invalid_bytes_token";return 0;}
    if(n/2>BYTE_CAP){failure="byte_capacity";return 0;}
    for(i=0;i<n/2;i++){
        int a=byte_nibble(s[2+2*i]),b=byte_nibble(s[3+2*i]);
        if(a<0||b<0){failure="invalid_bytes_token";return 0;}out->data[i]=(unsigned char)((a<<4)|b);
    }
    out->len=n/2;return 1;
}

enum { NV=58, NB=24, NT=5 };
typedef struct { int state; int64_t now,v[NV?NV:1],due[NT?NT:1]; Bytes b[NB?NB:1]; int active[NT?NT:1]; } Machine;
const char *state_names[]={"COMPOSED"};
const char *event_names[]={"L.app.resolve","L.app.cache_ttl","L.net.frame","L.timer.query","L.timer.cache","L.app.configure_checksum","L.app.send","L.app.require_checksum","T.app.connect","T.app.listen","T.app.close","T.app.abort","T.net.syn","T.net.synack","T.net.ack","T.net.fin","T.net.rst","T.net.rstack","T.timer.rtx","T.timer.user","T.timer.time_wait","T.app.send","T.app.transmit","T.app.receive","T.net.data","T.net.packet"};
const char *timer_names[]={"L.query","L.cache","T.rtx","T.user","T.time_wait"};
int event_origin[]={0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0};
int event_fields[]={1,1,1,0,0,1,1,1,0,0,0,0,1,3,3,2,1,2,0,0,0,1,0,1,4,1};
int event_kinds[26][FIELD_CAP]={{3},{0},{3},{0},{0},{1},{3},{1},{0},{0},{0},{0},{2},{2,2,0},{2,2,0},{2,2},{2},{2,2},{0},{0},{0},{3},{0},{0},{2,2,0,3},{3}};
int timer_events[]={3,4,18,19,20};
int variable_kinds[]={3,0,0,1,3,3,3,3,3,3,3,0,0,0,0,0,3,1,3,4,3,3,3,3,4,4,2,2,2,2,2,2,2,4,0,0,1,0,0,0,3,3,3,0,2,2,0,3,3,3,3,3,3,3,0,4,4,4};
int variable_byte_index[]={0,-1,-1,-1,1,2,3,4,5,6,7,-1,-1,-1,-1,-1,8,-1,9,-1,10,11,12,13,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,14,15,16,-1,-1,-1,-1,17,18,19,20,21,22,23,-1,-1,-1,-1};
const char *variable_names[]={"L.peer_mac","L.retry_count","L.cache_ttl_ms","L.checksums_enabled","L.payload","L.udp_zero","L.pseudoheader","L.udp_wire","L.ip_zero","L.ip_wire","L.packet","L.udp_length","L.ip_length","L.udp_raw_checksum","L.udp_checksum","L.ip_checksum","L.pending_packet","L.rxudp_require_checksum","L.rxudp_payload","L.rxudp_disposition","L.echo_reply","L.echo_icmp_zero","L.echo_icmp_wire","L.echo_ip_zero","L.echo_disposition","L.control","T.iss","T.irs","T.snd_una","T.snd_nxt","T.rcv_nxt","T.tx_seq","T.tx_ack","T.tx_flags","T.rto_ms","T.retries","T.active_open","T.user_timeout_ms","T.msl_ms","T.local_window","T.snd_buf","T.rtx_buf","T.rcv_buf","T.snd_wnd","T.snd_wl1","T.snd_wl2","T.take","T.rx_chunk","T.wire_data","T.wire_tcp_zero","T.wire_pseudo","T.wire_tcp","T.wire_ip_zero","T.wire_packet","T.wire_flags","T.wire_disposition","T.control","ip_pending_owner"};
const char *source_json_strings[]={"\"A\"","\"CLOSE-WAIT\"","\"CLOSED\"","\"CLOSING\"","\"EMPTY\"","\"ESTABLISHED\"","\"FA\"","\"FIN-WAIT-1\"","\"FIN-WAIT-2\"","\"LAST-ACK\"","\"LISTEN\"","\"PENDING\"","\"R\"","\"RA\"","\"RESOLVED\"","\"S\"","\"SA\"","\"SYN-RECEIVED\"","\"SYN-SENT\"","\"TCP\"","\"TIME-WAIT\"","\"UDP\"","\"aborted\"","\"already_closing\"","\"arp_timeout\"","\"closed\"","\"connected\"","\"deliver\"","\"drop_absent\"","\"drop_icmp_checksum\"","\"drop_ip_checksum\"","\"drop_ip_length\"","\"drop_short\"","\"drop_tcp_checksum\"","\"drop_tcp_length\"","\"drop_udp_checksum\"","\"drop_udp_length\"","\"empty_send\"","\"none\"","\"peer_eof\"","\"protocol\"","\"queued\"","\"refused\"","\"reply\"","\"reset\"","\"send_buffer_full\"","\"timeout\""};
const char *source_json(int64_t i) { if(i<0||i>=STRING_COUNT){failure="string_domain";return "\"\"";}return source_json_strings[i];}
static inline int64_t shared_expr_0(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((((int64_t)(bf[0]).len)>=INT64_C(42))&&(((int64_t)(bf[0]).len)<=INT64_C(1514))); }
static inline int64_t shared_expr_1(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((((int64_t)(bf[0]).len)>=INT64_C(54))&&(((int64_t)(bf[0]).len)<=INT64_C(1514))); }
static inline Bytes shared_expr_2(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){69,0},2),byte_pack16be(m->v[12])); }
static inline int64_t shared_expr_3(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&((m->v[1]==INT64_C(1))&&(((int64_t)(m->b[8]).len)>=INT64_C(28)))); }
static inline int64_t shared_expr_4(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(add(((int64_t)(m->b[14]).len),((int64_t)(m->b[15]).len)),((int64_t)(bf[0]).len)); }
static inline int64_t shared_expr_5(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((1&&(((int64_t)(m->b[14]).len)==INT64_C(0)))&&(((int64_t)(m->b[15]).len)==INT64_C(0))); }
static inline int64_t shared_expr_6(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(mul(INT64_C(256),byte_at_or_zero(bf[0],INT64_C(16))),byte_at_or_zero(bf[0],INT64_C(17))); }
static inline int64_t shared_expr_7(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(mul(byte_at_or_zero(bf[0],INT64_C(16)),INT64_C(256)),byte_at_or_zero(bf[0],INT64_C(17))); }
static inline int64_t shared_expr_8(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((((int64_t)(m->b[8]).len)<=INT64_C(45))?sub(INT64_C(46),((int64_t)(m->b[8]).len)):INT64_C(0)); }
static inline int64_t shared_expr_9(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(6),INT64_C(6)),byte_slice(bf[0],INT64_C(22),INT64_C(6)))); }
static inline int64_t shared_expr_10(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return minimum(INT64_C(4),minimum(((int64_t)(m->b[14]).len),sub(m->v[43],((int64_t)(m->b[15]).len)))); }
static inline int64_t shared_expr_11(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((0==0)?INT64_C(16):((0==6)?INT64_C(17):((0==12)?INT64_C(4):((0==13)?INT64_C(20):INT64_C(0))))); }
static inline int64_t shared_expr_12(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[33]==6)?INT64_C(17):((m->v[33]==12)?INT64_C(4):((m->v[33]==13)?INT64_C(20):INT64_C(0)))); }
static inline int64_t shared_expr_13(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((((int64_t)(m->b[23]).len)<=INT64_C(45))?sub(INT64_C(46),((int64_t)(m->b[23]).len)):INT64_C(0)); }
static inline Bytes shared_expr_14(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_slice(m->b[13],INT64_C(0),INT64_C(10)),byte_pack16be(byte_checksum16(m->b[13]))); }
static inline Bytes shared_expr_15(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_slice(m->b[22],INT64_C(0),INT64_C(10)),byte_pack16be(byte_checksum16(m->b[22]))); }
static inline Bytes shared_expr_16(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_concat(m->b[0],byte_literal((const unsigned char[]){2,0,0,0,0,1,8,0},8)),m->b[8]); }
static inline Bytes shared_expr_17(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){0,0},2),byte_pack16be(byte_checksum16(m->b[11]))); }
static inline Bytes shared_expr_18(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_concat(byte_slice(m->b[2],INT64_C(0),INT64_C(6)),byte_pack16be(m->v[14])),m->b[1]); }
static inline int64_t shared_expr_19(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((12==0)?INT64_C(16):((12==6)?INT64_C(17):((12==12)?INT64_C(4):((12==13)?INT64_C(20):INT64_C(0))))); }
static inline int64_t shared_expr_20(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((13==0)?INT64_C(16):((13==6)?INT64_C(17):((13==12)?INT64_C(4):((13==13)?INT64_C(20):INT64_C(0))))); }
static inline int64_t shared_expr_21(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(12),INT64_C(2)),byte_literal((const unsigned char[]){8,0},2))); }
static inline int64_t shared_expr_22(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(20),INT64_C(2)),byte_literal((const unsigned char[]){0,1},2))); }
static inline int64_t shared_expr_23(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(20),INT64_C(2)),byte_literal((const unsigned char[]){0,2},2))); }
static inline int64_t shared_expr_24(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(34),INT64_C(2)),byte_literal((const unsigned char[]){8,0},2))); }
static inline int64_t shared_expr_25(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(14),INT64_C(2)),byte_literal((const unsigned char[]){69,0},2))); }
static inline int64_t shared_expr_26(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(20),INT64_C(2)),byte_literal((const unsigned char[]){64,0},2))); }
static inline int64_t shared_expr_27(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((1&&(((int64_t)(m->b[14]).len)>=INT64_C(1)))&&(sub(m->v[43],((int64_t)(m->b[15]).len))>=INT64_C(1))); }
static inline int64_t shared_expr_28(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(22),INT64_C(2)),byte_literal((const unsigned char[]){64,17},2))); }
static inline int64_t shared_expr_29(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_22(m,f,bf)); }
static inline int64_t shared_expr_30(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(26),INT64_C(4)),byte_literal((const unsigned char[]){192,0,2,2},4))); }
static inline int64_t shared_expr_31(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(28),INT64_C(4)),byte_literal((const unsigned char[]){192,0,2,2},4))); }
static inline int64_t shared_expr_32(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(30),INT64_C(4)),byte_literal((const unsigned char[]){192,0,2,1},4))); }
static inline int64_t shared_expr_33(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(38),INT64_C(4)),byte_literal((const unsigned char[]){192,0,2,1},4))); }
static inline int64_t shared_expr_34(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_27(m,f,bf)); }
static inline int64_t shared_expr_35(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(0),INT64_C(6)),byte_literal((const unsigned char[]){2,0,0,0,0,1},6))); }
static inline int64_t shared_expr_36(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(6),INT64_C(6)),byte_literal((const unsigned char[]){2,0,0,0,0,2},6))); }
static inline int64_t shared_expr_37(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_6(m,f,bf)<=INT64_C(46)); }
static inline int64_t shared_expr_38(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_6(m,f,bf)>=INT64_C(40)); }
static inline int64_t shared_expr_39(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_7(m,f,bf)>=INT64_C(28)); }
static inline Bytes shared_expr_40(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_concat(byte_pack16be(INT64_C(40000)),byte_pack16be(INT64_C(8080))),byte_pack16be(m->v[11])); }
static inline int64_t shared_expr_41(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_33(m,f,bf)); }
static inline Bytes shared_expr_42(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_slice(bf[0],INT64_C(6),INT64_C(6)),byte_literal((const unsigned char[]){2,0,0,0,0,1,8,0},8)); }
static inline int64_t shared_expr_43(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_6(m,f,bf)<=INT64_C(1500)); }
static inline int64_t shared_expr_44(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_7(m,f,bf)<=INT64_C(1500)); }
static inline int64_t shared_expr_45(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(34),INT64_C(4)),byte_literal((const unsigned char[]){31,144,156,64},4))); }
static inline int64_t shared_expr_46(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(INT64_C(14),shared_expr_6(m,f,bf)); }
static inline int64_t shared_expr_47(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(INT64_C(14),shared_expr_7(m,f,bf)); }
static inline int64_t shared_expr_48(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_39(m,f,bf)); }
static inline int64_t shared_expr_49(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(12),INT64_C(8)),byte_literal((const unsigned char[]){8,6,0,1,8,0,6,4},8))); }
static inline Bytes shared_expr_50(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){156,64,31,144},4),byte_pack32be(distance(INT64_C(0),m->v[28]))); }
static inline Bytes shared_expr_51(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){156,64,31,144},4),byte_pack32be(distance(INT64_C(0),m->v[29]))); }
static inline Bytes shared_expr_52(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){156,64,31,144},4),byte_pack32be(distance(INT64_C(0),m->v[31]))); }
static inline Bytes shared_expr_53(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){156,64,31,144},4),byte_pack32be(distance(INT64_C(0),INT64_C(0)))); }
static inline Bytes shared_expr_54(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){192,0,2,1},4),byte_literal((const unsigned char[]){192,0,2,2},4)); }
static inline int64_t shared_expr_55(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(26),INT64_C(8)),byte_literal((const unsigned char[]){192,0,2,2,192,0,2,1},8))); }
static inline Bytes shared_expr_56(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){69,0},2),byte_pack16be(add(INT64_C(40),((int64_t)(m->b[18]).len)))); }
static inline int64_t shared_expr_57(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((0==16)?INT64_C(18):shared_expr_11(m,f,bf)); }
static inline int64_t shared_expr_58(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(0),INT64_C(6)),byte_literal((const unsigned char[]){255,255,255,255,255,255},6))); }
static inline Bytes shared_expr_59(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_slice(m->b[19],INT64_C(0),INT64_C(16)),byte_pack16be(byte_checksum16(byte_concat(m->b[20],m->b[19])))); }
static inline Bytes shared_expr_60(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(bf[0],INT64_C(14),shared_expr_6(m,f,bf)); }
static inline Bytes shared_expr_61(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(bf[0],INT64_C(14),shared_expr_7(m,f,bf)); }
static inline int64_t shared_expr_62(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((12==16)?INT64_C(18):shared_expr_19(m,f,bf)); }
static inline int64_t shared_expr_63(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((13==16)?INT64_C(18):shared_expr_20(m,f,bf)); }
static inline int64_t shared_expr_64(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[33]==0)?INT64_C(16):shared_expr_12(m,f,bf)); }
static inline int64_t shared_expr_65(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_47(m,f,bf)>=INT64_C(60)); }
static inline int64_t shared_expr_66(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(byte_slice(bf[0],INT64_C(0),INT64_C(14)),byte_literal((const unsigned char[]){2,0,0,0,0,1,2,0,0,0,0,2,8,0},14))); }
static inline Bytes shared_expr_67(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){255,255,255,255,255,255},6),byte_literal((const unsigned char[]){2,0,0,0,0,1},6)); }
static inline int64_t shared_expr_68(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_5(m,f,bf)&&(((int64_t)(m->b[16]).len)==INT64_C(0))); }
static inline Bytes shared_expr_69(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_42(m,f,bf),m->b[10]); }
static inline Bytes shared_expr_70(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_concat(m->b[0],byte_literal((const unsigned char[]){2,0,0,0,0,1},6)),byte_literal((const unsigned char[]){8,0},2)); }
static inline Bytes shared_expr_71(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_concat(byte_slice(m->b[5],INT64_C(0),INT64_C(10)),byte_pack16be(m->v[15])),byte_slice(m->b[5],INT64_C(12),INT64_C(8))); }
static inline int64_t shared_expr_72(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((int64_t)(bf[0]).len)==shared_expr_46(m,f,bf)); }
static inline int64_t shared_expr_73(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((int64_t)(bf[0]).len)==shared_expr_47(m,f,bf)); }
static inline int64_t shared_expr_74(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_68(m,f,bf)); }
static inline int64_t shared_expr_75(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_7(m,f,bf)<=sub(((int64_t)(bf[0]).len),INT64_C(14))); }
static inline Bytes shared_expr_76(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){192,0,2,1,192,0,2,2,0,6},10),byte_pack16be(add(INT64_C(20),((int64_t)(m->b[18]).len)))); }
static inline int64_t shared_expr_77(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_75(m,f,bf)); }
static inline int64_t shared_expr_78(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((0==15)?INT64_C(2):shared_expr_57(m,f,bf)); }
static inline int64_t shared_expr_79(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((int64_t)(shared_expr_60(m,f,bf)).len); }
static inline int64_t shared_expr_80(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((int64_t)(shared_expr_61(m,f,bf)).len); }
static inline int64_t shared_expr_81(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((12==15)?INT64_C(2):shared_expr_62(m,f,bf)); }
static inline int64_t shared_expr_82(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((13==15)?INT64_C(2):shared_expr_63(m,f,bf)); }
static inline Bytes shared_expr_83(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_concat(m->b[0],byte_literal((const unsigned char[]){2,0,0,0,0,1},6)),byte_literal((const unsigned char[]){8,6,0,1,8,0,6,4,0,2},10)); }
static inline int64_t shared_expr_84(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_34(m,f,bf)&&(((int64_t)(m->b[15]).len)==INT64_C(0))); }
static inline int64_t shared_expr_85(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_34(m,f,bf)&&(((int64_t)(m->b[15]).len)>=INT64_C(1))); }
static inline int64_t shared_expr_86(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(2)); }
static inline int64_t shared_expr_87(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(3)); }
static inline int64_t shared_expr_88(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(8)); }
static inline int64_t shared_expr_89(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(9)); }
static inline int64_t shared_expr_90(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(0)); }
static inline int64_t shared_expr_91(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(1)); }
static inline int64_t shared_expr_92(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(2)); }
static inline int64_t shared_expr_93(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(3)); }
static inline int64_t shared_expr_94(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(6)); }
static inline int64_t shared_expr_95(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(7)); }
static inline int64_t shared_expr_96(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(8)); }
static inline int64_t shared_expr_97(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(9)); }
static inline int64_t shared_expr_98(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(24)); }
static inline int64_t shared_expr_99(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(25)); }
static inline int64_t shared_expr_100(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(26)); }
static inline int64_t shared_expr_101(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(27)); }
static inline int64_t shared_expr_102(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(28)); }
static inline int64_t shared_expr_103(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(29)); }
static inline int64_t shared_expr_104(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(30)); }
static inline int64_t shared_expr_105(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(31)); }
static inline int64_t shared_expr_106(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(32)); }
static inline int64_t shared_expr_107(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(33)); }
static inline int64_t shared_expr_108(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(34)); }
static inline int64_t shared_expr_109(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(35)); }
static inline int64_t shared_expr_110(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(42)); }
static inline int64_t shared_expr_111(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_60(m,f,bf),INT64_C(43)); }
static inline int64_t shared_expr_112(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(20)); }
static inline int64_t shared_expr_113(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(21)); }
static inline int64_t shared_expr_114(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(24)); }
static inline int64_t shared_expr_115(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(25)); }
static inline int64_t shared_expr_116(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(26)); }
static inline int64_t shared_expr_117(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_at_or_zero(shared_expr_61(m,f,bf),INT64_C(27)); }
static inline int64_t shared_expr_118(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[33]==16)?INT64_C(18):shared_expr_64(m,f,bf)); }
static inline int64_t shared_expr_119(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_74(m,f,bf)); }
static inline Bytes shared_expr_120(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_70(m,f,bf),m->b[23]); }
static inline Bytes shared_expr_121(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_14(m,f,bf),byte_slice(m->b[13],INT64_C(12),INT64_C(8))); }
static inline Bytes shared_expr_122(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_15(m,f,bf),byte_slice(m->b[22],INT64_C(12),INT64_C(8))); }
static inline Bytes shared_expr_123(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_pack16be(shared_expr_80(m,f,bf)); }
static inline int64_t shared_expr_124(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_79(m,f,bf)==INT64_C(40)); }
static inline int64_t shared_expr_125(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_79(m,f,bf)==INT64_C(44)); }
static inline int64_t shared_expr_126(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_79(m,f,bf)>=INT64_C(40)); }
static inline int64_t shared_expr_127(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_79(m,f,bf)>=INT64_C(41)); }
static inline int64_t shared_expr_128(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_79(m,f,bf)>=INT64_C(44)); }
static inline int64_t shared_expr_129(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_80(m,f,bf)>=INT64_C(28)); }
static inline Bytes shared_expr_130(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_2(m,f,bf),byte_literal((const unsigned char[]){0,0,64,0,64,17,0,0},8)); }
static inline Bytes shared_expr_131(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(0),INT64_C(2)); }
static inline Bytes shared_expr_132(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(6),INT64_C(2)); }
static inline Bytes shared_expr_133(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(0),INT64_C(2)); }
static inline Bytes shared_expr_134(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(6),INT64_C(4)); }
static inline int64_t shared_expr_135(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_79(m,f,bf)<=INT64_C(1500)); }
static inline int64_t shared_expr_136(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_80(m,f,bf)<=INT64_C(1500)); }
static inline int64_t shared_expr_137(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(shared_expr_79(m,f,bf),INT64_C(20)); }
static inline int64_t shared_expr_138(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(shared_expr_79(m,f,bf),INT64_C(40)); }
static inline int64_t shared_expr_139(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(shared_expr_80(m,f,bf),INT64_C(20)); }
static inline int64_t shared_expr_140(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(shared_expr_80(m,f,bf),INT64_C(24)); }
static inline Bytes shared_expr_141(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(0),INT64_C(20)); }
static inline Bytes shared_expr_142(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(12),INT64_C(8)); }
static inline Bytes shared_expr_143(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(38),INT64_C(2)); }
static inline Bytes shared_expr_144(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(38),INT64_C(4)); }
static inline Bytes shared_expr_145(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(0),INT64_C(20)); }
static inline Bytes shared_expr_146(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(12),INT64_C(4)); }
static inline Bytes shared_expr_147(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(12),INT64_C(8)); }
static inline Bytes shared_expr_148(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(16),INT64_C(4)); }
static inline Bytes shared_expr_149(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(24),INT64_C(2)); }
static inline int64_t shared_expr_150(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_126(m,f,bf)); }
static inline int64_t shared_expr_151(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_128(m,f,bf)); }
static inline Bytes shared_expr_152(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(12),INT64_C(12)); }
static inline Bytes shared_expr_153(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(12),INT64_C(12)); }
static inline int64_t shared_expr_154(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_88(m,f,bf)>=INT64_C(1)); }
static inline int64_t shared_expr_155(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_89(m,f,bf)==INT64_C(6)); }
static inline int64_t shared_expr_156(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_91(m,f,bf)==INT64_C(0)); }
static inline int64_t shared_expr_157(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_95(m,f,bf)==INT64_C(0)); }
static inline int64_t shared_expr_158(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_96(m,f,bf)>=INT64_C(1)); }
static inline int64_t shared_expr_159(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_97(m,f,bf)==INT64_C(1)); }
static inline int64_t shared_expr_160(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_107(m,f,bf)==INT64_C(2)); }
static inline int64_t shared_expr_161(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_107(m,f,bf)==INT64_C(4)); }
static inline int64_t shared_expr_162(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_90(m,f,bf)==INT64_C(69)); }
static inline int64_t shared_expr_163(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_112(m,f,bf)==INT64_C(8)); }
static inline int64_t shared_expr_164(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_113(m,f,bf)==INT64_C(0)); }
static inline int64_t shared_expr_165(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_94(m,f,bf)==INT64_C(64)); }
static inline Bytes shared_expr_166(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_40(m,f,bf),byte_literal((const unsigned char[]){0,0},2)); }
static inline int64_t shared_expr_167(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_84(m,f,bf)); }
static inline int64_t shared_expr_168(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_85(m,f,bf)); }
static inline int64_t shared_expr_169(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_106(m,f,bf)==INT64_C(80)); }
static inline int64_t shared_expr_170(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_106(m,f,bf)==INT64_C(96)); }
static inline int64_t shared_expr_171(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_106(m,f,bf)>=INT64_C(80)); }
static inline int64_t shared_expr_172(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_107(m,f,bf)==INT64_C(16)); }
static inline int64_t shared_expr_173(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_107(m,f,bf)==INT64_C(17)); }
static inline int64_t shared_expr_174(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_107(m,f,bf)==INT64_C(18)); }
static inline int64_t shared_expr_175(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_107(m,f,bf)==INT64_C(20)); }
static inline int64_t shared_expr_176(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_107(m,f,bf)==INT64_C(24)); }
static inline int64_t shared_expr_177(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_86(m,f,bf),INT64_C(256)); }
static inline int64_t shared_expr_178(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_92(m,f,bf),INT64_C(256)); }
static inline int64_t shared_expr_179(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_171(m,f,bf)); }
static inline int64_t shared_expr_180(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_100(m,f,bf),INT64_C(256)); }
static inline int64_t shared_expr_181(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_104(m,f,bf),INT64_C(256)); }
static inline int64_t shared_expr_182(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_108(m,f,bf),INT64_C(256)); }
static inline int64_t shared_expr_183(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_110(m,f,bf),INT64_C(256)); }
static inline int64_t shared_expr_184(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_114(m,f,bf),INT64_C(256)); }
static inline int64_t shared_expr_185(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_116(m,f,bf),INT64_C(256)); }
static inline Bytes shared_expr_186(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_50(m,f,bf),byte_pack32be(distance(INT64_C(0),m->v[30]))); }
static inline Bytes shared_expr_187(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_51(m,f,bf),byte_pack32be(distance(INT64_C(0),m->v[30]))); }
static inline Bytes shared_expr_188(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_52(m,f,bf),byte_pack32be(distance(INT64_C(0),m->v[32]))); }
static inline Bytes shared_expr_189(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_pack16be(shared_expr_137(m,f,bf)); }
static inline int64_t shared_expr_190(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_99(m,f,bf),INT64_C(65536)); }
static inline int64_t shared_expr_191(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_103(m,f,bf),INT64_C(65536)); }
static inline Bytes shared_expr_192(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_51(m,f,bf),byte_pack32be(distance(INT64_C(0),INT64_C(0)))); }
static inline int64_t shared_expr_193(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_139(m,f,bf),INT64_C(1)); }
static inline Bytes shared_expr_194(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_54(m,f,bf),byte_literal((const unsigned char[]){0,17},2)); }
static inline int64_t shared_expr_195(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_checksum16(shared_expr_141(m,f,bf)); }
static inline int64_t shared_expr_196(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_checksum16(shared_expr_145(m,f,bf)); }
static inline int64_t shared_expr_197(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_98(m,f,bf),INT64_C(16777216)); }
static inline int64_t shared_expr_198(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return mul(shared_expr_102(m,f,bf),INT64_C(16777216)); }
static inline Bytes shared_expr_199(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_121(m,f,bf),m->b[12]); }
static inline Bytes shared_expr_200(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_122(m,f,bf),m->b[21]); }
static inline int64_t shared_expr_201(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[33]==15)?INT64_C(2):shared_expr_118(m,f,bf)); }
static inline Bytes shared_expr_202(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_166(m,f,bf),m->b[1]); }
static inline Bytes shared_expr_203(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(m->b[11],INT64_C(4),shared_expr_140(m,f,bf)); }
static inline int64_t shared_expr_204(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_195(m,f,bf)==INT64_C(0)); }
static inline int64_t shared_expr_205(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_196(m,f,bf)==INT64_C(0)); }
static inline int64_t shared_expr_206(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_1(m,f,bf)&&shared_expr_35(m,f,bf)); }
static inline int64_t shared_expr_207(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_204(m,f,bf)); }
static inline int64_t shared_expr_208(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_205(m,f,bf)); }
static inline int64_t shared_expr_209(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((((int64_t)(m->b[18]).len)>=INT64_C(1))?INT64_C(24):shared_expr_78(m,f,bf)); }
static inline Bytes shared_expr_210(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(byte_literal((const unsigned char[]){0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},18),INT64_C(0),shared_expr_8(m,f,bf)); }
static inline int64_t shared_expr_211(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((((int64_t)(m->b[18]).len)>=INT64_C(1))?INT64_C(24):shared_expr_81(m,f,bf)); }
static inline int64_t shared_expr_212(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((((int64_t)(m->b[18]).len)>=INT64_C(1))?INT64_C(24):shared_expr_82(m,f,bf)); }
static inline int64_t shared_expr_213(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_22(m,f,bf)||shared_expr_23(m,f,bf)); }
static inline int64_t shared_expr_214(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_25(m,f,bf)&&shared_expr_26(m,f,bf)); }
static inline Bytes shared_expr_215(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_67(m,f,bf),byte_literal((const unsigned char[]){8,6,0,1,8,0,6,4,0,1},10)); }
static inline Bytes shared_expr_216(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_59(m,f,bf),byte_slice(m->b[19],INT64_C(18),add(INT64_C(2),((int64_t)(m->b[18]).len)))); }
static inline int64_t shared_expr_217(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_0(m,f,bf)&&shared_expr_66(m,f,bf)); }
static inline Bytes shared_expr_218(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_56(m,f,bf),byte_literal((const unsigned char[]){0,0,64,0,64,6,0,0,192,0,2,1,192,0,2,2},16)); }
static inline Bytes shared_expr_219(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_194(m,f,bf),byte_pack16be(m->v[11])); }
static inline Bytes shared_expr_220(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){69,0},2),shared_expr_123(m,f,bf)); }
static inline Bytes shared_expr_221(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_83(m,f,bf),byte_literal((const unsigned char[]){2,0,0,0,0,1},6)); }
static inline Bytes shared_expr_222(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_142(m,f,bf),byte_literal((const unsigned char[]){0,6},2)); }
static inline Bytes shared_expr_223(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){0,17},2),shared_expr_149(m,f,bf)); }
static inline int64_t shared_expr_224(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_131(m,f,bf),byte_literal((const unsigned char[]){69,0},2))); }
static inline int64_t shared_expr_225(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_143(m,f,bf),byte_literal((const unsigned char[]){0,0},2))); }
static inline int64_t shared_expr_226(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_132(m,f,bf),byte_literal((const unsigned char[]){64,0},2))); }
static inline int64_t shared_expr_227(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_133(m,f,bf),byte_literal((const unsigned char[]){69,0},2))); }
static inline Bytes shared_expr_228(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_130(m,f,bf),byte_literal((const unsigned char[]){192,0,2,1},4)); }
static inline Bytes shared_expr_229(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(byte_literal((const unsigned char[]){0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},46),INT64_C(0),sub(INT64_C(46),minimum(INT64_C(46),((int64_t)(m->b[10]).len)))); }
static inline int64_t shared_expr_230(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_144(m,f,bf),byte_literal((const unsigned char[]){0,0,2,4},4))); }
static inline int64_t shared_expr_231(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_146(m,f,bf),byte_literal((const unsigned char[]){192,0,2,2},4))); }
static inline int64_t shared_expr_232(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_148(m,f,bf),byte_literal((const unsigned char[]){192,0,2,1},4))); }
static inline int64_t shared_expr_233(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_134(m,f,bf),byte_literal((const unsigned char[]){64,0,64,17},4))); }
static inline Bytes shared_expr_234(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_186(m,f,bf),byte_literal((const unsigned char[]){80},1)); }
static inline Bytes shared_expr_235(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_187(m,f,bf),byte_literal((const unsigned char[]){80},1)); }
static inline Bytes shared_expr_236(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_188(m,f,bf),byte_literal((const unsigned char[]){80},1)); }
static inline int64_t shared_expr_237(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_35(m,f,bf)||shared_expr_58(m,f,bf)); }
static inline Bytes shared_expr_238(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_192(m,f,bf),byte_literal((const unsigned char[]){80},1)); }
static inline int64_t shared_expr_239(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_37(m,f,bf)?INT64_C(60):shared_expr_46(m,f,bf)); }
static inline int64_t shared_expr_240(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((((int64_t)(m->b[18]).len)>=INT64_C(1))?INT64_C(24):shared_expr_201(m,f,bf)); }
static inline int64_t shared_expr_241(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_65(m,f,bf)?shared_expr_47(m,f,bf):INT64_C(60)); }
static inline int64_t shared_expr_242(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_152(m,f,bf),byte_literal((const unsigned char[]){192,0,2,2,192,0,2,1,31,144,156,64},12))); }
static inline int64_t shared_expr_243(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (byte_equal(shared_expr_153(m,f,bf),byte_literal((const unsigned char[]){192,0,2,2,192,0,2,1,31,144,156,64},12))); }
static inline int64_t shared_expr_244(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_48(m,f,bf)||shared_expr_77(m,f,bf)); }
static inline Bytes shared_expr_245(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(byte_literal((const unsigned char[]){0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},46),INT64_C(0),shared_expr_13(m,f,bf)); }
static inline int64_t shared_expr_246(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((int64_t)(bf[0]).len)==shared_expr_239(m,f,bf)); }
static inline Bytes shared_expr_247(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_234(m,f,bf),byte_pack8(m->v[54])); }
static inline Bytes shared_expr_248(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_235(m,f,bf),byte_pack8(m->v[54])); }
static inline Bytes shared_expr_249(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_236(m,f,bf),byte_pack8(m->v[54])); }
static inline Bytes shared_expr_250(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_238(m,f,bf),byte_pack8(m->v[54])); }
static inline Bytes shared_expr_251(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_215(m,f,bf),byte_literal((const unsigned char[]){2,0,0,0,0,1},6)); }
static inline int64_t shared_expr_252(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((int64_t)(bf[0]).len)==shared_expr_241(m,f,bf)); }
static inline Bytes shared_expr_253(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_221(m,f,bf),byte_literal((const unsigned char[]){192,0,2,1},4)); }
static inline Bytes shared_expr_254(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_228(m,f,bf),byte_literal((const unsigned char[]){192,0,2,2},4)); }
static inline Bytes shared_expr_255(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_248(m,f,bf),byte_pack16be(m->v[39])); }
static inline Bytes shared_expr_256(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_249(m,f,bf),byte_pack16be(m->v[39])); }
static inline Bytes shared_expr_257(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_253(m,f,bf),m->b[0]); }
static inline Bytes shared_expr_258(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_250(m,f,bf),byte_pack16be(m->v[39])); }
static inline Bytes shared_expr_259(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_17(m,f,bf),shared_expr_203(m,f,bf)); }
static inline int64_t shared_expr_260(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_206(m,f,bf)&&shared_expr_36(m,f,bf)); }
static inline Bytes shared_expr_261(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(20),shared_expr_137(m,f,bf)); }
static inline Bytes shared_expr_262(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_60(m,f,bf),INT64_C(40),shared_expr_138(m,f,bf)); }
static inline Bytes shared_expr_263(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(20),shared_expr_139(m,f,bf)); }
static inline Bytes shared_expr_264(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(24),shared_expr_140(m,f,bf)); }
static inline Bytes shared_expr_265(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_220(m,f,bf),byte_literal((const unsigned char[]){0,0,64,0,64,1,0,0,192,0,2,1,192,0,2,2},16)); }
static inline Bytes shared_expr_266(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_16(m,f,bf),shared_expr_210(m,f,bf)); }
static inline int64_t shared_expr_267(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((((int64_t)(bf[0]).len)>=INT64_C(42))&&(((int64_t)(bf[0]).len)<=INT64_C(60)))&&shared_expr_237(m,f,bf)); }
static inline int64_t shared_expr_268(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_126(m,f,bf)&&shared_expr_135(m,f,bf)); }
static inline int64_t shared_expr_269(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_129(m,f,bf)&&shared_expr_136(m,f,bf)); }
static inline int64_t shared_expr_270(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_217(m,f,bf)&&shared_expr_39(m,f,bf)); }
static inline int64_t shared_expr_271(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((int64_t)(shared_expr_262(m,f,bf)).len); }
static inline int64_t shared_expr_272(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_checksum16(shared_expr_263(m,f,bf)); }
static inline int64_t shared_expr_273(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_214(m,f,bf)&&shared_expr_55(m,f,bf)); }
static inline int64_t shared_expr_274(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_160(m,f,bf)&&shared_expr_124(m,f,bf)); }
static inline int64_t shared_expr_275(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_161(m,f,bf)&&shared_expr_124(m,f,bf)); }
static inline int64_t shared_expr_276(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_172(m,f,bf)&&shared_expr_124(m,f,bf)); }
static inline int64_t shared_expr_277(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_173(m,f,bf)&&shared_expr_124(m,f,bf)); }
static inline int64_t shared_expr_278(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_175(m,f,bf)&&shared_expr_124(m,f,bf)); }
static inline int64_t shared_expr_279(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_176(m,f,bf)&&shared_expr_127(m,f,bf)); }
static inline int64_t shared_expr_280(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_177(m,f,bf),shared_expr_87(m,f,bf)); }
static inline int64_t shared_expr_281(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_178(m,f,bf),shared_expr_93(m,f,bf)); }
static inline int64_t shared_expr_282(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_180(m,f,bf),shared_expr_101(m,f,bf)); }
static inline int64_t shared_expr_283(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_181(m,f,bf),shared_expr_105(m,f,bf)); }
static inline int64_t shared_expr_284(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_182(m,f,bf),shared_expr_109(m,f,bf)); }
static inline int64_t shared_expr_285(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_183(m,f,bf),shared_expr_111(m,f,bf)); }
static inline int64_t shared_expr_286(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_184(m,f,bf),shared_expr_115(m,f,bf)); }
static inline int64_t shared_expr_287(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_185(m,f,bf),shared_expr_117(m,f,bf)); }
static inline Bytes shared_expr_288(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_247(m,f,bf),byte_pack16be(sub(INT64_C(16),((int64_t)(m->b[16]).len)))); }
static inline Bytes shared_expr_289(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_248(m,f,bf),byte_pack16be(sub(INT64_C(16),((int64_t)(m->b[16]).len)))); }
static inline int64_t shared_expr_290(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_271(m,f,bf)>=INT64_C(1)); }
static inline int64_t shared_expr_291(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_272(m,f,bf)==INT64_C(0)); }
static inline Bytes shared_expr_292(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_251(m,f,bf),byte_literal((const unsigned char[]){192,0,2,1},4)); }
static inline int64_t shared_expr_293(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_271(m,f,bf)<=INT64_C(16)); }
static inline int64_t shared_expr_294(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_160(m,f,bf)||shared_expr_174(m,f,bf)); }
static inline int64_t shared_expr_295(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_170(m,f,bf)&&shared_expr_174(m,f,bf)); }
static inline int64_t shared_expr_296(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_172(m,f,bf)||shared_expr_176(m,f,bf)); }
static inline int64_t shared_expr_297(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(shared_expr_271(m,f,bf),INT64_C(0)); }
static inline int64_t shared_expr_298(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(shared_expr_271(m,f,bf),INT64_C(1)); }
static inline int64_t shared_expr_299(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_291(m,f,bf)); }
static inline int64_t shared_expr_300(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_284(m,f,bf)==m->v[43]); }
static inline int64_t shared_expr_301(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_284(m,f,bf)>=INT64_C(0)); }
static inline int64_t shared_expr_302(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_285(m,f,bf)>=INT64_C(4)); }
static inline int64_t shared_expr_303(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_286(m,f,bf)<=INT64_C(7)); }
static inline int64_t shared_expr_304(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_286(m,f,bf)>=INT64_C(8)); }
static inline int64_t shared_expr_305(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_287(m,f,bf)==INT64_C(0)); }
static inline int64_t shared_expr_306(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(shared_expr_286(m,f,bf),INT64_C(8)); }
static inline int64_t shared_expr_307(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_305(m,f,bf)); }
static inline int64_t shared_expr_308(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_284(m,f,bf)<=INT64_C(65535)); }
static inline int64_t shared_expr_309(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_301(m,f,bf)); }
static inline int64_t shared_expr_310(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (INT64_C(0)<=shared_expr_298(m,f,bf)); }
static inline int64_t shared_expr_311(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_197(m,f,bf),shared_expr_190(m,f,bf)); }
static inline int64_t shared_expr_312(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_198(m,f,bf),shared_expr_191(m,f,bf)); }
static inline int64_t shared_expr_313(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_305(m,f,bf)&&(!m->v[17])); }
static inline int64_t shared_expr_314(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_284(m,f,bf)>=((int64_t)(m->b[15]).len)); }
static inline Bytes shared_expr_315(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_255(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0},4)); }
static inline Bytes shared_expr_316(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_256(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0},4)); }
static inline Bytes shared_expr_317(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_258(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0},4)); }
static inline Bytes shared_expr_318(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_257(m,f,bf),byte_literal((const unsigned char[]){192,0,2,2},4)); }
static inline Bytes shared_expr_319(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_69(m,f,bf),shared_expr_229(m,f,bf)); }
static inline Bytes shared_expr_320(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){0,0,0,0},4),shared_expr_264(m,f,bf)); }
static inline int64_t shared_expr_321(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_273(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(22))>=INT64_C(1))); }
static inline Bytes shared_expr_322(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_315(m,f,bf),m->b[18]); }
static inline Bytes shared_expr_323(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_316(m,f,bf),m->b[18]); }
static inline Bytes shared_expr_324(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_317(m,f,bf),m->b[18]); }
static inline int64_t shared_expr_325(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_169(m,f,bf)&&shared_expr_225(m,f,bf)); }
static inline Bytes shared_expr_326(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_147(m,f,bf),shared_expr_223(m,f,bf)); }
static inline int64_t shared_expr_327(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return minimum(sub(INT64_C(16),((int64_t)(m->b[16]).len)),shared_expr_297(m,f,bf)); }
static inline Bytes shared_expr_328(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_288(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0},4)); }
static inline Bytes shared_expr_329(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_289(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0},4)); }
static inline int64_t shared_expr_330(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_246(m,f,bf)||shared_expr_72(m,f,bf)); }
static inline Bytes shared_expr_331(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_222(m,f,bf),shared_expr_189(m,f,bf)); }
static inline Bytes shared_expr_332(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_292(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0,0,0},6)); }
static inline int64_t shared_expr_333(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_260(m,f,bf)&&shared_expr_21(m,f,bf)); }
static inline int64_t shared_expr_334(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_73(m,f,bf)||shared_expr_252(m,f,bf)); }
static inline Bytes shared_expr_335(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_328(m,f,bf),m->b[18]); }
static inline Bytes shared_expr_336(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_329(m,f,bf),m->b[18]); }
static inline Bytes shared_expr_337(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_120(m,f,bf),shared_expr_245(m,f,bf)); }
static inline int64_t shared_expr_338(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_267(m,f,bf)&&shared_expr_49(m,f,bf)); }
static inline int64_t shared_expr_339(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_321(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(23))==INT64_C(1))); }
static inline int64_t shared_expr_340(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_273(m,f,bf)&&shared_expr_28(m,f,bf)); }
static inline int64_t shared_expr_341(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_270(m,f,bf)&&shared_expr_44(m,f,bf)); }
static inline Bytes shared_expr_342(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_318(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},18)); }
static inline int64_t shared_expr_343(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_333(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(14))==INT64_C(69))); }
static inline Bytes shared_expr_344(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_332(m,f,bf),byte_literal((const unsigned char[]){192,0,2,2},4)); }
static inline int64_t shared_expr_345(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_280(m,f,bf)==shared_expr_79(m,f,bf)); }
static inline int64_t shared_expr_346(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_281(m,f,bf)==shared_expr_80(m,f,bf)); }
static inline int64_t shared_expr_347(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_345(m,f,bf)); }
static inline Bytes shared_expr_348(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(20),shared_expr_286(m,f,bf)); }
static inline int64_t shared_expr_349(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_269(m,f,bf)&&shared_expr_162(m,f,bf)); }
static inline int64_t shared_expr_350(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_286(m,f,bf)==shared_expr_139(m,f,bf)); }
static inline Bytes shared_expr_351(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_61(m,f,bf),INT64_C(28),shared_expr_306(m,f,bf)); }
static inline int64_t shared_expr_352(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_295(m,f,bf)&&shared_expr_125(m,f,bf)); }
static inline int64_t shared_expr_353(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_296(m,f,bf)&&shared_expr_127(m,f,bf)); }
static inline int64_t shared_expr_354(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_295(m,f,bf)&&shared_expr_151(m,f,bf)); }
static inline int64_t shared_expr_355(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_286(m,f,bf)>=shared_expr_193(m,f,bf)); }
static inline int64_t shared_expr_356(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_294(m,f,bf)||shared_expr_173(m,f,bf)); }
static inline int64_t shared_expr_357(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_343(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(15))==INT64_C(0))); }
static inline int64_t shared_expr_358(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_339(m,f,bf)&&shared_expr_24(m,f,bf)); }
static inline int64_t shared_expr_359(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_268(m,f,bf)&&shared_expr_224(m,f,bf)); }
static inline int64_t shared_expr_360(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_269(m,f,bf)&&shared_expr_227(m,f,bf)); }
static inline int64_t shared_expr_361(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_340(m,f,bf)&&shared_expr_45(m,f,bf)); }
static inline Bytes shared_expr_362(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_344(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},18)); }
static inline int64_t shared_expr_363(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_357(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(20))==INT64_C(64))); }
static inline int64_t shared_expr_364(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_363(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(21))==INT64_C(0))); }
static inline int64_t shared_expr_365(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_338(m,f,bf)&&shared_expr_213(m,f,bf)); }
static inline int64_t shared_expr_366(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_349(m,f,bf)&&shared_expr_156(m,f,bf)); }
static inline int64_t shared_expr_367(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_364(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(22))>=INT64_C(1))); }
static inline int64_t shared_expr_368(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_179(m,f,bf)||shared_expr_354(m,f,bf)); }
static inline int64_t shared_expr_369(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_356(m,f,bf)||shared_expr_161(m,f,bf)); }
static inline int64_t shared_expr_370(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_311(m,f,bf),shared_expr_282(m,f,bf)); }
static inline int64_t shared_expr_371(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return add(shared_expr_312(m,f,bf),shared_expr_283(m,f,bf)); }
static inline int64_t shared_expr_372(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_309(m,f,bf)&&shared_expr_308(m,f,bf)); }
static inline int64_t shared_expr_373(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return seqadd(INT64_C(0),shared_expr_370(m,f,bf)); }
static inline int64_t shared_expr_374(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return seqadd(INT64_C(0),shared_expr_371(m,f,bf)); }
static inline int64_t shared_expr_375(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (m->v[44]==shared_expr_373(m,f,bf)); }
static inline int64_t shared_expr_376(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_373(m,f,bf)==m->v[27]); }
static inline int64_t shared_expr_377(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_373(m,f,bf)==m->v[30]); }
static inline int64_t shared_expr_378(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_374(m,f,bf)!=m->v[29]); }
static inline int64_t shared_expr_379(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_374(m,f,bf)==m->v[28]); }
static inline int64_t shared_expr_380(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_374(m,f,bf)==m->v[29]); }
static inline Bytes shared_expr_381(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_262(m,f,bf),INT64_C(0),shared_expr_327(m,f,bf)); }
static inline Bytes shared_expr_382(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_331(m,f,bf),shared_expr_261(m,f,bf)); }
static inline int64_t shared_expr_383(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_352(m,f,bf)&&shared_expr_230(m,f,bf)); }
static inline int64_t shared_expr_384(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_367(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(22))<=INT64_C(255))); }
static inline int64_t shared_expr_385(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_375(m,f,bf)); }
static inline int64_t shared_expr_386(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_377(m,f,bf)); }
static inline int64_t shared_expr_387(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_379(m,f,bf)); }
static inline int64_t shared_expr_388(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return distance(m->v[28],shared_expr_374(m,f,bf)); }
static inline int64_t shared_expr_389(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return distance(shared_expr_373(m,f,bf),m->v[30]); }
static inline int64_t shared_expr_390(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return seqadd(shared_expr_373(m,f,bf),INT64_C(1)); }
static inline int64_t shared_expr_391(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return distance(INT64_C(0),shared_expr_374(m,f,bf)); }
static inline int64_t shared_expr_392(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_365(m,f,bf)&&shared_expr_9(m,f,bf)); }
static inline int64_t shared_expr_393(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_377(m,f,bf)&&(m->v[36]==0)); }
static inline int64_t shared_expr_394(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_377(m,f,bf)&&(m->v[36]==1)); }
static inline int64_t shared_expr_395(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_390(m,f,bf)==m->v[30]); }
static inline int64_t shared_expr_396(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_checksum16(shared_expr_382(m,f,bf)); }
static inline int64_t shared_expr_397(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_388(m,f,bf)>=INT64_C(1)); }
static inline Bytes shared_expr_398(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_pack32be(shared_expr_391(m,f,bf)); }
static inline int64_t shared_expr_399(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_380(m,f,bf)&&(m->v[35]==INT64_C(0))); }
static inline int64_t shared_expr_400(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_380(m,f,bf)&&(m->v[35]==INT64_C(1))); }
static inline int64_t shared_expr_401(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_380(m,f,bf)&&(m->v[35]>=INT64_C(2))); }
static inline int64_t shared_expr_402(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_397(m,f,bf)); }
static inline int64_t shared_expr_403(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_217(m,f,bf)&&shared_expr_358(m,f,bf)); }
static inline int64_t shared_expr_404(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return distance(INT64_C(0),shared_expr_390(m,f,bf)); }
static inline int64_t shared_expr_405(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (distance(m->v[45],shared_expr_374(m,f,bf))<INT64_C(2147483648)); }
static inline int64_t shared_expr_406(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (distance(m->v[28],shared_expr_374(m,f,bf))!=INT64_C(2147483648)); }
static inline int64_t shared_expr_407(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_388(m,f,bf)<=INT64_C(2147483647)); }
static inline int64_t shared_expr_408(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (distance(m->v[29],shared_expr_374(m,f,bf))!=INT64_C(2147483648)); }
static inline int64_t shared_expr_409(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (distance(shared_expr_373(m,f,bf),m->v[30])!=INT64_C(2147483648)); }
static inline int64_t shared_expr_410(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_396(m,f,bf)==INT64_C(0)); }
static inline int64_t shared_expr_411(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_388(m,f,bf)<=((int64_t)(m->b[15]).len)); }
static inline int64_t shared_expr_412(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_388(m,f,bf)==((int64_t)(m->b[15]).len)); }
static inline int64_t shared_expr_413(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_410(m,f,bf)); }
static inline int64_t shared_expr_414(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(((int64_t)(m->b[15]).len),shared_expr_388(m,f,bf)); }
static inline int64_t shared_expr_415(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_412(m,f,bf)); }
static inline int64_t shared_expr_416(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_217(m,f,bf)&&shared_expr_361(m,f,bf)); }
static inline int64_t shared_expr_417(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_359(m,f,bf)&&shared_expr_226(m,f,bf)); }
static inline Bytes shared_expr_418(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_pack32be(shared_expr_404(m,f,bf)); }
static inline int64_t shared_expr_419(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_360(m,f,bf)&&shared_expr_233(m,f,bf)); }
static inline int64_t shared_expr_420(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_388(m,f,bf)>=add(((int64_t)(m->b[15]).len),INT64_C(1))); }
static inline Bytes shared_expr_421(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(m->b[15],shared_expr_388(m,f,bf),((int64_t)(m->b[15]).len)); }
static inline int64_t shared_expr_422(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_384(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(23))==INT64_C(6))); }
static inline int64_t shared_expr_423(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_392(m,f,bf)&&(byte_at_or_zero(bf[0],INT64_C(22))==INT64_C(2))); }
static inline Bytes shared_expr_424(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(byte_literal((const unsigned char[]){156,64,31,144},4),shared_expr_398(m,f,bf)); }
static inline int64_t shared_expr_425(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_366(m,f,bf)&&shared_expr_165(m,f,bf)); }
static inline int64_t shared_expr_426(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_304(m,f,bf)&&shared_expr_350(m,f,bf)); }
static inline int64_t shared_expr_427(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_369(m,f,bf)||shared_expr_175(m,f,bf)); }
static inline int64_t shared_expr_428(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_303(m,f,bf)||shared_expr_355(m,f,bf)); }
static inline int64_t shared_expr_429(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_341(m,f,bf)&&shared_expr_334(m,f,bf)); }
static inline Bytes shared_expr_430(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_424(m,f,bf),byte_pack32be(distance(INT64_C(0),INT64_C(0)))); }
static inline Bytes shared_expr_431(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_326(m,f,bf),shared_expr_348(m,f,bf)); }
static inline int64_t shared_expr_432(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_422(m,f,bf)&&shared_expr_30(m,f,bf)); }
static inline Bytes shared_expr_433(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_53(m,f,bf),shared_expr_418(m,f,bf)); }
static inline int64_t shared_expr_434(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_423(m,f,bf)&&shared_expr_31(m,f,bf)); }
static inline int64_t shared_expr_435(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_checksum16(shared_expr_431(m,f,bf)); }
static inline int64_t shared_expr_436(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_435(m,f,bf)==INT64_C(0)); }
static inline int64_t shared_expr_437(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_436(m,f,bf)); }
static inline int64_t shared_expr_438(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_417(m,f,bf)&&shared_expr_154(m,f,bf)); }
static inline Bytes shared_expr_439(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_430(m,f,bf),byte_literal((const unsigned char[]){80},1)); }
static inline Bytes shared_expr_440(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_433(m,f,bf),byte_literal((const unsigned char[]){80},1)); }
static inline Bytes shared_expr_441(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_439(m,f,bf),byte_pack8(m->v[54])); }
static inline Bytes shared_expr_442(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_440(m,f,bf),byte_pack8(m->v[54])); }
static inline int64_t shared_expr_443(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_425(m,f,bf)&&shared_expr_157(m,f,bf)); }
static inline int64_t shared_expr_444(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_432(m,f,bf)&&shared_expr_32(m,f,bf)); }
static inline Bytes shared_expr_445(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_441(m,f,bf),byte_pack16be(m->v[39])); }
static inline int64_t shared_expr_446(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_403(m,f,bf)&&shared_expr_244(m,f,bf)); }
static inline int64_t shared_expr_447(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_434(m,f,bf)&&shared_expr_33(m,f,bf)); }
static inline int64_t shared_expr_448(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_434(m,f,bf)&&shared_expr_41(m,f,bf)); }
static inline int64_t shared_expr_449(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_427(m,f,bf)&&shared_expr_124(m,f,bf)); }
static inline int64_t shared_expr_450(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_416(m,f,bf)&&shared_expr_244(m,f,bf)); }
static inline int64_t shared_expr_451(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_419(m,f,bf)&&shared_expr_243(m,f,bf)); }
static inline Bytes shared_expr_452(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_442(m,f,bf),byte_pack16be(m->v[39])); }
static inline int64_t shared_expr_453(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_389(m,f,bf)>=shared_expr_271(m,f,bf)); }
static inline int64_t shared_expr_454(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return sub(shared_expr_271(m,f,bf),shared_expr_389(m,f,bf)); }
static inline Bytes shared_expr_455(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_445(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0},4)); }
static inline int64_t shared_expr_456(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_387(m,f,bf)&&shared_expr_300(m,f,bf)); }
static inline int64_t shared_expr_457(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_389(m,f,bf)<=shared_expr_298(m,f,bf)); }
static inline int64_t shared_expr_458(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_383(m,f,bf)&&shared_expr_302(m,f,bf)); }
static inline int64_t shared_expr_459(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_386(m,f,bf)&&shared_expr_301(m,f,bf)); }
static inline Bytes shared_expr_460(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_452(m,f,bf),byte_literal((const unsigned char[]){0,0,0,0},4)); }
static inline Bytes shared_expr_461(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_455(m,f,bf),m->b[18]); }
static inline int64_t shared_expr_462(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_284(m,f,bf)>=shared_expr_414(m,f,bf)); }
static inline int64_t shared_expr_463(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_438(m,f,bf)&&shared_expr_155(m,f,bf)); }
static inline Bytes shared_expr_464(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_concat(shared_expr_460(m,f,bf),m->b[18]); }
static inline int64_t shared_expr_465(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return minimum(sub(INT64_C(16),((int64_t)(m->b[16]).len)),shared_expr_454(m,f,bf)); }
static inline int64_t shared_expr_466(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_444(m,f,bf)&&shared_expr_45(m,f,bf)); }
static inline int64_t shared_expr_467(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_447(m,f,bf)&&shared_expr_22(m,f,bf)); }
static inline int64_t shared_expr_468(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_447(m,f,bf)&&shared_expr_29(m,f,bf)); }
static inline int64_t shared_expr_469(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_443(m,f,bf)&&shared_expr_159(m,f,bf)); }
static inline int64_t shared_expr_470(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_449(m,f,bf)||shared_expr_172(m,f,bf)); }
static inline int64_t shared_expr_471(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_466(m,f,bf)&&shared_expr_38(m,f,bf)); }
static inline int64_t shared_expr_472(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_307(m,f,bf)&&shared_expr_436(m,f,bf)); }
static inline int64_t shared_expr_473(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_469(m,f,bf)&&shared_expr_163(m,f,bf)); }
static inline int64_t shared_expr_474(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_471(m,f,bf)&&shared_expr_43(m,f,bf)); }
static inline int64_t shared_expr_475(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_463(m,f,bf)&&shared_expr_242(m,f,bf)); }
static inline int64_t shared_expr_476(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_456(m,f,bf)&&shared_expr_290(m,f,bf)); }
static inline int64_t shared_expr_477(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_459(m,f,bf)&&shared_expr_308(m,f,bf)); }
static inline int64_t shared_expr_478(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_377(m,f,bf)&&shared_expr_378(m,f,bf)); }
static inline int64_t shared_expr_479(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_377(m,f,bf)&&shared_expr_379(m,f,bf)); }
static inline int64_t shared_expr_480(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_379(m,f,bf)||shared_expr_380(m,f,bf)); }
static inline int64_t shared_expr_481(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_380(m,f,bf)&&shared_expr_376(m,f,bf)); }
static inline int64_t shared_expr_482(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_380(m,f,bf)&&shared_expr_377(m,f,bf)); }
static inline int64_t shared_expr_483(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_399(m,f,bf)&&shared_expr_372(m,f,bf)); }
static inline int64_t shared_expr_484(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_400(m,f,bf)&&shared_expr_372(m,f,bf)); }
static inline int64_t shared_expr_485(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_401(m,f,bf)&&shared_expr_372(m,f,bf)); }
static inline int64_t shared_expr_486(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_481(m,f,bf)&&(m->v[35]==INT64_C(0))); }
static inline int64_t shared_expr_487(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_481(m,f,bf)&&(m->v[35]==INT64_C(1))); }
static inline int64_t shared_expr_488(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_481(m,f,bf)&&(m->v[35]>=INT64_C(2))); }
static inline int64_t shared_expr_489(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_385(m,f,bf)&&shared_expr_405(m,f,bf)); }
static inline int64_t shared_expr_490(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (distance(m->v[30],shared_expr_373(m,f,bf))>0&&distance(m->v[30],shared_expr_373(m,f,bf))<INT64_C(2147483648)); }
static inline int64_t shared_expr_491(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (distance(m->v[44],shared_expr_373(m,f,bf))>0&&distance(m->v[44],shared_expr_373(m,f,bf))<INT64_C(2147483648)); }
static inline int64_t shared_expr_492(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (distance(shared_expr_373(m,f,bf),m->v[30])>0&&distance(shared_expr_373(m,f,bf),m->v[30])<INT64_C(2147483648)); }
static inline int64_t shared_expr_493(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_490(m,f,bf)); }
static inline int64_t shared_expr_494(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (0||shared_expr_491(m,f,bf)); }
static inline int64_t shared_expr_495(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_492(m,f,bf)); }
static inline int64_t shared_expr_496(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_451(m,f,bf)&&shared_expr_346(m,f,bf)); }
static inline int64_t shared_expr_497(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_473(m,f,bf)&&shared_expr_164(m,f,bf)); }
static inline int64_t shared_expr_498(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_402(m,f,bf)&&shared_expr_411(m,f,bf)); }
static inline int64_t shared_expr_499(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_470(m,f,bf)||shared_expr_279(m,f,bf)); }
static inline int64_t shared_expr_500(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_420(m,f,bf)&&shared_expr_407(m,f,bf)); }
static inline int64_t shared_expr_501(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_482(m,f,bf)&&shared_expr_68(m,f,bf)); }
static inline int64_t shared_expr_502(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_313(m,f,bf)||shared_expr_472(m,f,bf)); }
static inline int64_t shared_expr_503(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_497(m,f,bf)&&shared_expr_158(m,f,bf)); }
static inline int64_t shared_expr_504(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_496(m,f,bf)&&shared_expr_205(m,f,bf)); }
static inline int64_t shared_expr_505(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_496(m,f,bf)&&shared_expr_208(m,f,bf)); }
static inline int64_t shared_expr_506(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_474(m,f,bf)&&shared_expr_330(m,f,bf)); }
static inline int64_t shared_expr_507(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_476(m,f,bf)&&shared_expr_293(m,f,bf)); }
static inline int64_t shared_expr_508(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_507(m,f,bf)); }
static inline int64_t shared_expr_509(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_508(m,f,bf)&&(sub(INT64_C(16),((int64_t)(m->b[16]).len))==INT64_C(0))); }
static inline int64_t shared_expr_510(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_475(m,f,bf)&&shared_expr_345(m,f,bf)); }
static inline int64_t shared_expr_511(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_475(m,f,bf)&&shared_expr_347(m,f,bf)); }
static inline int64_t shared_expr_512(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_503(m,f,bf)&&shared_expr_231(m,f,bf)); }
static inline int64_t shared_expr_513(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_325(m,f,bf)&&shared_expr_499(m,f,bf)); }
static inline int64_t shared_expr_514(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_510(m,f,bf)&&shared_expr_204(m,f,bf)); }
static inline int64_t shared_expr_515(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_510(m,f,bf)&&shared_expr_207(m,f,bf)); }
static inline int64_t shared_expr_516(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_512(m,f,bf)&&shared_expr_232(m,f,bf)); }
static inline Bytes shared_expr_517(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return byte_slice(shared_expr_262(m,f,bf),shared_expr_389(m,f,bf),shared_expr_465(m,f,bf)); }
static inline int64_t shared_expr_518(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_486(m,f,bf)&&shared_expr_372(m,f,bf)); }
static inline int64_t shared_expr_519(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_487(m,f,bf)&&shared_expr_372(m,f,bf)); }
static inline int64_t shared_expr_520(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_488(m,f,bf)&&shared_expr_372(m,f,bf)); }
static inline int64_t shared_expr_521(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_477(m,f,bf)&&shared_expr_406(m,f,bf)); }
static inline int64_t shared_expr_522(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_395(m,f,bf)&&shared_expr_480(m,f,bf)); }
static inline int64_t shared_expr_523(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_508(m,f,bf)&&shared_expr_377(m,f,bf)); }
static inline int64_t shared_expr_524(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_504(m,f,bf)&&shared_expr_426(m,f,bf)); }
static inline int64_t shared_expr_525(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_495(m,f,bf)&&shared_expr_453(m,f,bf)); }
static inline int64_t shared_expr_526(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_525(m,f,bf)); }
static inline int64_t shared_expr_527(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_504(m,f,bf)&&shared_expr_428(m,f,bf)); }
static inline int64_t shared_expr_528(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_429(m,f,bf)&&shared_expr_505(m,f,bf)); }
static inline int64_t shared_expr_529(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_509(m,f,bf)&&shared_expr_409(m,f,bf)); }
static inline int64_t shared_expr_530(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_516(m,f,bf)&&shared_expr_346(m,f,bf)); }
static inline int64_t shared_expr_531(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_514(m,f,bf)&&shared_expr_368(m,f,bf)); }
static inline int64_t shared_expr_532(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_530(m,f,bf)&&shared_expr_205(m,f,bf)); }
static inline int64_t shared_expr_533(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_530(m,f,bf)&&shared_expr_208(m,f,bf)); }
static inline int64_t shared_expr_534(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_523(m,f,bf)&&shared_expr_310(m,f,bf)); }
static inline int64_t shared_expr_535(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_524(m,f,bf)&&shared_expr_305(m,f,bf)); }
static inline int64_t shared_expr_536(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_524(m,f,bf)&&shared_expr_307(m,f,bf)); }
static inline int64_t shared_expr_537(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_535(m,f,bf)&&m->v[17]); }
static inline int64_t shared_expr_538(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_534(m,f,bf)&&(sub(INT64_C(16),((int64_t)(m->b[16]).len))>=INT64_C(1))); }
static inline int64_t shared_expr_539(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_521(m,f,bf)&&shared_expr_408(m,f,bf)); }
static inline int64_t shared_expr_540(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (1&&shared_expr_539(m,f,bf)); }
static inline int64_t shared_expr_541(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_494(m,f,bf)||shared_expr_489(m,f,bf)); }
static inline int64_t shared_expr_542(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (!shared_expr_541(m,f,bf)); }
static inline int64_t shared_expr_543(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_513(m,f,bf)||shared_expr_458(m,f,bf)); }
static inline int64_t shared_expr_544(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_532(m,f,bf)&&shared_expr_291(m,f,bf)); }
static inline int64_t shared_expr_545(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_532(m,f,bf)&&shared_expr_299(m,f,bf)); }
static inline int64_t shared_expr_546(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_508(m,f,bf)&&shared_expr_490(m,f,bf)); }
static inline int64_t shared_expr_547(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_508(m,f,bf)&&shared_expr_492(m,f,bf)); }
static inline int64_t shared_expr_548(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_429(m,f,bf)&&shared_expr_527(m,f,bf)); }
static inline int64_t shared_expr_549(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_540(m,f,bf)&&shared_expr_379(m,f,bf)); }
static inline int64_t shared_expr_550(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_429(m,f,bf)&&shared_expr_533(m,f,bf)); }
static inline int64_t shared_expr_551(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_429(m,f,bf)&&shared_expr_537(m,f,bf)); }
static inline int64_t shared_expr_552(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_536(m,f,bf)&&shared_expr_437(m,f,bf)); }
static inline int64_t shared_expr_553(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_429(m,f,bf)&&shared_expr_544(m,f,bf)); }
static inline int64_t shared_expr_554(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_429(m,f,bf)&&shared_expr_545(m,f,bf)); }
static inline int64_t shared_expr_555(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_549(m,f,bf)&&shared_expr_314(m,f,bf)); }
static inline int64_t shared_expr_556(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_524(m,f,bf)&&shared_expr_502(m,f,bf)); }
static inline int64_t shared_expr_557(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_508(m,f,bf)&&shared_expr_525(m,f,bf)); }
static inline int64_t shared_expr_558(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_547(m,f,bf)&&shared_expr_457(m,f,bf)); }
static inline int64_t shared_expr_559(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_558(m,f,bf)&&(sub(INT64_C(16),((int64_t)(m->b[16]).len))>=INT64_C(1))); }
static inline int64_t shared_expr_560(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_540(m,f,bf)&&shared_expr_498(m,f,bf)); }
static inline int64_t shared_expr_561(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_540(m,f,bf)&&shared_expr_500(m,f,bf)); }
static inline int64_t shared_expr_562(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_429(m,f,bf)&&shared_expr_552(m,f,bf)); }
static inline int64_t shared_expr_563(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_514(m,f,bf)&&shared_expr_543(m,f,bf)); }
static inline int64_t shared_expr_564(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_429(m,f,bf)&&shared_expr_556(m,f,bf)); }
static inline int64_t shared_expr_565(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_529(m,f,bf)&&shared_expr_526(m,f,bf)); }
static inline int64_t shared_expr_566(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_560(m,f,bf)&&shared_expr_412(m,f,bf)); }
static inline int64_t shared_expr_567(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_560(m,f,bf)&&shared_expr_415(m,f,bf)); }
static inline int64_t shared_expr_568(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_563(m,f,bf)&&shared_expr_410(m,f,bf)); }
static inline int64_t shared_expr_569(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_563(m,f,bf)&&shared_expr_413(m,f,bf)); }
static inline int64_t shared_expr_570(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_568(m,f,bf)&&shared_expr_174(m,f,bf)); }
static inline int64_t shared_expr_571(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_570(m,f,bf)&&1); }
static inline int64_t shared_expr_572(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==2)&&shared_expr_571(m,f,bf)); }
static inline int64_t shared_expr_573(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==10)&&shared_expr_571(m,f,bf)); }
static inline int64_t shared_expr_574(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_568(m,f,bf)&&shared_expr_274(m,f,bf)); }
static inline int64_t shared_expr_575(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_568(m,f,bf)&&shared_expr_275(m,f,bf)); }
static inline int64_t shared_expr_576(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_568(m,f,bf)&&shared_expr_276(m,f,bf)); }
static inline int64_t shared_expr_577(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_568(m,f,bf)&&shared_expr_277(m,f,bf)); }
static inline int64_t shared_expr_578(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_568(m,f,bf)&&shared_expr_278(m,f,bf)); }
static inline int64_t shared_expr_579(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_574(m,f,bf)&&1); }
static inline int64_t shared_expr_580(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_575(m,f,bf)&&1); }
static inline int64_t shared_expr_581(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_576(m,f,bf)&&1); }
static inline int64_t shared_expr_582(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_577(m,f,bf)&&1); }
static inline int64_t shared_expr_583(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_578(m,f,bf)&&1); }
static inline int64_t shared_expr_584(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==2)&&shared_expr_579(m,f,bf)); }
static inline int64_t shared_expr_585(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==10)&&shared_expr_579(m,f,bf)); }
static inline int64_t shared_expr_586(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&shared_expr_579(m,f,bf)); }
static inline int64_t shared_expr_587(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==2)&&shared_expr_581(m,f,bf)); }
static inline int64_t shared_expr_588(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==2)&&shared_expr_582(m,f,bf)); }
static inline int64_t shared_expr_589(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==10)&&shared_expr_581(m,f,bf)); }
static inline int64_t shared_expr_590(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==10)&&shared_expr_582(m,f,bf)); }
static inline int64_t shared_expr_591(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_568(m,f,bf)&&shared_expr_353(m,f,bf)); }
static inline int64_t shared_expr_592(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_566(m,f,bf)&&shared_expr_462(m,f,bf)); }
static inline int64_t shared_expr_593(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_567(m,f,bf)&&shared_expr_462(m,f,bf)); }
static inline int64_t shared_expr_594(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_565(m,f,bf)&&shared_expr_493(m,f,bf)); }
static inline int64_t shared_expr_595(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_570(m,f,bf)&&shared_expr_378(m,f,bf)); }
static inline int64_t shared_expr_596(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&shared_expr_595(m,f,bf)); }
static inline int64_t shared_expr_597(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_575(m,f,bf)&&shared_expr_377(m,f,bf)); }
static inline int64_t shared_expr_598(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_576(m,f,bf)&&shared_expr_378(m,f,bf)); }
static inline int64_t shared_expr_599(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_578(m,f,bf)&&shared_expr_377(m,f,bf)); }
static inline int64_t shared_expr_600(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&shared_expr_598(m,f,bf)); }
static inline int64_t shared_expr_601(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_570(m,f,bf)&&shared_expr_483(m,f,bf)); }
static inline int64_t shared_expr_602(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_570(m,f,bf)&&shared_expr_484(m,f,bf)); }
static inline int64_t shared_expr_603(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_570(m,f,bf)&&shared_expr_485(m,f,bf)); }
static inline int64_t shared_expr_604(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&shared_expr_601(m,f,bf)); }
static inline int64_t shared_expr_605(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&shared_expr_602(m,f,bf)); }
static inline int64_t shared_expr_606(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&shared_expr_603(m,f,bf)); }
static inline int64_t shared_expr_607(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_576(m,f,bf)&&shared_expr_478(m,f,bf)); }
static inline int64_t shared_expr_608(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_576(m,f,bf)&&shared_expr_479(m,f,bf)); }
static inline int64_t shared_expr_609(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_576(m,f,bf)&&shared_expr_482(m,f,bf)); }
static inline int64_t shared_expr_610(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_577(m,f,bf)&&shared_expr_479(m,f,bf)); }
static inline int64_t shared_expr_611(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_577(m,f,bf)&&shared_expr_482(m,f,bf)); }
static inline int64_t shared_expr_612(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==7)&&shared_expr_610(m,f,bf)); }
static inline int64_t shared_expr_613(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==7)&&shared_expr_611(m,f,bf)); }
static inline int64_t shared_expr_614(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==8)&&shared_expr_611(m,f,bf)); }
static inline int64_t shared_expr_615(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==17)&&shared_expr_607(m,f,bf)); }
static inline int64_t shared_expr_616(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_577(m,f,bf)&&shared_expr_501(m,f,bf)); }
static inline int64_t shared_expr_617(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_616(m,f,bf)); }
static inline int64_t shared_expr_618(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_572(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_619(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_573(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_620(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_584(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_621(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_585(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_622(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_586(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_623(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_587(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_624(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_588(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_625(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_589(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_626(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_590(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_627(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_570(m,f,bf)&&shared_expr_518(m,f,bf)); }
static inline int64_t shared_expr_628(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_570(m,f,bf)&&shared_expr_519(m,f,bf)); }
static inline int64_t shared_expr_629(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_570(m,f,bf)&&shared_expr_520(m,f,bf)); }
static inline int64_t shared_expr_630(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==17)&&shared_expr_627(m,f,bf)); }
static inline int64_t shared_expr_631(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==17)&&shared_expr_628(m,f,bf)); }
static inline int64_t shared_expr_632(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==17)&&shared_expr_629(m,f,bf)); }
static inline int64_t shared_expr_633(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_577(m,f,bf)&&shared_expr_522(m,f,bf)); }
static inline int64_t shared_expr_634(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==1)&&shared_expr_633(m,f,bf)); }
static inline int64_t shared_expr_635(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==3)&&shared_expr_633(m,f,bf)); }
static inline int64_t shared_expr_636(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==9)&&shared_expr_633(m,f,bf)); }
static inline int64_t shared_expr_637(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==20)&&shared_expr_633(m,f,bf)); }
static inline int64_t shared_expr_638(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_596(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_639(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_600(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_640(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_604(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_641(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_605(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_642(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_606(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_643(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_591(m,f,bf)&&shared_expr_538(m,f,bf)); }
static inline int64_t shared_expr_644(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_643(m,f,bf)); }
static inline int64_t shared_expr_645(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_612(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_646(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_613(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_647(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_614(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_648(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_615(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_649(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_617(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_650(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_591(m,f,bf)&&shared_expr_546(m,f,bf)); }
static inline int64_t shared_expr_651(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_650(m,f,bf)); }
static inline int64_t shared_expr_652(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_630(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_653(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_631(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_654(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_632(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_655(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_634(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_656(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_635(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_657(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_636(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_658(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_637(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_659(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_576(m,f,bf)&&shared_expr_561(m,f,bf)); }
static inline int64_t shared_expr_660(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_591(m,f,bf)&&shared_expr_557(m,f,bf)); }
static inline int64_t shared_expr_661(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_659(m,f,bf)); }
static inline int64_t shared_expr_662(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_660(m,f,bf)); }
static inline int64_t shared_expr_663(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_591(m,f,bf)&&shared_expr_559(m,f,bf)); }
static inline int64_t shared_expr_664(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_663(m,f,bf)); }
static inline int64_t shared_expr_665(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_644(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_666(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_651(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_667(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_661(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_668(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_662(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_669(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_664(m,f,bf)&&shared_expr_506(m,f,bf)); }
static inline int64_t shared_expr_670(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_591(m,f,bf)&&shared_expr_594(m,f,bf)); }
static inline int64_t shared_expr_671(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&shared_expr_670(m,f,bf)); }
static inline int64_t shared_expr_672(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_671(m,f,bf)&&shared_expr_506(m,f,bf)); }
void initialize(Machine *m) { memset(m,0,sizeof(*m)); m->state=0;
m->b[0]=byte_literal((const unsigned char[]){0},0);
m->v[1]=INT64_C(0);
m->v[2]=INT64_C(60000);
m->v[3]=1;
m->b[1]=byte_literal((const unsigned char[]){0},0);
m->b[2]=byte_literal((const unsigned char[]){0},0);
m->b[3]=byte_literal((const unsigned char[]){0},0);
m->b[4]=byte_literal((const unsigned char[]){0},0);
m->b[5]=byte_literal((const unsigned char[]){0},0);
m->b[6]=byte_literal((const unsigned char[]){0},0);
m->b[7]=byte_literal((const unsigned char[]){0},0);
m->v[11]=INT64_C(0);
m->v[12]=INT64_C(0);
m->v[13]=INT64_C(0);
m->v[14]=INT64_C(0);
m->v[15]=INT64_C(0);
m->b[8]=byte_literal((const unsigned char[]){0},0);
m->v[17]=0;
m->b[9]=byte_literal((const unsigned char[]){0},0);
m->v[19]=38;
m->b[10]=byte_literal((const unsigned char[]){0},0);
m->b[11]=byte_literal((const unsigned char[]){0},0);
m->b[12]=byte_literal((const unsigned char[]){0},0);
m->b[13]=byte_literal((const unsigned char[]){0},0);
m->v[24]=38;
m->v[25]=4;
m->v[26]=INT64_C(1000);
m->v[27]=INT64_C(0);
m->v[28]=INT64_C(1000);
m->v[29]=INT64_C(1000);
m->v[30]=INT64_C(0);
m->v[31]=INT64_C(1000);
m->v[32]=INT64_C(0);
m->v[33]=15;
m->v[34]=INT64_C(1000);
m->v[35]=INT64_C(0);
m->v[36]=1;
m->v[37]=INT64_C(30000);
m->v[38]=INT64_C(60000);
m->v[39]=INT64_C(16);
m->b[14]=byte_literal((const unsigned char[]){0},0);
m->b[15]=byte_literal((const unsigned char[]){0},0);
m->b[16]=byte_literal((const unsigned char[]){0},0);
m->v[43]=INT64_C(8);
m->v[44]=INT64_C(0);
m->v[45]=INT64_C(0);
m->v[46]=INT64_C(0);
m->b[17]=byte_literal((const unsigned char[]){0},0);
m->b[18]=byte_literal((const unsigned char[]){0},0);
m->b[19]=byte_literal((const unsigned char[]){0},0);
m->b[20]=byte_literal((const unsigned char[]){0},0);
m->b[21]=byte_literal((const unsigned char[]){0},0);
m->b[22]=byte_literal((const unsigned char[]){0},0);
m->b[23]=byte_literal((const unsigned char[]){0},0);
m->v[54]=INT64_C(0);
m->v[55]=38;
m->v[56]=2;
m->v[57]=38;
}
int invariants(Machine *m) { (void)m; if(failure)return 0;
if(!((!(m->v[25]==4)||(((((int64_t)(m->b[0]).len)==INT64_C(0))&&(!m->active[0]))&&(!m->active[1]))))) {failure="invariant:L.STATE-EMPTY";return 0;}
if(!((!(m->v[25]==11)||(((((int64_t)(m->b[0]).len)==INT64_C(0))&&m->active[0])&&(!m->active[1]))))) {failure="invariant:L.STATE-PENDING";return 0;}
if(!((!(m->v[25]==14)||(((((int64_t)(m->b[0]).len)==INT64_C(6))&&(!m->active[0]))&&m->active[1])))) {failure="invariant:L.STATE-RESOLVED";return 0;}
if(!(((m->v[1]>=INT64_C(0))&&(m->v[1]<=INT64_C(1))))) {failure="invariant:L.RETRY-BOUND";return 0;}
if(!(((m->v[2]>=INT64_C(60000))&&(m->v[2]<=INT64_C(3600000))))) {failure="invariant:L.TTL-DOMAIN";return 0;}
if(!((((int64_t)(m->b[7]).len)<=INT64_C(1500)))) {failure="invariant:L.PACKET-MTU";return 0;}
if(!(((((int64_t)(m->b[7]).len)==INT64_C(0))||(((int64_t)(m->b[7]).len)==m->v[12])))) {failure="invariant:L.PACKET-LENGTH";return 0;}
if(!((((int64_t)(m->b[8]).len)<=INT64_C(1500)))) {failure="invariant:L.QUEUE-BOUND";return 0;}
if(!((!(((int64_t)(m->b[8]).len)>=INT64_C(1))||(m->v[25]==11)))) {failure="invariant:L.QUEUE-ONLY-PENDING";return 0;}
if(!(((((int64_t)(m->b[8]).len)==INT64_C(0))||(((int64_t)(m->b[8]).len)>=INT64_C(28))))) {failure="invariant:L.QUEUE-PACKET-OR-EMPTY";return 0;}
if(!((((int64_t)(m->b[9]).len)<=INT64_C(1472)))) {failure="invariant:L.UDPRX-RX-PAYLOAD-BOUND";return 0;}
if(!((!(m->v[19]!=27)||(((int64_t)(m->b[9]).len)==INT64_C(0))))) {failure="invariant:L.UDPRX-RX-DROP-EMPTY";return 0;}
if(!((((int64_t)(m->b[10]).len)<=INT64_C(1500)))) {failure="invariant:L.ECHO-ECHO-REPLY-BOUND";return 0;}
if(!((!(m->v[24]!=43)||(((int64_t)(m->b[10]).len)==INT64_C(0))))) {failure="invariant:L.ECHO-ECHO-DROP-EMPTY";return 0;}
if(!((((m->v[25]==4)||(m->v[25]==11))||(m->v[25]==14)))) {failure="invariant:L.COMPONENT-STATE-DOMAIN";return 0;}
if(!((!(m->v[56]==2)||(m->active[2]==0)))) {failure="invariant:T.C-INV-TIMER-CLOSED-rtx";return 0;}
if(!((!(m->v[56]==2)||(m->active[3]==0)))) {failure="invariant:T.C-INV-TIMER-CLOSED-user";return 0;}
if(!((!(m->v[56]==2)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-CLOSED-time_wait";return 0;}
if(!((!(m->v[56]==10)||(m->active[2]==0)))) {failure="invariant:T.C-INV-TIMER-LISTEN-rtx";return 0;}
if(!((!(m->v[56]==10)||(m->active[3]==0)))) {failure="invariant:T.C-INV-TIMER-LISTEN-user";return 0;}
if(!((!(m->v[56]==10)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-LISTEN-time_wait";return 0;}
if(!((!(m->v[56]==18)||(m->active[2]==1)))) {failure="invariant:T.C-INV-TIMER-SYN-SENT-rtx";return 0;}
if(!((!(m->v[56]==18)||(m->active[3]==1)))) {failure="invariant:T.C-INV-TIMER-SYN-SENT-user";return 0;}
if(!((!(m->v[56]==18)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-SYN-SENT-time_wait";return 0;}
if(!((!(m->v[56]==17)||(m->active[2]==1)))) {failure="invariant:T.C-INV-TIMER-SYN-RECEIVED-rtx";return 0;}
if(!((!(m->v[56]==17)||(m->active[3]==1)))) {failure="invariant:T.C-INV-TIMER-SYN-RECEIVED-user";return 0;}
if(!((!(m->v[56]==17)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-SYN-RECEIVED-time_wait";return 0;}
if(!((!(m->v[56]==5)||(m->active[3]==0)))) {failure="invariant:T.C-INV-TIMER-ESTABLISHED-user";return 0;}
if(!((!(m->v[56]==5)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-ESTABLISHED-time_wait";return 0;}
if(!((!(m->v[56]==7)||(m->active[2]==1)))) {failure="invariant:T.C-INV-TIMER-FIN-WAIT-1-rtx";return 0;}
if(!((!(m->v[56]==7)||(m->active[3]==1)))) {failure="invariant:T.C-INV-TIMER-FIN-WAIT-1-user";return 0;}
if(!((!(m->v[56]==7)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-FIN-WAIT-1-time_wait";return 0;}
if(!((!(m->v[56]==8)||(m->active[2]==0)))) {failure="invariant:T.C-INV-TIMER-FIN-WAIT-2-rtx";return 0;}
if(!((!(m->v[56]==8)||(m->active[3]==1)))) {failure="invariant:T.C-INV-TIMER-FIN-WAIT-2-user";return 0;}
if(!((!(m->v[56]==8)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-FIN-WAIT-2-time_wait";return 0;}
if(!((!(m->v[56]==1)||(m->active[2]==0)))) {failure="invariant:T.C-INV-TIMER-CLOSE-WAIT-rtx";return 0;}
if(!((!(m->v[56]==1)||(m->active[3]==0)))) {failure="invariant:T.C-INV-TIMER-CLOSE-WAIT-user";return 0;}
if(!((!(m->v[56]==1)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-CLOSE-WAIT-time_wait";return 0;}
if(!((!(m->v[56]==3)||(m->active[2]==1)))) {failure="invariant:T.C-INV-TIMER-CLOSING-rtx";return 0;}
if(!((!(m->v[56]==3)||(m->active[3]==1)))) {failure="invariant:T.C-INV-TIMER-CLOSING-user";return 0;}
if(!((!(m->v[56]==3)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-CLOSING-time_wait";return 0;}
if(!((!(m->v[56]==9)||(m->active[2]==1)))) {failure="invariant:T.C-INV-TIMER-LAST-ACK-rtx";return 0;}
if(!((!(m->v[56]==9)||(m->active[3]==1)))) {failure="invariant:T.C-INV-TIMER-LAST-ACK-user";return 0;}
if(!((!(m->v[56]==9)||(m->active[4]==0)))) {failure="invariant:T.C-INV-TIMER-LAST-ACK-time_wait";return 0;}
if(!((!(m->v[56]==20)||(m->active[2]==0)))) {failure="invariant:T.C-INV-TIMER-TIME-WAIT-rtx";return 0;}
if(!((!(m->v[56]==20)||(m->active[3]==0)))) {failure="invariant:T.C-INV-TIMER-TIME-WAIT-user";return 0;}
if(!((!(m->v[56]==20)||(m->active[4]==1)))) {failure="invariant:T.C-INV-TIMER-TIME-WAIT-time_wait";return 0;}
if(!((!(((((0||(m->v[56]==18))||(m->v[56]==17))||(m->v[56]==7))||(m->v[56]==3))||(m->v[56]==9))||((m->v[29]==seqadd(m->v[31],INT64_C(1)))&&(m->v[28]==m->v[31]))))) {failure="invariant:T.C-INV-OUTSTANDING-CONTROL";return 0;}
if(!((m->v[34]>=INT64_C(1000)))) {failure="invariant:T.C-INV-BOUND-rto_ms";return 0;}
if(!((m->v[35]>=INT64_C(0)))) {failure="invariant:T.C-INV-BOUND-retries";return 0;}
if(!((m->v[38]>=INT64_C(1)))) {failure="invariant:T.C-INV-BOUND-msl_ms";return 0;}
if(!((m->v[37]>=INT64_C(1)))) {failure="invariant:T.C-INV-BOUND-user_timeout_ms";return 0;}
if(!((!(m->v[56]==18)||(m->v[28]==m->v[26])))) {failure="invariant:T.C-INV-SYN-SENT-ISS";return 0;}
if(!((!(m->v[56]==5)||(m->active[2]==(((int64_t)(m->b[15]).len)>=INT64_C(1)))))) {failure="invariant:T.D-INV-TIMER";return 0;}
if(!((!(m->v[56]==5)||(m->v[29]==seqadd(m->v[28],((int64_t)(m->b[15]).len)))))) {failure="invariant:T.D-INV-SEQUENCE-BUFFER";return 0;}
if(!((add(((int64_t)(m->b[14]).len),((int64_t)(m->b[15]).len))<=INT64_C(16)))) {failure="invariant:T.D-INV-SEND-CAPACITY";return 0;}
if(!((((int64_t)(m->b[16]).len)<=INT64_C(16)))) {failure="invariant:T.D-INV-RECEIVE-CAPACITY";return 0;}
if(!(((1&&(m->v[43]>=INT64_C(0)))&&(m->v[43]<=INT64_C(65535))))) {failure="invariant:T.D-INV-WINDOW";return 0;}
if(!((!(!(m->v[56]==5))||shared_expr_68(m,NULL,NULL)))) {failure="invariant:T.D-INV-NO-DATA-OUTSIDE-ESTABLISHED";return 0;}
if(!((m->v[39]==sub(INT64_C(16),((int64_t)(m->b[16]).len))))) {failure="invariant:T.D-INV-ADVERTISED-WINDOW";return 0;}
if(!((!(((0||(m->v[56]==1))||(m->v[56]==8))||(m->v[56]==20))||(m->v[28]==m->v[29])))) {failure="invariant:T.D-INV-CONTROL-DRAINED";return 0;}
if(!((((int64_t)(m->b[15]).len)<=m->v[43]))) {failure="invariant:T.D-INV-FLIGHT-WINDOW";return 0;}
if(!((((int64_t)(m->b[23]).len)<=INT64_C(1500)))) {failure="invariant:T.WIRE-PACKET-BOUND";return 0;}
if(!((((((((((((m->v[56]==2)||(m->v[56]==10))||(m->v[56]==18))||(m->v[56]==17))||(m->v[56]==5))||(m->v[56]==7))||(m->v[56]==8))||(m->v[56]==1))||(m->v[56]==3))||(m->v[56]==9))||(m->v[56]==20)))) {failure="invariant:T.COMPONENT-STATE-DOMAIN";return 0;}
if(!((((m->v[57]==38)||((m->v[57]==21)||(m->v[57]==19)))&&((m->v[57]==38)==(((int64_t)(m->b[8]).len)==INT64_C(0)))))) {failure="invariant:IP-PENDING-OWNER";return 0;}
return failure==NULL; }
void snapshot(Buffer *out,Machine *m) { int first=1;
text(out,"{\"state\":");
switch(m->state) {
case 0:
text(out,"\"COMPOSED\"");
break;
default:failure="invalid_state";}
text(out,",\"variables\":{");
text(out,"\"L.peer_mac\":");
byte_json(out,m->b[0]);
text(out,",\"L.retry_count\":");
number(out,m->v[1]);
text(out,",\"L.cache_ttl_ms\":");
number(out,m->v[2]);
text(out,",\"L.checksums_enabled\":");
text(out,m->v[3]?"true":"false");
text(out,",\"L.payload\":");
byte_json(out,m->b[1]);
text(out,",\"L.udp_zero\":");
byte_json(out,m->b[2]);
text(out,",\"L.pseudoheader\":");
byte_json(out,m->b[3]);
text(out,",\"L.udp_wire\":");
byte_json(out,m->b[4]);
text(out,",\"L.ip_zero\":");
byte_json(out,m->b[5]);
text(out,",\"L.ip_wire\":");
byte_json(out,m->b[6]);
text(out,",\"L.packet\":");
byte_json(out,m->b[7]);
text(out,",\"L.udp_length\":");
number(out,m->v[11]);
text(out,",\"L.ip_length\":");
number(out,m->v[12]);
text(out,",\"L.udp_raw_checksum\":");
number(out,m->v[13]);
text(out,",\"L.udp_checksum\":");
number(out,m->v[14]);
text(out,",\"L.ip_checksum\":");
number(out,m->v[15]);
text(out,",\"L.pending_packet\":");
byte_json(out,m->b[8]);
text(out,",\"L.rxudp_require_checksum\":");
text(out,m->v[17]?"true":"false");
text(out,",\"L.rxudp_payload\":");
byte_json(out,m->b[9]);
text(out,",\"L.rxudp_disposition\":");
text(out,source_json(m->v[19]));
text(out,",\"L.echo_reply\":");
byte_json(out,m->b[10]);
text(out,",\"L.echo_icmp_zero\":");
byte_json(out,m->b[11]);
text(out,",\"L.echo_icmp_wire\":");
byte_json(out,m->b[12]);
text(out,",\"L.echo_ip_zero\":");
byte_json(out,m->b[13]);
text(out,",\"L.echo_disposition\":");
text(out,source_json(m->v[24]));
text(out,",\"L.control\":");
text(out,source_json(m->v[25]));
text(out,",\"T.iss\":");
number(out,m->v[26]);
text(out,",\"T.irs\":");
number(out,m->v[27]);
text(out,",\"T.snd_una\":");
number(out,m->v[28]);
text(out,",\"T.snd_nxt\":");
number(out,m->v[29]);
text(out,",\"T.rcv_nxt\":");
number(out,m->v[30]);
text(out,",\"T.tx_seq\":");
number(out,m->v[31]);
text(out,",\"T.tx_ack\":");
number(out,m->v[32]);
text(out,",\"T.tx_flags\":");
text(out,source_json(m->v[33]));
text(out,",\"T.rto_ms\":");
number(out,m->v[34]);
text(out,",\"T.retries\":");
number(out,m->v[35]);
text(out,",\"T.active_open\":");
text(out,m->v[36]?"true":"false");
text(out,",\"T.user_timeout_ms\":");
number(out,m->v[37]);
text(out,",\"T.msl_ms\":");
number(out,m->v[38]);
text(out,",\"T.local_window\":");
number(out,m->v[39]);
text(out,",\"T.snd_buf\":");
byte_json(out,m->b[14]);
text(out,",\"T.rtx_buf\":");
byte_json(out,m->b[15]);
text(out,",\"T.rcv_buf\":");
byte_json(out,m->b[16]);
text(out,",\"T.snd_wnd\":");
number(out,m->v[43]);
text(out,",\"T.snd_wl1\":");
number(out,m->v[44]);
text(out,",\"T.snd_wl2\":");
number(out,m->v[45]);
text(out,",\"T.take\":");
number(out,m->v[46]);
text(out,",\"T.rx_chunk\":");
byte_json(out,m->b[17]);
text(out,",\"T.wire_data\":");
byte_json(out,m->b[18]);
text(out,",\"T.wire_tcp_zero\":");
byte_json(out,m->b[19]);
text(out,",\"T.wire_pseudo\":");
byte_json(out,m->b[20]);
text(out,",\"T.wire_tcp\":");
byte_json(out,m->b[21]);
text(out,",\"T.wire_ip_zero\":");
byte_json(out,m->b[22]);
text(out,",\"T.wire_packet\":");
byte_json(out,m->b[23]);
text(out,",\"T.wire_flags\":");
number(out,m->v[54]);
text(out,",\"T.wire_disposition\":");
text(out,source_json(m->v[55]));
text(out,",\"T.control\":");
text(out,source_json(m->v[56]));
text(out,",\"ip_pending_owner\":");
text(out,source_json(m->v[57]));
text(out,"},\"timers\":{");
if(m->active[0]) { if(!first)text(out,",");first=0;
text(out,"\"L.query\":");
number(out,m->due[0]);}
if(m->active[1]) { if(!first)text(out,",");first=0;
text(out,"\"L.cache\":");
number(out,m->due[1]);}
if(m->active[2]) { if(!first)text(out,",");first=0;
text(out,"\"T.rtx\":");
number(out,m->due[2]);}
if(m->active[3]) { if(!first)text(out,",");first=0;
text(out,"\"T.user\":");
number(out,m->due[3]);}
if(m->active[4]) { if(!first)text(out,",");first=0;
text(out,"\"T.time_wait\":");
number(out,m->due[4]);}
(void)first;
text(out,"}}");
}
static int rule_guard_0(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&(byte_equal(bf[0],byte_literal((const unsigned char[]){192,0,2,2},4)))); }
static int rule_guard_1(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&(byte_equal(bf[0],byte_literal((const unsigned char[]){192,0,2,2},4)))); }
static int rule_guard_2(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&(byte_equal(bf[0],byte_literal((const unsigned char[]){192,0,2,2},4)))); }
static int rule_guard_3(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&(m->v[1]==INT64_C(0))); }
static int rule_guard_4(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&1); }
static int rule_guard_5(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&((f[0]>=INT64_C(60000))&&(f[0]<=INT64_C(3600000)))); }
static int rule_guard_6(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&(((int64_t)(bf[0]).len)<=INT64_C(41))); }
static int rule_guard_7(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_467(m,f,bf)); }
static int rule_guard_8(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_468(m,f,bf)); }
static int rule_guard_9(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_448(m,f,bf)); }
static int rule_guard_10(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&((f[0]>=INT64_C(60000))&&(f[0]<=INT64_C(3600000)))); }
static int rule_guard_11(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&(((int64_t)(bf[0]).len)<=INT64_C(41))); }
static int rule_guard_12(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_448(m,f,bf)); }
static int rule_guard_13(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&((f[0]>=INT64_C(60000))&&(f[0]<=INT64_C(3600000)))); }
static int rule_guard_14(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&(((int64_t)(bf[0]).len)<=INT64_C(41))); }
static int rule_guard_15(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_467(m,f,bf)); }
static int rule_guard_16(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_468(m,f,bf)); }
static int rule_guard_17(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_448(m,f,bf)); }
static int rule_guard_18(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&(((int64_t)(bf[0]).len)<=INT64_C(1472))); }
static int rule_guard_19(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&1); }
static int rule_guard_20(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&(((int64_t)(bf[0]).len)<=INT64_C(1472))); }
static int rule_guard_21(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&1); }
static int rule_guard_22(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&(((int64_t)(bf[0]).len)<=INT64_C(1472))); }
static int rule_guard_23(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&1); }
static int rule_guard_24(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_3(m,f,bf)&&(m->v[57]==21)); }
static int rule_guard_25(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_3(m,f,bf)&&(m->v[57]==19)); }
static int rule_guard_26(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&((m->v[1]==INT64_C(1))&&(((int64_t)(m->b[8]).len)==INT64_C(0)))); }
static int rule_guard_27(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&(shared_expr_467(m,f,bf)&&(((int64_t)(m->b[8]).len)>=INT64_C(28)))); }
static int rule_guard_28(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&(shared_expr_467(m,f,bf)&&(((int64_t)(m->b[8]).len)==INT64_C(0)))); }
static int rule_guard_29(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&(shared_expr_468(m,f,bf)&&(((int64_t)(m->b[8]).len)>=INT64_C(28)))); }
static int rule_guard_30(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&(shared_expr_468(m,f,bf)&&(((int64_t)(m->b[8]).len)==INT64_C(0)))); }
static int rule_guard_31(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_528(m,f,bf)); }
static int rule_guard_32(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_548(m,f,bf)); }
static int rule_guard_33(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_551(m,f,bf)); }
static int rule_guard_34(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_562(m,f,bf)); }
static int rule_guard_35(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_564(m,f,bf)); }
static int rule_guard_36(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&1); }
static int rule_guard_37(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_450(m,f,bf)); }
static int rule_guard_38(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_528(m,f,bf)); }
static int rule_guard_39(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_548(m,f,bf)); }
static int rule_guard_40(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_551(m,f,bf)); }
static int rule_guard_41(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_562(m,f,bf)); }
static int rule_guard_42(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_564(m,f,bf)); }
static int rule_guard_43(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&1); }
static int rule_guard_44(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_450(m,f,bf)); }
static int rule_guard_45(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_528(m,f,bf)); }
static int rule_guard_46(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_548(m,f,bf)); }
static int rule_guard_47(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_551(m,f,bf)); }
static int rule_guard_48(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_562(m,f,bf)); }
static int rule_guard_49(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_564(m,f,bf)); }
static int rule_guard_50(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&1); }
static int rule_guard_51(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_450(m,f,bf)); }
static int rule_guard_52(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_550(m,f,bf)); }
static int rule_guard_53(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_554(m,f,bf)); }
static int rule_guard_54(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_553(m,f,bf)); }
static int rule_guard_55(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==4)&&shared_expr_446(m,f,bf)); }
static int rule_guard_56(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_550(m,f,bf)); }
static int rule_guard_57(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_554(m,f,bf)); }
static int rule_guard_58(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_553(m,f,bf)); }
static int rule_guard_59(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==11)&&shared_expr_446(m,f,bf)); }
static int rule_guard_60(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_550(m,f,bf)); }
static int rule_guard_61(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_554(m,f,bf)); }
static int rule_guard_62(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_553(m,f,bf)); }
static int rule_guard_63(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[25]==14)&&shared_expr_446(m,f,bf)); }
static int rule_guard_64(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&1)&&(m->v[25]==4)); }
static int rule_guard_65(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&1)&&(m->v[25]==11)); }
static int rule_guard_66(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&1)&&(m->v[25]==14)); }
static int rule_guard_67(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==2)&&1); }
static int rule_guard_68(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_621(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_69(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_621(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_70(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_621(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_71(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_622(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_72(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_622(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_73(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_622(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_74(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_640(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_75(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_640(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_76(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_640(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_77(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&(shared_expr_576(m,f,bf)&&((shared_expr_482(m,f,bf)&&(m->v[35]==INT64_C(0)))&&shared_expr_372(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_78(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_652(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_79(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_652(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_80(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_652(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_81(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_641(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_82(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_641(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_83(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_641(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_84(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&(shared_expr_576(m,f,bf)&&((shared_expr_482(m,f,bf)&&(m->v[35]==INT64_C(1)))&&shared_expr_372(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_85(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_653(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_86(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_653(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_87(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_653(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_88(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_642(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_89(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_642(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_90(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_642(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_91(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&(shared_expr_576(m,f,bf)&&((shared_expr_482(m,f,bf)&&(m->v[35]>=INT64_C(2)))&&shared_expr_372(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_92(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_654(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_93(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_654(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_94(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_654(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_95(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_639(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_96(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_639(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_97(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_639(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_98(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_638(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_99(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_638(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_100(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_638(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_101(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&(shared_expr_576(m,f,bf)&&shared_expr_380(m,f,bf)))&&shared_expr_506(m,f,bf)); }
static int rule_guard_102(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_648(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_103(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_648(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_104(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_648(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_105(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_119(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_106(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_119(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_107(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_119(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_108(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&1)&&(m->v[25]==4)); }
static int rule_guard_109(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&1)&&(m->v[25]==11)); }
static int rule_guard_110(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&1)&&(m->v[25]==14)); }
static int rule_guard_111(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==10)&&1); }
static int rule_guard_112(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&1); }
static int rule_guard_113(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==7)&&1); }
static int rule_guard_114(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==8)&&1); }
static int rule_guard_115(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==3)&&1); }
static int rule_guard_116(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==9)&&1); }
static int rule_guard_117(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==20)&&1); }
static int rule_guard_118(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&shared_expr_609(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_119(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&shared_expr_609(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_120(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_609(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_121(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_608(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_122(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_609(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_123(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_608(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_124(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_609(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_125(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_608(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_126(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_649(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_127(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_649(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_128(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_649(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_129(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_647(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_130(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_647(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_131(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_647(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_132(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_646(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_133(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_646(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_134(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_646(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_135(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_645(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_136(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_645(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_137(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_645(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_138(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_655(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_139(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_655(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_140(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_655(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_141(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_656(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_142(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_656(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_143(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_656(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_144(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_657(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_145(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_657(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_146(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_657(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_147(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_658(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_148(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_658(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_149(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_658(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_150(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&1)&&(m->v[25]==4)); }
static int rule_guard_151(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&1)&&(m->v[25]==11)); }
static int rule_guard_152(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&1)&&(m->v[25]==14)); }
static int rule_guard_153(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&1)&&(m->v[25]==4)); }
static int rule_guard_154(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&1)&&(m->v[25]==11)); }
static int rule_guard_155(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&1)&&(m->v[25]==14)); }
static int rule_guard_156(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&1)&&(m->v[25]==4)); }
static int rule_guard_157(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&1)&&(m->v[25]==11)); }
static int rule_guard_158(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&1)&&(m->v[25]==14)); }
static int rule_guard_159(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&1)&&(m->v[25]==4)); }
static int rule_guard_160(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&1)&&(m->v[25]==11)); }
static int rule_guard_161(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&1)&&(m->v[25]==14)); }
static int rule_guard_162(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&1)&&(m->v[25]==4)); }
static int rule_guard_163(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&1)&&(m->v[25]==11)); }
static int rule_guard_164(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&1)&&(m->v[25]==14)); }
static int rule_guard_165(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&1); }
static int rule_guard_166(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==17)&&1); }
static int rule_guard_167(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==7)&&1); }
static int rule_guard_168(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==8)&&1); }
static int rule_guard_169(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==3)&&1); }
static int rule_guard_170(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==9)&&1); }
static int rule_guard_171(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==20)&&1); }
static int rule_guard_172(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==2)&&1); }
static int rule_guard_173(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==10)&&1); }
static int rule_guard_174(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==18)&&1); }
static int rule_guard_175(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&1)&&(m->v[25]==4)); }
static int rule_guard_176(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&1)&&(m->v[25]==11)); }
static int rule_guard_177(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&1)&&(m->v[25]==14)); }
static int rule_guard_178(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&1)&&(m->v[25]==4)); }
static int rule_guard_179(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&1)&&(m->v[25]==11)); }
static int rule_guard_180(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&1)&&(m->v[25]==14)); }
static int rule_guard_181(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&1)&&(m->v[25]==4)); }
static int rule_guard_182(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&1)&&(m->v[25]==11)); }
static int rule_guard_183(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&1)&&(m->v[25]==14)); }
static int rule_guard_184(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&1)&&(m->v[25]==4)); }
static int rule_guard_185(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&1)&&(m->v[25]==11)); }
static int rule_guard_186(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&1)&&(m->v[25]==14)); }
static int rule_guard_187(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&1)&&(m->v[25]==4)); }
static int rule_guard_188(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&1)&&(m->v[25]==11)); }
static int rule_guard_189(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&1)&&(m->v[25]==14)); }
static int rule_guard_190(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==3)&&1); }
static int rule_guard_191(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==9)&&1); }
static int rule_guard_192(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==20)&&1); }
static int rule_guard_193(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&shared_expr_580(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_194(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==10)&&shared_expr_580(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_195(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&shared_expr_580(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_196(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&(shared_expr_575(m,f,bf)&&shared_expr_393(m,f,bf)))&&shared_expr_506(m,f,bf)); }
static int rule_guard_197(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&(shared_expr_575(m,f,bf)&&shared_expr_394(m,f,bf)))&&shared_expr_506(m,f,bf)); }
static int rule_guard_198(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&shared_expr_597(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_199(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_597(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_200(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&shared_expr_597(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_201(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&shared_expr_597(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_202(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_597(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_203(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_597(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_204(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==20)&&shared_expr_597(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_205(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&shared_expr_583(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_206(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==10)&&shared_expr_583(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_207(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&(shared_expr_578(m,f,bf)&&shared_expr_380(m,f,bf)))&&shared_expr_506(m,f,bf)); }
static int rule_guard_208(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&(shared_expr_578(m,f,bf)&&shared_expr_393(m,f,bf)))&&shared_expr_506(m,f,bf)); }
static int rule_guard_209(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&(shared_expr_578(m,f,bf)&&shared_expr_394(m,f,bf)))&&shared_expr_506(m,f,bf)); }
static int rule_guard_210(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&shared_expr_599(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_211(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_599(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_212(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&shared_expr_599(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_213(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&shared_expr_599(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_214(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_599(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_215(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_599(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_216(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==20)&&shared_expr_599(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_217(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_623(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_218(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_623(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_219(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_623(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_220(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_625(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_221(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_625(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_222(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_625(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_223(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_618(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_224(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_618(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_225(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_618(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_226(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_619(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_227(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_619(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_228(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_619(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_229(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_624(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_230(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_624(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_231(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_624(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_232(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_626(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_233(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_626(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_234(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_626(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_235(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_620(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_236(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_620(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_237(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_620(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_238(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&((1&&(((int64_t)(bf[0]).len)>=INT64_C(1)))&&(shared_expr_4(m,f,bf)<=INT64_C(16)))); }
static int rule_guard_239(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&(((int64_t)(bf[0]).len)==INT64_C(0))); }
static int rule_guard_240(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&(shared_expr_4(m,f,bf)>=INT64_C(17))); }
static int rule_guard_241(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_167(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_242(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_167(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_243(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_167(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_244(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_168(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_245(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_168(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_246(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_168(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_247(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return ((m->v[56]==5)&&(!shared_expr_27(m,f,bf))); }
static int rule_guard_248(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(shared_expr_576(m,f,bf)&&(shared_expr_592(m,f,bf)&&shared_expr_541(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_249(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(shared_expr_576(m,f,bf)&&(shared_expr_592(m,f,bf)&&shared_expr_542(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_250(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(shared_expr_576(m,f,bf)&&(shared_expr_593(m,f,bf)&&shared_expr_541(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_251(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(shared_expr_576(m,f,bf)&&(shared_expr_593(m,f,bf)&&shared_expr_542(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_252(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(shared_expr_576(m,f,bf)&&(shared_expr_555(m,f,bf)&&shared_expr_541(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_253(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(shared_expr_576(m,f,bf)&&(shared_expr_555(m,f,bf)&&shared_expr_542(m,f,bf))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_254(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(shared_expr_576(m,f,bf)&&(shared_expr_540(m,f,bf)&&(distance(shared_expr_374(m,f,bf),m->v[28])>0&&distance(shared_expr_374(m,f,bf),m->v[28])<INT64_C(2147483648)))))&&shared_expr_506(m,f,bf)); }
static int rule_guard_255(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_667(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_256(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_667(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_257(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_667(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_258(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(((int64_t)(m->b[15]).len)>=INT64_C(1)))&&(m->v[25]==4)); }
static int rule_guard_259(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(((int64_t)(m->b[15]).len)>=INT64_C(1)))&&(m->v[25]==11)); }
static int rule_guard_260(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(((int64_t)(m->b[15]).len)>=INT64_C(1)))&&(m->v[25]==14)); }
static int rule_guard_261(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_665(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_262(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_665(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_263(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_665(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_264(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_669(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_265(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_669(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_266(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_669(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_267(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_668(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_268(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_668(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_269(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_668(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_270(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_666(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_271(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_666(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_272(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_666(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_273(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_672(m,f,bf)&&(m->v[25]==4)); }
static int rule_guard_274(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_672(m,f,bf)&&(m->v[25]==11)); }
static int rule_guard_275(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (shared_expr_672(m,f,bf)&&(m->v[25]==14)); }
static int rule_guard_276(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(f[0]>=INT64_C(1)))&&(m->v[25]==4)); }
static int rule_guard_277(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(f[0]>=INT64_C(1)))&&(m->v[25]==11)); }
static int rule_guard_278(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&(f[0]>=INT64_C(1)))&&(m->v[25]==14)); }
static int rule_guard_279(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_280(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_281(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_282(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_283(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==2)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_284(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==10)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_285(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==10)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_286(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==10)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_287(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==10)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_288(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==10)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_289(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_290(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_291(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_292(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_293(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==18)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_294(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_295(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_296(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_297(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_298(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==17)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_299(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_300(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_301(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_302(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_303(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==5)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_304(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_305(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_306(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_307(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_308(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==7)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_309(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_310(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_311(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_312(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_313(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==8)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_314(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_315(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_316(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_317(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_318(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==1)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_319(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_320(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_321(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_322(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_323(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==3)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_324(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_325(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_326(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_327(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_328(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==9)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_329(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==20)&&shared_expr_150(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_330(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==20)&&shared_expr_511(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_331(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==20)&&shared_expr_515(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_332(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==20)&&shared_expr_531(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_333(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((m->v[56]==20)&&shared_expr_569(m,f,bf))&&shared_expr_506(m,f,bf)); }
static int rule_guard_334(Machine *m,int64_t *f,Bytes *bf) { (void)m; (void)f; (void)bf; return (((((((((((((((((((int64_t)(bf[0]).len)>=INT64_C(60))&&(((int64_t)(bf[0]).len)<=INT64_C(1514)))&&shared_expr_35(m,f,bf))&&shared_expr_36(m,f,bf))&&shared_expr_21(m,f,bf))&&(byte_at_or_zero(bf[0],INT64_C(14))==INT64_C(69)))&&(byte_at_or_zero(bf[0],INT64_C(15))==INT64_C(0)))&&(byte_at_or_zero(bf[0],INT64_C(20))==INT64_C(64)))&&(byte_at_or_zero(bf[0],INT64_C(21))==INT64_C(0)))&&(byte_at_or_zero(bf[0],INT64_C(22))>=INT64_C(1)))&&(byte_at_or_zero(bf[0],INT64_C(22))<=INT64_C(255)))&&(byte_at_or_zero(bf[0],INT64_C(23))==INT64_C(6)))&&shared_expr_30(m,f,bf))&&shared_expr_32(m,f,bf))&&(byte_equal(byte_slice(bf[0],INT64_C(34),INT64_C(2)),byte_literal((const unsigned char[]){31,144},2))))&&(byte_equal(byte_slice(bf[0],INT64_C(36),INT64_C(2)),byte_literal((const unsigned char[]){156,64},2))))&&(shared_expr_43(m,f,bf)&&((shared_expr_6(m,f,bf)<=INT64_C(39))||(shared_expr_6(m,f,bf)>=sub(((int64_t)(bf[0]).len),INT64_C(13)))))); }
static int rule_action_0(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.QUERY-START\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.resolve\",\"fields\":{");
text(log,"\"ip\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_1(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.QUERY-COALESCE\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.resolve\",\"fields\":{");
text(log,"\"ip\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_2(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.neighbor.resolved\",\"fields\":{");
text(&messages,"\"ip\":");
byte_json(&messages,byte_literal((const unsigned char[]){192,0,2,2},4));
text(&messages,",\"mac\":");
byte_json(&messages,m->b[0]);
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.QUERY-CACHED\",\"requirements\":[\"L.ARP-826\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.resolve\",\"fields\":{");
text(log,"\"ip\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_3(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[1]=INT64_C(1);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.QUERY-RETRY\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.timer.query\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_4(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.CACHE-EXPIRE\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.timer.cache\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_5(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[2]=f[0];
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.CONFIG-EMPTY\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.cache_ttl\",\"fields\":{");
text(log,"\"milliseconds\":");
number(log,f[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_6(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.SHORT-EMPTY\",\"requirements\":[\"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_7(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
if(1)m->active[0]=0;
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_342(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.LOCAL-REQUEST-EMPTY\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_8(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
if(1)m->active[0]=0;
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.LOCAL-REPLY-EMPTY\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_9(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.NONLOCAL-EMPTY\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_10(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[2]=f[0];
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.CONFIG-PENDING\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.cache_ttl\",\"fields\":{");
text(log,"\"milliseconds\":");
number(log,f[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_11(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.SHORT-PENDING\",\"requirements\":[\"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_12(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.NONLOCAL-PENDING\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_13(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[2]=f[0];
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.CONFIG-RESOLVED\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.cache_ttl\",\"fields\":{");
text(log,"\"milliseconds\":");
number(log,f[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_14(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.SHORT-RESOLVED\",\"requirements\":[\"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_15(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
if(1)m->active[0]=0;
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_342(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.LOCAL-REQUEST-RESOLVED\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_16(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
if(1)m->active[0]=0;
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.LOCAL-REPLY-RESOLVED\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_17(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.NONLOCAL-RESOLVED\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_18(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[1]=bf[0];
if(failure)return 0;
m->v[11]=add(INT64_C(8),((int64_t)(m->b[1]).len));
if(failure)return 0;
m->v[12]=add(INT64_C(20),m->v[11]);
if(failure)return 0;
m->b[2]=shared_expr_202(m,f,bf);
if(failure)return 0;
m->b[3]=shared_expr_219(m,f,bf);
if(failure)return 0;
m->v[13]=byte_checksum16(byte_concat(m->b[3],m->b[2]));
if(failure)return 0;
m->v[14]=(m->v[3]?((m->v[13]==INT64_C(0))?INT64_C(65535):m->v[13]):INT64_C(0));
if(failure)return 0;
m->b[4]=shared_expr_18(m,f,bf);
if(failure)return 0;
m->b[5]=shared_expr_254(m,f,bf);
if(failure)return 0;
m->v[15]=byte_checksum16(m->b[5]);
if(failure)return 0;
m->b[6]=shared_expr_71(m,f,bf);
if(failure)return 0;
m->b[7]=byte_concat(m->b[6],m->b[4]);
if(failure)return 0;
m->b[8]=m->b[7];
if(failure)return 0;
m->v[57]=21;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDP-SEND-EMPTY\",\"requirements\":[\"L.UDP-WIRE\", \"L.UDP-DEFAULT\", \"L.IP-WIRE\", \"L.ATOMIC-ID\", \"L.PROFILE\", \"L.COMPOSED-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.ETH-IP\", \"L.ETH-ERRATA\", \"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.send\",\"fields\":{");
text(log,"\"data\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_19(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[3]=f[0];
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDP-CHECKSUM-EMPTY\",\"requirements\":[\"L.UDP-DEFAULT\", \"L.COMPOSED-PROFILE\", \"L.ARP-PACKET-QUEUE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.configure_checksum\",\"fields\":{");
text(log,"\"enabled\":");
text(log,f[0]?"true":"false");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_20(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[1]=bf[0];
if(failure)return 0;
m->v[11]=add(INT64_C(8),((int64_t)(m->b[1]).len));
if(failure)return 0;
m->v[12]=add(INT64_C(20),m->v[11]);
if(failure)return 0;
m->b[2]=shared_expr_202(m,f,bf);
if(failure)return 0;
m->b[3]=shared_expr_219(m,f,bf);
if(failure)return 0;
m->v[13]=byte_checksum16(byte_concat(m->b[3],m->b[2]));
if(failure)return 0;
m->v[14]=(m->v[3]?((m->v[13]==INT64_C(0))?INT64_C(65535):m->v[13]):INT64_C(0));
if(failure)return 0;
m->b[4]=shared_expr_18(m,f,bf);
if(failure)return 0;
m->b[5]=shared_expr_254(m,f,bf);
if(failure)return 0;
m->v[15]=byte_checksum16(m->b[5]);
if(failure)return 0;
m->b[6]=shared_expr_71(m,f,bf);
if(failure)return 0;
m->b[7]=byte_concat(m->b[6],m->b[4]);
if(failure)return 0;
m->b[8]=m->b[7];
if(failure)return 0;
m->v[57]=21;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDP-SEND-PENDING\",\"requirements\":[\"L.UDP-WIRE\", \"L.UDP-DEFAULT\", \"L.IP-WIRE\", \"L.ATOMIC-ID\", \"L.PROFILE\", \"L.COMPOSED-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.ETH-IP\", \"L.ETH-ERRATA\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.send\",\"fields\":{");
text(log,"\"data\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_21(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[3]=f[0];
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDP-CHECKSUM-PENDING\",\"requirements\":[\"L.UDP-DEFAULT\", \"L.COMPOSED-PROFILE\", \"L.ARP-PACKET-QUEUE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.configure_checksum\",\"fields\":{");
text(log,"\"enabled\":");
text(log,f[0]?"true":"false");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_22(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[1]=bf[0];
if(failure)return 0;
m->v[11]=add(INT64_C(8),((int64_t)(m->b[1]).len));
if(failure)return 0;
m->v[12]=add(INT64_C(20),m->v[11]);
if(failure)return 0;
m->b[2]=shared_expr_202(m,f,bf);
if(failure)return 0;
m->b[3]=shared_expr_219(m,f,bf);
if(failure)return 0;
m->v[13]=byte_checksum16(byte_concat(m->b[3],m->b[2]));
if(failure)return 0;
m->v[14]=(m->v[3]?((m->v[13]==INT64_C(0))?INT64_C(65535):m->v[13]):INT64_C(0));
if(failure)return 0;
m->b[4]=shared_expr_18(m,f,bf);
if(failure)return 0;
m->b[5]=shared_expr_254(m,f,bf);
if(failure)return 0;
m->v[15]=byte_checksum16(m->b[5]);
if(failure)return 0;
m->b[6]=shared_expr_71(m,f,bf);
if(failure)return 0;
m->b[7]=byte_concat(m->b[6],m->b[4]);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,byte_concat(byte_concat(byte_concat(m->b[0],byte_literal((const unsigned char[]){2,0,0,0,0,1,8,0},8)),m->b[7]),byte_slice(byte_literal((const unsigned char[]){0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},18),INT64_C(0),((((int64_t)(m->b[7]).len)<=INT64_C(45))?sub(INT64_C(46),((int64_t)(m->b[7]).len)):INT64_C(0)))));
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDP-SEND-RESOLVED\",\"requirements\":[\"L.UDP-WIRE\", \"L.UDP-DEFAULT\", \"L.IP-WIRE\", \"L.ATOMIC-ID\", \"L.PROFILE\", \"L.COMPOSED-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.ETH-IP\", \"L.ETH-ERRATA\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.send\",\"fields\":{");
text(log,"\"data\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_23(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[3]=f[0];
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDP-CHECKSUM-RESOLVED\",\"requirements\":[\"L.UDP-DEFAULT\", \"L.COMPOSED-PROFILE\", \"L.ARP-PACKET-QUEUE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.configure_checksum\",\"fields\":{");
text(log,"\"enabled\":");
text(log,f[0]?"true":"false");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_24(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.neighbor.failed\",\"fields\":{");
text(&messages,"\"ip\":");
byte_json(&messages,byte_literal((const unsigned char[]){192,0,2,2},4));
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.udp.send_failed\",\"fields\":{");
text(&messages,"\"reason\":");
text(&messages,source_json(24));
text(&messages,"}}");
}
if(failure)return 0;
m->b[8]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[57]=38;
if(failure)return 0;
m->v[57]=38;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.QUERY-FAIL-QUEUED-UDP\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.COMPOSED-PROFILE\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.timer.query\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_25(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.neighbor.failed\",\"fields\":{");
text(&messages,"\"ip\":");
byte_json(&messages,byte_literal((const unsigned char[]){192,0,2,2},4));
text(&messages,"}}");
}
if(failure)return 0;
m->b[8]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[57]=38;
if(failure)return 0;
m->v[57]=38;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.QUERY-FAIL-QUEUED-TCP\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.COMPOSED-PROFILE\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.timer.query\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_26(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.neighbor.failed\",\"fields\":{");
text(&messages,"\"ip\":");
byte_json(&messages,byte_literal((const unsigned char[]){192,0,2,2},4));
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.QUERY-FAIL-UNQUEUED\",\"requirements\":[\"L.ARP-CACHE\", \"L.ARP-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.COMPOSED-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.timer.query\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_27(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
if(1)m->active[0]=0;
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_342(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.neighbor.resolved\",\"fields\":{");
text(&messages,"\"ip\":");
byte_json(&messages,byte_literal((const unsigned char[]){192,0,2,2},4));
text(&messages,",\"mac\":");
byte_json(&messages,m->b[0]);
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_266(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->b[8]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[57]=38;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.LOCAL-REQUEST-PENDING-QUEUED\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.COMPOSED-PROFILE\", \"L.ETH-IP\", \"L.ETH-ERRATA\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_28(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
if(1)m->active[0]=0;
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_342(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.neighbor.resolved\",\"fields\":{");
text(&messages,"\"ip\":");
byte_json(&messages,byte_literal((const unsigned char[]){192,0,2,2},4));
text(&messages,",\"mac\":");
byte_json(&messages,m->b[0]);
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.LOCAL-REQUEST-PENDING-UNQUEUED\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.COMPOSED-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_29(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
if(1)m->active[0]=0;
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.neighbor.resolved\",\"fields\":{");
text(&messages,"\"ip\":");
byte_json(&messages,byte_literal((const unsigned char[]){192,0,2,2},4));
text(&messages,",\"mac\":");
byte_json(&messages,m->b[0]);
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_266(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->b[8]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[57]=38;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.LOCAL-REPLY-PENDING-QUEUED\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.COMPOSED-PROFILE\", \"L.ETH-IP\", \"L.ETH-ERRATA\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_30(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[0]=byte_slice(bf[0],INT64_C(22),INT64_C(6));
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
if(1)m->active[0]=0;
if(failure)return 0;
{
int64_t delay=m->v[2]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[1]=add(m->now,delay);m->active[1]=1;}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.neighbor.resolved\",\"fields\":{");
text(&messages,"\"ip\":");
byte_json(&messages,byte_literal((const unsigned char[]){192,0,2,2},4));
text(&messages,",\"mac\":");
byte_json(&messages,m->b[0]);
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.LOCAL-REPLY-PENDING-UNQUEUED\",\"requirements\":[\"L.ARP-826\", \"L.ARP-CACHE\", \"L.ARP-PROFILE\", \"L.ARP-PACKET-QUEUE\", \"L.COMPOSED-PROFILE\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_31(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=30;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-IP_CHECKSUM-EMPTY\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-IP-CHECKSUM\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_32(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=36;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-UDP_LENGTH-EMPTY\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-LENGTH\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_33(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=28;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-ABSENT_REQUIRED-EMPTY\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_34(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=35;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-UDP_CHECKSUM-EMPTY\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-UDP-PSEUDO\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_35(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=shared_expr_351(m,f,bf);
if(failure)return 0;
m->v[19]=27;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.udp.rx\",\"fields\":{");
text(&messages,"\"data\":");
byte_json(&messages,m->b[9]);
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-DELIVER-EMPTY\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-LENGTH\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-UDP-PSEUDO\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_36(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[17]=f[0];
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-POLICY-EMPTY\",\"requirements\":[\"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-RX-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.require_checksum\",\"fields\":{");
text(log,"\"required\":");
text(log,f[0]?"true":"false");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_37(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=31;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-FRAME-IP-LENGTH-EMPTY\",\"requirements\":[\"L.UDPRX-IP-LENGTH\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_38(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=30;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-IP_CHECKSUM-PENDING\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-IP-CHECKSUM\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_39(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=36;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-UDP_LENGTH-PENDING\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-LENGTH\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_40(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=28;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-ABSENT_REQUIRED-PENDING\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_41(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=35;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-UDP_CHECKSUM-PENDING\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-UDP-PSEUDO\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_42(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=shared_expr_351(m,f,bf);
if(failure)return 0;
m->v[19]=27;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.udp.rx\",\"fields\":{");
text(&messages,"\"data\":");
byte_json(&messages,m->b[9]);
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-DELIVER-PENDING\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-LENGTH\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-UDP-PSEUDO\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_43(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[17]=f[0];
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-POLICY-PENDING\",\"requirements\":[\"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-RX-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.require_checksum\",\"fields\":{");
text(log,"\"required\":");
text(log,f[0]?"true":"false");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_44(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=31;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-FRAME-IP-LENGTH-PENDING\",\"requirements\":[\"L.UDPRX-IP-LENGTH\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_45(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=30;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-IP_CHECKSUM-RESOLVED\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-IP-CHECKSUM\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_46(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=36;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-UDP_LENGTH-RESOLVED\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-LENGTH\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_47(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=28;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-ABSENT_REQUIRED-RESOLVED\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_48(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=35;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-UDP_CHECKSUM-RESOLVED\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-UDP-PSEUDO\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_49(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=shared_expr_351(m,f,bf);
if(failure)return 0;
m->v[19]=27;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.udp.rx\",\"fields\":{");
text(&messages,"\"data\":");
byte_json(&messages,m->b[9]);
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-DELIVER-RESOLVED\",\"requirements\":[\"L.UDPRX-RX-PROFILE\", \"L.UDPRX-UDP-LENGTH\", \"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-UDP-PSEUDO\", \"L.UDPRX-IP-ATOMIC-ID\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_50(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[17]=f[0];
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-POLICY-RESOLVED\",\"requirements\":[\"L.UDPRX-UDP-CHECKSUM\", \"L.UDPRX-RX-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.app.require_checksum\",\"fields\":{");
text(log,"\"required\":");
text(log,f[0]?"true":"false");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_51(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[9]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[19]=31;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.UDPRX-FRAME-IP-LENGTH-RESOLVED\",\"requirements\":[\"L.UDPRX-IP-LENGTH\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_52(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=30;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-IP_CHECKSUM-EMPTY\",\"requirements\":[\"L.ECHO-IP-CHECKSUM\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_53(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=29;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-ICMP_CHECKSUM-EMPTY\",\"requirements\":[\"L.ECHO-ICMP-CHECKSUM\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_54(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[11]=shared_expr_320(m,f,bf);
if(failure)return 0;
m->b[12]=shared_expr_259(m,f,bf);
if(failure)return 0;
m->b[13]=shared_expr_265(m,f,bf);
if(failure)return 0;
m->b[10]=shared_expr_199(m,f,bf);
if(failure)return 0;
m->v[24]=43;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_319(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-ECHO-EMPTY\",\"requirements\":[\"L.ECHO-ECHO-REPLY\", \"L.ECHO-ECHO-HOST\", \"L.ECHO-ICMP-CHECKSUM\", \"L.ECHO-IP-LENGTH\", \"L.ECHO-IP-ATOMIC\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_55(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=31;
if(failure)return 0;
m->v[25]=4;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-FRAME-IP-LENGTH-EMPTY\",\"requirements\":[\"L.ECHO-IP-LENGTH\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_56(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=30;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-IP_CHECKSUM-PENDING\",\"requirements\":[\"L.ECHO-IP-CHECKSUM\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_57(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=29;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-ICMP_CHECKSUM-PENDING\",\"requirements\":[\"L.ECHO-ICMP-CHECKSUM\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_58(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[11]=shared_expr_320(m,f,bf);
if(failure)return 0;
m->b[12]=shared_expr_259(m,f,bf);
if(failure)return 0;
m->b[13]=shared_expr_265(m,f,bf);
if(failure)return 0;
m->b[10]=shared_expr_199(m,f,bf);
if(failure)return 0;
m->v[24]=43;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_319(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-ECHO-PENDING\",\"requirements\":[\"L.ECHO-ECHO-REPLY\", \"L.ECHO-ECHO-HOST\", \"L.ECHO-ICMP-CHECKSUM\", \"L.ECHO-IP-LENGTH\", \"L.ECHO-IP-ATOMIC\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_59(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=31;
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-FRAME-IP-LENGTH-PENDING\",\"requirements\":[\"L.ECHO-IP-LENGTH\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_60(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=30;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-IP_CHECKSUM-RESOLVED\",\"requirements\":[\"L.ECHO-IP-CHECKSUM\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_61(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=29;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-ICMP_CHECKSUM-RESOLVED\",\"requirements\":[\"L.ECHO-ICMP-CHECKSUM\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_62(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[11]=shared_expr_320(m,f,bf);
if(failure)return 0;
m->b[12]=shared_expr_259(m,f,bf);
if(failure)return 0;
m->b[13]=shared_expr_265(m,f,bf);
if(failure)return 0;
m->b[10]=shared_expr_199(m,f,bf);
if(failure)return 0;
m->v[24]=43;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_319(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-ECHO-RESOLVED\",\"requirements\":[\"L.ECHO-ECHO-REPLY\", \"L.ECHO-ECHO-HOST\", \"L.ECHO-ICMP-CHECKSUM\", \"L.ECHO-IP-LENGTH\", \"L.ECHO-IP-ATOMIC\", \"L.ECHO-ECHO-PROFILE\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_63(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[10]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[11]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[12]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[13]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[24]=31;
if(failure)return 0;
m->v[25]=14;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"L.ECHO-FRAME-IP-LENGTH-RESOLVED\",\"requirements\":[\"L.ECHO-IP-LENGTH\", \"L.ENDPOINT-INGRESS\", \"L.ENDPOINT-LINK\", \"L.TAP-INTERFACE\", \"L.TAP-EXTENT\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_64(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
m->v[34]=INT64_C(1000);
if(failure)return 0;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[28]=m->v[26];
if(failure)return 0;
m->v[29]=seqadd(m->v[26],INT64_C(1));
if(failure)return 0;
m->v[36]=1;
if(failure)return 0;
m->v[33]=15;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=INT64_C(0);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACTIVE-OPEN-EMPTY\",\"requirements\":[\"T.CONN-OPEN\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.connect\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_65(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
m->v[34]=INT64_C(1000);
if(failure)return 0;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[28]=m->v[26];
if(failure)return 0;
m->v[29]=seqadd(m->v[26],INT64_C(1));
if(failure)return 0;
m->v[36]=1;
if(failure)return 0;
m->v[33]=15;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=INT64_C(0);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACTIVE-OPEN-PENDING\",\"requirements\":[\"T.CONN-OPEN\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.connect\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_66(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
m->v[34]=INT64_C(1000);
if(failure)return 0;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[28]=m->v[26];
if(failure)return 0;
m->v[29]=seqadd(m->v[26],INT64_C(1));
if(failure)return 0;
m->v[36]=1;
if(failure)return 0;
m->v[33]=15;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=INT64_C(0);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACTIVE-OPEN-RESOLVED\",\"requirements\":[\"T.CONN-OPEN\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.connect\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_67(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
m->v[36]=0;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PASSIVE-OPEN\",\"requirements\":[\"T.CONN-OPEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.listen\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_68(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[34]=INT64_C(1000);
if(failure)return 0;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[28]=m->v[26];
if(failure)return 0;
m->v[29]=seqadd(m->v[26],INT64_C(1));
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[33]=16;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-LISTEN-SYN-EMPTY\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_69(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[34]=INT64_C(1000);
if(failure)return 0;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[28]=m->v[26];
if(failure)return 0;
m->v[29]=seqadd(m->v[26],INT64_C(1));
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[33]=16;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-LISTEN-SYN-PENDING\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_70(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[34]=INT64_C(1000);
if(failure)return 0;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[28]=m->v[26];
if(failure)return 0;
m->v[29]=seqadd(m->v[26],INT64_C(1));
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[33]=16;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-LISTEN-SYN-RESOLVED\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_71(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[33]=16;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYN-EMPTY\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.CONN-SIMULTANEOUS\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_72(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[33]=16;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYN-PENDING\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.CONN-SIMULTANEOUS\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_73(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[33]=16;
if(failure)return 0;
m->v[31]=m->v[26];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYN-RESOLVED\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.CONN-SIMULTANEOUS\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_74(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-EMPTY\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_75(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-PENDING\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_76(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-RESOLVED\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_77(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-ACK\",\"requirements\":[\"T.CONN-ACK\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_78(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-EMPTY\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_79(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-PENDING\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_80(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-RESOLVED\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_81(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[34]=INT64_C(3000);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-AFTER-RETRY-EMPTY\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_82(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[34]=INT64_C(3000);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-AFTER-RETRY-PENDING\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_83(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[34]=INT64_C(3000);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-AFTER-RETRY-RESOLVED\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_84(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[34]=INT64_C(3000);
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-ACK-AFTER-RETRY\",\"requirements\":[\"T.CONN-ACK\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_85(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[34]=INT64_C(3000);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-AFTER-RETRY-EMPTY\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_86(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[34]=INT64_C(3000);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-AFTER-RETRY-PENDING\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_87(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[34]=INT64_C(3000);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-AFTER-RETRY-RESOLVED\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_88(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-AFTER-MULTIPLE-RETRIES-EMPTY\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_89(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-AFTER-MULTIPLE-RETRIES-PENDING\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_90(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[27]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-SYNACK-AFTER-MULTIPLE-RETRIES-RESOLVED\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_91(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ACCEPT-ACK-AFTER-MULTIPLE-RETRIES\",\"requirements\":[\"T.CONN-ACK\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_92(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-AFTER-MULTIPLE-RETRIES-EMPTY\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_93(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-AFTER-MULTIPLE-RETRIES-PENDING\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_94(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(26));
text(&messages,"}}");
}
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-SYNACK-AFTER-MULTIPLE-RETRIES-RESOLVED\",\"requirements\":[\"T.CONN-SIMULTANEOUS\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_95(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-BAD-ACK-EMPTY\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_96(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-BAD-ACK-PENDING\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_97(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-BAD-ACK-RESOLVED\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_98(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-BAD-SYNACK-EMPTY\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_99(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-BAD-SYNACK-PENDING\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_100(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-BAD-SYNACK-RESOLVED\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_101(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-BARE-ACK\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_102(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-RECEIVED-BAD-ACK-EMPTY\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_103(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-RECEIVED-BAD-ACK-PENDING\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_104(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-RECEIVED-BAD-ACK-RESOLVED\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_105(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[33]=6;
if(failure)return 0;
m->v[31]=m->v[29];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[29]=seqadd(m->v[29],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSE-ESTABLISHED-EMPTY\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_106(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[33]=6;
if(failure)return 0;
m->v[31]=m->v[29];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[29]=seqadd(m->v[29],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSE-ESTABLISHED-PENDING\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_107(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[33]=6;
if(failure)return 0;
m->v[31]=m->v[29];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[29]=seqadd(m->v[29],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSE-ESTABLISHED-RESOLVED\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_108(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[33]=6;
if(failure)return 0;
m->v[31]=m->v[29];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[29]=seqadd(m->v[29],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSE-CLOSE-WAIT-EMPTY\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_109(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[33]=6;
if(failure)return 0;
m->v[31]=m->v[29];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[29]=seqadd(m->v[29],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSE-CLOSE-WAIT-PENDING\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_110(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[35]=INT64_C(0);
if(failure)return 0;
m->v[33]=6;
if(failure)return 0;
m->v[31]=m->v[29];
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[29]=seqadd(m->v[29],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
{
int64_t delay=m->v[37]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[3]=add(m->now,delay);m->active[3]=1;}
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSE-CLOSE-WAIT-RESOLVED\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_111(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(25));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSE-LISTEN\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_112(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(25));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSE-SYN-SENT\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_113(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(23));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REPEATED-CLOSE-FIN-WAIT-1\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_114(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(23));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=8;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REPEATED-CLOSE-FIN-WAIT-2\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_115(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(23));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REPEATED-CLOSE-CLOSING\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_116(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(23));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REPEATED-CLOSE-LAST-ACK\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_117(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(23));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REPEATED-CLOSE-TIME-WAIT\",\"requirements\":[\"T.CONN-CLOSE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.close\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_118(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-ACK-CLOSE-WAIT\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_119(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=8;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-ACK-FIN-WAIT-2\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_120(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
m->v[56]=8;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-FIN-ACK-FIN-WAIT-1\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_121(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-OLD-ACK-FIN-WAIT-1\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_122(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-FIN-ACK-CLOSING\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_123(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-OLD-ACK-CLOSING\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_124(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(25));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-FIN-ACK-LAST-ACK\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_125(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-OLD-ACK-LAST-ACK\",\"requirements\":[\"T.CONN-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_126(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-EMPTY\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_127(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-PENDING\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_128(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-RESOLVED\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_129(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-FW2-EMPTY\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_130(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-FW2-PENDING\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_131(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-FW2-RESOLVED\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_132(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-FW1-ACKED-EMPTY\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_133(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-FW1-ACKED-PENDING\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_134(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-PEER-FIN-FW1-ACKED-RESOLVED\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_135(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-FIN-EMPTY\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_136(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-FIN-PENDING\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_137(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[30]=shared_expr_390(m,f,bf);
if(failure)return 0;
m->v[32]=m->v[30];
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(39));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SIMULTANEOUS-FIN-RESOLVED\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_138(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-CLOSE-WAIT-EMPTY\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_139(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-CLOSE-WAIT-PENDING\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_140(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-CLOSE-WAIT-RESOLVED\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_141(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-CLOSING-EMPTY\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_142(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-CLOSING-PENDING\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_143(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-CLOSING-RESOLVED\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_144(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-LAST-ACK-EMPTY\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_145(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-LAST-ACK-PENDING\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_146(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-LAST-ACK-RESOLVED\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_147(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-TIME-WAIT-EMPTY\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_148(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-TIME-WAIT-PENDING\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_149(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_322(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=mul(m->v[38],INT64_C(2)); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[4]=add(m->now,delay);m->active[4]=1;}
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-DUPLICATE-FIN-TIME-WAIT-RESOLVED\",\"requirements\":[\"T.CONN-FIN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_150(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-SYN-SENT-EMPTY\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_151(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-SYN-SENT-PENDING\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_152(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-SYN-SENT-RESOLVED\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_153(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-SYN-RECEIVED-EMPTY\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_154(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-SYN-RECEIVED-PENDING\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_155(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-SYN-RECEIVED-RESOLVED\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_156(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-FIN-WAIT-1-EMPTY\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_157(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-FIN-WAIT-1-PENDING\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_158(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-FIN-WAIT-1-RESOLVED\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_159(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-CLOSING-EMPTY\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_160(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-CLOSING-PENDING\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_161(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-CLOSING-RESOLVED\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_162(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-LAST-ACK-EMPTY\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_163(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-LAST-ACK-PENDING\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_164(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_240(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_323(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RETRANSMIT-LAST-ACK-RESOLVED\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.RTO-PROFILE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_165(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(46));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-USER-TIMEOUT-SYN-SENT\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.user\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_166(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(46));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-USER-TIMEOUT-SYN-RECEIVED\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.user\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_167(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(46));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-USER-TIMEOUT-FIN-WAIT-1\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.user\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_168(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(46));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-USER-TIMEOUT-FIN-WAIT-2\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.user\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_169(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(46));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-USER-TIMEOUT-CLOSING\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.user\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_170(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(46));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-USER-TIMEOUT-LAST-ACK\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.user\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_171(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(25));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-TIME-WAIT-EXPIRED\",\"requirements\":[\"T.CONN-TIMEOUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.time_wait\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_172(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-CLOSED\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_173(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-LISTEN\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_174(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-SYN-SENT\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_175(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-SYN-RECEIVED-EMPTY\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_176(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-SYN-RECEIVED-PENDING\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_177(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-SYN-RECEIVED-RESOLVED\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_178(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->b[14]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[15]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[16]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[39]=INT64_C(16);
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-ESTABLISHED-EMPTY\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_179(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->b[14]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[15]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[16]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[39]=INT64_C(16);
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-ESTABLISHED-PENDING\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_180(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->b[14]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[15]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[16]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[39]=INT64_C(16);
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-ESTABLISHED-RESOLVED\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_181(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-FIN-WAIT-1-EMPTY\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_182(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-FIN-WAIT-1-PENDING\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_183(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-FIN-WAIT-1-RESOLVED\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_184(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-FIN-WAIT-2-EMPTY\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_185(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-FIN-WAIT-2-PENDING\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_186(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-FIN-WAIT-2-RESOLVED\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_187(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-CLOSE-WAIT-EMPTY\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_188(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-CLOSE-WAIT-PENDING\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_189(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_324(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-CLOSE-WAIT-RESOLVED\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_190(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-CLOSING\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_191(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-LAST-ACK\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_192(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(22));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-ABORT-TIME-WAIT\",\"requirements\":[\"T.CONN-ABORT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.abort\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_193(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-IGNORE-NET-RST-CLOSED\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_194(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-IGNORE-NET-RST-LISTEN\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_195(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-NET-RST\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_196(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-RECEIVED-NET-RST-PASSIVE\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_197(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(42));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-RECEIVED-NET-RST-ACTIVE\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_198(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->b[14]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[15]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[16]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[39]=INT64_C(16);
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-ESTABLISHED-rst\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_199(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-FIN-WAIT-1-rst\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_200(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-FIN-WAIT-2-rst\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_201(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-CLOSE-WAIT-rst\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_202(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-CLOSING-rst\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_203(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-LAST-ACK-rst\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_204(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-TIME-WAIT-rst\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_205(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-IGNORE-NET-RSTACK-CLOSED\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_206(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-IGNORE-NET-RSTACK-LISTEN\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_207(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(42));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-SENT-NET-RSTACK\",\"requirements\":[\"T.CONN-SYN-SENT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_208(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-RECEIVED-NET-RSTACK-PASSIVE\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_209(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(42));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-SYN-RECEIVED-NET-RSTACK-ACTIVE\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_210(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->b[14]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[15]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->b[16]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[39]=INT64_C(16);
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-ESTABLISHED-rstack\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_211(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-FIN-WAIT-1-rstack\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_212(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-FIN-WAIT-2-rstack\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_213(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-CLOSE-WAIT-rstack\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_214(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-CLOSING-rstack\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_215(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-LAST-ACK-rstack\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_216(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
if(1)m->active[3]=0;
if(failure)return 0;
if(1)m->active[4]=0;
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(44));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-RESET-TIME-WAIT-rstack\",\"requirements\":[\"T.CONN-RESET\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_217(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-ACK-CLOSED-EMPTY\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_218(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-ACK-CLOSED-PENDING\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_219(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-ACK-CLOSED-RESOLVED\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_220(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-ACK-LISTEN-EMPTY\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_221(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-ACK-LISTEN-PENDING\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_222(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-ACK-LISTEN-RESOLVED\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_223(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-SYNACK-CLOSED-EMPTY\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_224(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-SYNACK-CLOSED-PENDING\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_225(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-SYNACK-CLOSED-RESOLVED\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_226(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-SYNACK-LISTEN-EMPTY\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_227(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-SYNACK-LISTEN-PENDING\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_228(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-SYNACK-LISTEN-RESOLVED\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_229(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-FIN-CLOSED-EMPTY\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_230(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-FIN-CLOSED-PENDING\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_231(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-FIN-CLOSED-RESOLVED\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_232(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-FIN-LISTEN-EMPTY\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_233(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-FIN-LISTEN-PENDING\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_234(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_211(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_461(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-REJECT-FIN-LISTEN-RESOLVED\",\"requirements\":[\"T.CONN-LISTEN\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_235(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_212(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_464(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSED-SYN-EMPTY\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_236(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_212(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_464(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSED-SYN-PENDING\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_237(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_212(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_464(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.C-CLOSED-SYN-RESOLVED\",\"requirements\":[\"T.CONN-CLOSED-INPUT\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_238(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[14]=byte_concat(m->b[14],bf[0]);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(41));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-QUEUE\",\"requirements\":[\"T.DATA-SEND\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.send\",\"fields\":{");
text(log,"\"data\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_239(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(37));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-SEND-EMPTY\",\"requirements\":[\"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.send\",\"fields\":{");
text(log,"\"data\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_240(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application\",\"fields\":{");
text(&messages,"\"code\":");
text(&messages,source_json(45));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-SEND-FULL\",\"requirements\":[\"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.send\",\"fields\":{");
text(log,"\"data\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_241(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[46]=shared_expr_10(m,f,bf);
if(failure)return 0;
m->b[18]=byte_slice(m->b[14],INT64_C(0),m->v[46]);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->b[15]=byte_concat(m->b[15],byte_slice(m->b[14],INT64_C(0),m->v[46]));
if(failure)return 0;
m->b[14]=byte_slice(m->b[14],m->v[46],((int64_t)(m->b[14]).len));
if(failure)return 0;
m->v[29]=seqadd(m->v[29],m->v[46]);
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-FLUSH-FIRST-EMPTY\",\"requirements\":[\"T.DATA-SEND\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.transmit\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_242(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[46]=shared_expr_10(m,f,bf);
if(failure)return 0;
m->b[18]=byte_slice(m->b[14],INT64_C(0),m->v[46]);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->b[15]=byte_concat(m->b[15],byte_slice(m->b[14],INT64_C(0),m->v[46]));
if(failure)return 0;
m->b[14]=byte_slice(m->b[14],m->v[46],((int64_t)(m->b[14]).len));
if(failure)return 0;
m->v[29]=seqadd(m->v[29],m->v[46]);
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-FLUSH-FIRST-PENDING\",\"requirements\":[\"T.DATA-SEND\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.transmit\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_243(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[46]=shared_expr_10(m,f,bf);
if(failure)return 0;
m->b[18]=byte_slice(m->b[14],INT64_C(0),m->v[46]);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->b[15]=byte_concat(m->b[15],byte_slice(m->b[14],INT64_C(0),m->v[46]));
if(failure)return 0;
m->b[14]=byte_slice(m->b[14],m->v[46],((int64_t)(m->b[14]).len));
if(failure)return 0;
m->v[29]=seqadd(m->v[29],m->v[46]);
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-FLUSH-FIRST-RESOLVED\",\"requirements\":[\"T.DATA-SEND\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.transmit\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_244(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[46]=shared_expr_10(m,f,bf);
if(failure)return 0;
m->b[18]=byte_slice(m->b[14],INT64_C(0),m->v[46]);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->b[15]=byte_concat(m->b[15],byte_slice(m->b[14],INT64_C(0),m->v[46]));
if(failure)return 0;
m->b[14]=byte_slice(m->b[14],m->v[46],((int64_t)(m->b[14]).len));
if(failure)return 0;
m->v[29]=seqadd(m->v[29],m->v[46]);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-FLUSH-MORE-EMPTY\",\"requirements\":[\"T.DATA-SEND\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.transmit\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_245(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[46]=shared_expr_10(m,f,bf);
if(failure)return 0;
m->b[18]=byte_slice(m->b[14],INT64_C(0),m->v[46]);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->b[15]=byte_concat(m->b[15],byte_slice(m->b[14],INT64_C(0),m->v[46]));
if(failure)return 0;
m->b[14]=byte_slice(m->b[14],m->v[46],((int64_t)(m->b[14]).len));
if(failure)return 0;
m->v[29]=seqadd(m->v[29],m->v[46]);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-FLUSH-MORE-PENDING\",\"requirements\":[\"T.DATA-SEND\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.transmit\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_246(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[46]=shared_expr_10(m,f,bf);
if(failure)return 0;
m->b[18]=byte_slice(m->b[14],INT64_C(0),m->v[46]);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->b[15]=byte_concat(m->b[15],byte_slice(m->b[14],INT64_C(0),m->v[46]));
if(failure)return 0;
m->b[14]=byte_slice(m->b[14],m->v[46],((int64_t)(m->b[14]).len));
if(failure)return 0;
m->v[29]=seqadd(m->v[29],m->v[46]);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-FLUSH-MORE-RESOLVED\",\"requirements\":[\"T.DATA-SEND\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.transmit\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_247(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-FLUSH-BLOCKED\",\"requirements\":[\"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.transmit\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_248(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[15]=shared_expr_421(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-FULL-WINDOW\",\"requirements\":[\"T.DATA-ACK\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_249(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[15]=shared_expr_421(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
if(1)m->active[2]=0;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-FULL-STALE-WINDOW\",\"requirements\":[\"T.DATA-ACK\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_250(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[15]=shared_expr_421(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-PARTIAL-WINDOW\",\"requirements\":[\"T.DATA-ACK\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_251(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[15]=shared_expr_421(m,f,bf);
if(failure)return 0;
m->v[28]=shared_expr_374(m,f,bf);
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-PARTIAL-STALE-WINDOW\",\"requirements\":[\"T.DATA-ACK\", \"T.DATA-WINDOW\", \"T.DATA-SEQ\", \"T.DATA-RTO\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_252(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[43]=shared_expr_284(m,f,bf);
if(failure)return 0;
m->v[44]=shared_expr_373(m,f,bf);
if(failure)return 0;
m->v[45]=shared_expr_374(m,f,bf);
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-DUP-WINDOW\",\"requirements\":[\"T.DATA-ACK\", \"T.DATA-WINDOW\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_253(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-DUP-STALE-WINDOW\",\"requirements\":[\"T.DATA-ACK\", \"T.DATA-WINDOW\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_254(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-OLD\",\"requirements\":[\"T.DATA-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_255(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-FUTURE-EMPTY\",\"requirements\":[\"T.DATA-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_256(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-FUTURE-PENDING\",\"requirements\":[\"T.DATA-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_257(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-ACK-FUTURE-RESOLVED\",\"requirements\":[\"T.DATA-ACK\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_258(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_slice(m->b[15],INT64_C(0),INT64_C(4));
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_335(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RETRANSMIT-EMPTY\",\"requirements\":[\"T.DATA-RTX\", \"T.DATA-RTO\", \"T.DATA-SEQ\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_259(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_slice(m->b[15],INT64_C(0),INT64_C(4));
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_335(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RETRANSMIT-PENDING\",\"requirements\":[\"T.DATA-RTX\", \"T.DATA-RTO\", \"T.DATA-SEQ\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_260(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[18]=byte_slice(m->b[15],INT64_C(0),INT64_C(4));
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_335(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[34]=mul(m->v[34],INT64_C(2));
if(failure)return 0;
m->v[35]=add(m->v[35],INT64_C(1));
if(failure)return 0;
{
int64_t delay=m->v[34]; if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[2]=add(m->now,delay);m->active[2]=1;}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RETRANSMIT-RESOLVED\",\"requirements\":[\"T.DATA-RTX\", \"T.DATA-RTO\", \"T.DATA-SEQ\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.timer.rtx\",\"fields\":{");
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_261(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[17]=shared_expr_381(m,f,bf);
if(failure)return 0;
m->b[16]=byte_concat(m->b[16],m->b[17]);
if(failure)return 0;
m->v[30]=seqadd(m->v[30],((int64_t)(m->b[17]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-IN-ORDER-EMPTY\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SEQ\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_262(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[17]=shared_expr_381(m,f,bf);
if(failure)return 0;
m->b[16]=byte_concat(m->b[16],m->b[17]);
if(failure)return 0;
m->v[30]=seqadd(m->v[30],((int64_t)(m->b[17]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-IN-ORDER-PENDING\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SEQ\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_263(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[17]=shared_expr_381(m,f,bf);
if(failure)return 0;
m->b[16]=byte_concat(m->b[16],m->b[17]);
if(failure)return 0;
m->v[30]=seqadd(m->v[30],((int64_t)(m->b[17]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-IN-ORDER-RESOLVED\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SEQ\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_264(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[17]=shared_expr_517(m,f,bf);
if(failure)return 0;
m->b[16]=byte_concat(m->b[16],m->b[17]);
if(failure)return 0;
m->v[30]=seqadd(m->v[30],((int64_t)(m->b[17]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-OVERLAP-EMPTY\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SEQ\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_265(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[17]=shared_expr_517(m,f,bf);
if(failure)return 0;
m->b[16]=byte_concat(m->b[16],m->b[17]);
if(failure)return 0;
m->v[30]=seqadd(m->v[30],((int64_t)(m->b[17]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-OVERLAP-PENDING\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SEQ\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_266(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[17]=shared_expr_517(m,f,bf);
if(failure)return 0;
m->b[16]=byte_concat(m->b[16],m->b[17]);
if(failure)return 0;
m->v[30]=seqadd(m->v[30],((int64_t)(m->b[17]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-OVERLAP-RESOLVED\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SEQ\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_267(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-DUPLICATE-EMPTY\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_268(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-DUPLICATE-PENDING\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_269(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-DUPLICATE-RESOLVED\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_270(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-AHEAD-EMPTY\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_271(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-AHEAD-PENDING\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_272(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-AHEAD-RESOLVED\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_273(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-ZERO-WINDOW-EMPTY\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_274(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-ZERO-WINDOW-PENDING\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_275(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=40;
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-RECEIVE-ZERO-WINDOW-RESOLVED\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_276(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application_data\",\"fields\":{");
text(&messages,"\"data\":");
byte_json(&messages,byte_slice(m->b[16],INT64_C(0),f[0]));
text(&messages,"}}");
}
if(failure)return 0;
m->b[16]=byte_slice(m->b[16],f[0],((int64_t)(m->b[16]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[1]=INT64_C(0);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_362(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
{
int64_t delay=INT64_C(1000); if(delay<=0){failure="invalid_timer_delay";return 0;}
m->due[0]=add(m->now,delay);m->active[0]=1;}
if(failure)return 0;
m->v[25]=11;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-APPLICATION-READ-EMPTY\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.receive\",\"fields\":{");
text(log,"\"count\":");
number(log,f[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_277(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application_data\",\"fields\":{");
text(&messages,"\"data\":");
byte_json(&messages,byte_slice(m->b[16],INT64_C(0),f[0]));
text(&messages,"}}");
}
if(failure)return 0;
m->b[16]=byte_slice(m->b[16],f[0],((int64_t)(m->b[16]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
m->b[8]=m->b[23];
if(failure)return 0;
m->v[57]=19;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-APPLICATION-READ-PENDING\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.receive\",\"fields\":{");
text(log,"\"count\":");
number(log,f[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_278(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"T.application_data\",\"fields\":{");
text(&messages,"\"data\":");
byte_json(&messages,byte_slice(m->b[16],INT64_C(0),f[0]));
text(&messages,"}}");
}
if(failure)return 0;
m->b[16]=byte_slice(m->b[16],f[0],((int64_t)(m->b[16]).len));
if(failure)return 0;
m->v[39]=sub(INT64_C(16),((int64_t)(m->b[16]).len));
if(failure)return 0;
m->b[18]=byte_literal((const unsigned char[]){0},0);
if(failure)return 0;
m->v[54]=shared_expr_209(m,f,bf);
if(failure)return 0;
m->b[19]=shared_expr_336(m,f,bf);
if(failure)return 0;
m->b[20]=shared_expr_76(m,f,bf);
if(failure)return 0;
m->b[21]=shared_expr_216(m,f,bf);
if(failure)return 0;
m->b[22]=shared_expr_218(m,f,bf);
if(failure)return 0;
m->b[23]=shared_expr_200(m,f,bf);
if(failure)return 0;
{
if(emitted++)text(&messages,",");
text(&messages,"{\"message\":\"L.ethernet.tx\",\"fields\":{");
text(&messages,"\"frame\":");
byte_json(&messages,shared_expr_337(m,f,bf));
text(&messages,"}}");
}
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.D-APPLICATION-READ-RESOLVED\",\"requirements\":[\"T.DATA-RECEIVE\", \"T.DATA-SCOPE\", \"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"T.WIRE-MSS\", \"T.WIRE-PUSH\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"T.app.receive\",\"fields\":{");
text(log,"\"count\":");
number(log,f[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_279(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=32;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-CLOSED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_280(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=31;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-CLOSED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_281(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=30;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-CLOSED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_282(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=34;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-CLOSED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_283(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->b[8]=((m->v[57]==19)?byte_literal((const unsigned char[]){0},0):m->b[8]);
if(failure)return 0;
m->v[57]=((m->v[57]==19)?38:m->v[57]);
if(failure)return 0;
m->v[55]=33;
if(failure)return 0;
m->v[56]=2;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-CLOSED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_284(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-LISTEN\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_285(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-LISTEN\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_286(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-LISTEN\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_287(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-LISTEN\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_288(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=10;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-LISTEN\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_289(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-SYN-SENT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_290(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-SYN-SENT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_291(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-SYN-SENT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_292(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-SYN-SENT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_293(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=18;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-SYN-SENT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_294(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-SYN-RECEIVED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_295(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-SYN-RECEIVED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_296(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-SYN-RECEIVED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_297(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-SYN-RECEIVED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_298(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=17;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-SYN-RECEIVED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_299(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-ESTABLISHED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_300(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-ESTABLISHED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_301(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-ESTABLISHED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_302(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-ESTABLISHED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_303(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=5;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-ESTABLISHED\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_304(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-FIN-WAIT-1\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_305(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-FIN-WAIT-1\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_306(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-FIN-WAIT-1\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_307(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-FIN-WAIT-1\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_308(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=7;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-FIN-WAIT-1\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_309(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=8;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-FIN-WAIT-2\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_310(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=8;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-FIN-WAIT-2\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_311(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=8;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-FIN-WAIT-2\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_312(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=8;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-FIN-WAIT-2\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_313(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=8;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-FIN-WAIT-2\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_314(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-CLOSE-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_315(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-CLOSE-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_316(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-CLOSE-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_317(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-CLOSE-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_318(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=1;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-CLOSE-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_319(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-CLOSING\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_320(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-CLOSING\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_321(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-CLOSING\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_322(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-CLOSING\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_323(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=3;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-CLOSING\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_324(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-LAST-ACK\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_325(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-LAST-ACK\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_326(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-LAST-ACK\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_327(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-LAST-ACK\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_328(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=9;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-LAST-ACK\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_329(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=32;
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-SHORT-TIME-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_330(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-TIME-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_331(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=30;
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-CHECKSUM-TIME-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_332(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=34;
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-LENGTH-TIME-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_333(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=33;
if(failure)return 0;
m->v[56]=20;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-TCP-CHECKSUM-TIME-WAIT\",\"requirements\":[\"T.WIRE-PROFILE\", \"T.WIRE-IP\", \"T.WIRE-TCP\", \"CROSS-IP-LINK\", \"VIRTUAL-ETHERNET-RX\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
static int rule_action_334(Machine *m,int64_t *f,Bytes *bf,Buffer *log) { Buffer messages={{0},0}; int emitted=0; (void)f; (void)bf; (void)emitted;
m->v[55]=31;
if(failure)return 0;
m->state=0; if(!invariants(m))return 0;
text(log,"{\"status\":\"transition\",\"transition\":\"T.WIRE-DROP-IP-LENGTH-MALFORMED\",\"requirements\":[\"TCP-IP-FRAME-DROP\", \"CROSS-IP-LINK\"],\"time_ms\":");
number(log,m->now);
text(log,",\"event\":{\"name\":\"L.net.frame\",\"fields\":{");
text(log,"\"frame\":");
byte_json(log,bf[0]);
text(log,"}},\"after\":");
snapshot(log,m);
text(log,",\"emitted\":[");
text(log,messages.data);
text(log,"]}\012");
return failure==NULL; }
int fire(Machine *m,int event,int64_t *f,Bytes *bf,int expiring,Buffer *log) { int match=-1,count=0;
if(m->state==0&&event==0&&rule_guard_0(m,f,bf)) {match=0;count++;}
if(m->state==0&&event==0&&rule_guard_1(m,f,bf)) {match=1;count++;}
if(m->state==0&&event==0&&rule_guard_2(m,f,bf)) {match=2;count++;}
if(m->state==0&&event==3&&rule_guard_3(m,f,bf)) {match=3;count++;}
if(m->state==0&&event==4&&rule_guard_4(m,f,bf)) {match=4;count++;}
if(m->state==0&&event==1&&rule_guard_5(m,f,bf)) {match=5;count++;}
if(m->state==0&&event==2&&rule_guard_6(m,f,bf)) {match=6;count++;}
if(m->state==0&&event==2&&rule_guard_7(m,f,bf)) {match=7;count++;}
if(m->state==0&&event==2&&rule_guard_8(m,f,bf)) {match=8;count++;}
if(m->state==0&&event==2&&rule_guard_9(m,f,bf)) {match=9;count++;}
if(m->state==0&&event==1&&rule_guard_10(m,f,bf)) {match=10;count++;}
if(m->state==0&&event==2&&rule_guard_11(m,f,bf)) {match=11;count++;}
if(m->state==0&&event==2&&rule_guard_12(m,f,bf)) {match=12;count++;}
if(m->state==0&&event==1&&rule_guard_13(m,f,bf)) {match=13;count++;}
if(m->state==0&&event==2&&rule_guard_14(m,f,bf)) {match=14;count++;}
if(m->state==0&&event==2&&rule_guard_15(m,f,bf)) {match=15;count++;}
if(m->state==0&&event==2&&rule_guard_16(m,f,bf)) {match=16;count++;}
if(m->state==0&&event==2&&rule_guard_17(m,f,bf)) {match=17;count++;}
if(m->state==0&&event==6&&rule_guard_18(m,f,bf)) {match=18;count++;}
if(m->state==0&&event==5&&rule_guard_19(m,f,bf)) {match=19;count++;}
if(m->state==0&&event==6&&rule_guard_20(m,f,bf)) {match=20;count++;}
if(m->state==0&&event==5&&rule_guard_21(m,f,bf)) {match=21;count++;}
if(m->state==0&&event==6&&rule_guard_22(m,f,bf)) {match=22;count++;}
if(m->state==0&&event==5&&rule_guard_23(m,f,bf)) {match=23;count++;}
if(m->state==0&&event==3&&rule_guard_24(m,f,bf)) {match=24;count++;}
if(m->state==0&&event==3&&rule_guard_25(m,f,bf)) {match=25;count++;}
if(m->state==0&&event==3&&rule_guard_26(m,f,bf)) {match=26;count++;}
if(m->state==0&&event==2&&rule_guard_27(m,f,bf)) {match=27;count++;}
if(m->state==0&&event==2&&rule_guard_28(m,f,bf)) {match=28;count++;}
if(m->state==0&&event==2&&rule_guard_29(m,f,bf)) {match=29;count++;}
if(m->state==0&&event==2&&rule_guard_30(m,f,bf)) {match=30;count++;}
if(m->state==0&&event==2&&rule_guard_31(m,f,bf)) {match=31;count++;}
if(m->state==0&&event==2&&rule_guard_32(m,f,bf)) {match=32;count++;}
if(m->state==0&&event==2&&rule_guard_33(m,f,bf)) {match=33;count++;}
if(m->state==0&&event==2&&rule_guard_34(m,f,bf)) {match=34;count++;}
if(m->state==0&&event==2&&rule_guard_35(m,f,bf)) {match=35;count++;}
if(m->state==0&&event==7&&rule_guard_36(m,f,bf)) {match=36;count++;}
if(m->state==0&&event==2&&rule_guard_37(m,f,bf)) {match=37;count++;}
if(m->state==0&&event==2&&rule_guard_38(m,f,bf)) {match=38;count++;}
if(m->state==0&&event==2&&rule_guard_39(m,f,bf)) {match=39;count++;}
if(m->state==0&&event==2&&rule_guard_40(m,f,bf)) {match=40;count++;}
if(m->state==0&&event==2&&rule_guard_41(m,f,bf)) {match=41;count++;}
if(m->state==0&&event==2&&rule_guard_42(m,f,bf)) {match=42;count++;}
if(m->state==0&&event==7&&rule_guard_43(m,f,bf)) {match=43;count++;}
if(m->state==0&&event==2&&rule_guard_44(m,f,bf)) {match=44;count++;}
if(m->state==0&&event==2&&rule_guard_45(m,f,bf)) {match=45;count++;}
if(m->state==0&&event==2&&rule_guard_46(m,f,bf)) {match=46;count++;}
if(m->state==0&&event==2&&rule_guard_47(m,f,bf)) {match=47;count++;}
if(m->state==0&&event==2&&rule_guard_48(m,f,bf)) {match=48;count++;}
if(m->state==0&&event==2&&rule_guard_49(m,f,bf)) {match=49;count++;}
if(m->state==0&&event==7&&rule_guard_50(m,f,bf)) {match=50;count++;}
if(m->state==0&&event==2&&rule_guard_51(m,f,bf)) {match=51;count++;}
if(m->state==0&&event==2&&rule_guard_52(m,f,bf)) {match=52;count++;}
if(m->state==0&&event==2&&rule_guard_53(m,f,bf)) {match=53;count++;}
if(m->state==0&&event==2&&rule_guard_54(m,f,bf)) {match=54;count++;}
if(m->state==0&&event==2&&rule_guard_55(m,f,bf)) {match=55;count++;}
if(m->state==0&&event==2&&rule_guard_56(m,f,bf)) {match=56;count++;}
if(m->state==0&&event==2&&rule_guard_57(m,f,bf)) {match=57;count++;}
if(m->state==0&&event==2&&rule_guard_58(m,f,bf)) {match=58;count++;}
if(m->state==0&&event==2&&rule_guard_59(m,f,bf)) {match=59;count++;}
if(m->state==0&&event==2&&rule_guard_60(m,f,bf)) {match=60;count++;}
if(m->state==0&&event==2&&rule_guard_61(m,f,bf)) {match=61;count++;}
if(m->state==0&&event==2&&rule_guard_62(m,f,bf)) {match=62;count++;}
if(m->state==0&&event==2&&rule_guard_63(m,f,bf)) {match=63;count++;}
if(m->state==0&&event==8&&rule_guard_64(m,f,bf)) {match=64;count++;}
if(m->state==0&&event==8&&rule_guard_65(m,f,bf)) {match=65;count++;}
if(m->state==0&&event==8&&rule_guard_66(m,f,bf)) {match=66;count++;}
if(m->state==0&&event==9&&rule_guard_67(m,f,bf)) {match=67;count++;}
if(m->state==0&&event==2&&rule_guard_68(m,f,bf)) {match=68;count++;}
if(m->state==0&&event==2&&rule_guard_69(m,f,bf)) {match=69;count++;}
if(m->state==0&&event==2&&rule_guard_70(m,f,bf)) {match=70;count++;}
if(m->state==0&&event==2&&rule_guard_71(m,f,bf)) {match=71;count++;}
if(m->state==0&&event==2&&rule_guard_72(m,f,bf)) {match=72;count++;}
if(m->state==0&&event==2&&rule_guard_73(m,f,bf)) {match=73;count++;}
if(m->state==0&&event==2&&rule_guard_74(m,f,bf)) {match=74;count++;}
if(m->state==0&&event==2&&rule_guard_75(m,f,bf)) {match=75;count++;}
if(m->state==0&&event==2&&rule_guard_76(m,f,bf)) {match=76;count++;}
if(m->state==0&&event==2&&rule_guard_77(m,f,bf)) {match=77;count++;}
if(m->state==0&&event==2&&rule_guard_78(m,f,bf)) {match=78;count++;}
if(m->state==0&&event==2&&rule_guard_79(m,f,bf)) {match=79;count++;}
if(m->state==0&&event==2&&rule_guard_80(m,f,bf)) {match=80;count++;}
if(m->state==0&&event==2&&rule_guard_81(m,f,bf)) {match=81;count++;}
if(m->state==0&&event==2&&rule_guard_82(m,f,bf)) {match=82;count++;}
if(m->state==0&&event==2&&rule_guard_83(m,f,bf)) {match=83;count++;}
if(m->state==0&&event==2&&rule_guard_84(m,f,bf)) {match=84;count++;}
if(m->state==0&&event==2&&rule_guard_85(m,f,bf)) {match=85;count++;}
if(m->state==0&&event==2&&rule_guard_86(m,f,bf)) {match=86;count++;}
if(m->state==0&&event==2&&rule_guard_87(m,f,bf)) {match=87;count++;}
if(m->state==0&&event==2&&rule_guard_88(m,f,bf)) {match=88;count++;}
if(m->state==0&&event==2&&rule_guard_89(m,f,bf)) {match=89;count++;}
if(m->state==0&&event==2&&rule_guard_90(m,f,bf)) {match=90;count++;}
if(m->state==0&&event==2&&rule_guard_91(m,f,bf)) {match=91;count++;}
if(m->state==0&&event==2&&rule_guard_92(m,f,bf)) {match=92;count++;}
if(m->state==0&&event==2&&rule_guard_93(m,f,bf)) {match=93;count++;}
if(m->state==0&&event==2&&rule_guard_94(m,f,bf)) {match=94;count++;}
if(m->state==0&&event==2&&rule_guard_95(m,f,bf)) {match=95;count++;}
if(m->state==0&&event==2&&rule_guard_96(m,f,bf)) {match=96;count++;}
if(m->state==0&&event==2&&rule_guard_97(m,f,bf)) {match=97;count++;}
if(m->state==0&&event==2&&rule_guard_98(m,f,bf)) {match=98;count++;}
if(m->state==0&&event==2&&rule_guard_99(m,f,bf)) {match=99;count++;}
if(m->state==0&&event==2&&rule_guard_100(m,f,bf)) {match=100;count++;}
if(m->state==0&&event==2&&rule_guard_101(m,f,bf)) {match=101;count++;}
if(m->state==0&&event==2&&rule_guard_102(m,f,bf)) {match=102;count++;}
if(m->state==0&&event==2&&rule_guard_103(m,f,bf)) {match=103;count++;}
if(m->state==0&&event==2&&rule_guard_104(m,f,bf)) {match=104;count++;}
if(m->state==0&&event==10&&rule_guard_105(m,f,bf)) {match=105;count++;}
if(m->state==0&&event==10&&rule_guard_106(m,f,bf)) {match=106;count++;}
if(m->state==0&&event==10&&rule_guard_107(m,f,bf)) {match=107;count++;}
if(m->state==0&&event==10&&rule_guard_108(m,f,bf)) {match=108;count++;}
if(m->state==0&&event==10&&rule_guard_109(m,f,bf)) {match=109;count++;}
if(m->state==0&&event==10&&rule_guard_110(m,f,bf)) {match=110;count++;}
if(m->state==0&&event==10&&rule_guard_111(m,f,bf)) {match=111;count++;}
if(m->state==0&&event==10&&rule_guard_112(m,f,bf)) {match=112;count++;}
if(m->state==0&&event==10&&rule_guard_113(m,f,bf)) {match=113;count++;}
if(m->state==0&&event==10&&rule_guard_114(m,f,bf)) {match=114;count++;}
if(m->state==0&&event==10&&rule_guard_115(m,f,bf)) {match=115;count++;}
if(m->state==0&&event==10&&rule_guard_116(m,f,bf)) {match=116;count++;}
if(m->state==0&&event==10&&rule_guard_117(m,f,bf)) {match=117;count++;}
if(m->state==0&&event==2&&rule_guard_118(m,f,bf)) {match=118;count++;}
if(m->state==0&&event==2&&rule_guard_119(m,f,bf)) {match=119;count++;}
if(m->state==0&&event==2&&rule_guard_120(m,f,bf)) {match=120;count++;}
if(m->state==0&&event==2&&rule_guard_121(m,f,bf)) {match=121;count++;}
if(m->state==0&&event==2&&rule_guard_122(m,f,bf)) {match=122;count++;}
if(m->state==0&&event==2&&rule_guard_123(m,f,bf)) {match=123;count++;}
if(m->state==0&&event==2&&rule_guard_124(m,f,bf)) {match=124;count++;}
if(m->state==0&&event==2&&rule_guard_125(m,f,bf)) {match=125;count++;}
if(m->state==0&&event==2&&rule_guard_126(m,f,bf)) {match=126;count++;}
if(m->state==0&&event==2&&rule_guard_127(m,f,bf)) {match=127;count++;}
if(m->state==0&&event==2&&rule_guard_128(m,f,bf)) {match=128;count++;}
if(m->state==0&&event==2&&rule_guard_129(m,f,bf)) {match=129;count++;}
if(m->state==0&&event==2&&rule_guard_130(m,f,bf)) {match=130;count++;}
if(m->state==0&&event==2&&rule_guard_131(m,f,bf)) {match=131;count++;}
if(m->state==0&&event==2&&rule_guard_132(m,f,bf)) {match=132;count++;}
if(m->state==0&&event==2&&rule_guard_133(m,f,bf)) {match=133;count++;}
if(m->state==0&&event==2&&rule_guard_134(m,f,bf)) {match=134;count++;}
if(m->state==0&&event==2&&rule_guard_135(m,f,bf)) {match=135;count++;}
if(m->state==0&&event==2&&rule_guard_136(m,f,bf)) {match=136;count++;}
if(m->state==0&&event==2&&rule_guard_137(m,f,bf)) {match=137;count++;}
if(m->state==0&&event==2&&rule_guard_138(m,f,bf)) {match=138;count++;}
if(m->state==0&&event==2&&rule_guard_139(m,f,bf)) {match=139;count++;}
if(m->state==0&&event==2&&rule_guard_140(m,f,bf)) {match=140;count++;}
if(m->state==0&&event==2&&rule_guard_141(m,f,bf)) {match=141;count++;}
if(m->state==0&&event==2&&rule_guard_142(m,f,bf)) {match=142;count++;}
if(m->state==0&&event==2&&rule_guard_143(m,f,bf)) {match=143;count++;}
if(m->state==0&&event==2&&rule_guard_144(m,f,bf)) {match=144;count++;}
if(m->state==0&&event==2&&rule_guard_145(m,f,bf)) {match=145;count++;}
if(m->state==0&&event==2&&rule_guard_146(m,f,bf)) {match=146;count++;}
if(m->state==0&&event==2&&rule_guard_147(m,f,bf)) {match=147;count++;}
if(m->state==0&&event==2&&rule_guard_148(m,f,bf)) {match=148;count++;}
if(m->state==0&&event==2&&rule_guard_149(m,f,bf)) {match=149;count++;}
if(m->state==0&&event==18&&rule_guard_150(m,f,bf)) {match=150;count++;}
if(m->state==0&&event==18&&rule_guard_151(m,f,bf)) {match=151;count++;}
if(m->state==0&&event==18&&rule_guard_152(m,f,bf)) {match=152;count++;}
if(m->state==0&&event==18&&rule_guard_153(m,f,bf)) {match=153;count++;}
if(m->state==0&&event==18&&rule_guard_154(m,f,bf)) {match=154;count++;}
if(m->state==0&&event==18&&rule_guard_155(m,f,bf)) {match=155;count++;}
if(m->state==0&&event==18&&rule_guard_156(m,f,bf)) {match=156;count++;}
if(m->state==0&&event==18&&rule_guard_157(m,f,bf)) {match=157;count++;}
if(m->state==0&&event==18&&rule_guard_158(m,f,bf)) {match=158;count++;}
if(m->state==0&&event==18&&rule_guard_159(m,f,bf)) {match=159;count++;}
if(m->state==0&&event==18&&rule_guard_160(m,f,bf)) {match=160;count++;}
if(m->state==0&&event==18&&rule_guard_161(m,f,bf)) {match=161;count++;}
if(m->state==0&&event==18&&rule_guard_162(m,f,bf)) {match=162;count++;}
if(m->state==0&&event==18&&rule_guard_163(m,f,bf)) {match=163;count++;}
if(m->state==0&&event==18&&rule_guard_164(m,f,bf)) {match=164;count++;}
if(m->state==0&&event==19&&rule_guard_165(m,f,bf)) {match=165;count++;}
if(m->state==0&&event==19&&rule_guard_166(m,f,bf)) {match=166;count++;}
if(m->state==0&&event==19&&rule_guard_167(m,f,bf)) {match=167;count++;}
if(m->state==0&&event==19&&rule_guard_168(m,f,bf)) {match=168;count++;}
if(m->state==0&&event==19&&rule_guard_169(m,f,bf)) {match=169;count++;}
if(m->state==0&&event==19&&rule_guard_170(m,f,bf)) {match=170;count++;}
if(m->state==0&&event==20&&rule_guard_171(m,f,bf)) {match=171;count++;}
if(m->state==0&&event==11&&rule_guard_172(m,f,bf)) {match=172;count++;}
if(m->state==0&&event==11&&rule_guard_173(m,f,bf)) {match=173;count++;}
if(m->state==0&&event==11&&rule_guard_174(m,f,bf)) {match=174;count++;}
if(m->state==0&&event==11&&rule_guard_175(m,f,bf)) {match=175;count++;}
if(m->state==0&&event==11&&rule_guard_176(m,f,bf)) {match=176;count++;}
if(m->state==0&&event==11&&rule_guard_177(m,f,bf)) {match=177;count++;}
if(m->state==0&&event==11&&rule_guard_178(m,f,bf)) {match=178;count++;}
if(m->state==0&&event==11&&rule_guard_179(m,f,bf)) {match=179;count++;}
if(m->state==0&&event==11&&rule_guard_180(m,f,bf)) {match=180;count++;}
if(m->state==0&&event==11&&rule_guard_181(m,f,bf)) {match=181;count++;}
if(m->state==0&&event==11&&rule_guard_182(m,f,bf)) {match=182;count++;}
if(m->state==0&&event==11&&rule_guard_183(m,f,bf)) {match=183;count++;}
if(m->state==0&&event==11&&rule_guard_184(m,f,bf)) {match=184;count++;}
if(m->state==0&&event==11&&rule_guard_185(m,f,bf)) {match=185;count++;}
if(m->state==0&&event==11&&rule_guard_186(m,f,bf)) {match=186;count++;}
if(m->state==0&&event==11&&rule_guard_187(m,f,bf)) {match=187;count++;}
if(m->state==0&&event==11&&rule_guard_188(m,f,bf)) {match=188;count++;}
if(m->state==0&&event==11&&rule_guard_189(m,f,bf)) {match=189;count++;}
if(m->state==0&&event==11&&rule_guard_190(m,f,bf)) {match=190;count++;}
if(m->state==0&&event==11&&rule_guard_191(m,f,bf)) {match=191;count++;}
if(m->state==0&&event==11&&rule_guard_192(m,f,bf)) {match=192;count++;}
if(m->state==0&&event==2&&rule_guard_193(m,f,bf)) {match=193;count++;}
if(m->state==0&&event==2&&rule_guard_194(m,f,bf)) {match=194;count++;}
if(m->state==0&&event==2&&rule_guard_195(m,f,bf)) {match=195;count++;}
if(m->state==0&&event==2&&rule_guard_196(m,f,bf)) {match=196;count++;}
if(m->state==0&&event==2&&rule_guard_197(m,f,bf)) {match=197;count++;}
if(m->state==0&&event==2&&rule_guard_198(m,f,bf)) {match=198;count++;}
if(m->state==0&&event==2&&rule_guard_199(m,f,bf)) {match=199;count++;}
if(m->state==0&&event==2&&rule_guard_200(m,f,bf)) {match=200;count++;}
if(m->state==0&&event==2&&rule_guard_201(m,f,bf)) {match=201;count++;}
if(m->state==0&&event==2&&rule_guard_202(m,f,bf)) {match=202;count++;}
if(m->state==0&&event==2&&rule_guard_203(m,f,bf)) {match=203;count++;}
if(m->state==0&&event==2&&rule_guard_204(m,f,bf)) {match=204;count++;}
if(m->state==0&&event==2&&rule_guard_205(m,f,bf)) {match=205;count++;}
if(m->state==0&&event==2&&rule_guard_206(m,f,bf)) {match=206;count++;}
if(m->state==0&&event==2&&rule_guard_207(m,f,bf)) {match=207;count++;}
if(m->state==0&&event==2&&rule_guard_208(m,f,bf)) {match=208;count++;}
if(m->state==0&&event==2&&rule_guard_209(m,f,bf)) {match=209;count++;}
if(m->state==0&&event==2&&rule_guard_210(m,f,bf)) {match=210;count++;}
if(m->state==0&&event==2&&rule_guard_211(m,f,bf)) {match=211;count++;}
if(m->state==0&&event==2&&rule_guard_212(m,f,bf)) {match=212;count++;}
if(m->state==0&&event==2&&rule_guard_213(m,f,bf)) {match=213;count++;}
if(m->state==0&&event==2&&rule_guard_214(m,f,bf)) {match=214;count++;}
if(m->state==0&&event==2&&rule_guard_215(m,f,bf)) {match=215;count++;}
if(m->state==0&&event==2&&rule_guard_216(m,f,bf)) {match=216;count++;}
if(m->state==0&&event==2&&rule_guard_217(m,f,bf)) {match=217;count++;}
if(m->state==0&&event==2&&rule_guard_218(m,f,bf)) {match=218;count++;}
if(m->state==0&&event==2&&rule_guard_219(m,f,bf)) {match=219;count++;}
if(m->state==0&&event==2&&rule_guard_220(m,f,bf)) {match=220;count++;}
if(m->state==0&&event==2&&rule_guard_221(m,f,bf)) {match=221;count++;}
if(m->state==0&&event==2&&rule_guard_222(m,f,bf)) {match=222;count++;}
if(m->state==0&&event==2&&rule_guard_223(m,f,bf)) {match=223;count++;}
if(m->state==0&&event==2&&rule_guard_224(m,f,bf)) {match=224;count++;}
if(m->state==0&&event==2&&rule_guard_225(m,f,bf)) {match=225;count++;}
if(m->state==0&&event==2&&rule_guard_226(m,f,bf)) {match=226;count++;}
if(m->state==0&&event==2&&rule_guard_227(m,f,bf)) {match=227;count++;}
if(m->state==0&&event==2&&rule_guard_228(m,f,bf)) {match=228;count++;}
if(m->state==0&&event==2&&rule_guard_229(m,f,bf)) {match=229;count++;}
if(m->state==0&&event==2&&rule_guard_230(m,f,bf)) {match=230;count++;}
if(m->state==0&&event==2&&rule_guard_231(m,f,bf)) {match=231;count++;}
if(m->state==0&&event==2&&rule_guard_232(m,f,bf)) {match=232;count++;}
if(m->state==0&&event==2&&rule_guard_233(m,f,bf)) {match=233;count++;}
if(m->state==0&&event==2&&rule_guard_234(m,f,bf)) {match=234;count++;}
if(m->state==0&&event==2&&rule_guard_235(m,f,bf)) {match=235;count++;}
if(m->state==0&&event==2&&rule_guard_236(m,f,bf)) {match=236;count++;}
if(m->state==0&&event==2&&rule_guard_237(m,f,bf)) {match=237;count++;}
if(m->state==0&&event==21&&rule_guard_238(m,f,bf)) {match=238;count++;}
if(m->state==0&&event==21&&rule_guard_239(m,f,bf)) {match=239;count++;}
if(m->state==0&&event==21&&rule_guard_240(m,f,bf)) {match=240;count++;}
if(m->state==0&&event==22&&rule_guard_241(m,f,bf)) {match=241;count++;}
if(m->state==0&&event==22&&rule_guard_242(m,f,bf)) {match=242;count++;}
if(m->state==0&&event==22&&rule_guard_243(m,f,bf)) {match=243;count++;}
if(m->state==0&&event==22&&rule_guard_244(m,f,bf)) {match=244;count++;}
if(m->state==0&&event==22&&rule_guard_245(m,f,bf)) {match=245;count++;}
if(m->state==0&&event==22&&rule_guard_246(m,f,bf)) {match=246;count++;}
if(m->state==0&&event==22&&rule_guard_247(m,f,bf)) {match=247;count++;}
if(m->state==0&&event==2&&rule_guard_248(m,f,bf)) {match=248;count++;}
if(m->state==0&&event==2&&rule_guard_249(m,f,bf)) {match=249;count++;}
if(m->state==0&&event==2&&rule_guard_250(m,f,bf)) {match=250;count++;}
if(m->state==0&&event==2&&rule_guard_251(m,f,bf)) {match=251;count++;}
if(m->state==0&&event==2&&rule_guard_252(m,f,bf)) {match=252;count++;}
if(m->state==0&&event==2&&rule_guard_253(m,f,bf)) {match=253;count++;}
if(m->state==0&&event==2&&rule_guard_254(m,f,bf)) {match=254;count++;}
if(m->state==0&&event==2&&rule_guard_255(m,f,bf)) {match=255;count++;}
if(m->state==0&&event==2&&rule_guard_256(m,f,bf)) {match=256;count++;}
if(m->state==0&&event==2&&rule_guard_257(m,f,bf)) {match=257;count++;}
if(m->state==0&&event==18&&rule_guard_258(m,f,bf)) {match=258;count++;}
if(m->state==0&&event==18&&rule_guard_259(m,f,bf)) {match=259;count++;}
if(m->state==0&&event==18&&rule_guard_260(m,f,bf)) {match=260;count++;}
if(m->state==0&&event==2&&rule_guard_261(m,f,bf)) {match=261;count++;}
if(m->state==0&&event==2&&rule_guard_262(m,f,bf)) {match=262;count++;}
if(m->state==0&&event==2&&rule_guard_263(m,f,bf)) {match=263;count++;}
if(m->state==0&&event==2&&rule_guard_264(m,f,bf)) {match=264;count++;}
if(m->state==0&&event==2&&rule_guard_265(m,f,bf)) {match=265;count++;}
if(m->state==0&&event==2&&rule_guard_266(m,f,bf)) {match=266;count++;}
if(m->state==0&&event==2&&rule_guard_267(m,f,bf)) {match=267;count++;}
if(m->state==0&&event==2&&rule_guard_268(m,f,bf)) {match=268;count++;}
if(m->state==0&&event==2&&rule_guard_269(m,f,bf)) {match=269;count++;}
if(m->state==0&&event==2&&rule_guard_270(m,f,bf)) {match=270;count++;}
if(m->state==0&&event==2&&rule_guard_271(m,f,bf)) {match=271;count++;}
if(m->state==0&&event==2&&rule_guard_272(m,f,bf)) {match=272;count++;}
if(m->state==0&&event==2&&rule_guard_273(m,f,bf)) {match=273;count++;}
if(m->state==0&&event==2&&rule_guard_274(m,f,bf)) {match=274;count++;}
if(m->state==0&&event==2&&rule_guard_275(m,f,bf)) {match=275;count++;}
if(m->state==0&&event==23&&rule_guard_276(m,f,bf)) {match=276;count++;}
if(m->state==0&&event==23&&rule_guard_277(m,f,bf)) {match=277;count++;}
if(m->state==0&&event==23&&rule_guard_278(m,f,bf)) {match=278;count++;}
if(m->state==0&&event==2&&rule_guard_279(m,f,bf)) {match=279;count++;}
if(m->state==0&&event==2&&rule_guard_280(m,f,bf)) {match=280;count++;}
if(m->state==0&&event==2&&rule_guard_281(m,f,bf)) {match=281;count++;}
if(m->state==0&&event==2&&rule_guard_282(m,f,bf)) {match=282;count++;}
if(m->state==0&&event==2&&rule_guard_283(m,f,bf)) {match=283;count++;}
if(m->state==0&&event==2&&rule_guard_284(m,f,bf)) {match=284;count++;}
if(m->state==0&&event==2&&rule_guard_285(m,f,bf)) {match=285;count++;}
if(m->state==0&&event==2&&rule_guard_286(m,f,bf)) {match=286;count++;}
if(m->state==0&&event==2&&rule_guard_287(m,f,bf)) {match=287;count++;}
if(m->state==0&&event==2&&rule_guard_288(m,f,bf)) {match=288;count++;}
if(m->state==0&&event==2&&rule_guard_289(m,f,bf)) {match=289;count++;}
if(m->state==0&&event==2&&rule_guard_290(m,f,bf)) {match=290;count++;}
if(m->state==0&&event==2&&rule_guard_291(m,f,bf)) {match=291;count++;}
if(m->state==0&&event==2&&rule_guard_292(m,f,bf)) {match=292;count++;}
if(m->state==0&&event==2&&rule_guard_293(m,f,bf)) {match=293;count++;}
if(m->state==0&&event==2&&rule_guard_294(m,f,bf)) {match=294;count++;}
if(m->state==0&&event==2&&rule_guard_295(m,f,bf)) {match=295;count++;}
if(m->state==0&&event==2&&rule_guard_296(m,f,bf)) {match=296;count++;}
if(m->state==0&&event==2&&rule_guard_297(m,f,bf)) {match=297;count++;}
if(m->state==0&&event==2&&rule_guard_298(m,f,bf)) {match=298;count++;}
if(m->state==0&&event==2&&rule_guard_299(m,f,bf)) {match=299;count++;}
if(m->state==0&&event==2&&rule_guard_300(m,f,bf)) {match=300;count++;}
if(m->state==0&&event==2&&rule_guard_301(m,f,bf)) {match=301;count++;}
if(m->state==0&&event==2&&rule_guard_302(m,f,bf)) {match=302;count++;}
if(m->state==0&&event==2&&rule_guard_303(m,f,bf)) {match=303;count++;}
if(m->state==0&&event==2&&rule_guard_304(m,f,bf)) {match=304;count++;}
if(m->state==0&&event==2&&rule_guard_305(m,f,bf)) {match=305;count++;}
if(m->state==0&&event==2&&rule_guard_306(m,f,bf)) {match=306;count++;}
if(m->state==0&&event==2&&rule_guard_307(m,f,bf)) {match=307;count++;}
if(m->state==0&&event==2&&rule_guard_308(m,f,bf)) {match=308;count++;}
if(m->state==0&&event==2&&rule_guard_309(m,f,bf)) {match=309;count++;}
if(m->state==0&&event==2&&rule_guard_310(m,f,bf)) {match=310;count++;}
if(m->state==0&&event==2&&rule_guard_311(m,f,bf)) {match=311;count++;}
if(m->state==0&&event==2&&rule_guard_312(m,f,bf)) {match=312;count++;}
if(m->state==0&&event==2&&rule_guard_313(m,f,bf)) {match=313;count++;}
if(m->state==0&&event==2&&rule_guard_314(m,f,bf)) {match=314;count++;}
if(m->state==0&&event==2&&rule_guard_315(m,f,bf)) {match=315;count++;}
if(m->state==0&&event==2&&rule_guard_316(m,f,bf)) {match=316;count++;}
if(m->state==0&&event==2&&rule_guard_317(m,f,bf)) {match=317;count++;}
if(m->state==0&&event==2&&rule_guard_318(m,f,bf)) {match=318;count++;}
if(m->state==0&&event==2&&rule_guard_319(m,f,bf)) {match=319;count++;}
if(m->state==0&&event==2&&rule_guard_320(m,f,bf)) {match=320;count++;}
if(m->state==0&&event==2&&rule_guard_321(m,f,bf)) {match=321;count++;}
if(m->state==0&&event==2&&rule_guard_322(m,f,bf)) {match=322;count++;}
if(m->state==0&&event==2&&rule_guard_323(m,f,bf)) {match=323;count++;}
if(m->state==0&&event==2&&rule_guard_324(m,f,bf)) {match=324;count++;}
if(m->state==0&&event==2&&rule_guard_325(m,f,bf)) {match=325;count++;}
if(m->state==0&&event==2&&rule_guard_326(m,f,bf)) {match=326;count++;}
if(m->state==0&&event==2&&rule_guard_327(m,f,bf)) {match=327;count++;}
if(m->state==0&&event==2&&rule_guard_328(m,f,bf)) {match=328;count++;}
if(m->state==0&&event==2&&rule_guard_329(m,f,bf)) {match=329;count++;}
if(m->state==0&&event==2&&rule_guard_330(m,f,bf)) {match=330;count++;}
if(m->state==0&&event==2&&rule_guard_331(m,f,bf)) {match=331;count++;}
if(m->state==0&&event==2&&rule_guard_332(m,f,bf)) {match=332;count++;}
if(m->state==0&&event==2&&rule_guard_333(m,f,bf)) {match=333;count++;}
if(m->state==0&&event==2&&rule_guard_334(m,f,bf)) {match=334;count++;}
if(failure)return 0;
if(count!=1){failure=count?"rule_conflict":"uncovered_event";return 0;} if(expiring>=0)m->active[expiring]=0; switch(match) {
case 0:return rule_action_0(m,f,bf,log);
case 1:return rule_action_1(m,f,bf,log);
case 2:return rule_action_2(m,f,bf,log);
case 3:return rule_action_3(m,f,bf,log);
case 4:return rule_action_4(m,f,bf,log);
case 5:return rule_action_5(m,f,bf,log);
case 6:return rule_action_6(m,f,bf,log);
case 7:return rule_action_7(m,f,bf,log);
case 8:return rule_action_8(m,f,bf,log);
case 9:return rule_action_9(m,f,bf,log);
case 10:return rule_action_10(m,f,bf,log);
case 11:return rule_action_11(m,f,bf,log);
case 12:return rule_action_12(m,f,bf,log);
case 13:return rule_action_13(m,f,bf,log);
case 14:return rule_action_14(m,f,bf,log);
case 15:return rule_action_15(m,f,bf,log);
case 16:return rule_action_16(m,f,bf,log);
case 17:return rule_action_17(m,f,bf,log);
case 18:return rule_action_18(m,f,bf,log);
case 19:return rule_action_19(m,f,bf,log);
case 20:return rule_action_20(m,f,bf,log);
case 21:return rule_action_21(m,f,bf,log);
case 22:return rule_action_22(m,f,bf,log);
case 23:return rule_action_23(m,f,bf,log);
case 24:return rule_action_24(m,f,bf,log);
case 25:return rule_action_25(m,f,bf,log);
case 26:return rule_action_26(m,f,bf,log);
case 27:return rule_action_27(m,f,bf,log);
case 28:return rule_action_28(m,f,bf,log);
case 29:return rule_action_29(m,f,bf,log);
case 30:return rule_action_30(m,f,bf,log);
case 31:return rule_action_31(m,f,bf,log);
case 32:return rule_action_32(m,f,bf,log);
case 33:return rule_action_33(m,f,bf,log);
case 34:return rule_action_34(m,f,bf,log);
case 35:return rule_action_35(m,f,bf,log);
case 36:return rule_action_36(m,f,bf,log);
case 37:return rule_action_37(m,f,bf,log);
case 38:return rule_action_38(m,f,bf,log);
case 39:return rule_action_39(m,f,bf,log);
case 40:return rule_action_40(m,f,bf,log);
case 41:return rule_action_41(m,f,bf,log);
case 42:return rule_action_42(m,f,bf,log);
case 43:return rule_action_43(m,f,bf,log);
case 44:return rule_action_44(m,f,bf,log);
case 45:return rule_action_45(m,f,bf,log);
case 46:return rule_action_46(m,f,bf,log);
case 47:return rule_action_47(m,f,bf,log);
case 48:return rule_action_48(m,f,bf,log);
case 49:return rule_action_49(m,f,bf,log);
case 50:return rule_action_50(m,f,bf,log);
case 51:return rule_action_51(m,f,bf,log);
case 52:return rule_action_52(m,f,bf,log);
case 53:return rule_action_53(m,f,bf,log);
case 54:return rule_action_54(m,f,bf,log);
case 55:return rule_action_55(m,f,bf,log);
case 56:return rule_action_56(m,f,bf,log);
case 57:return rule_action_57(m,f,bf,log);
case 58:return rule_action_58(m,f,bf,log);
case 59:return rule_action_59(m,f,bf,log);
case 60:return rule_action_60(m,f,bf,log);
case 61:return rule_action_61(m,f,bf,log);
case 62:return rule_action_62(m,f,bf,log);
case 63:return rule_action_63(m,f,bf,log);
case 64:return rule_action_64(m,f,bf,log);
case 65:return rule_action_65(m,f,bf,log);
case 66:return rule_action_66(m,f,bf,log);
case 67:return rule_action_67(m,f,bf,log);
case 68:return rule_action_68(m,f,bf,log);
case 69:return rule_action_69(m,f,bf,log);
case 70:return rule_action_70(m,f,bf,log);
case 71:return rule_action_71(m,f,bf,log);
case 72:return rule_action_72(m,f,bf,log);
case 73:return rule_action_73(m,f,bf,log);
case 74:return rule_action_74(m,f,bf,log);
case 75:return rule_action_75(m,f,bf,log);
case 76:return rule_action_76(m,f,bf,log);
case 77:return rule_action_77(m,f,bf,log);
case 78:return rule_action_78(m,f,bf,log);
case 79:return rule_action_79(m,f,bf,log);
case 80:return rule_action_80(m,f,bf,log);
case 81:return rule_action_81(m,f,bf,log);
case 82:return rule_action_82(m,f,bf,log);
case 83:return rule_action_83(m,f,bf,log);
case 84:return rule_action_84(m,f,bf,log);
case 85:return rule_action_85(m,f,bf,log);
case 86:return rule_action_86(m,f,bf,log);
case 87:return rule_action_87(m,f,bf,log);
case 88:return rule_action_88(m,f,bf,log);
case 89:return rule_action_89(m,f,bf,log);
case 90:return rule_action_90(m,f,bf,log);
case 91:return rule_action_91(m,f,bf,log);
case 92:return rule_action_92(m,f,bf,log);
case 93:return rule_action_93(m,f,bf,log);
case 94:return rule_action_94(m,f,bf,log);
case 95:return rule_action_95(m,f,bf,log);
case 96:return rule_action_96(m,f,bf,log);
case 97:return rule_action_97(m,f,bf,log);
case 98:return rule_action_98(m,f,bf,log);
case 99:return rule_action_99(m,f,bf,log);
case 100:return rule_action_100(m,f,bf,log);
case 101:return rule_action_101(m,f,bf,log);
case 102:return rule_action_102(m,f,bf,log);
case 103:return rule_action_103(m,f,bf,log);
case 104:return rule_action_104(m,f,bf,log);
case 105:return rule_action_105(m,f,bf,log);
case 106:return rule_action_106(m,f,bf,log);
case 107:return rule_action_107(m,f,bf,log);
case 108:return rule_action_108(m,f,bf,log);
case 109:return rule_action_109(m,f,bf,log);
case 110:return rule_action_110(m,f,bf,log);
case 111:return rule_action_111(m,f,bf,log);
case 112:return rule_action_112(m,f,bf,log);
case 113:return rule_action_113(m,f,bf,log);
case 114:return rule_action_114(m,f,bf,log);
case 115:return rule_action_115(m,f,bf,log);
case 116:return rule_action_116(m,f,bf,log);
case 117:return rule_action_117(m,f,bf,log);
case 118:return rule_action_118(m,f,bf,log);
case 119:return rule_action_119(m,f,bf,log);
case 120:return rule_action_120(m,f,bf,log);
case 121:return rule_action_121(m,f,bf,log);
case 122:return rule_action_122(m,f,bf,log);
case 123:return rule_action_123(m,f,bf,log);
case 124:return rule_action_124(m,f,bf,log);
case 125:return rule_action_125(m,f,bf,log);
case 126:return rule_action_126(m,f,bf,log);
case 127:return rule_action_127(m,f,bf,log);
case 128:return rule_action_128(m,f,bf,log);
case 129:return rule_action_129(m,f,bf,log);
case 130:return rule_action_130(m,f,bf,log);
case 131:return rule_action_131(m,f,bf,log);
case 132:return rule_action_132(m,f,bf,log);
case 133:return rule_action_133(m,f,bf,log);
case 134:return rule_action_134(m,f,bf,log);
case 135:return rule_action_135(m,f,bf,log);
case 136:return rule_action_136(m,f,bf,log);
case 137:return rule_action_137(m,f,bf,log);
case 138:return rule_action_138(m,f,bf,log);
case 139:return rule_action_139(m,f,bf,log);
case 140:return rule_action_140(m,f,bf,log);
case 141:return rule_action_141(m,f,bf,log);
case 142:return rule_action_142(m,f,bf,log);
case 143:return rule_action_143(m,f,bf,log);
case 144:return rule_action_144(m,f,bf,log);
case 145:return rule_action_145(m,f,bf,log);
case 146:return rule_action_146(m,f,bf,log);
case 147:return rule_action_147(m,f,bf,log);
case 148:return rule_action_148(m,f,bf,log);
case 149:return rule_action_149(m,f,bf,log);
case 150:return rule_action_150(m,f,bf,log);
case 151:return rule_action_151(m,f,bf,log);
case 152:return rule_action_152(m,f,bf,log);
case 153:return rule_action_153(m,f,bf,log);
case 154:return rule_action_154(m,f,bf,log);
case 155:return rule_action_155(m,f,bf,log);
case 156:return rule_action_156(m,f,bf,log);
case 157:return rule_action_157(m,f,bf,log);
case 158:return rule_action_158(m,f,bf,log);
case 159:return rule_action_159(m,f,bf,log);
case 160:return rule_action_160(m,f,bf,log);
case 161:return rule_action_161(m,f,bf,log);
case 162:return rule_action_162(m,f,bf,log);
case 163:return rule_action_163(m,f,bf,log);
case 164:return rule_action_164(m,f,bf,log);
case 165:return rule_action_165(m,f,bf,log);
case 166:return rule_action_166(m,f,bf,log);
case 167:return rule_action_167(m,f,bf,log);
case 168:return rule_action_168(m,f,bf,log);
case 169:return rule_action_169(m,f,bf,log);
case 170:return rule_action_170(m,f,bf,log);
case 171:return rule_action_171(m,f,bf,log);
case 172:return rule_action_172(m,f,bf,log);
case 173:return rule_action_173(m,f,bf,log);
case 174:return rule_action_174(m,f,bf,log);
case 175:return rule_action_175(m,f,bf,log);
case 176:return rule_action_176(m,f,bf,log);
case 177:return rule_action_177(m,f,bf,log);
case 178:return rule_action_178(m,f,bf,log);
case 179:return rule_action_179(m,f,bf,log);
case 180:return rule_action_180(m,f,bf,log);
case 181:return rule_action_181(m,f,bf,log);
case 182:return rule_action_182(m,f,bf,log);
case 183:return rule_action_183(m,f,bf,log);
case 184:return rule_action_184(m,f,bf,log);
case 185:return rule_action_185(m,f,bf,log);
case 186:return rule_action_186(m,f,bf,log);
case 187:return rule_action_187(m,f,bf,log);
case 188:return rule_action_188(m,f,bf,log);
case 189:return rule_action_189(m,f,bf,log);
case 190:return rule_action_190(m,f,bf,log);
case 191:return rule_action_191(m,f,bf,log);
case 192:return rule_action_192(m,f,bf,log);
case 193:return rule_action_193(m,f,bf,log);
case 194:return rule_action_194(m,f,bf,log);
case 195:return rule_action_195(m,f,bf,log);
case 196:return rule_action_196(m,f,bf,log);
case 197:return rule_action_197(m,f,bf,log);
case 198:return rule_action_198(m,f,bf,log);
case 199:return rule_action_199(m,f,bf,log);
case 200:return rule_action_200(m,f,bf,log);
case 201:return rule_action_201(m,f,bf,log);
case 202:return rule_action_202(m,f,bf,log);
case 203:return rule_action_203(m,f,bf,log);
case 204:return rule_action_204(m,f,bf,log);
case 205:return rule_action_205(m,f,bf,log);
case 206:return rule_action_206(m,f,bf,log);
case 207:return rule_action_207(m,f,bf,log);
case 208:return rule_action_208(m,f,bf,log);
case 209:return rule_action_209(m,f,bf,log);
case 210:return rule_action_210(m,f,bf,log);
case 211:return rule_action_211(m,f,bf,log);
case 212:return rule_action_212(m,f,bf,log);
case 213:return rule_action_213(m,f,bf,log);
case 214:return rule_action_214(m,f,bf,log);
case 215:return rule_action_215(m,f,bf,log);
case 216:return rule_action_216(m,f,bf,log);
case 217:return rule_action_217(m,f,bf,log);
case 218:return rule_action_218(m,f,bf,log);
case 219:return rule_action_219(m,f,bf,log);
case 220:return rule_action_220(m,f,bf,log);
case 221:return rule_action_221(m,f,bf,log);
case 222:return rule_action_222(m,f,bf,log);
case 223:return rule_action_223(m,f,bf,log);
case 224:return rule_action_224(m,f,bf,log);
case 225:return rule_action_225(m,f,bf,log);
case 226:return rule_action_226(m,f,bf,log);
case 227:return rule_action_227(m,f,bf,log);
case 228:return rule_action_228(m,f,bf,log);
case 229:return rule_action_229(m,f,bf,log);
case 230:return rule_action_230(m,f,bf,log);
case 231:return rule_action_231(m,f,bf,log);
case 232:return rule_action_232(m,f,bf,log);
case 233:return rule_action_233(m,f,bf,log);
case 234:return rule_action_234(m,f,bf,log);
case 235:return rule_action_235(m,f,bf,log);
case 236:return rule_action_236(m,f,bf,log);
case 237:return rule_action_237(m,f,bf,log);
case 238:return rule_action_238(m,f,bf,log);
case 239:return rule_action_239(m,f,bf,log);
case 240:return rule_action_240(m,f,bf,log);
case 241:return rule_action_241(m,f,bf,log);
case 242:return rule_action_242(m,f,bf,log);
case 243:return rule_action_243(m,f,bf,log);
case 244:return rule_action_244(m,f,bf,log);
case 245:return rule_action_245(m,f,bf,log);
case 246:return rule_action_246(m,f,bf,log);
case 247:return rule_action_247(m,f,bf,log);
case 248:return rule_action_248(m,f,bf,log);
case 249:return rule_action_249(m,f,bf,log);
case 250:return rule_action_250(m,f,bf,log);
case 251:return rule_action_251(m,f,bf,log);
case 252:return rule_action_252(m,f,bf,log);
case 253:return rule_action_253(m,f,bf,log);
case 254:return rule_action_254(m,f,bf,log);
case 255:return rule_action_255(m,f,bf,log);
case 256:return rule_action_256(m,f,bf,log);
case 257:return rule_action_257(m,f,bf,log);
case 258:return rule_action_258(m,f,bf,log);
case 259:return rule_action_259(m,f,bf,log);
case 260:return rule_action_260(m,f,bf,log);
case 261:return rule_action_261(m,f,bf,log);
case 262:return rule_action_262(m,f,bf,log);
case 263:return rule_action_263(m,f,bf,log);
case 264:return rule_action_264(m,f,bf,log);
case 265:return rule_action_265(m,f,bf,log);
case 266:return rule_action_266(m,f,bf,log);
case 267:return rule_action_267(m,f,bf,log);
case 268:return rule_action_268(m,f,bf,log);
case 269:return rule_action_269(m,f,bf,log);
case 270:return rule_action_270(m,f,bf,log);
case 271:return rule_action_271(m,f,bf,log);
case 272:return rule_action_272(m,f,bf,log);
case 273:return rule_action_273(m,f,bf,log);
case 274:return rule_action_274(m,f,bf,log);
case 275:return rule_action_275(m,f,bf,log);
case 276:return rule_action_276(m,f,bf,log);
case 277:return rule_action_277(m,f,bf,log);
case 278:return rule_action_278(m,f,bf,log);
case 279:return rule_action_279(m,f,bf,log);
case 280:return rule_action_280(m,f,bf,log);
case 281:return rule_action_281(m,f,bf,log);
case 282:return rule_action_282(m,f,bf,log);
case 283:return rule_action_283(m,f,bf,log);
case 284:return rule_action_284(m,f,bf,log);
case 285:return rule_action_285(m,f,bf,log);
case 286:return rule_action_286(m,f,bf,log);
case 287:return rule_action_287(m,f,bf,log);
case 288:return rule_action_288(m,f,bf,log);
case 289:return rule_action_289(m,f,bf,log);
case 290:return rule_action_290(m,f,bf,log);
case 291:return rule_action_291(m,f,bf,log);
case 292:return rule_action_292(m,f,bf,log);
case 293:return rule_action_293(m,f,bf,log);
case 294:return rule_action_294(m,f,bf,log);
case 295:return rule_action_295(m,f,bf,log);
case 296:return rule_action_296(m,f,bf,log);
case 297:return rule_action_297(m,f,bf,log);
case 298:return rule_action_298(m,f,bf,log);
case 299:return rule_action_299(m,f,bf,log);
case 300:return rule_action_300(m,f,bf,log);
case 301:return rule_action_301(m,f,bf,log);
case 302:return rule_action_302(m,f,bf,log);
case 303:return rule_action_303(m,f,bf,log);
case 304:return rule_action_304(m,f,bf,log);
case 305:return rule_action_305(m,f,bf,log);
case 306:return rule_action_306(m,f,bf,log);
case 307:return rule_action_307(m,f,bf,log);
case 308:return rule_action_308(m,f,bf,log);
case 309:return rule_action_309(m,f,bf,log);
case 310:return rule_action_310(m,f,bf,log);
case 311:return rule_action_311(m,f,bf,log);
case 312:return rule_action_312(m,f,bf,log);
case 313:return rule_action_313(m,f,bf,log);
case 314:return rule_action_314(m,f,bf,log);
case 315:return rule_action_315(m,f,bf,log);
case 316:return rule_action_316(m,f,bf,log);
case 317:return rule_action_317(m,f,bf,log);
case 318:return rule_action_318(m,f,bf,log);
case 319:return rule_action_319(m,f,bf,log);
case 320:return rule_action_320(m,f,bf,log);
case 321:return rule_action_321(m,f,bf,log);
case 322:return rule_action_322(m,f,bf,log);
case 323:return rule_action_323(m,f,bf,log);
case 324:return rule_action_324(m,f,bf,log);
case 325:return rule_action_325(m,f,bf,log);
case 326:return rule_action_326(m,f,bf,log);
case 327:return rule_action_327(m,f,bf,log);
case 328:return rule_action_328(m,f,bf,log);
case 329:return rule_action_329(m,f,bf,log);
case 330:return rule_action_330(m,f,bf,log);
case 331:return rule_action_331(m,f,bf,log);
case 332:return rule_action_332(m,f,bf,log);
case 333:return rule_action_333(m,f,bf,log);
case 334:return rule_action_334(m,f,bf,log);
default:failure="invalid_rule";return 0;} }
/* Line interface for independent execution; no JSON model is read at runtime.
   I variable-index integer (before B), B, D milliseconds event integer-fields,
   T milliseconds. Each operation is committed atomically after all checks. */
int advance(Machine *m,int64_t at,Buffer *log) {
    int steps=0;
    if(at<m->now){failure="nonmonotonic_time";return 0;}
    for(;;) {
        int next=-1,i;
        for(i=0;i<NT;i++)if(m->active[i] && (next<0||m->due[i]<m->due[next]||
             (m->due[i]==m->due[next]&&strcmp(timer_names[i],timer_names[next])<0)))next=i;
        if(next<0||m->due[next]>at)break;
        if(++steps>4096){failure="timer_step_capacity";return 0;}
        m->now=m->due[next];
        if(!fire(m,timer_events[next],NULL,NULL,next,log)){if(!failure)failure="internal_transition_failure";return 0;}
    }
    m->now=at;return 1;
}
int parse_integer(const char *s,int64_t *out) {
    char *end; long long n;
    if(!s||!*s)return 0;
    errno=0;n=strtoll(s,&end,10);
    if(errno||*end||n<INT64_MIN||n>INT64_MAX)return 0;
    *out=(int64_t)n;return 1;
}
#ifdef HAS_TEXT_EVENTS
int parse_text_field(TextPool *pool, const char *token, int64_t *out) {
    return parse_text(pool, token, out);
}
#endif
void reply(Machine *m,const char *status,const char *error) {
    Buffer out={{0},0};
    text(&out,"{\"status\":\"");text(&out,status);text(&out,"\"");
    if(error){text(&out,",\"failure\":");json_string(&out,error);}
    text(&out,",\"snapshot\":");snapshot(&out,m);text(&out,"}\n");fputs(out.data,stdout);
}
int snapshot_fits(Machine *m) {
    Buffer preview={{0},0};snapshot(&preview,m);
    if(preview.size>LOG_CAP-4096)failure="output_capacity";
    return failure==NULL;
}
int main(void) {
    Machine committed;char line[INPUT_CAP];int begun=0,errors=0;
    initialize(&committed);
    while(fgets(line,sizeof(line),stdin)) {
        char *tokens[FIELD_CAP+4];int count=0,overflow=0,i,event=-1;char *token;
        int64_t at=0,fields[FIELD_CAP]={0};Bytes byte_fields[FIELD_CAP]={{0}};Machine candidate=committed;Buffer log={{0},0};
        failure=NULL;
        if(!strchr(line,'\n')&&!feof(stdin)){failure="input_capacity";while((i=getchar())!='\n'&&i!=EOF){} }
        token=strtok(line," \t\r\n");
        while(token){if(count<(int)(sizeof(tokens)/sizeof(tokens[0])))tokens[count++]=token;else overflow=1;token=strtok(NULL," \t\r\n");}
        if(!count)continue;
        if(overflow)failure="input_capacity";
        if(!failure && !strcmp(tokens[0],"I")) {
            int64_t index,value;
            if(begun||count!=3||!parse_integer(tokens[1],&index)||index<0||index>=NV)failure="invalid_initial_override";
            else if(variable_kinds[index]==3)parse_bytes(tokens[2],&candidate.b[variable_byte_index[index]]);
#ifdef HAS_TEXT_EVENTS
            else if(variable_kinds[index]==4) {
                if(!parse_text_field(&candidate.texts, tokens[2], &value)&&!failure) failure="invalid_initial_override";
                else if(!failure) candidate.v[index]=value;
            }
#endif
            else if(!parse_integer(tokens[2],&value)||!valid(value,variable_kinds[index]))failure="invalid_initial_override";
            else candidate.v[index]=value;
            if(!failure&&snapshot_fits(&candidate)){committed=candidate;continue;}
        } else if(!failure && !strcmp(tokens[0],"B")) {
            if(begun||count!=1)failure="invalid_begin";
            else if(invariants(&candidate)){begun=1;reply(&committed,"ready",NULL);continue;}
        } else if(!failure && (!strcmp(tokens[0],"D")||!strcmp(tokens[0],"T")
#ifdef WIRE_PROFILE
                  ||!strcmp(tokens[0],"P")
#endif
                  )) {
            if(!begun||count<2||!parse_integer(tokens[1],&at))failure="invalid_command";
            if(!failure && !strcmp(tokens[0],"D")) {
                if(count<3)failure="invalid_command";
                else {
                    for(i=0;i<(int)(sizeof(event_names)/sizeof(event_names[0]));i++)if(!strcmp(tokens[2],event_names[i]))event=i;
                    if(event<0)failure="unknown_event";
                    else if(event_origin[event])failure="timer_injection";
                    else if(count!=3+event_fields[event])failure="event_field_mismatch";
                    else for(i=0;i<event_fields[event]&&!failure;i++) {
                        if(event_kinds[event][i]==3)parse_bytes(tokens[3+i],&byte_fields[i]);
#ifdef HAS_TEXT_EVENTS
                        else if(event_kinds[event][i]==4) {
                            if(!parse_text_field(&candidate.texts, tokens[3+i], &fields[i])&&!failure) failure="invalid_event_value";
                        }
#endif
                        else if(!parse_integer(tokens[3+i],&fields[i])||!valid(fields[i],event_kinds[event][i]))failure="invalid_event_value";
                    }
                }
            }
#ifdef WIRE_PROFILE
            else if(!failure && !strcmp(tokens[0],"P")) {
                if(count!=3)failure="invalid_wire_command";
                else if(wire_decode(tokens[2],fields))event=WIRE_EVENT;
            }
#endif
            else if(!failure && count!=2)failure="invalid_command";
            if(!failure && advance(&candidate,at,&log)) {
                if(event>=0){if(!fire(&candidate,event,fields,byte_fields,-1,&log)&&!failure)failure="internal_transition_failure";}
                else if(!invariants(&candidate)&&!failure)failure="internal_invariant_failure";
            }
            if(!failure&&snapshot_fits(&candidate)){committed=candidate;fputs(log.data,stdout);reply(&committed,"ok",NULL);continue;}
        } else if(!failure)failure="invalid_command";
        errors++;reply(&committed,"error",failure?failure:"internal_error");
    }
    if(ferror(stdin))return 2;
    if(!begun)return 2;
    return errors?1:0;
}

