# L4 Transport Layer Specification — Multi-PCB UDP & Full RFC 9293/6298/5681 TCP

## 1. Scope & Architecture Role
Layer 4 sits above `ip4_input` / `ip4_output` (`src/core/ip4.c`) and below the sequential APIs (`netconn` / `sockets`, M4) and application callbacks (`NO_SYS=1` Raw API). Under `TCPIP_NO_SYS=0`, all UDP and TCP protocol state machines and PCB tables execute exclusively inside the single-writer `tcpip_thread` actor with zero internal locks.

## 2. UDP (`include/tcpip/udp.h`, `src/core/udp.c`)
- Fixed static pool `MEMP_UDP_PCB` (`TCPIP_MEMP_NUM_UDP_PCB`, default 16).
- Binding & demultiplexing:
  - Exact 4-tuple `(local_ip, local_port, remote_ip, remote_port)` match preferred over connected wildcard-local or unconnected `(local_ip/INADDR_ANY, local_port)`.
  - Ephemeral ports allocated monotonically from `[49152, 65535]`.
- Output & Checksum:
  - RFC 768 header (8 bytes) + RFC 1071 pseudo-header checksum (0 replaced with `0xFFFF` on TX; skipped on RX if 0).
- Error handling:
  - Unicast datagram with no matching PCB triggers `icmp_dest_unreach(ip_pkt, ICMP_DUR_PORT)` (`pbuf_header` restores IP header before passing to ICMP).

## 3. TCP (`include/tcpip/tcp.h`, `src/core/tcp*.c`) + Formal Model (`model/stack/tcp_pcb.json`)
- Fixed static pools `MEMP_TCP_PCB` (`TCPIP_MEMP_NUM_TCP_PCB`) and `MEMP_TCP_PCB_LISTEN` (`TCPIP_MEMP_NUM_TCP_PCB_LISTEN`).
- All 11 RFC 9293 connection states:
  `CLOSED` (0), `LISTEN` (1), `SYN_SENT` (2), `SYN_RCVD` (3), `ESTABLISHED` (4),
  `FIN_WAIT_1` (5), `FIN_WAIT_2` (6), `CLOSE_WAIT` (7), `CLOSING` (8), `LAST_ACK` (9), `TIME_WAIT` (10).
- Formalized shadow FSM `tcp_fsm` (`model/stack/tcp_pcb.json`, Lean 4 proved in `formal/lib/stack/tcp_pcb/TimedProof.lean`):
  - Variables: `unacked` in `[0, 65535]`, `cwnd` in `[1460, 65535]`, `ssthresh` in `[2920, 65535]`, `rto_ms` in `[200, 60000]`, `retries` in `[0, 8]`, `dup_acks` in `[0, 3]`, `snd_wnd` in `[0, 65535]`.
  - Timers: `retransmit` (active in `SYN_SENT`, `SYN_RCVD`, `FIN_WAIT_1`, `CLOSING`, `LAST_ACK`, and `ESTABLISHED` while `unacked > 0`), `persist` (active only in `ESTABLISHED` during Zero-Window Probe), `timewait` (active only in `TIME_WAIT`).
- Data path & reliability:
  - MSS option negotiation (default 1460 bytes).
  - Send & receive ring buffers (`TCPIP_TCP_SND_BUF`, `TCPIP_TCP_WND`).
  - Out-of-order segment reassembly queue (`TCPIP_TCP_OOO_MAX`) with SACK-style contiguous trimming on advance.
  - RFC 6298 RTT estimation (`SRTT`, `RTTVAR`, `RTO` clamped to `[200ms, 60000ms]`, Karn's algorithm on retransmissions, exponential backoff `RTO = min(2*RTO, 60000)`).
  - RFC 5681 Slow Start, Congestion Avoidance, 3-DupACK Fast Retransmit & Fast Recovery.
  - Zero-Window Probe (ZWP) persist timer preventing deadlock on `snd_wnd == 0`.
  - Clean active/passive FIN teardown, simultaneous close (`CLOSING`), `RST` abort, and `TIME_WAIT` recycling/expiry.
