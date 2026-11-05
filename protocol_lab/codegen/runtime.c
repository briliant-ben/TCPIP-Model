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
    return kind==0 || (kind==1 && (n==0||n==1)) || (kind==2 && n>=0 && n<SEQ_MOD);
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
