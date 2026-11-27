#include <stdio.h>
#include <stdlib.h>
#include "tcpip/opt.h"
#include "tcpip/pcap.h"

#if !TCPIP_NO_SYS
#include <pthread.h>
#endif

struct tcpip_pcap {
    FILE *fp;
    uint32_t packets;
#if !TCPIP_NO_SYS
    pthread_mutex_t lock;
#endif
};

static void put_le16(uint8_t *b, uint16_t v) {
    b[0] = (uint8_t)(v & 0xFFU);
    b[1] = (uint8_t)((v >> 8) & 0xFFU);
}

static void put_le32(uint8_t *b, uint32_t v) {
    b[0] = (uint8_t)(v & 0xFFU);
    b[1] = (uint8_t)((v >> 8) & 0xFFU);
    b[2] = (uint8_t)((v >> 16) & 0xFFU);
    b[3] = (uint8_t)((v >> 24) & 0xFFU);
}

err_t tcpip_pcap_open(tcpip_pcap_t **out, const char *path) {
    if (!out || !path) return ERR_ARG;
    FILE *fp = fopen(path, "wb");
    if (!fp) return ERR_MEM;

    /* Standard libpcap little-endian header, DLT_EN10MB = 1 */
    uint8_t hdr[24];
    put_le32(hdr + 0, 0xA1B2C3D4U);
    put_le16(hdr + 4, 2U);
    put_le16(hdr + 6, 4U);
    put_le32(hdr + 8, 0U);
    put_le32(hdr + 12, 0U);
    put_le32(hdr + 16, 65535U);
    put_le32(hdr + 20, 1U);
    if (fwrite(hdr, 1, sizeof(hdr), fp) != sizeof(hdr)) {
        fclose(fp);
        return ERR_MEM;
    }
    fflush(fp);

    tcpip_pcap_t *p = (tcpip_pcap_t *)calloc(1, sizeof(*p));
    if (!p) {
        fclose(fp);
        return ERR_MEM;
    }
    p->fp = fp;
#if !TCPIP_NO_SYS
    pthread_mutex_init(&p->lock, NULL);
#endif
    *out = p;
    return ERR_OK;
}

void tcpip_pcap_write(tcpip_pcap_t *pcap, uint64_t ts_us, const uint8_t *frame, uint16_t len) {
    if (!pcap || !pcap->fp || !frame || len == 0) return;
#if !TCPIP_NO_SYS
    pthread_mutex_lock(&pcap->lock);
#endif
    uint8_t rec[16];
    put_le32(rec + 0, (uint32_t)(ts_us / 1000000ULL));
    put_le32(rec + 4, (uint32_t)(ts_us % 1000000ULL));
    put_le32(rec + 8, (uint32_t)len);
    put_le32(rec + 12, (uint32_t)len);
    fwrite(rec, 1, sizeof(rec), pcap->fp);
    fwrite(frame, 1, len, pcap->fp);
    fflush(pcap->fp);
    pcap->packets++;
#if !TCPIP_NO_SYS
    pthread_mutex_unlock(&pcap->lock);
#endif
}

uint32_t tcpip_pcap_packet_count(const tcpip_pcap_t *pcap) {
    if (!pcap) return 0;
#if !TCPIP_NO_SYS
    pthread_mutex_lock(&((tcpip_pcap_t *)pcap)->lock);
    uint32_t n = pcap->packets;
    pthread_mutex_unlock(&((tcpip_pcap_t *)pcap)->lock);
    return n;
#else
    return pcap->packets;
#endif
}

void tcpip_pcap_close(tcpip_pcap_t *pcap) {
    if (!pcap) return;
#if !TCPIP_NO_SYS
    pthread_mutex_destroy(&pcap->lock);
#endif
    if (pcap->fp) fclose(pcap->fp);
    free(pcap);
}
