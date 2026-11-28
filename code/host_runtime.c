#if !defined(FSA_HOST_NO_SYS) || (FSA_HOST_NO_SYS == 0)
#if !defined(FSA_HOST_FREERTOS)
#ifndef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE 200809L
#endif
#endif
#endif

#include "host_runtime.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if defined(FSA_HOST_FREERTOS)
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "queue.h"
#elif !FSA_HOST_NO_SYS
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>
#else
#include <time.h>
#endif

typedef struct {
    uint16_t len;
    int64_t ts_ms;
    uint8_t data[FSA_HOST_MAX_FRAME_LEN];
} fsa_host_frame_item_t;

struct fsa_host_stack {
    tcpip_stack_system_t sys;
    fsa_host_wire_tx_fn tx_fn;
    void *tx_ctx;
    fsa_host_pcap_t *pcap;

    fsa_host_frame_item_t tx_out_q[FSA_HOST_TX_STAGING_CAP];
    uint16_t tx_out_head;
    uint16_t tx_out_count;

    fsa_host_frame_item_t rx_in_q[FSA_HOST_RX_MBOX_CAP];
    uint16_t rx_in_head;
    uint16_t rx_in_count;

    fsa_host_tcp_slot_t tcp_slots[12];
    fsa_host_udp_slot_t udp_slots[16];
    fsa_host_dns_slot_t dns_slots[4];
    fsa_host_dhcp_info_t dhcp;
    fsa_host_stats_t stats;

    int actor_running;
    int actor_stop_req;
    int64_t last_now_ms;

#if defined(FSA_HOST_FREERTOS)
    SemaphoreHandle_t lock;
    SemaphoreHandle_t wake_sem;
    QueueHandle_t mbox_handle;
    TaskHandle_t actor_task;
#elif !FSA_HOST_NO_SYS
    pthread_mutex_t lock;
    pthread_cond_t wake_cv;
    pthread_cond_t app_cv;
    pthread_t actor_thread;
    int sync_inited;
#endif
};

/* ---- Monotonic clock ---- */

int64_t fsa_host_monotonic_ms(void) {
#if defined(FSA_HOST_FREERTOS)
    return (int64_t)xTaskGetTickCount() * (int64_t)portTICK_PERIOD_MS;
#elif !FSA_HOST_NO_SYS
    struct timespec ts;
    if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0) {
        return (int64_t)ts.tv_sec * 1000 + (int64_t)(ts.tv_nsec / 1000000L);
    }
    return 0;
#else
    return (int64_t)((uint64_t)clock() * 1000ULL / (uint64_t)CLOCKS_PER_SEC);
#endif
}

static int64_t resolve_now_ms(fsa_host_stack_t *st, int64_t now_ms) {
    if (now_ms < 0) {
        now_ms = fsa_host_monotonic_ms();
    }
    if (now_ms < st->last_now_ms) {
        now_ms = st->last_now_ms;
    } else {
        st->last_now_ms = now_ms;
    }
    return now_ms;
}

/* ---- Lock helpers ---- */

static void host_lock(fsa_host_stack_t *st) {
#if defined(FSA_HOST_FREERTOS)
    if (st->lock) (void)xSemaphoreTake(st->lock, portMAX_DELAY);
#elif !FSA_HOST_NO_SYS
    if (st->sync_inited) (void)pthread_mutex_lock(&st->lock);
#else
    (void)st;
#endif
}

static void host_unlock(fsa_host_stack_t *st) {
#if defined(FSA_HOST_FREERTOS)
    if (st->lock) (void)xSemaphoreGive(st->lock);
#elif !FSA_HOST_NO_SYS
    if (st->sync_inited) (void)pthread_mutex_unlock(&st->lock);
#else
    (void)st;
#endif
}

static void host_notify_app(fsa_host_stack_t *st) {
#if !FSA_HOST_NO_SYS && !defined(FSA_HOST_FREERTOS)
    if (st->sync_inited) (void)pthread_cond_broadcast(&st->app_cv);
#else
    (void)st;
#endif
}

static void host_notify_actor(fsa_host_stack_t *st) {
#if defined(FSA_HOST_FREERTOS)
    if (st->wake_sem) (void)xSemaphoreGive(st->wake_sem);
#elif !FSA_HOST_NO_SYS
    if (st->sync_inited) (void)pthread_cond_signal(&st->wake_cv);
#else
    (void)st;
#endif
}

/* ---- PCAP writer (DLT_EN10MB = 1) ---- */

static void put_le16(uint8_t *p, uint16_t v) {
    p[0] = (uint8_t)(v & 0xFFU);
    p[1] = (uint8_t)((v >> 8) & 0xFFU);
}

static void put_le32(uint8_t *p, uint32_t v) {
    p[0] = (uint8_t)(v & 0xFFU);
    p[1] = (uint8_t)((v >> 8) & 0xFFU);
    p[2] = (uint8_t)((v >> 16) & 0xFFU);
    p[3] = (uint8_t)((v >> 24) & 0xFFU);
}

int fsa_host_pcap_open(fsa_host_pcap_t *pcap, const char *path) {
    uint8_t ghdr[24];
    FILE *fp;
    if (!pcap || !path) return -1;
    memset(pcap, 0, sizeof(*pcap));
    fp = fopen(path, "wb");
    if (!fp) return -1;
    put_le32(&ghdr[0], 0xA1B2C3D4U);
    put_le16(&ghdr[4], 2U);
    put_le16(&ghdr[6], 4U);
    put_le32(&ghdr[8], 0U);
    put_le32(&ghdr[12], 0U);
    put_le32(&ghdr[16], 65535U);
    put_le32(&ghdr[20], 1U); /* LINKTYPE_ETHERNET */
    if (fwrite(ghdr, 1, sizeof(ghdr), fp) != sizeof(ghdr)) {
        fclose(fp);
        return -1;
    }
    fflush(fp);
    pcap->fp = fp;
    return 0;
}

int fsa_host_pcap_write(fsa_host_pcap_t *pcap, const uint8_t *frame, uint16_t len, int64_t ts_ms) {
    uint8_t phdr[16];
    uint32_t sec, usec;
    FILE *fp;
    if (!pcap || !pcap->fp || !frame || len == 0U) return -1;
    fp = (FILE *)pcap->fp;
    sec = ts_ms > 0 ? (uint32_t)(ts_ms / 1000) : 0U;
    usec = ts_ms > 0 ? (uint32_t)((ts_ms % 1000) * 1000) : 0U;
    put_le32(&phdr[0], sec);
    put_le32(&phdr[4], usec);
    put_le32(&phdr[8], (uint32_t)len);
    put_le32(&phdr[12], (uint32_t)len);
    if (fwrite(phdr, 1, sizeof(phdr), fp) != sizeof(phdr)) return -1;
    if (fwrite(frame, 1, len, fp) != (size_t)len) return -1;
    fflush(fp);
    pcap->packets_written++;
    pcap->bytes_written += (uint64_t)len;
    return 0;
}

void fsa_host_pcap_close(fsa_host_pcap_t *pcap) {
    if (!pcap) return;
    if (pcap->fp) {
        fclose((FILE *)pcap->fp);
        pcap->fp = NULL;
    }
}

/* ---- Host output callback from generated system ---- */

static void copy_ip4(uint8_t dst[4], const fsa_val_t *v) {
    memset(dst, 0, 4);
    if (v && v->kind == FSA_KIND_BYTES && v->bytes.ptr && v->bytes.len >= 4U) {
        memcpy(dst, v->bytes.ptr, 4);
    }
}

