#include <string.h>
#include "tcpip/memp.h"
#include "tcpip/sys.h"
#include "tcpip/tcpip.h"
#if TCPIP_VERIFY_FSM
#include "actor_fsm.h"
#endif

#define TCPIP_MAX_TIMERS 8

enum {
    TCPIP_MSG_INPKT = 1,
    TCPIP_MSG_CALLBACK,
    TCPIP_MSG_API,
    TCPIP_MSG_SHUTDOWN
};

typedef struct {
    int type;
    union {
        struct {
            struct pbuf *p;
            struct netif *inp;
        } inp;
        struct {
            tcpip_callback_fn fn;
            void *ctx;
        } cb;
        struct {
            tcpip_api_fn fn;
            void *arg;
            err_t err;
            sys_sem_t *reply;
        } api;
    } u;
} tcpip_msg_t;

typedef struct {
    uint32_t interval_ms;
    uint32_t last_run_ms;
    tcpip_timer_fn fn;
    void *ctx;
    int active;
} tcpip_timer_entry_t;

static tcpip_timer_entry_t core_timers[TCPIP_MAX_TIMERS];
#if TCPIP_VERIFY_FSM
static actor_fsm_machine_t actor_fsm;
#endif
static int core_initialized = 0;

#if !TCPIP_NO_SYS
static sys_mbox_t tcpip_mbox;
static sys_thread_t tcpip_tid;
static int actor_running = 0;
static pthread_mutex_t actor_stat_lock = PTHREAD_MUTEX_INITIALIZER;
#define ACTOR_LOCK()   pthread_mutex_lock(&actor_stat_lock)
#define ACTOR_UNLOCK() pthread_mutex_unlock(&actor_stat_lock)
#else
#define ACTOR_LOCK()   ((void)0)
#define ACTOR_UNLOCK() ((void)0)
#endif

static void run_due_timers(uint32_t now_ms) {
#if TCPIP_VERIFY_FSM
    ACTOR_LOCK();
    actor_fsm_step(&actor_fsm, (int64_t)now_ms, ACTOR_FSM_EV_ACTOR_DISPATCH, NULL, 0, NULL, NULL, NULL);
    ACTOR_UNLOCK();
#endif
    for (int i = 0; i < TCPIP_MAX_TIMERS; i++) {
        tcpip_timer_fn fn = NULL;
        void *ctx = NULL;
        ACTOR_LOCK();
        if (core_timers[i].active && (uint32_t)(now_ms - core_timers[i].last_run_ms) >= core_timers[i].interval_ms) {
            core_timers[i].last_run_ms = now_ms;
            fn = core_timers[i].fn;
            ctx = core_timers[i].ctx;
        }
        ACTOR_UNLOCK();
        if (fn) fn(ctx, now_ms);
    }
#if TCPIP_VERIFY_FSM
    ACTOR_LOCK();
    actor_fsm_step(&actor_fsm, (int64_t)now_ms, ACTOR_FSM_EV_ACTOR_COMPLETE, NULL, 0, NULL, NULL, NULL);
    ACTOR_UNLOCK();
#endif
}

/* Weak-like linkable RX hook; M2 sets/implements netif dispatch via tcpip_set_rx_handler or netif_input. */
static tcpip_rx_dispatch_fn rx_dispatch_hook = NULL;

void tcpip_set_rx_handler(tcpip_rx_dispatch_fn fn) {
    rx_dispatch_hook = fn;
}

#if !TCPIP_NO_SYS
static uint32_t next_timer_wait_ms(uint32_t now_ms) {
    uint32_t best = 50U;
    ACTOR_LOCK();
    for (int i = 0; i < TCPIP_MAX_TIMERS; i++) {
        if (!core_timers[i].active) continue;
        uint32_t elapsed = now_ms - core_timers[i].last_run_ms;
        if (elapsed >= core_timers[i].interval_ms) {
            ACTOR_UNLOCK();
            return 1U;
        }
        uint32_t rem = core_timers[i].interval_ms - elapsed;
        if (rem < best) best = rem;
    }
    ACTOR_UNLOCK();
    return best ? best : 1U;
}

