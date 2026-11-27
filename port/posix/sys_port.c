#define _POSIX_C_SOURCE 200809L
#include <errno.h>
#include <stdlib.h>
#include <time.h>
#include "tcpip/sys.h"

#if !TCPIP_NO_SYS

#if TCPIP_VERIFY_FSM
#include "sys_port_fsm.h"
#endif

static uint64_t monotonic_ms_raw(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000ULL + (uint64_t)(ts.tv_nsec / 1000000L);
}

static uint64_t sys_boot_ms = 0;
static pthread_once_t sys_once = PTHREAD_ONCE_INIT;

static void sys_once_init(void) {
    sys_boot_ms = monotonic_ms_raw();
}

void sys_init(void) {
    pthread_once(&sys_once, sys_once_init);
}

uint32_t sys_now(void) {
    pthread_once(&sys_once, sys_once_init);
    return (uint32_t)(monotonic_ms_raw() - sys_boot_ms);
}

void sys_msleep(uint32_t ms) {
    struct timespec req;
    req.tv_sec = (time_t)(ms / 1000U);
    req.tv_nsec = (long)((ms % 1000U) * 1000000UL);
    while (nanosleep(&req, &req) == -1 && errno == EINTR) {}
}

static void realtime_deadline(uint32_t timeout_ms, struct timespec *out) {
    clock_gettime(CLOCK_REALTIME, out);
    uint64_t ns = (uint64_t)out->tv_nsec + (uint64_t)(timeout_ms % 1000U) * 1000000ULL;
    out->tv_sec += (time_t)(timeout_ms / 1000U) + (time_t)(ns / 1000000000ULL);
    out->tv_nsec = (long)(ns % 1000000000ULL);
}

err_t sys_sem_new(sys_sem_t *sem, uint8_t count) {
    if (!sem) return ERR_ARG;
    if (pthread_mutex_init(&sem->lock, NULL) != 0) return ERR_MEM;
    if (pthread_cond_init(&sem->cond, NULL) != 0) {
        pthread_mutex_destroy(&sem->lock);
        return ERR_MEM;
    }
    sem->count = (uint32_t)count;
    sem->cap = 64U;
    sem->valid = 1;
    return ERR_OK;
}

void sys_sem_free(sys_sem_t *sem) {
    if (!sem || !sem->valid) return;
    sem->valid = 0;
    pthread_cond_destroy(&sem->cond);
    pthread_mutex_destroy(&sem->lock);
}

void sys_sem_signal(sys_sem_t *sem) {
    if (!sem || !sem->valid) return;
    pthread_mutex_lock(&sem->lock);
    if (sem->count < sem->cap) sem->count++;
    pthread_cond_signal(&sem->cond);
    pthread_mutex_unlock(&sem->lock);
}

uint32_t sys_arch_sem_wait(sys_sem_t *sem, uint32_t timeout_ms) {
    if (!sem || !sem->valid) return SYS_ARCH_TIMEOUT;
    uint32_t start = sys_now();
    pthread_mutex_lock(&sem->lock);
    if (timeout_ms == 0) {
        while (sem->count == 0) {
            pthread_cond_wait(&sem->cond, &sem->lock);
        }
    } else {
        struct timespec dl;
        realtime_deadline(timeout_ms, &dl);
        while (sem->count == 0) {
            if (pthread_cond_timedwait(&sem->cond, &sem->lock, &dl) == ETIMEDOUT) {
                if (sem->count == 0) {
                    pthread_mutex_unlock(&sem->lock);
                    return SYS_ARCH_TIMEOUT;
                }
                break;
            }
        }
    }
    sem->count--;
    pthread_mutex_unlock(&sem->lock);
    return sys_now() - start;
}

int sys_sem_valid(const sys_sem_t *sem) {
    return sem && sem->valid;
}

err_t sys_mutex_new(sys_mutex_t *mutex) {
    if (!mutex) return ERR_ARG;
    if (pthread_mutex_init(&mutex->lock, NULL) != 0) return ERR_MEM;
    mutex->valid = 1;
    return ERR_OK;
}

void sys_mutex_lock(sys_mutex_t *mutex) {
    if (mutex && mutex->valid) pthread_mutex_lock(&mutex->lock);
}

void sys_mutex_unlock(sys_mutex_t *mutex) {
    if (mutex && mutex->valid) pthread_mutex_unlock(&mutex->lock);
}

void sys_mutex_free(sys_mutex_t *mutex) {
    if (!mutex || !mutex->valid) return;
    mutex->valid = 0;
    pthread_mutex_destroy(&mutex->lock);
}

