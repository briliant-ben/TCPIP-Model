# Layer 2: Dynamic Multi-Netif, Ethernet II & ARP Specification

## Scope
Covers dynamic network interface management (`netif`), longest-prefix-match (LPM) CIDR routing, Ethernet II encapsulation/demultiplexing (`0x0800` IPv4, `0x0806` ARP), and bounded-queue RFC 826 ARP resolution/aging (`arp_entry.json` / `arp_fsm`).

## Requirements
- `L2.NETIF.LPM`: `netif_route(dest)` scans up interfaces matching `(dest & netmask) == (ip_addr & netmask)` and selects the match with maximum prefix length (`popcount(netmask)`), preferring exact host match or falling back to `netif_default`.
- `L2.ARP.TABLE`: Fixed 16-entry ARP cache (`TCPIP_ARP_TABLE_SIZE`) with no heap allocation.
- `L2.ARP.QUEUE`: An `EMPTY` entry transitions to `PENDING` on cache miss (`queue_len=1`, `retries=1`) and queues up to `TCPIP_ARP_QUEUE_LEN` (4) pending `pbuf`s. Overflow replaces/drops while keeping `0 <= queue_len <= 4`.
- `L2.ARP.TIMER`: `retry_tmo` retries up to 5 times in `PENDING` before evicting to `EMPTY`; `age_tmo` transitions `STABLE -> STALE -> EMPTY`. Timers are strictly tied to their owning states (`retry_tmo => PENDING`, `age_tmo => STABLE \/ STALE`).