static void dispatch_msg(tcpip_msg_t *msg) {
#if TCPIP_VERIFY_FSM
    uint32_t now_ms = sys_now();
#endif
    switch (msg->type) {
        case TCPIP_MSG_INPKT: {
#if TCPIP_VERIFY_FSM
            ACTOR_LOCK();
            actor_fsm_step(&actor_fsm, (int64_t)now_ms, ACTOR_FSM_EV_ACTOR_DISPATCH, NULL, 0, NULL, NULL, NULL);
            ACTOR_UNLOCK();
#endif
            if (rx_dispatch_hook) {
                (void)rx_dispatch_hook(msg->u.inp.p, msg->u.inp.inp);
            } else if (msg->u.inp.p) {
                pbuf_free(msg->u.inp.p);
            }
#if TCPIP_VERIFY_FSM
            ACTOR_LOCK();
            actor_fsm_step(&actor_fsm, (int64_t)now_ms, ACTOR_FSM_EV_ACTOR_COMPLETE, NULL, 0, NULL, NULL, NULL);
            ACTOR_UNLOCK();
#endif
            memp_free(MEMP_API_MSG, msg);
            break;
        }
        case TCPIP_MSG_CALLBACK: {
#if TCPIP_VERIFY_FSM
            ACTOR_LOCK();
            actor_fsm_step(&actor_fsm, (int64_t)now_ms, ACTOR_FSM_EV_ACTOR_DISPATCH, NULL, 0, NULL, NULL, NULL);
            ACTOR_UNLOCK();
#endif
            if (msg->u.cb.fn) msg->u.cb.fn(msg->u.cb.ctx);
#if TCPIP_VERIFY_FSM
            ACTOR_LOCK();
            actor_fsm_step(&actor_fsm, (int64_t)now_ms, ACTOR_FSM_EV_ACTOR_COMPLETE, NULL, 0, NULL, NULL, NULL);
            ACTOR_UNLOCK();
#endif
            memp_free(MEMP_API_MSG, msg);
            break;
        }
        case TCPIP_MSG_API: {
#if TCPIP_VERIFY_FSM
            ACTOR_LOCK();
            actor_fsm_step(&actor_fsm, (int64_t)now_ms, ACTOR_FSM_EV_ACTOR_DISPATCH, NULL, 0, NULL, NULL, NULL);
            ACTOR_UNLOCK();
#endif
            msg->u.api.err = msg->u.api.fn ? msg->u.api.fn(msg->u.api.arg) : ERR_ARG;
#if TCPIP_VERIFY_FSM
            ACTOR_LOCK();
            actor_fsm_step(&actor_fsm, (int64_t)now_ms, ACTOR_FSM_EV_ACTOR_COMPLETE, NULL, 0, NULL, NULL, NULL);
            ACTOR_UNLOCK();
#endif
            sys_sem_signal(msg->u.api.reply);
            break;
        }
        default:
            memp_free(MEMP_API_MSG, msg);
            break;
    }
}

static void tcpip_thread(void *arg) {
    tcpip_init_done_fn done = (tcpip_init_done_fn)arg;
    if (done) done(NULL);
    for (;;) {
        void *raw = NULL;
        uint32_t wait_ms = next_timer_wait_ms(sys_now());
        uint32_t rc = sys_arch_mbox_fetch(&tcpip_mbox, &raw, wait_ms);
        if (rc != SYS_ARCH_TIMEOUT && raw != NULL) {
            tcpip_msg_t *msg = (tcpip_msg_t *)raw;
            if (msg->type == TCPIP_MSG_SHUTDOWN) {
                memp_free(MEMP_API_MSG, msg);
                break;
            }
            dispatch_msg(msg);
        }
        run_due_timers(sys_now());
    }
}
#endif

void tcpip_init(tcpip_init_done_fn initfunc, void *arg) {
    (void)arg;
    sys_init();
    memp_init();
    memset(core_timers, 0, sizeof(core_timers));
#if TCPIP_VERIFY_FSM
    actor_fsm_init(&actor_fsm);
    actor_fsm_step(&actor_fsm, (int64_t)sys_now(), ACTOR_FSM_EV_ACTOR_START, NULL, 0, NULL, NULL, NULL);
#endif
    core_initialized = 1;
#if !TCPIP_NO_SYS
    sys_mbox_new(&tcpip_mbox, TCPIP_MBOX_SIZE);
    actor_running = 1;
    tcpip_tid = sys_thread_new("tcpip_thread", tcpip_thread, (void *)initfunc, 0, 0);
#else
    if (initfunc) initfunc(arg);
#endif
}

void tcpip_shutdown(void) {
    if (!core_initialized) return;
#if !TCPIP_NO_SYS
    if (actor_running) {
        tcpip_msg_t *msg = (tcpip_msg_t *)memp_malloc(MEMP_API_MSG);
        if (msg) {
            msg->type = TCPIP_MSG_SHUTDOWN;
            sys_mbox_post(&tcpip_mbox, msg);
        }
        sys_thread_join(tcpip_tid);
        actor_running = 0;
        sys_mbox_free(&tcpip_mbox);
    }
#endif
#if TCPIP_VERIFY_FSM
    actor_fsm_step(&actor_fsm, (int64_t)sys_now(), ACTOR_FSM_EV_ACTOR_STOP, NULL, 0, NULL, NULL, NULL);
#endif
    core_initialized = 0;
}

