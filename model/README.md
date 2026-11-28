# Model

## 10-Module Generated TCP/IPv4 Stack (`tcpip-stack-system.json`)
[tcpip-stack-system.json](tcpip-stack-system.json) (`schema: fsa-system-v1`) composes
10 self-contained Protocol IR `0.6` state machines generated deterministically by
`code/author_models.py`:

- **Software Architecture (`arch/`)**:
  [sys_port.json](arch/sys_port.json),
  [frame_pool.json](arch/frame_pool.json),
  [stack_actor.json](arch/stack_actor.json)
- **Protocol Stack (`stack/`)**:
  [arp_neighbor.json](stack/arp_neighbor.json),
  [ipv4_reass.json](stack/ipv4_reass.json),
  [eth_ipv4_icmp.json](stack/eth_ipv4_icmp.json),
  [udp_endpoint.json](stack/udp_endpoint.json),
  [tcp_connection.json](stack/tcp_connection.json),
  [dhcpv4_client.json](stack/dhcpv4_client.json),
  [dns_resolver.json](stack/dns_resolver.json)

All byte parsing, packet serialization, RFC 1071 checksums, sliding-window arithmetic,
and timer transitions are expressed purely in declarative IR.

## Preserved v1 Minimal Prototype (`ipv4-endpoint-virtual-link.json`)
[ipv4-endpoint-virtual-link.json](ipv4-endpoint-virtual-link.json) (`SHA256`:
`7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5`) remains the
unchanged v1 single-endpoint model (335 rules, 58 variables, 65 invariants, 61
requirements; see [rules.md](rules.md)).

Next: [formal results](../formal/README.md).
