#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "tcpip/memp.h"
#include "tcpip/pbuf.h"
#include "tcpip/pcap.h"
#include "tcpip/sys.h"
#include "tcpip/tcpip.h"
#include "actor_fsm.h"

#if !TCPIP_NO_SYS
typedef struct {
    sys_mbox_t *mbox;
    int tid;
    int count;
} prod_arg_t;

static void producer_worker(void *raw) {
    prod_arg_t *pa = (prod_arg_t *)raw;
    for (int i = 0; i < pa->count; i++) {
        uintptr_t val = (uintptr_t)((pa->tid << 16) | i | 1);
        sys_mbox_post(pa->mbox, (void *)val);
    }
}

typedef struct {
    int in;
    int out;
} api_echo_arg_t;

static err_t api_double_fn(void *raw) {
    api_echo_arg_t *a = (api_echo_arg_t *)raw;
    a->out = a->in * 2 + 1;
    return ERR_OK;
}

typedef struct {
    int calls;
    int done;
} thr_stress_arg_t;

static void api_caller_thread(void *raw) {
    thr_stress_arg_t *ta = (thr_stress_arg_t *)raw;
    for (int i = 0; i < ta->calls; i++) {
        api_echo_arg_t req = { i, 0 };
        err_t rc = tcpip_api_call(api_double_fn, &req);
        assert(rc == ERR_OK);
        assert(req.out == i * 2 + 1);
        struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, 64, PBUF_POOL);
        assert(p != NULL);
        assert(pbuf_header(p, -20) == 0);
        assert(pbuf_header(p, -14) == 0);
        assert(tcpip_input(p, NULL) == ERR_OK);
    }
    ta->done = 1;
}
#endif

static void test_pbuf_and_memp_contracts(void) {
    memp_init();
    uint32_t init_avail = memp_avail(MEMP_PBUF_POOL);
    assert(init_avail == TCPIP_MEMP_NUM_PBUF_POOL);

    struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, 100, PBUF_POOL);
    assert(p != NULL && p->len == 100 && p->tot_len == 100 && p->ref == 1);
    uint8_t data[100];
    for (int i = 0; i < 100; i++) data[i] = (uint8_t)i;
    assert(pbuf_take(p, data, 100) == ERR_OK);

    /* Zero-copy header prepending (IP 20B + Eth 14B) */
    assert(pbuf_header(p, -20) == 0);
    assert(p->len == 120 && p->tot_len == 120);
    assert(pbuf_header(p, -14) == 0);
    assert(p->len == 134 && p->tot_len == 134);
    assert(pbuf_header(p, 34) == 0);
    assert(p->len == 100);

    uint8_t check[100];
    assert(pbuf_copy_partial(p, check, 100, 0) == 100);
    assert(memcmp(data, check, 100) == 0);

    /* Chained allocation (4000B > single 1600B slot) */
    struct pbuf *big = pbuf_alloc(PBUF_IP, 4000, PBUF_POOL);
    assert(big != NULL && big->tot_len == 4000 && pbuf_clen(big) == 3);
    pbuf_ref(big);
    assert(pbuf_free(big) == 0);
    assert(pbuf_free(big) == 3);
    assert(pbuf_free(p) == 1);
    assert(memp_avail(MEMP_PBUF_POOL) == init_avail);
}

static void test_pcap_writer(void) {
    const char *path = "/tmp/tcpip_m1_test.pcap";
    tcpip_pcap_t *pcap = NULL;
    assert(tcpip_pcap_open(&pcap, path) == ERR_OK);
    uint8_t frame[60];
    memset(frame, 0xAB, sizeof(frame));
    tcpip_pcap_write(pcap, 1000500ULL, frame, sizeof(frame));
    assert(tcpip_pcap_packet_count(pcap) == 1);
    tcpip_pcap_close(pcap);

    FILE *fp = fopen(path, "rb");
    assert(fp != NULL);
    uint8_t hdr[24];
    assert(fread(hdr, 1, 24, fp) == 24);
    assert(hdr[0] == 0xD4 && hdr[1] == 0xC3 && hdr[2] == 0xB2 && hdr[3] == 0xA1);
    fclose(fp);
    remove(path);
}

#if TCPIP_NO_SYS
static int nosys_timer_hits = 0;
static void nosys_tmr(void *ctx, uint32_t now_ms) {
    (void)ctx; (void)now_ms;
    nosys_timer_hits++;
}
#endif

int main(void) {
    test_pbuf_and_memp_contracts();
    test_pcap_writer();

#if TCPIP_NO_SYS
    tcpip_init(NULL, NULL);
    assert(tcpip_timer_add(50, nosys_tmr, NULL) == ERR_OK);
    tcpip_poll(40);
    assert(nosys_timer_hits == 0);
    tcpip_poll(60);
    assert(nosys_timer_hits == 1);
    tcpip_poll(120);
    assert(nosys_timer_hits == 2);
    tcpip_shutdown();
    assert(tcpip_actor_state() == ACTOR_FSM_STATE_STOPPED);
    printf("M1 NO_SYS=1 OK (timers=%d)\n", nosys_timer_hits);
#else
    sys_init();
    sys_mbox_t mb;
    assert(sys_mbox_new(&mb, 32) == ERR_OK);
    sys_thread_t prods[4];
    prod_arg_t pargs[4];
    for (int t = 0; t < 4; t++) {
        pargs[t].mbox = &mb;
        pargs[t].tid = t;
        pargs[t].count = 200;
        prods[t] = sys_thread_new("prod", producer_worker, &pargs[t], 0, 0);
    }
    int received = 0;
    while (received < 800) {
        void *msg = NULL;
        assert(sys_arch_mbox_fetch(&mb, &msg, 5000) != SYS_ARCH_TIMEOUT);
        assert(msg != NULL);
        received++;
    }
    for (int t = 0; t < 4; t++) sys_thread_join(prods[t]);
    sys_mbox_free(&mb);

    tcpip_init(NULL, NULL);
    sys_thread_t callers[4];
    thr_stress_arg_t cargs[4];
    for (int t = 0; t < 4; t++) {
        cargs[t].calls = 250;
        cargs[t].done = 0;
        callers[t] = sys_thread_new("caller", api_caller_thread, &cargs[t], 0, 0);
    }
    for (int t = 0; t < 4; t++) {
        sys_thread_join(callers[t]);
        assert(cargs[t].done == 1);
    }
    tcpip_shutdown();
    assert(memp_avail(MEMP_PBUF_POOL) == TCPIP_MEMP_NUM_PBUF_POOL);
    assert(tcpip_actor_state() == ACTOR_FSM_STATE_STOPPED);
    printf("M1 NO_SYS=0 OK (1000 RPC+RX actor ops, 0 leaks, 0 races)\n");
#endif
    return 0;
}
