# Single-Writer `tcpip_thread` Actor Protocol (`tcpip_actor`)

## Scope
Formalizes lwIP-style core locking (`TCPIP_NO_SYS=0` actor thread / `TCPIP_NO_SYS=1` polled loop) so all core L2/L3/L4 PCB and ARP table mutations occur under single-writer ownership while application threads communicate solely through bounded mailboxes and synchronous reply semaphores.

## States
- `STOPPED`: actor inactive (`!core_locked`, `!reply_pending`).
- `IDLE`: actor awake/waiting on mailbox (`!core_locked`, `!reply_pending`).
- `HANDLING_RX`: processing an inbound Ethernet `pbuf` (`core_locked == true`).
- `HANDLING_API`: executing a marshaled Netconn/Socket RPC (`core_locked == true`).
- `HANDLING_TIMER`: executing scheduled TCP/ARP/IP-reass/DHCP/DNS timeouts (`core_locked == true`).

## Safety Invariants
1. `ACTOR_MUTEX`: `core_locked` holds if and only if `state` is `HANDLING_RX`, `HANDLING_API`, or `HANDLING_TIMER`.
2. `ACTOR_REPLY_LIVENESS`: completion of `HANDLING_API` posts the caller reply semaphore before clearing `core_locked` and returning to `IDLE`.
3. `ACTOR_QUEUE_BOUNDS`: `0 <= pending_rx <= 128` and `0 <= pending_api <= 64`.
