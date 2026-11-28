# Control-Plane Protocols: DHCPv4 Client & DNS A-Record Stub Resolver

## Scope
Covers UDP control-plane state machines in `model/stack/dhcpv4_client.json` (`CTRL.DHCP`) and `model/stack/dns_resolver.json` (`CTRL.DNS`) plus their composition routes into `eth_ipv4_icmp` in `model/tcpip-stack-system.json`.

## Requirements
- `CTRL.DHCP`: RFC 2131 DORA exchange (`INIT`, `SELECTING`, `REQUESTING`, `BOUND`, `RENEWING`) over UDP ports 68/67 (`0x63825363` magic cookie, TLV options parsing), bounded retries (`0..4`, `1000` ms), and automatic propagation of leased `(ip, netmask, gateway, dns_ip)` to `eth_ipv4_icmp` (`cfg.set_ip`) and host notification (`DHCP_BOUND`).
- `CTRL.DNS`: RFC 1035 IPv4 `A` stub resolver (`IDLE`, `QUERYING`, `CACHED`), bounded DNS wire name skipping (up to 6 labels + compressed pointer answers `>= 0xC0`), transaction ID matching, retry backoff (`0..3`), `60000` ms TTL timer, and `DNS_RESOLVED` / `DNS_FAILED` host outputs.