static void on_stack_output(void *raw_ctx, int out_id, uint16_t src_slot,
                            const fsa_val_t *fields, int nfields) {
    fsa_host_stack_t *st = (fsa_host_stack_t *)raw_ctx;
    if (!st) return;

    switch (out_id) {
        case TCPIP_STACK_OUT_WIRE_TX: {
            if (nfields < 1 || fields[0].kind != FSA_KIND_BYTES || !fields[0].bytes.ptr) break;
            if (fields[0].bytes.len == 0U || fields[0].bytes.len > FSA_HOST_MAX_FRAME_LEN) break;
            if (st->tx_out_count >= FSA_HOST_TX_STAGING_CAP) break;
            {
                uint16_t tail = (uint16_t)((st->tx_out_head + st->tx_out_count) % FSA_HOST_TX_STAGING_CAP);
                fsa_host_frame_item_t *it = &st->tx_out_q[tail];
                it->len = fields[0].bytes.len;
                it->ts_ms = st->last_now_ms;
                memcpy(it->data, fields[0].bytes.ptr, it->len);
                st->tx_out_count++;
            }
            break;
        }
        case TCPIP_STACK_OUT_TCP_ACCEPTED: {
            int parent_slot;
            if (nfields < 3 || src_slot >= 12U) break;
            parent_slot = (int)fields[0].i64;
            if (parent_slot < 0 || parent_slot >= 12) break;
            memset(&st->tcp_slots[src_slot], 0, sizeof(st->tcp_slots[src_slot]));
            st->tcp_slots[src_slot].reserved = 1;
            st->tcp_slots[src_slot].connected = 1;
            st->tcp_slots[src_slot].mss = 1460U;
            if (st->tcp_slots[parent_slot].accept_count < FSA_HOST_ACCEPT_CAP) {
                fsa_host_tcp_slot_t *ps = &st->tcp_slots[parent_slot];
                uint16_t tail = (uint16_t)((ps->accept_head + ps->accept_count) % FSA_HOST_ACCEPT_CAP);
                ps->accept_q[tail].child_slot = (int)src_slot;
                copy_ip4(ps->accept_q[tail].remote_ip, &fields[1]);
                ps->accept_q[tail].remote_port = (uint16_t)(fields[2].i64 & 0xFFFF);
                ps->accept_count++;
            }
            host_notify_app(st);
            break;
        }
        case TCPIP_STACK_OUT_TCP_CONNECTED: {
            if (src_slot >= 12U) break;
            st->tcp_slots[src_slot].connected = 1;
            st->tcp_slots[src_slot].mss = (nfields >= 1 && fields[0].i64 > 0)
                ? (uint16_t)fields[0].i64 : (uint16_t)1460;
            host_notify_app(st);
            break;
        }
        case TCPIP_STACK_OUT_TCP_RX_DATA: {
            uint16_t dlen;
            fsa_host_tcp_slot_t *ts;
            uint32_t space, take, i;
            if (src_slot >= 12U || nfields < 1 || fields[0].kind != FSA_KIND_BYTES) break;
            dlen = fields[0].bytes.len;
            if (dlen == 0U || !fields[0].bytes.ptr) break;
            ts = &st->tcp_slots[src_slot];
            space = (uint32_t)FSA_HOST_TCP_RX_BUF_CAP - ts->rx_len;
            take = (uint32_t)dlen < space ? (uint32_t)dlen : space;
            for (i = 0; i < take; i++) {
                uint32_t pos = (ts->rx_head + ts->rx_len + i) % (uint32_t)FSA_HOST_TCP_RX_BUF_CAP;
                ts->rx_buf[pos] = fields[0].bytes.ptr[i];
            }
            ts->rx_len += take;
            ts->total_rx_bytes += (uint64_t)take;
            host_notify_app(st);
            break;
        }
        case TCPIP_STACK_OUT_TCP_PEER_EOF: {
            if (src_slot >= 12U) break;
            st->tcp_slots[src_slot].peer_eof = 1;
            host_notify_app(st);
            break;
        }
        case TCPIP_STACK_OUT_TCP_CLOSED: {
            if (src_slot >= 12U) break;
            st->tcp_slots[src_slot].closed = 1;
            st->tcp_slots[src_slot].connected = 0;
            st->tcp_slots[src_slot].close_reason = (nfields >= 1) ? (int)fields[0].i64 : 0;
            host_notify_app(st);
            break;
        }
        case TCPIP_STACK_OUT_UDP_RX: {
            fsa_host_udp_slot_t *us;
            uint16_t tail, pay_len;
            if (src_slot >= 16U || nfields < 4 || fields[3].kind != FSA_KIND_BYTES) break;
            us = &st->udp_slots[src_slot];
            if (us->count >= FSA_HOST_UDP_QUEUE_CAP) break;
            tail = (uint16_t)((us->head + us->count) % FSA_HOST_UDP_QUEUE_CAP);
            copy_ip4(us->q[tail].src_ip, &fields[0]);
            us->q[tail].src_port = (uint16_t)(fields[1].i64 & 0xFFFF);
            us->q[tail].dst_port = (uint16_t)(fields[2].i64 & 0xFFFF);
            pay_len = fields[3].bytes.len;
            if (pay_len > FSA_HOST_UDP_MAX_PAYLOAD) pay_len = FSA_HOST_UDP_MAX_PAYLOAD;
            us->q[tail].len = pay_len;
            if (pay_len > 0U && fields[3].bytes.ptr) {
                memcpy(us->q[tail].data, fields[3].bytes.ptr, pay_len);
            }
            us->count++;
            host_notify_app(st);
            break;
        }
        case TCPIP_STACK_OUT_DHCP_BOUND: {
            if (nfields < 4) break;
            st->dhcp.bound = 1;
            copy_ip4(st->dhcp.ip, &fields[0]);
            copy_ip4(st->dhcp.mask, &fields[1]);
            copy_ip4(st->dhcp.gw, &fields[2]);
            copy_ip4(st->dhcp.dns_ip, &fields[3]);
            host_notify_app(st);
            break;
        }
        case TCPIP_STACK_OUT_DNS_RESOLVED: {
            if (src_slot >= 4U || nfields < 3) break;
            st->dns_slots[src_slot].status = 1;
            copy_ip4(st->dns_slots[src_slot].ip, &fields[1]);
            st->dns_slots[src_slot].ttl_s = fields[2].i64;
            host_notify_app(st);
            break;
        }
        case TCPIP_STACK_OUT_DNS_FAILED: {
            if (src_slot >= 4U) break;
            st->dns_slots[src_slot].status = -1;
            host_notify_app(st);
            break;
        }
        default:
            break;
    }
}

/* Flush staged outgoing wire frames outside drain_bus and exercise frame_pool accounting. */
static void flush_tx_locked(fsa_host_stack_t *st, int64_t now_ms) {
    while (st->tx_out_count > 0U) {
        fsa_host_frame_item_t local = st->tx_out_q[st->tx_out_head];
        int pool_ok = 0;
        st->tx_out_head = (uint16_t)((st->tx_out_head + 1U) % FSA_HOST_TX_STAGING_CAP);
        st->tx_out_count--;
        if (tcpip_stack_pool_alloc(&st->sys, now_ms) == FSA_OK) {
            pool_ok = 1;
            st->stats.pool_alloc_ops++;
        }
        if (st->pcap) {
            (void)fsa_host_pcap_write(st->pcap, local.data, local.len, now_ms);
        }
        st->stats.wire_tx_frames++;
        st->stats.wire_tx_bytes += (uint64_t)local.len;
        if (st->tx_fn) {
            st->tx_fn(st->tx_ctx, local.data, local.len, now_ms);
        }
        if (pool_ok && tcpip_stack_pool_free(&st->sys, now_ms) == FSA_OK) {
            st->stats.pool_free_ops++;
        }
    }
}

