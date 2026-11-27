#include <stddef.h>
#include "tcpip/opt.h"
#include "tcpip/sys.h"

#if !TCPIP_NO_SYS
#include "FreeRTOS.h"
#include "queue.h"
#include "semphr.h"
#include "task.h"

#if TCPIP_VERIFY_FSM
#include "sys_port_fsm.h"
static sys_port_fsm_machine_t port_fsm;
#endif

void sys_init(void) {
#if TCPIP_VERIFY_FSM
    sys_port_fsm_init(&port_fsm);
#endif
}

uint32_t sys_now(void) {
    return (uint32_t)(xTaskGetTickCount() * portTICK_PERIOD_MS);
}

err_t sys_sem_new(sys_sem_t *sem, uint8_t count) {
    if (!sem) return ERR_ARG;
    SemaphoreHandle_t h = xSemaphoreCreateCounting(0x7FFFU, (UBaseType_t)count);
    if (!h) return ERR_MEM;
    *sem = (sys_sem_t)h;
    return ERR_OK;
}

void sys_sem_free(sys_sem_t *sem) {
    if (!sem || !*sem) return;
    vSemaphoreDelete((SemaphoreHandle_t)*sem);
    *sem = NULL;
}

void sys_sem_signal(sys_sem_t *sem) {
    if (!sem || !*sem) return;
    xSemaphoreGive((SemaphoreHandle_t)*sem);
}

uint32_t sys_arch_sem_wait(sys_sem_t *sem, uint32_t timeout_ms) {
    if (!sem || !*sem) return SYS_ARCH_TIMEOUT;
    TickType_t ticks = (timeout_ms == 0U) ? portMAX_DELAY : pdMS_TO_TICKS(timeout_ms);
    uint32_t start = sys_now();
    if (xSemaphoreTake((SemaphoreHandle_t)*sem, ticks) != pdTRUE) {
        return SYS_ARCH_TIMEOUT;
    }
    return sys_now() - start;
}

err_t sys_mbox_new(sys_mbox_t *mbox, int size) {
    if (!mbox || size <= 0) return ERR_ARG;
    QueueHandle_t q = xQueueCreate((UBaseType_t)size, sizeof(void *));
    if (!q) return ERR_MEM;
    *mbox = (sys_mbox_t)q;
    return ERR_OK;
}

void sys_mbox_free(sys_mbox_t *mbox) {
    if (!mbox || !*mbox) return;
    vQueueDelete((QueueHandle_t)*mbox);
    *mbox = NULL;
}

void sys_mbox_post(sys_mbox_t *mbox, void *msg) {
    if (!mbox || !*mbox) return;
    (void)xQueueSend((QueueHandle_t)*mbox, &msg, portMAX_DELAY);
}

err_t sys_mbox_trypost(sys_mbox_t *mbox, void *msg) {
    if (!mbox || !*mbox) return ERR_ARG;
    return (xQueueSend((QueueHandle_t)*mbox, &msg, 0) == pdTRUE) ? ERR_OK : ERR_MEM;
}

uint32_t sys_arch_mbox_fetch(sys_mbox_t *mbox, void **msg, uint32_t timeout_ms) {
    if (!mbox || !*mbox || !msg) return SYS_ARCH_TIMEOUT;
    TickType_t ticks = (timeout_ms == 0U) ? portMAX_DELAY : pdMS_TO_TICKS(timeout_ms);
    uint32_t start = sys_now();
    if (xQueueReceive((QueueHandle_t)*mbox, msg, ticks) != pdTRUE) {
        return SYS_ARCH_TIMEOUT;
    }
    return sys_now() - start;
}

uint32_t sys_arch_mbox_tryfetch(sys_mbox_t *mbox, void **msg) {
    return sys_arch_mbox_fetch(mbox, msg, 1U);
}

static void freertos_thread_trampoline(void *arg) {
    /* Optional wrapper if thread signature differs from TaskFunction_t */
    (void)arg;
    vTaskDelete(NULL);
}

sys_thread_t sys_thread_new(const char *name, void (*thread)(void *arg), void *arg, int stacksize, int prio) {
    (void)freertos_thread_trampoline;
    TaskHandle_t h = NULL;
    uint16_t words = (uint16_t)(stacksize > 0 ? (stacksize / (int)sizeof(StackType_t)) : 1024);
    if (xTaskCreate((TaskFunction_t)thread, name ? name : "tcpip", words, arg, (UBaseType_t)prio, &h) != pdPASS) {
        return NULL;
    }
    return (sys_thread_t)h;
}

void sys_msleep(uint32_t ms) {
    vTaskDelay(pdMS_TO_TICKS(ms));
}

#endif /* !TCPIP_NO_SYS */
