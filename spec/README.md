# Specification

## v1 Minimal Prototype Sources
[sources/](sources/) contains the exact RFC/Linux-link source versions used by
the v1 minimal single-endpoint profile, and [references.json](references.json)
maps each v1 model requirement to its source hash, clause, and immutable
original document.

## 10-Module Generated Stack & Software-Architecture Specifications
- **Software Architecture (`spec/arch/`)**:
  - [sys-port.md](arch/sys-port.md): OS synchronization & task lifecycle accounting (`sys_port`).
  - [frame-pool.md](arch/frame-pool.md): Fixed-capacity `128`-slot frame pool conservation (`frame_pool`).
  - [stack-actor.md](arch/stack-actor.md): Single-writer stack actor mailbox & dispatch discipline (`stack_actor`).
- **Network Stack (`spec/stack/`)**:
  - [l2-arp-netif.md](stack/l2-arp-netif.md): Ethernet II framing & 16-entry ARP neighbor cache with pending queue (`arp_neighbor`, `eth_ipv4_icmp`).
  - [l3-ipv4-icmp.md](stack/l3-ipv4-icmp.md): RFC 791 IPv4 routing/checksum, 2- and 3-fragment MTU split & out-of-order reassembly (`ipv4_reass`), and RFC 792 ICMP Echo / Destination Unreachable.
  - [l4-udp-tcp.md](stack/l4-udp-tcp.md): RFC 768 multi-endpoint UDP (`udp_endpoint`) and RFC 9293 / 6298 / 5681 11-state TCP (`tcp_connection`).
  - [ctrl-dhcp-dns.md](stack/ctrl-dhcp-dns.md): RFC 2131 DHCPv4 DORA client (`dhcpv4_client`) and RFC 1035 DNS A-record stub resolver (`dns_resolver`).

Next: [model](../model/README.md).