static int process_one_rx_locked(fsa_host_stack_t *st, int64_t now_ms, const uint8_t *frame, uint16_t len) {
    int rc;
    int pool_ok = 0;
    if (tcpip_stack_pool_alloc(&st->sys, now_ms) == FSA_OK) {
        pool_ok = 1;
        st->stats.pool_alloc_ops++;
    }
    st->stats.wire_rx_frames++;
    st->stats.wire_rx_bytes += (uint64_t)len;
    rc = tcpip_stack_rx_frame(&st->sys, now_ms, frame, len);
    if (pool_ok && tcpip_stack_pool_free(&st->sys, now_ms) == FSA_OK) {
        st->stats.pool_free_ops++;
    }
    flush_tx_locked(st, now_ms);
    return rc;
}

/* ---- Background actor loop (POSIX pthread / FreeRTOS task) ---- */

#if defined(FSA_HOST_FREERTOS)
static void freertos_actor_entry(void *arg) {
    fsa_host_stack_t *st = (fsa_host_stack_t *)arg;
    for (;;) {
        int64_t now_ms;
        int64_t due_ms;
        TickType_t wait_ticks = pdMS_TO_TICKS(10);
        host_lock(st);
        if (st->actor_stop_req) {
            host_unlock(st);
            break;
        }
        now_ms = resolve_now_ms(st, -1);
        while (st->rx_in_count > 0U) {
            fsa_host_frame_item_t f = st->rx_in_q[st->rx_in_head];
            st->rx_in_head = (uint16_t)((st->rx_in_head + 1U) % FSA_HOST_RX_MBOX_CAP);
            st->rx_in_count--;
            (void)process_one_rx_locked(st, now_ms, f.data, f.len);
        }
        (void)tcpip_stack_tick(&st->sys, now_ms);
        flush_tx_locked(st, now_ms);
        due_ms = tcpip_stack_next_due_ms(&st->sys);
        if (due_ms >= 0) {
            int64_t delta = due_ms > now_ms ? (due_ms - now_ms) : 1;
            if (delta < 10) wait_ticks = pdMS_TO_TICKS((uint32_t)delta);
        }
        host_unlock(st);
        (void)xSemaphoreTake(st->wake_sem, wait_ticks);
    }
    vTaskDelete(NULL);
}
#elif !FSA_HOST_NO_SYS
static void *posix_actor_entry(void *arg) {
    fsa_host_stack_t *st = (fsa_host_stack_t *)arg;
    host_lock(st);
    while (!st->actor_stop_req) {
        int64_t now_ms = resolve_now_ms(st, -1);
        while (st->rx_in_count > 0U) {
            fsa_host_frame_item_t f = st->rx_in_q[st->rx_in_head];
            st->rx_in_head = (uint16_t)((st->rx_in_head + 1U) % FSA_HOST_RX_MBOX_CAP);
            st->rx_in_count--;
            (void)process_one_rx_locked(st, now_ms, f.data, f.len);
        }
        (void)tcpip_stack_tick(&st->sys, now_ms);
        flush_tx_locked(st, now_ms);
        if (st->actor_stop_req || st->rx_in_count > 0U) continue;
        {
            int64_t due_ms = tcpip_stack_next_due_ms(&st->sys);
            int64_t wait_ms = 5;
            struct timespec ts;
            if (due_ms >= 0) {
                int64_t d = due_ms > now_ms ? (due_ms - now_ms) : 1;
                if (d < wait_ms) wait_ms = d;
            }
            if (clock_gettime(CLOCK_REALTIME, &ts) == 0) {
                long add_ns = (long)(wait_ms % 1000) * 1000000L;
                ts.tv_sec += (time_t)(wait_ms / 1000);
                ts.tv_nsec += add_ns;
                if (ts.tv_nsec >= 1000000000L) {
                    ts.tv_sec += 1;
                    ts.tv_nsec -= 1000000000L;
                }
                (void)pthread_cond_timedwait(&st->wake_cv, &st->lock, &ts);
            }
        }
    }
    host_unlock(st);
    return NULL;
}
#endif

/* ---- Lifecycle ---- */

fsa_host_stack_t *fsa_host_create(fsa_host_wire_tx_fn tx_fn, void *tx_ctx, fsa_host_pcap_t *pcap) {
    fsa_host_stack_t *st = (fsa_host_stack_t *)calloc(1, sizeof(*st));
    if (!st) return NULL;
    st->tx_fn = tx_fn;
    st->tx_ctx = tx_ctx;
    st->pcap = pcap;
    if (tcpip_stack_init(&st->sys, on_stack_output, st) != FSA_OK) {
        free(st);
        return NULL;
    }
#if defined(FSA_HOST_FREERTOS)
    st->lock = xSemaphoreCreateMutex();
    st->wake_sem = xSemaphoreCreateBinary();
    st->mbox_handle = xQueueCreate(FSA_HOST_RX_MBOX_CAP, sizeof(uint16_t));
    if (st->lock) (void)tcpip_stack_port_sem_alloc(&st->sys, 0);
    if (st->wake_sem) (void)tcpip_stack_port_sem_alloc(&st->sys, 0);
    if (st->mbox_handle) (void)tcpip_stack_port_mbox_alloc(&st->sys, 0);
#elif !FSA_HOST_NO_SYS
    if (pthread_mutex_init(&st->lock, NULL) != 0) {
        free(st);
        return NULL;
    }
    (void)pthread_cond_init(&st->wake_cv, NULL);
    (void)pthread_cond_init(&st->app_cv, NULL);
    st->sync_inited = 1;
    (void)tcpip_stack_port_sem_alloc(&st->sys, 0);
    (void)tcpip_stack_port_sem_alloc(&st->sys, 0);
    (void)tcpip_stack_port_mbox_alloc(&st->sys, 0);
#endif
    return st;
}

int fsa_host_start_actor(fsa_host_stack_t *st, int64_t now_ms) {
    if (!st) return -1;
#if defined(FSA_HOST_FREERTOS)
    host_lock(st);
    if (!st->actor_running) {
        now_ms = resolve_now_ms(st, now_ms);
        st->actor_stop_req = 0;
        if (xTaskCreate(freertos_actor_entry, "fsa_stack", 2048U, st, 2U, &st->actor_task) == pdPASS) {
            st->actor_running = 1;
            (void)tcpip_stack_port_thread_spawn(&st->sys, now_ms);
        }
    }
    host_unlock(st);
    return st->actor_running ? 0 : -1;
#elif !FSA_HOST_NO_SYS
    host_lock(st);
    if (st->actor_running) {
        host_unlock(st);
        return 0;
    }
    now_ms = resolve_now_ms(st, now_ms);
    st->actor_stop_req = 0;
    (void)tcpip_stack_port_thread_spawn(&st->sys, now_ms);
    st->actor_running = 1;
    host_unlock(st);
    if (pthread_create(&st->actor_thread, NULL, posix_actor_entry, st) != 0) {
        host_lock(st);
        st->actor_running = 0;
        (void)tcpip_stack_port_thread_join(&st->sys, now_ms);
        host_unlock(st);
        return -1;
    }
    return 0;
#else
    (void)now_ms;
    return 0;
#endif
}

