#include "tcpip/sys.h"

#if TCPIP_NO_SYS

static uint32_t nosys_now_ms = 0;

void sys_init(void) {
    nosys_now_ms = 0;
}

uint32_t sys_now(void) {
    return nosys_now_ms;
}

void sys_nosys_set_now(uint32_t now_ms) {
    nosys_now_ms = now_ms;
}

void sys_nosys_advance_now(uint32_t delta_ms) {
    nosys_now_ms += delta_ms;
}

void sys_msleep(uint32_t ms) {
    nosys_now_ms += ms;
}

err_t sys_sem_new(sys_sem_t *sem, uint8_t count) {
    if (!sem) return ERR_ARG;
    *sem = (int)count;
    return ERR_OK;
}
void sys_sem_free(sys_sem_t *sem) { if (sem) *sem = -1; }
void sys_sem_signal(sys_sem_t *sem) { if (sem && *sem >= 0) (*sem)++; }
uint32_t sys_arch_sem_wait(sys_sem_t *sem, uint32_t timeout_ms) {
    (void)timeout_ms;
    if (!sem || *sem <= 0) return SYS_ARCH_TIMEOUT;
    (*sem)--;
    return 0;
}
int sys_sem_valid(const sys_sem_t *sem) { return sem && *sem >= 0; }

err_t sys_mutex_new(sys_mutex_t *mutex) { if (!mutex) return ERR_ARG; *mutex = 1; return ERR_OK; }
void sys_mutex_lock(sys_mutex_t *mutex) { (void)mutex; }
void sys_mutex_unlock(sys_mutex_t *mutex) { (void)mutex; }
void sys_mutex_free(sys_mutex_t *mutex) { if (mutex) *mutex = 0; }

err_t sys_mbox_new(sys_mbox_t *mbox, int size) { (void)size; if (!mbox) return ERR_ARG; *mbox = 1; return ERR_OK; }
void sys_mbox_free(sys_mbox_t *mbox) { if (mbox) *mbox = 0; }
void sys_mbox_post(sys_mbox_t *mbox, void *msg) { (void)mbox; (void)msg; }
err_t sys_mbox_trypost(sys_mbox_t *mbox, void *msg) { (void)mbox; (void)msg; return ERR_VAL; }
uint32_t sys_arch_mbox_fetch(sys_mbox_t *mbox, void **msg, uint32_t timeout_ms) {
    (void)mbox; (void)msg; (void)timeout_ms;
    return SYS_ARCH_TIMEOUT;
}
uint32_t sys_arch_mbox_tryfetch(sys_mbox_t *mbox, void **msg) {
    (void)mbox; (void)msg;
    return SYS_MBOX_EMPTY;
}
int sys_mbox_valid(const sys_mbox_t *mbox) { return mbox && *mbox != 0; }

sys_thread_t sys_thread_new(const char *name, sys_thread_fn fn, void *arg, int stacksize, int prio) {
    (void)name; (void)fn; (void)arg; (void)stacksize; (void)prio;
    return 0;
}
void sys_thread_join(sys_thread_t th) { (void)th; }

#endif /* TCPIP_NO_SYS */
