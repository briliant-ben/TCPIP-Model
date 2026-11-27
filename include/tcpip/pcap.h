#ifndef TCPIP_PCAP_H
#define TCPIP_PCAP_H

#include <stdint.h>
#include "tcpip/err.h"

typedef struct tcpip_pcap tcpip_pcap_t;

err_t tcpip_pcap_open(tcpip_pcap_t **out, const char *path);
void tcpip_pcap_write(tcpip_pcap_t *pcap, uint64_t ts_us, const uint8_t *frame, uint16_t len);
uint32_t tcpip_pcap_packet_count(const tcpip_pcap_t *pcap);
void tcpip_pcap_close(tcpip_pcap_t *pcap);

#endif /* TCPIP_PCAP_H */