int fsa_host_stop_actor(fsa_host_stack_t *st, int64_t now_ms) {
    if (!st) return -1;
#if defined(FSA_HOST_FREERTOS)
    host_lock(st);
    if (st->actor_running) {
        now_ms = resolve_now_ms(st, now_ms);
        st->actor_stop_req = 1;
        st->actor_running = 0;
        (void)tcpip_stack_port_thread_join(&st->sys, now_ms);
        host_notify_actor(st);
    }
    host_unlock(st);
    return 0;
#elif !FSA_HOST_NO_SYS
    host_lock(st);
    if (!st->actor_running) {
        host_unlock(st);
        return 0;
    }
    st->actor_stop_req = 1;
    host_notify_actor(st);
    host_unlock(st);
    (void)pthread_join(st->actor_thread, NULL);
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    st->actor_running = 0;
    (void)tcpip_stack_port_thread_join(&st->sys, now_ms);
    host_unlock(st);
    return 0;
#else
    (void)now_ms;
    return 0;
#endif
}

void fsa_host_destroy(fsa_host_stack_t *st, int64_t now_ms) {
    if (!st) return;
    (void)fsa_host_stop_actor(st, now_ms);
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
#if defined(FSA_HOST_FREERTOS)
    if (st->mbox_handle) (void)tcpip_stack_port_mbox_free(&st->sys, now_ms);
    if (st->wake_sem) (void)tcpip_stack_port_sem_free(&st->sys, now_ms);
    if (st->lock) (void)tcpip_stack_port_sem_free(&st->sys, now_ms);
#elif !FSA_HOST_NO_SYS
    if (st->sync_inited) {
        (void)tcpip_stack_port_mbox_free(&st->sys, now_ms);
        (void)tcpip_stack_port_sem_free(&st->sys, now_ms);
        (void)tcpip_stack_port_sem_free(&st->sys, now_ms);
    }
#endif
    (void)tcpip_stack_shutdown(&st->sys, now_ms);
    host_unlock(st);
#if defined(FSA_HOST_FREERTOS)
    if (st->mbox_handle) vQueueDelete(st->mbox_handle);
    if (st->wake_sem) vSemaphoreDelete(st->wake_sem);
    if (st->lock) vSemaphoreDelete(st->lock);
#elif !FSA_HOST_NO_SYS
    if (st->sync_inited) {
        (void)pthread_cond_destroy(&st->app_cv);
        (void)pthread_cond_destroy(&st->wake_cv);
        (void)pthread_mutex_destroy(&st->lock);
    }
#endif
    free(st);
}

/* ---- Inspection ---- */

const tcpip_stack_system_t *fsa_host_raw_system_unsafe(const fsa_host_stack_t *st) {
    return st ? &st->sys : NULL;
}

void fsa_host_get_stats(fsa_host_stack_t *st, fsa_host_stats_t *out) {
    if (!st || !out) return;
    host_lock(st);
    *out = st->stats;
    host_unlock(st);
}

void fsa_host_get_arch_snapshot(fsa_host_stack_t *st,
                                int *port_state, int64_t *sem_live, int64_t *mbox_live, int64_t *threads_live,
                                int *pool_state, int64_t *pool_free, int64_t *pool_used,
                                int *actor_state, int64_t *actor_q_depth, int64_t *actor_dispatched) {
    if (!st) return;
    host_lock(st);
    if (port_state) *port_state = tcpip_stack_get_sys_port_state(&st->sys, 0);
    if (sem_live) *sem_live = tcpip_stack_get_sys_port_var_int(&st->sys, 0, FSA_SYS_PORT_SVAR_SEM_LIVE);
    if (mbox_live) *mbox_live = tcpip_stack_get_sys_port_var_int(&st->sys, 0, FSA_SYS_PORT_SVAR_MBOX_LIVE);
    if (threads_live) *threads_live = tcpip_stack_get_sys_port_var_int(&st->sys, 0, FSA_SYS_PORT_SVAR_THREADS_LIVE);
    if (pool_state) *pool_state = tcpip_stack_get_frame_pool_state(&st->sys, 0);
    if (pool_free) *pool_free = tcpip_stack_get_frame_pool_var_int(&st->sys, 0, FSA_FRAME_POOL_SVAR_FREE_SLOTS);
    if (pool_used) *pool_used = tcpip_stack_get_frame_pool_var_int(&st->sys, 0, FSA_FRAME_POOL_SVAR_USED_SLOTS);
    if (actor_state) *actor_state = tcpip_stack_get_stack_actor_state(&st->sys, 0);
    if (actor_q_depth) *actor_q_depth = tcpip_stack_get_stack_actor_var_int(&st->sys, 0, FSA_STACK_ACTOR_SVAR_Q_DEPTH);
    if (actor_dispatched) *actor_dispatched = tcpip_stack_get_stack_actor_var_int(&st->sys, 0, FSA_STACK_ACTOR_SVAR_DISPATCHED_TOTAL);
    host_unlock(st);
}

void fsa_host_get_if_config(fsa_host_stack_t *st,
                            uint8_t ip_out[4], uint8_t mask_out[4], uint8_t gw_out[4], uint8_t dns_out[4]) {
    if (!st) return;
    host_lock(st);
    if (ip_out) {
        memset(ip_out, 0, 4);
        (void)tcpip_stack_get_eth_ipv4_icmp_var_bytes(&st->sys, 0, FSA_ETH_IP_BVAR_LOCAL_IP, ip_out, 4);
    }
    if (mask_out) {
        memset(mask_out, 0, 4);
        (void)tcpip_stack_get_eth_ipv4_icmp_var_bytes(&st->sys, 0, FSA_ETH_IP_BVAR_NETMASK, mask_out, 4);
    }
    if (gw_out) {
        memset(gw_out, 0, 4);
        (void)tcpip_stack_get_eth_ipv4_icmp_var_bytes(&st->sys, 0, FSA_ETH_IP_BVAR_GATEWAY, gw_out, 4);
    }
    if (dns_out) {
        memset(dns_out, 0, 4);
        (void)tcpip_stack_get_eth_ipv4_icmp_var_bytes(&st->sys, 0, FSA_ETH_IP_BVAR_DNS_IP, dns_out, 4);
    }
    host_unlock(st);
}

/* ---- Interface, RX, Timers ---- */