err_t tcpip_input(struct pbuf *p, struct netif *inp) {
    if (!p) return ERR_ARG;
#if TCPIP_NO_SYS
    if (rx_dispatch_hook) return rx_dispatch_hook(p, inp);
    pbuf_free(p);
    return ERR_OK;
#else
    tcpip_msg_t *msg = (tcpip_msg_t *)memp_malloc(MEMP_API_MSG);
    if (!msg) {
        pbuf_free(p);
        return ERR_MEM;
    }
    msg->type = TCPIP_MSG_INPKT;
    msg->u.inp.p = p;
    msg->u.inp.inp = inp;
#if TCPIP_VERIFY_FSM
    ACTOR_LOCK();
    actor_fsm_step(&actor_fsm, (int64_t)sys_now(), ACTOR_FSM_EV_ACTOR_POST_RX, NULL, 0, NULL, NULL, NULL);
    ACTOR_UNLOCK();
#endif
    if (sys_mbox_trypost(&tcpip_mbox, msg) != ERR_OK) {
        memp_free(MEMP_API_MSG, msg);
        pbuf_free(p);
        return ERR_MEM;
    }
    return ERR_OK;
#endif
}

err_t tcpip_try_callback(tcpip_callback_fn func, void *ctx) {
    if (!func) return ERR_ARG;
#if TCPIP_NO_SYS
    func(ctx);
    return ERR_OK;
#else
    tcpip_msg_t *msg = (tcpip_msg_t *)memp_malloc(MEMP_API_MSG);
    if (!msg) return ERR_MEM;
    msg->type = TCPIP_MSG_CALLBACK;
    msg->u.cb.fn = func;
    msg->u.cb.ctx = ctx;
#if TCPIP_VERIFY_FSM
    ACTOR_LOCK();
    actor_fsm_step(&actor_fsm, (int64_t)sys_now(), ACTOR_FSM_EV_ACTOR_POST_RX, NULL, 0, NULL, NULL, NULL);
    ACTOR_UNLOCK();
#endif
    if (sys_mbox_trypost(&tcpip_mbox, msg) != ERR_OK) {
        memp_free(MEMP_API_MSG, msg);
        return ERR_MEM;
    }
    return ERR_OK;
#endif
}

err_t tcpip_callback(tcpip_callback_fn func, void *ctx) {
    return tcpip_try_callback(func, ctx);
}

err_t tcpip_api_call(tcpip_api_fn fn, void *arg) {
    if (!fn) return ERR_ARG;
#if TCPIP_NO_SYS
    return fn(arg);
#else
    sys_sem_t reply;
    if (sys_sem_new(&reply, 0) != ERR_OK) return ERR_MEM;
    tcpip_msg_t msg;
    msg.type = TCPIP_MSG_API;
    msg.u.api.fn = fn;
    msg.u.api.arg = arg;
    msg.u.api.err = ERR_OK;
    msg.u.api.reply = &reply;
#if TCPIP_VERIFY_FSM
    ACTOR_LOCK();
    actor_fsm_step(&actor_fsm, (int64_t)sys_now(), ACTOR_FSM_EV_ACTOR_POST_API, NULL, 0, NULL, NULL, NULL);
    ACTOR_UNLOCK();
#endif
    sys_mbox_post(&tcpip_mbox, &msg);
    sys_arch_sem_wait(&reply, 0);
    sys_sem_free(&reply);
    return msg.u.api.err;
#endif
}

err_t tcpip_timer_add(uint32_t interval_ms, tcpip_timer_fn fn, void *ctx) {
    if (!fn || interval_ms == 0) return ERR_ARG;
    ACTOR_LOCK();
    for (int i = 0; i < TCPIP_MAX_TIMERS; i++) {
        if (!core_timers[i].active) {
            core_timers[i].interval_ms = interval_ms;
            core_timers[i].last_run_ms = sys_now();
            core_timers[i].fn = fn;
            core_timers[i].ctx = ctx;
            core_timers[i].active = 1;
            ACTOR_UNLOCK();
            return ERR_OK;
        }
    }
    ACTOR_UNLOCK();
    return ERR_MEM;
}

void tcpip_poll(uint32_t now_ms) {
#if TCPIP_NO_SYS
    sys_nosys_set_now(now_ms);
    run_due_timers(now_ms);
#else
    (void)now_ms;
#endif
}

int tcpip_actor_state(void) {
#if TCPIP_VERIFY_FSM
#if !TCPIP_NO_SYS
    pthread_mutex_lock(&actor_stat_lock);
    int s = actor_fsm.state;
    pthread_mutex_unlock(&actor_stat_lock);
    return s;
#else
    return actor_fsm.state;
#endif
#else
    return 0;
#endif
}