err_t sys_mbox_new(sys_mbox_t *mbox, int size) {
    if (!mbox || size <= 0) return ERR_ARG;
    uint32_t cap = (uint32_t)size;
    if (cap > TCPIP_MBOX_SIZE) cap = TCPIP_MBOX_SIZE;
    if (pthread_mutex_init(&mbox->lock, NULL) != 0) return ERR_MEM;
    if (pthread_cond_init(&mbox->not_empty, NULL) != 0) {
        pthread_mutex_destroy(&mbox->lock);
        return ERR_MEM;
    }
    if (pthread_cond_init(&mbox->not_full, NULL) != 0) {
        pthread_cond_destroy(&mbox->not_empty);
        pthread_mutex_destroy(&mbox->lock);
        return ERR_MEM;
    }
    mbox->cap = cap;
    mbox->head = 0;
    mbox->tail = 0;
    mbox->count = 0;
    mbox->valid = 1;
    return ERR_OK;
}

void sys_mbox_free(sys_mbox_t *mbox) {
    if (!mbox || !mbox->valid) return;
    mbox->valid = 0;
    pthread_cond_destroy(&mbox->not_full);
    pthread_cond_destroy(&mbox->not_empty);
    pthread_mutex_destroy(&mbox->lock);
}

void sys_mbox_post(sys_mbox_t *mbox, void *msg) {
    if (!mbox || !mbox->valid) return;
    pthread_mutex_lock(&mbox->lock);
    while (mbox->count == mbox->cap) {
        pthread_cond_wait(&mbox->not_full, &mbox->lock);
    }
    mbox->slots[mbox->tail] = msg;
    mbox->tail = (mbox->tail + 1U) % mbox->cap;
    mbox->count++;
    pthread_cond_signal(&mbox->not_empty);
    pthread_mutex_unlock(&mbox->lock);
}

err_t sys_mbox_trypost(sys_mbox_t *mbox, void *msg) {
    if (!mbox || !mbox->valid) return ERR_ARG;
    pthread_mutex_lock(&mbox->lock);
    if (mbox->count == mbox->cap) {
        pthread_mutex_unlock(&mbox->lock);
        return ERR_MEM;
    }
    mbox->slots[mbox->tail] = msg;
    mbox->tail = (mbox->tail + 1U) % mbox->cap;
    mbox->count++;
    pthread_cond_signal(&mbox->not_empty);
    pthread_mutex_unlock(&mbox->lock);
    return ERR_OK;
}

uint32_t sys_arch_mbox_fetch(sys_mbox_t *mbox, void **msg, uint32_t timeout_ms) {
    if (!mbox || !mbox->valid || !msg) return SYS_ARCH_TIMEOUT;
    uint32_t start = sys_now();
    pthread_mutex_lock(&mbox->lock);
    if (timeout_ms == 0) {
        while (mbox->count == 0) {
            pthread_cond_wait(&mbox->not_empty, &mbox->lock);
        }
    } else {
        struct timespec dl;
        realtime_deadline(timeout_ms, &dl);
        while (mbox->count == 0) {
            if (pthread_cond_timedwait(&mbox->not_empty, &mbox->lock, &dl) == ETIMEDOUT) {
                if (mbox->count == 0) {
                    pthread_mutex_unlock(&mbox->lock);
                    return SYS_ARCH_TIMEOUT;
                }
                break;
            }
        }
    }
    *msg = mbox->slots[mbox->head];
    mbox->head = (mbox->head + 1U) % mbox->cap;
    mbox->count--;
    pthread_cond_signal(&mbox->not_full);
    pthread_mutex_unlock(&mbox->lock);
    return sys_now() - start;
}

uint32_t sys_arch_mbox_tryfetch(sys_mbox_t *mbox, void **msg) {
    if (!mbox || !mbox->valid || !msg) return SYS_MBOX_EMPTY;
    pthread_mutex_lock(&mbox->lock);
    if (mbox->count == 0) {
        pthread_mutex_unlock(&mbox->lock);
        return SYS_MBOX_EMPTY;
    }
    *msg = mbox->slots[mbox->head];
    mbox->head = (mbox->head + 1U) % mbox->cap;
    mbox->count--;
    pthread_cond_signal(&mbox->not_full);
    pthread_mutex_unlock(&mbox->lock);
    return 0;
}

int sys_mbox_valid(const sys_mbox_t *mbox) {
    return mbox && mbox->valid;
}

typedef struct {
    sys_thread_fn fn;
    void *arg;
} thread_trampoline_t;

static void *pthread_entry(void *raw) {
    thread_trampoline_t *tr = (thread_trampoline_t *)raw;
    sys_thread_fn fn = tr->fn;
    void *arg = tr->arg;
    free(tr);
    fn(arg);
    return NULL;
}

sys_thread_t sys_thread_new(const char *name, sys_thread_fn fn, void *arg, int stacksize, int prio) {
    (void)name; (void)stacksize; (void)prio;
    pthread_t th = (pthread_t)0;
    thread_trampoline_t *tr = (thread_trampoline_t *)malloc(sizeof(*tr));
    if (!tr) return th;
    tr->fn = fn;
    tr->arg = arg;
    if (pthread_create(&th, NULL, pthread_entry, tr) != 0) {
        free(tr);
    }
    return th;
}

void sys_thread_join(sys_thread_t th) {
    pthread_join(th, NULL);
}

#endif /* !TCPIP_NO_SYS */