int fsa_host_init_if(fsa_host_stack_t *st, int64_t now_ms,
                     const uint8_t ip[4], const uint8_t mask[4], const uint8_t gw[4],
                     const uint8_t mac[6], uint16_t mtu) {
    int rc;
    if (!st || !ip || !mask || !gw || !mac) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_init_if(&st->sys, now_ms, ip, 4U, mask, 4U, gw, 4U, mac, 6U, (int64_t)mtu);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int fsa_host_input_frame(fsa_host_stack_t *st, int64_t now_ms, const uint8_t *frame, uint16_t len) {
    int rc = 0;
    if (!st || !frame || len == 0U || len > FSA_HOST_MAX_FRAME_LEN) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    if (st->actor_running) {
        if (st->rx_in_count < FSA_HOST_RX_MBOX_CAP) {
            uint16_t tail = (uint16_t)((st->rx_in_head + st->rx_in_count) % FSA_HOST_RX_MBOX_CAP);
            st->rx_in_q[tail].len = len;
            st->rx_in_q[tail].ts_ms = now_ms;
            memcpy(st->rx_in_q[tail].data, frame, len);
            st->rx_in_count++;
            host_notify_actor(st);
        } else {
            rc = -1;
        }
    } else {
        rc = process_one_rx_locked(st, now_ms, frame, len);
    }
    host_unlock(st);
    return rc;
}

int fsa_host_tick(fsa_host_stack_t *st, int64_t now_ms) {
    int rc;
    if (!st) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_tick(&st->sys, now_ms);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int64_t fsa_host_next_due_ms(fsa_host_stack_t *st) {
    int64_t due;
    if (!st) return -1;
    host_lock(st);
    due = tcpip_stack_next_due_ms(&st->sys);
    host_unlock(st);
    return due;
}

int fsa_host_tx_ip(fsa_host_stack_t *st, int64_t now_ms,
                   const uint8_t src_ip[4], const uint8_t dst_ip[4],
                   uint8_t proto, const uint8_t *payload, uint16_t len) {
    int rc;
    if (!st || !src_ip || !dst_ip || (!payload && len > 0U)) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_tx_ip(&st->sys, now_ms, src_ip, 4U, dst_ip, 4U, (int64_t)proto, payload, len);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

/* ---- UDP API ---- */

int fsa_host_udp_open(fsa_host_stack_t *st) {
    int slot = -1, i;
    if (!st) return -1;
    host_lock(st);
    for (i = 0; i < 16; i++) {
        if (tcpip_stack_get_udp_endpoint_state(&st->sys, i) == FSA_UDP_STATE_UNBOUND &&
            !st->udp_slots[i].reserved) {
            memset(&st->udp_slots[i], 0, sizeof(st->udp_slots[i]));
            st->udp_slots[i].reserved = 1;
            slot = i;
            break;
        }
    }
    host_unlock(st);
    return slot;
}

int fsa_host_udp_bind(fsa_host_stack_t *st, int64_t now_ms, int slot,
                      const uint8_t *local_ip_or_null, uint16_t local_port) {
    static const uint8_t zero4[4] = {0, 0, 0, 0};
    const uint8_t *ip = local_ip_or_null ? local_ip_or_null : zero4;
    uint16_t ip_len = local_ip_or_null ? 4U : 0U;
    int rc;
    if (!st || slot < 0 || slot >= 16) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_udp_bind(&st->sys, now_ms, slot, ip, ip_len, (int64_t)local_port);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int fsa_host_udp_connect(fsa_host_stack_t *st, int64_t now_ms, int slot,
                         const uint8_t remote_ip[4], uint16_t remote_port) {
    int rc;
    if (!st || slot < 0 || slot >= 16 || !remote_ip) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_udp_connect(&st->sys, now_ms, slot, remote_ip, 4U, (int64_t)remote_port);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int fsa_host_udp_sendto(fsa_host_stack_t *st, int64_t now_ms, int slot,
                        const uint8_t src_ip[4], const uint8_t dst_ip[4], uint16_t dst_port,
                        const uint8_t *data, uint16_t len) {
    int rc;
    if (!st || slot < 0 || slot >= 16 || !src_ip || !dst_ip) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_udp_sendto(&st->sys, now_ms, slot, src_ip, 4U, dst_ip, 4U, (int64_t)dst_port, data, len);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int fsa_host_udp_send(fsa_host_stack_t *st, int64_t now_ms, int slot,
                      const uint8_t src_ip[4], const uint8_t *data, uint16_t len) {
    int rc;
    if (!st || slot < 0 || slot >= 16 || !src_ip) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_udp_send(&st->sys, now_ms, slot, src_ip, 4U, data, len);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

#if !FSA_HOST_NO_SYS && !defined(FSA_HOST_FREERTOS)
static void make_deadline(struct timespec *ts, uint32_t timeout_ms) {
    (void)clock_gettime(CLOCK_REALTIME, ts);
    ts->tv_sec += (time_t)(timeout_ms / 1000U);
    ts->tv_nsec += (long)(timeout_ms % 1000U) * 1000000L;
    if (ts->tv_nsec >= 1000000000L) {
        ts->tv_sec += 1;
        ts->tv_nsec -= 1000000000L;
    }
}
#endif

int fsa_host_udp_recv(fsa_host_stack_t *st, int slot, fsa_host_udp_dgram_t *out, uint32_t timeout_ms) {
    int rc = -1;
    if (!st || slot < 0 || slot >= 16 || !out) return -1;
    host_lock(st);
#if !FSA_HOST_NO_SYS && !defined(FSA_HOST_FREERTOS)
    if (st->udp_slots[slot].count == 0U && timeout_ms > 0U && st->actor_running) {
        struct timespec dl;
        make_deadline(&dl, timeout_ms);
        while (st->udp_slots[slot].count == 0U) {
            if (pthread_cond_timedwait(&st->app_cv, &st->lock, &dl) == ETIMEDOUT) break;
        }
    }
#else
    (void)timeout_ms;
#endif
    if (st->udp_slots[slot].count > 0U) {
        fsa_host_udp_slot_t *us = &st->udp_slots[slot];
        *out = us->q[us->head];
        us->head = (uint16_t)((us->head + 1U) % FSA_HOST_UDP_QUEUE_CAP);
        us->count--;
        rc = (int)out->len;
    }
    host_unlock(st);
    return rc;
}

int fsa_host_udp_close(fsa_host_stack_t *st, int64_t now_ms, int slot) {
    int rc;
    if (!st || slot < 0 || slot >= 16) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_udp_close(&st->sys, now_ms, slot);
    memset(&st->udp_slots[slot], 0, sizeof(st->udp_slots[slot]));
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

/* ---- TCP API ---- */

int fsa_host_tcp_open(fsa_host_stack_t *st) {
    int slot = -1, i;
    if (!st) return -1;
    host_lock(st);
    for (i = 0; i < 12; i++) {
        if (tcpip_stack_get_tcp_connection_state(&st->sys, i) == FSA_TCP_STATE_CLOSED) {
            if (st->tcp_slots[i].closed) {
                st->tcp_slots[i].reserved = 0;
            }
            if (!st->tcp_slots[i].reserved) {
                memset(&st->tcp_slots[i], 0, sizeof(st->tcp_slots[i]));
                st->tcp_slots[i].reserved = 1;
                slot = i;
                break;
            }
        }
    }
    host_unlock(st);
    return slot;
}

int fsa_host_tcp_state(fsa_host_stack_t *st, int slot) {
    int state;
    if (!st || slot < 0 || slot >= 12) return -1;
    host_lock(st);
    state = tcpip_stack_get_tcp_connection_state(&st->sys, slot);
    host_unlock(st);
    return state;
}

int fsa_host_tcp_listen(fsa_host_stack_t *st, int64_t now_ms, int slot,
                        const uint8_t *local_ip_or_null, uint16_t local_port) {
    static const uint8_t zero4[4] = {0, 0, 0, 0};
    const uint8_t *ip = local_ip_or_null ? local_ip_or_null : zero4;
    uint16_t ip_len = local_ip_or_null ? 4U : 0U;
    int rc;
    if (!st || slot < 0 || slot >= 12) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    memset(&st->tcp_slots[slot], 0, sizeof(st->tcp_slots[slot]));
    st->tcp_slots[slot].reserved = 1;
    rc = tcpip_stack_tcp_listen(&st->sys, now_ms, slot, ip, ip_len, (int64_t)local_port);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int fsa_host_tcp_accept(fsa_host_stack_t *st, int listen_slot, fsa_host_accept_item_t *out, uint32_t timeout_ms) {
    int child = -1;
    if (!st || listen_slot < 0 || listen_slot >= 12) return -1;
    host_lock(st);
#if !FSA_HOST_NO_SYS && !defined(FSA_HOST_FREERTOS)
    if (st->tcp_slots[listen_slot].accept_count == 0U && timeout_ms > 0U && st->actor_running) {
        struct timespec dl;
        make_deadline(&dl, timeout_ms);
        while (st->tcp_slots[listen_slot].accept_count == 0U) {
            if (pthread_cond_timedwait(&st->app_cv, &st->lock, &dl) == ETIMEDOUT) break;
        }
    }
#else
    (void)timeout_ms;
#endif
    if (st->tcp_slots[listen_slot].accept_count > 0U) {
        fsa_host_tcp_slot_t *ls = &st->tcp_slots[listen_slot];
        fsa_host_accept_item_t item = ls->accept_q[ls->accept_head];
        ls->accept_head = (uint16_t)((ls->accept_head + 1U) % FSA_HOST_ACCEPT_CAP);
        ls->accept_count--;
        child = item.child_slot;
        if (out) *out = item;
    }
    host_unlock(st);
    return child;
}

int fsa_host_tcp_connect(fsa_host_stack_t *st, int64_t now_ms, int slot,
                         const uint8_t local_ip[4], uint16_t local_port,
                         const uint8_t remote_ip[4], uint16_t remote_port, uint32_t iss) {
    int rc;
    if (!st || slot < 0 || slot >= 12 || !local_ip || !remote_ip) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    memset(&st->tcp_slots[slot], 0, sizeof(st->tcp_slots[slot]));
    st->tcp_slots[slot].reserved = 1;
    rc = tcpip_stack_tcp_connect(&st->sys, now_ms, slot, local_ip, 4U, (int64_t)local_port,
                                 remote_ip, 4U, (int64_t)remote_port, iss);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int fsa_host_tcp_is_connected(fsa_host_stack_t *st, int slot) {
    int conn;
    if (!st || slot < 0 || slot >= 12) return 0;
    host_lock(st);
    conn = st->tcp_slots[slot].connected;
    host_unlock(st);
    return conn;
}

int fsa_host_tcp_wait_connected(fsa_host_stack_t *st, int slot, uint32_t timeout_ms) {
    int ok = 0;
    if (!st || slot < 0 || slot >= 12) return -1;
    host_lock(st);
#if !FSA_HOST_NO_SYS && !defined(FSA_HOST_FREERTOS)
    if (!st->tcp_slots[slot].connected && !st->tcp_slots[slot].closed && timeout_ms > 0U && st->actor_running) {
        struct timespec dl;
        make_deadline(&dl, timeout_ms);
        while (!st->tcp_slots[slot].connected && !st->tcp_slots[slot].closed) {
            if (pthread_cond_timedwait(&st->app_cv, &st->lock, &dl) == ETIMEDOUT) break;
        }
    }
#else
    (void)timeout_ms;
#endif
    ok = st->tcp_slots[slot].connected;
    host_unlock(st);
    return ok ? 0 : -1;
}

static void pump_tcp_slot_locked(fsa_host_stack_t *st, int64_t now_ms, int slot) {
    int guard;
    for (guard = 0; guard < 8; guard++) {
        uint32_t una = (uint32_t)st->sys.m_tcp_connection[slot].v[FSA_TCP_SVAR_SND_UNA];
        uint32_t nxt = (uint32_t)st->sys.m_tcp_connection[slot].v[FSA_TCP_SVAR_SND_NXT];
        int64_t unsent = (int64_t)(uint32_t)(nxt - una);
        int64_t blen = (int64_t)st->sys.m_tcp_connection[slot].blen[FSA_TCP_BVAR_SND_BUF];
        int64_t swnd = st->sys.m_tcp_connection[slot].v[FSA_TCP_SVAR_SND_WND];
        int64_t cwnd = st->sys.m_tcp_connection[slot].v[FSA_TCP_SVAR_CWND];
        int64_t ew = swnd < cwnd ? swnd : cwnd;
        if (blen <= unsent || unsent >= ew) break;
        if (tcpip_stack_tcp_pump(&st->sys, now_ms, slot) != FSA_OK) break;
        flush_tx_locked(st, now_ms);
    }
}

int fsa_host_tcp_write(fsa_host_stack_t *st, int64_t now_ms, int slot, const uint8_t *data, uint32_t len) {
    uint32_t written = 0U;
    if (!st || slot < 0 || slot >= 12 || (!data && len > 0U)) return -1;
    if (len == 0U) return 0;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    while (written < len) {
        uint16_t cur_blen = st->sys.m_tcp_connection[slot].blen[FSA_TCP_BVAR_SND_BUF];
        uint32_t avail = cur_blen < 8192U ? (uint32_t)(8192U - cur_blen) : 0U;
        uint32_t chunk;
        if (avail == 0U) break;
        chunk = (len - written) < avail ? (len - written) : avail;
        if (chunk > 4096U) chunk = 4096U;
        if (tcpip_stack_tcp_send(&st->sys, now_ms, slot, data + written, (uint16_t)chunk) != FSA_OK) {
            if (written == 0U) {
                host_unlock(st);
                return -1;
            }
            break;
        }
        flush_tx_locked(st, now_ms);
        pump_tcp_slot_locked(st, now_ms, slot);
        written += chunk;
    }
    host_unlock(st);
    return (int)written;
}

int fsa_host_tcp_pump(fsa_host_stack_t *st, int64_t now_ms, int slot) {
    if (!st || slot < 0 || slot >= 12) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    pump_tcp_slot_locked(st, now_ms, slot);
    host_unlock(st);
    return 0;
}

int fsa_host_tcp_recv(fsa_host_stack_t *st, int64_t now_ms, int slot,
                      uint8_t *dst, uint32_t cap, int *eof_out, uint32_t timeout_ms) {
    uint32_t take = 0U, i;
    if (!st || slot < 0 || slot >= 12 || (!dst && cap > 0U)) return -1;
    host_lock(st);
#if !FSA_HOST_NO_SYS && !defined(FSA_HOST_FREERTOS)
    if (st->tcp_slots[slot].rx_len == 0U && !st->tcp_slots[slot].peer_eof &&
        !st->tcp_slots[slot].closed && timeout_ms > 0U && st->actor_running) {
        struct timespec dl;
        make_deadline(&dl, timeout_ms);
        while (st->tcp_slots[slot].rx_len == 0U && !st->tcp_slots[slot].peer_eof && !st->tcp_slots[slot].closed) {
            if (pthread_cond_timedwait(&st->app_cv, &st->lock, &dl) == ETIMEDOUT) break;
        }
    }
#else
    (void)timeout_ms;
#endif
    {
        fsa_host_tcp_slot_t *ts = &st->tcp_slots[slot];
        take = ts->rx_len < cap ? ts->rx_len : cap;
        for (i = 0U; i < take; i++) {
            dst[i] = ts->rx_buf[(ts->rx_head + i) % (uint32_t)FSA_HOST_TCP_RX_BUF_CAP];
        }
        ts->rx_head = (ts->rx_head + take) % (uint32_t)FSA_HOST_TCP_RX_BUF_CAP;
        ts->rx_len -= take;
        if (eof_out) {
            *eof_out = (ts->rx_len == 0U && (ts->peer_eof || ts->closed)) ? 1 : 0;
        }
        if (take > 0U) {
            int st_id = tcpip_stack_get_tcp_connection_state(&st->sys, slot);
            if (st_id == FSA_TCP_STATE_ESTABLISHED ||
                st_id == FSA_TCP_STATE_FIN_WAIT_1 ||
                st_id == FSA_TCP_STATE_FIN_WAIT_2) {
                now_ms = resolve_now_ms(st, now_ms);
                (void)tcpip_stack_tcp_recved(&st->sys, now_ms, slot, (int64_t)take);
                flush_tx_locked(st, now_ms);
            }
        }
    }
    host_unlock(st);
    return (int)take;
}

int fsa_host_tcp_close(fsa_host_stack_t *st, int64_t now_ms, int slot) {
    int rc;
    if (!st || slot < 0 || slot >= 12) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_tcp_close(&st->sys, now_ms, slot);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int fsa_host_tcp_abort(fsa_host_stack_t *st, int64_t now_ms, int slot) {
    int rc;
    if (!st || slot < 0 || slot >= 12) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_tcp_abort(&st->sys, now_ms, slot);
    st->tcp_slots[slot].closed = 1;
    st->tcp_slots[slot].connected = 0;
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

/* ---- DHCPv4 & DNS ---- */

int fsa_host_dhcp_start(fsa_host_stack_t *st, int64_t now_ms, const uint8_t mac[6], uint32_t xid) {
    int rc;
    if (!st || !mac) return -1;
    host_lock(st);
    now_ms = resolve_now_ms(st, now_ms);
    memset(&st->dhcp, 0, sizeof(st->dhcp));
    rc = tcpip_stack_dhcp_start(&st->sys, now_ms, mac, 6U, (int64_t)xid);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return rc;
}

int fsa_host_dhcp_poll(fsa_host_stack_t *st, fsa_host_dhcp_info_t *out) {
    int bound;
    if (!st) return 0;
    host_lock(st);
    bound = st->dhcp.bound;
    if (out) *out = st->dhcp;
    host_unlock(st);
    return bound;
}

uint16_t fsa_host_dns_encode_qname(const char *hostname, uint8_t *out, uint16_t cap) {
    uint16_t pos = 0U;
    const char *p = hostname;
    if (!hostname || !out || cap < 2U) return 0U;
    while (*p != '\0') {
        const char *dot = strchr(p, '.');
        size_t lab_len = dot ? (size_t)(dot - p) : strlen(p);
        if (lab_len == 0U || lab_len > 63U) return 0U;
        if ((uint32_t)pos + 1U + (uint32_t)lab_len + 1U > (uint32_t)cap) return 0U;
        out[pos++] = (uint8_t)lab_len;
        memcpy(out + pos, p, lab_len);
        pos = (uint16_t)(pos + (uint16_t)lab_len);
        if (!dot) break;
        p = dot + 1;
    }
    out[pos++] = 0U;
    return pos;
}

int fsa_host_dns_query(fsa_host_stack_t *st, int64_t now_ms,
                       const uint8_t src_ip[4], const uint8_t server_ip[4],
                       const char *hostname, uint16_t txid) {
    uint8_t qwire[256];
    uint16_t qlen;
    int slot, rc;
    if (!st || !src_ip || !server_ip || !hostname) return -1;
    qlen = fsa_host_dns_encode_qname(hostname, qwire, sizeof(qwire));
    if (qlen == 0U) return -1;
    host_lock(st);
    slot = tcpip_stack_alloc_dns_resolver(&st->sys);
    if (slot < 0 || slot >= 4) {
        host_unlock(st);
        return -1;
    }
    memset(&st->dns_slots[slot], 0, sizeof(st->dns_slots[slot]));
    st->dns_slots[slot].qname_len = qlen;
    memcpy(st->dns_slots[slot].qname_wire, qwire, qlen);
    now_ms = resolve_now_ms(st, now_ms);
    rc = tcpip_stack_dns_resolve(&st->sys, now_ms, slot, src_ip, 4U, server_ip, 4U, qwire, qlen, (int64_t)txid);
    flush_tx_locked(st, now_ms);
    host_unlock(st);
    return (rc == FSA_OK) ? slot : -1;
}

int fsa_host_dns_poll(fsa_host_stack_t *st, int slot, fsa_host_dns_slot_t *out) {
    int status;
    if (!st || slot < 0 || slot >= 4) return -1;
    host_lock(st);
    status = st->dns_slots[slot].status;
    if (out) *out = st->dns_slots[slot];
    host_unlock(st);
    return status;
}

/* ---- Deterministic Virtual Ethernet Wire ---- */

static void veth_enqueue_pkt(fsa_host_veth_link_t *link, int dst_side,
                             const uint8_t *frame, uint16_t len, int64_t deliver_ms) {
    size_t i;
    if (!link || len == 0U || len > FSA_HOST_MAX_FRAME_LEN) return;
    for (i = 0U; i < FSA_HOST_VETH_QUEUE_CAP; i++) {
        if (!link->q[i].valid) {
            link->q[i].valid = 1;
            link->q[i].dst_side = dst_side;
            link->q[i].deliver_ms = deliver_ms;
            link->q[i].len = len;
            memcpy(link->q[i].data, frame, len);
            return;
        }
    }
}

static void veth_send_dir(fsa_host_veth_link_t *link, int dir,
                          const uint8_t *frame, uint16_t len, int64_t now_ms) {
    uint64_t seq;
    const fsa_host_impair_cfg_t *cfg;
    int dst_side = (dir == 0) ? 1 : 0;
    int drop = 0, reorder = 0, dup = 0;
    int64_t deliver_ms;
    if (!link || !frame || len == 0U) return;
    if (link->pcap) {
        (void)fsa_host_pcap_write(link->pcap, frame, len, now_ms);
    }
    cfg = &link->dir_cfg[dir];
    seq = link->tx_seq[dir]++;
    if (seq < 64ULL && ((cfg->drop_seq_mask >> seq) & 1ULL) != 0ULL) drop = 1;
    if (cfg->drop_every_n > 0U && ((seq + 1ULL) % (uint64_t)cfg->drop_every_n) == 0ULL) drop = 1;
    if (drop) {
        link->dropped[dir]++;
        return;
    }
    if (seq < 64ULL && ((cfg->reorder_seq_mask >> seq) & 1ULL) != 0ULL) reorder = 1;
    if (seq < 64ULL && ((cfg->dup_seq_mask >> seq) & 1ULL) != 0ULL) dup = 1;
    deliver_ms = now_ms + cfg->base_delay_ms;
    if (reorder) {
        int64_t extra = cfg->reorder_extra_ms > 0 ? cfg->reorder_extra_ms : 5;
        deliver_ms += extra;
        link->reordered[dir]++;
    }
    veth_enqueue_pkt(link, dst_side, frame, len, deliver_ms);
    if (dup) {
        veth_enqueue_pkt(link, dst_side, frame, len, deliver_ms + 1);
        link->duplicated[dir]++;
    }
}

static void veth_tx_a_cb(void *ctx, const uint8_t *frame, uint16_t len, int64_t now_ms) {
    veth_send_dir((fsa_host_veth_link_t *)ctx, 0, frame, len, now_ms);
}

static void veth_tx_b_cb(void *ctx, const uint8_t *frame, uint16_t len, int64_t now_ms) {
    veth_send_dir((fsa_host_veth_link_t *)ctx, 1, frame, len, now_ms);
}

void fsa_host_veth_init(fsa_host_veth_link_t *link, fsa_host_pcap_t *pcap) {
    if (!link) return;
    memset(link, 0, sizeof(*link));
    link->pcap = pcap;
}

void fsa_host_veth_attach(fsa_host_veth_link_t *link, fsa_host_stack_t *side_a, fsa_host_stack_t *side_b) {
    if (!link) return;
    link->side[0] = side_a;
    link->side[1] = side_b;
}

fsa_host_wire_tx_fn fsa_host_veth_tx_fn_a(void) { return veth_tx_a_cb; }
fsa_host_wire_tx_fn fsa_host_veth_tx_fn_b(void) { return veth_tx_b_cb; }

int fsa_host_veth_pump(fsa_host_veth_link_t *link, int64_t now_ms) {
    int count = 0;
    if (!link) return 0;
    for (;;) {
        int best_idx = -1;
        int64_t best_ts = 0;
        size_t i;
        for (i = 0U; i < FSA_HOST_VETH_QUEUE_CAP; i++) {
            if (link->q[i].valid && link->q[i].deliver_ms <= now_ms) {
                if (best_idx < 0 || link->q[i].deliver_ms < best_ts) {
                    best_idx = (int)i;
                    best_ts = link->q[i].deliver_ms;
                }
            }
        }
        if (best_idx < 0) break;
        {
            fsa_host_veth_pkt_t pkt = link->q[best_idx];
            int dir = (pkt.dst_side == 1) ? 0 : 1;
            link->q[best_idx].valid = 0;
            if (link->side[pkt.dst_side]) {
                link->delivered[dir]++;
                (void)fsa_host_input_frame(link->side[pkt.dst_side], now_ms, pkt.data, pkt.len);
                count++;
            }
        }
    }
    return count;
}

int fsa_host_veth_step_until_quiescent(fsa_host_veth_link_t *link, int64_t now_ms, int max_rounds) {
    int total = 0, r;
    if (!link) return 0;
    for (r = 0; r < max_rounds; r++) {
        int n;
        if (link->side[0] && !link->side[0]->actor_running) (void)fsa_host_tick(link->side[0], now_ms);
        if (link->side[1] && !link->side[1]->actor_running) (void)fsa_host_tick(link->side[1], now_ms);
        n = fsa_host_veth_pump(link, now_ms);
        total += n;
        if (n == 0) break;
    }
    return total;
}

/* ---- Real POSIX UDP Loopback Wire Bridge ---- */

#if !FSA_HOST_NO_SYS && !defined(FSA_HOST_FREERTOS)
static int open_loopback_udp(uint16_t *port_out) {
    struct sockaddr_in sin;
    socklen_t slen = sizeof(sin);
    int fd = socket(AF_INET, SOCK_DGRAM, 0);
    int flags;
    if (fd < 0) return -1;
    memset(&sin, 0, sizeof(sin));
    sin.sin_family = AF_INET;
    sin.sin_addr.s_addr = htonl(UINT32_C(0x7F000001));
    sin.sin_port = htons(0);
    if (bind(fd, (struct sockaddr *)&sin, sizeof(sin)) != 0 ||
        getsockname(fd, (struct sockaddr *)&sin, &slen) != 0) {
        close(fd);
        return -1;
    }
    flags = fcntl(fd, F_GETFL, 0);
    if (flags >= 0) (void)fcntl(fd, F_SETFL, flags | O_NONBLOCK);
    *port_out = ntohs(sin.sin_port);
    return fd;
}

static void udp_wire_send(fsa_host_udp_wire_t *w, int from_a, const uint8_t *frame, uint16_t len, int64_t now_ms) {
    struct sockaddr_in dst;
    int fd;
    if (!w || !frame || len == 0U) return;
    if (w->pcap) (void)fsa_host_pcap_write(w->pcap, frame, len, now_ms);
    memset(&dst, 0, sizeof(dst));
    dst.sin_family = AF_INET;
    dst.sin_addr.s_addr = htonl(UINT32_C(0x7F000001));
    dst.sin_port = htons(from_a ? w->port_b : w->port_a);
    fd = from_a ? w->fd_a : w->fd_b;
    if (fd >= 0 && sendto(fd, frame, len, 0, (struct sockaddr *)&dst, sizeof(dst)) > 0) {
        if (from_a) w->tx_a_to_b++;
        else w->tx_b_to_a++;
    }
}

static void udp_wire_tx_a_cb(void *ctx, const uint8_t *frame, uint16_t len, int64_t now_ms) {
    udp_wire_send((fsa_host_udp_wire_t *)ctx, 1, frame, len, now_ms);
}

static void udp_wire_tx_b_cb(void *ctx, const uint8_t *frame, uint16_t len, int64_t now_ms) {
    udp_wire_send((fsa_host_udp_wire_t *)ctx, 0, frame, len, now_ms);
}

int fsa_host_udp_wire_open(fsa_host_udp_wire_t *w, fsa_host_pcap_t *pcap) {
    if (!w) return -1;
    memset(w, 0, sizeof(*w));
    w->fd_a = -1;
    w->fd_b = -1;
    w->pcap = pcap;
    w->fd_a = open_loopback_udp(&w->port_a);
    w->fd_b = open_loopback_udp(&w->port_b);
    if (w->fd_a < 0 || w->fd_b < 0) {
        fsa_host_udp_wire_close(w);
        return -1;
    }
    return 0;
}

void fsa_host_udp_wire_close(fsa_host_udp_wire_t *w) {
    if (!w) return;
    if (w->fd_a >= 0) { close(w->fd_a); w->fd_a = -1; }
    if (w->fd_b >= 0) { close(w->fd_b); w->fd_b = -1; }
}

fsa_host_wire_tx_fn fsa_host_udp_wire_tx_a(void) { return udp_wire_tx_a_cb; }
fsa_host_wire_tx_fn fsa_host_udp_wire_tx_b(void) { return udp_wire_tx_b_cb; }

int fsa_host_udp_wire_pump(fsa_host_udp_wire_t *w, fsa_host_stack_t *side_a, fsa_host_stack_t *side_b, int64_t now_ms) {
    uint8_t buf[FSA_HOST_MAX_FRAME_LEN];
    int total = 0, guard;
    if (!w) return 0;
    for (guard = 0; guard < 128; guard++) {
        int progressed = 0;
        ssize_t n;
        if (w->fd_a >= 0 && side_a) {
            n = recv(w->fd_a, buf, sizeof(buf), 0);
            if (n > 0) {
                (void)fsa_host_input_frame(side_a, now_ms, buf, (uint16_t)n);
                total++;
                progressed = 1;
            }
        }
        if (w->fd_b >= 0 && side_b) {
            n = recv(w->fd_b, buf, sizeof(buf), 0);
            if (n > 0) {
                (void)fsa_host_input_frame(side_b, now_ms, buf, (uint16_t)n);
                total++;
                progressed = 1;
            }
        }
        if (!progressed) break;
    }
    return total;
}
#else
static void udp_wire_noop_cb(void *ctx, const uint8_t *frame, uint16_t len, int64_t now_ms) {
    (void)ctx; (void)frame; (void)len; (void)now_ms;
}
int fsa_host_udp_wire_open(fsa_host_udp_wire_t *w, fsa_host_pcap_t *pcap) {
    (void)w; (void)pcap; return -1;
}
void fsa_host_udp_wire_close(fsa_host_udp_wire_t *w) { (void)w; }
fsa_host_wire_tx_fn fsa_host_udp_wire_tx_a(void) { return udp_wire_noop_cb; }
fsa_host_wire_tx_fn fsa_host_udp_wire_tx_b(void) { return udp_wire_noop_cb; }
int fsa_host_udp_wire_pump(fsa_host_udp_wire_t *w, fsa_host_stack_t *side_a, fsa_host_stack_t *side_b, int64_t now_ms) {
    (void)w; (void)side_a; (void)side_b; (void)now_ms; return 0;
}
#endif
