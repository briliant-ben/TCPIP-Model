# Layer 4: Multi-Endpoint UDP & 11-State RFC 9293/6298/5681 TCP Specification

## Scope
Covers multi-slot UDP endpoints (`model/stack/udp_endpoint.json`, 8 slots) and full 11-state TCP connections (`model/stack/tcp_connection.json`, 8 slots) composed into `code/generated/stack/` from `model/tcpip-stack-system.json`.

## Requirements
- `L4.UDP`: `UNBOUND`, `BOUND`, `CONNECTED` endpoint lifecycle, RFC 768 8-byte header + RFC 1071 pseudo-header checksum, exact vs wildcard matching (`tcpip_stack_rx_frame` lookup chain), and ICMP Port Unreachable on miss.
- `L4.TCP`: Full 11-state RFC 9293 connection lifecycle (`CLOSED`, `LISTEN`, `SYN_SENT`, `SYN_RCVD`, `ESTABLISHED`, `FIN_WAIT_1`, `FIN_WAIT_2`, `CLOSE_WAIT`, `CLOSING`, `LAST_ACK`, `TIME_WAIT`), active open, passive LISTEN fork (`accepted`), MSS negotiation (`256..1460`), 8192B send buffer & receive window, out-of-order segment buffering (`<= 1460` B), 3-DupACK fast retransmit, slow-start/congestion avoidance (`cwnd`/`ssthresh`), zero-window probing (`tmr.rtx` ZWP), exponential RTO backoff (`100..60000` ms, `retries <= 8`), graceful FIN teardown, RST abort, and 2s `TIME_WAIT` expiry.
