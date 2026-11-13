# 2. Authoritative protocol model

Start with [ipv4-endpoint-virtual-link.json](ipv4-endpoint-virtual-link.json):
**335 rules, 58 variables, 65 invariants and 61 specification/scope requirements**.
One composed EFSM owns Ethernet/ARP, atomic IPv4, UDP, ICMP Echo, finite TCP,
shared pending output and timers. Guards, ordered actions, bytes, checksums,
sequence arithmetic and sources are explicit IR, not Python protocol callbacks.

| File/group | Role |
|---|---|
| `ipv4-endpoint-virtual-link.json` | Final finite virtual-link subject |
| `tcp-ipv4-*`, `ipv4-udp-icmp-*`, `arp-udp-*` | Earlier composition and link-profile experiments |
| `tcp-wire-*`, `udp-wire-*`, `arp-endpoint`, `icmp-echo` | Independently scoped component models |
| `tcp-data` through `tcp-sent-ledger` | Historical data/recovery modeling research |
| `bytes-*`, `seq32-*`, `word32-*` | IR primitive qualification contracts |
| `*-exploration.json` | Explicit finite test-generation domains, not protocol authority |

The earlier models remain reproducible experiments. They are not fragments that
an adapter silently dispatches as the final protocol implementation. Their paths
and hashes are retained for existing evidence and regression tests.

The final model SHA256 is
`7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5`.
See [the full scope](../docs/ipv4-endpoint-virtual-link.md) and
[framework separation](../docs/repository-boundaries.md).

Next: [formal checks](../formal/README.md).
