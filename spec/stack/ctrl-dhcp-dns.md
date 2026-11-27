# Control-Plane Protocols & Sequential API Specification

## 1. Scope
- Sequential blocking APIs (`NO_SYS=0`): `netconn` (`include/tcpip/netconn.h`, `src/api/netconn.c`) and BSD-style `sockets` (`include/tcpip/sockets.h`, `src/api/sockets.c`) marshaling all PCB operations into the single-writer `tcpip_thread` actor via `tcpip_api_call` and per-connection `sys_mbox_t` queues.
- Control-plane UDP protocols: DHCPv4 client (`include/tcpip/dhcp.h`, `src/core/dhcp.c`) and DNS A-record stub resolver (`include/tcpip/dns.h`, `src/core/dns.c`).
- Embedded RTOS abstraction: FreeRTOS port skeleton (`port/freertos/sys_port_freertos.c`, `port/freertos/README.md`).

## 2. DHCPv4 Client (`model/stack/dhcp_client.json` -> `dhcp_fsm`)
- States: `INIT` (0), `SELECTING` (1), `REQUESTING` (2), `BOUND` (3), `RENEWING` (4), `REBINDING` (5).
- DORA exchange on UDP ports 68/67 (`BOOTREQUEST` / `BOOTREPLY`, magic cookie `0x63825363`), configuring `netif` IP/netmask/gateway via `netif_set_addr` and primary DNS server via `dns_setserver`.
- Bounded `retries` (`0..5`) and `lease_s` (`0..86400`), with `retry_tmo` and `lease_tmo` ownership invariants proved in Lean 4 (`formal/lib/stack/dhcp_client/TimedProof.lean`).

## 3. DNS Stub Resolver (`model/stack/dns_stub.json` -> `dns_fsm`)
- States: `IDLE` (0), `QUERYING` (1), `CACHED` (2).
- RFC 1035 standard A-record query/response with DNS label compression (`0xC0xx` pointer decompression), transaction ID matching, bounded retry backoff (`0..3`), and static 8-entry TTL cache (`TCPIP_DNS_CACHE_SIZE`).
- Proved in Lean 4 (`formal/lib/stack/dns_stub/TimedProof.lean`) with zero `sorry`.
