# Layer 2: Ethernet II Framing & ARP Neighbor Cache Specification

## Scope
Covers Ethernet II framing (`0x0800` IPv4, `0x0806` ARP) in `model/stack/eth_ipv4_icmp.json` and RFC 826 ARP resolution/queuing/aging in `model/stack/arp_neighbor.json` (16-slot neighbor table composed in `model/tcpip-stack-system.json`).

## Requirements
- `L2.ETH`: Validate Ethernet II headers (>= 42B for ARP, >= 34B for IPv4), answer ARP requests targeting `local_ip`, learn peer `(ip, mac)` bindings via `arp_learn`, and apply subnet/gateway next-hop selection.
- `L2.ARP`: Bounded 16-entry ARP neighbor table (`FREE`, `PENDING`, `REACHABLE`). Unicast resolution caches `pending_pkt` (`<= 1500` B), retries up to 4 times (`250` ms), flushes `pending_pkt` when resolved, and ages entries after `60000` ms. Broadcast IPv4 (`255.255.255.255`) emits directly to `ff:ff:ff:ff:ff:ff`.
