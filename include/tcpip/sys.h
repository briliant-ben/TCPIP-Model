#ifndef TCPIP_SYS_H
#define TCPIP_SYS_H

#include <stdint.h>
#include "tcpip/err.h"
#include "tcpip/opt.h"

#define SYS_ARCH_TIMEOUT UINT32_MAX
#define SYS_MBOX_EMPTY   UINT32_MAX

#if TCPIP_NO_SYS

typedef int sys_sem_t;
typedef int sys_mutex_t;
typedef int sys_mbox_t;
typedef int sys_thread_t;

void sys_nosys_set_now(uint32_t now_ms);
void sys_nosys_advance_now(uint32_t delta_ms);

#elif defined(TCPIP_PORT_FREERTOS)

typedef void *sys_sem_t;
typedef void *sys_mutex_t;
typedef void *sys_mbox_t;
typedef void *sys_thread_t;

#else /* POSIX !TCPIP_NO_SYS */

#include <pthread.h>

typedef struct {
    pthread_mutex_t lock;
    pthread_cond_t cond;
    uint32_t count;
    uint32_t cap;
    int valid;
} sys_sem_t;

typedef struct {
    pthread_mutex_t lock;
    int valid;
} sys_mutex_t;

typedef struct {
    pthread_mutex_t lock;
    pthread_cond_t not_empty;
    pthread_cond_t not_full;
    void *slots[TCPIP_MBOX_SIZE];
    uint32_t cap;
    uint32_t head;
    uint32_t tail;
    uint32_t count;
    int valid;
} sys_mbox_t;

typedef pthread_t sys_thread_t;

#endif /* TCPIP_NO_SYS */

void sys_init(void);
uint32_t sys_now(void);
void sys_msleep(uint32_t ms);

err_t sys_sem_new(sys_sem_t *sem, uint8_t count);
void sys_sem_free(sys_sem_t *sem);
void sys_sem_signal(sys_sem_t *sem);
uint32_t sys_arch_sem_wait(sys_sem_t *sem, uint32_t timeout_ms);
int sys_sem_valid(const sys_sem_t *sem);

err_t sys_mutex_new(sys_mutex_t *mutex);
void sys_mutex_lock(sys_mutex_t *mutex);
void sys_mutex_unlock(sys_mutex_t *mutex);
void sys_mutex_free(sys_mutex_t *mutex);

err_t sys_mbox_new(sys_mbox_t *mbox, int size);
void sys_mbox_free(sys_mbox_t *mbox);
void sys_mbox_post(sys_mbox_t *mbox, void *msg);
err_t sys_mbox_trypost(sys_mbox_t *mbox, void *msg);
uint32_t sys_arch_mbox_fetch(sys_mbox_t *mbox, void **msg, uint32_t timeout_ms);
uint32_t sys_arch_mbox_tryfetch(sys_mbox_t *mbox, void **msg);
int sys_mbox_valid(const sys_mbox_t *mbox);

typedef void (*sys_thread_fn)(void *arg);
sys_thread_t sys_thread_new(const char *name, sys_thread_fn fn, void *arg, int stacksize, int prio);
void sys_thread_join(sys_thread_t th);

#endif /* TCPIP_SYS_H */
