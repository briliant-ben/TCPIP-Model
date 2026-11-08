# Finite TCP/IPv4 Endpoint Model

This document describes the composed finite IR model `model/tcp-ipv4-endpoint.json`,
which couples the pre-existing IPv4/UDP/ICMP endpoint and TCP wire endpoint into a
single monolithic state machine. The model is **not** a general TCP implementation;
it is a finite profile with explicit parameters and support limits. The offline
builder produces the authoritative IR. Both the reference interpreter and an
independently running generated C program execute that IR; live composed-peer
acceptance remains outstanding.

## Scope and Assembly

- **IR version**: 0.6
- **Semantics**: `flat-efsm-atomic-ordered-v1` (strict sequential atomic ordered actions).
- **States**: Single global state `COMPOSED`. Internal component states are lowered
  into explicit string control variables `L.control` (link) and `T.control` (TCP).
- **Component origins**:
  - `model/ipv4-udp-icmp-endpoint.json` (lowered, namespaced as `L.*`)
  - `model/tcp-wire-endpoint.json` (lowered, namespaced as `T.*`)
- **Merge**: Disjoint union yields 57 variables and 235 transitions. Coupling
  produces **58 variables**, **335 transitions**, and one `COMPOSED` state.
- **Coupling**: An approved offline compilation transform (`protocol_lab/compose/tcp_link.py`)
  rewrites the link layer to carry TCP payloads over Ethernet with ARP, adds a shared
  pending owner slot, and injects explicit drop rules for malformed TCP IP lengths.
  All resulting guards and actions are explicit in the flattened authoritative IR.

## Fixed Profile Parameters

Addresses, ports and MTU are fixed by this profile. Configuration events remain
explicit in the IR: `L.app.cache_ttl(milliseconds)` changes the cache lifetime
within its declared 60000..3600000ms domain; `L.app.configure_checksum(enabled)`
controls UDP transmit checksums, and `L.app.require_checksum(required)` controls
acceptance of absent UDP receive checksums. Key profile values include:

- Local MAC: `02:00:00:00:00:01`
- TCP ingress peer MAC: `02:00:00:00:00:02`; ARP retains its inherited
  single-peer-IP/02-prefix sender-MAC admission and learns the transmit MAC.
- Local IPv4: `192.0.2.1`
- Peer IPv4: `192.0.2.2`
- TCP peer port: `8080`, local TCP port: `40000`
- Fixed MTU: 1500 bytes; admitted TCP Ethernet input is exactly
  `max(60, 14 + ip_total_length)` bytes. ARP retains its separate 42..60-byte
  input profile; Ethernet output has at least 46 payload bytes. Unpadded
  54/58-byte virtual TAP TCP frames are currently outside this profile.
- ARP query retry interval: 1000 ms
- TCP timers and windows are inherited from the `tcp-wire-endpoint` profile, which
  itself is a finite modern-TCP subset (see inherited limitations below).

## Shared Pending IP Payload and Owner

The IPv4 link already maintained a single `L.pending_packet` byte sequence for
outgoing UDP packets. To accommodate TCP, a new string variable
`ip_pending_owner` records which protocol (`UDP` or `TCP`) currently owns the
pending slot. The invariant `IP-PENDING-OWNER` enforces that the owner is `none`
if and only if the pending packet is empty, and that the owner is always one of
the declared values.

Transitions that set `L.pending_packet` are updated to also set the owner; when
the slot is cleared, the owner becomes `none`. The link's query-failure handling
is split into `L.QUERY-FAIL-QUEUED-UDP` and `L.QUERY-FAIL-QUEUED-TCP` so that
only UDP receives a send-failure notification.

When any transition sets `T.control` to the literal string `"CLOSED"`, an explicit
cleanup action is prepended that clears the pending packet and owner **only if**
the owner is `TCP`. This detection relies on literal assignment; expression-based
assignments to `T.control` are **unsupported** and rejected by the builder.
This clears a previous TCP pending packet; a new reset emitted by that same
transition can subsequently occupy the slot under the ordinary latest policy.

## Ethernet Ingress and TCP Frame Envelope

TCP segments arriving on `L.net.frame` must satisfy a complete binary envelope
checked by `_tcp_frame_envelope_guard()` in the coupling transform. The guard verifies
Ethernet destination/source MACs, EtherType `0x0800`, IPv4 header fields (version,
IHL, total length, protocol 6, source/destination IPs), TCP ports, and exact
frame length consistency (including minimum padding). Inputs outside the declared
protocol envelopes are atomic model gaps (`Uncovered`), with no committed state
change. Admitted malformed shapes may instead match explicit drop rules.

Additionally, an explicit drop transition `T.WIRE-DROP-IP-LENGTH-MALFORMED` is
added for frames where the IPv4 total length is `<= 1500` and either `<= 39` or
`>= frame_len - 13`, with the rule's fixed Ethernet/IP/port identity checks.
This drop sets only `T.wire_disposition = drop_ip_length`; queue, owner, control
state, timers and emitted messages remain unchanged.

## ARP Resolution for TCP Transmit

All `T.ipv4.tx` emissions are transformed into three cases based on `L.control`:

- `EMPTY`: no pending packet, no ARP resolution. The transition buffers the TCP
  packet into `L.pending_packet`, sets owner to `TCP`, resets `L.retry_count`,
  emits an ARP request, arms the `L.query` timer, and switches `L.control` to
  `PENDING`.
- `PENDING`: ARP query already in progress. The transition simply overwrites the
  pending packet (latest wins) and owner remains `TCP`.
- `RESOLVED`: the peer MAC is known. The transition builds a full Ethernet frame
  by prefixing destination MAC, local MAC, EtherType, the original IP packet, and
  appropriate padding, then emits it on `L.ethernet.tx`.

## Modeling Choices and Requirements

- `CROSS-IP-LINK`: The coupling introduces a **latest shared pending slot** with a
  single owner. This is one latest pending IP datagram, rather than a general
  neighbor packet queue. The TCP component separately retains its finite byte
  send/retransmission buffers. This policy is a modeling choice. Source: this document.
- `TCP-IP-FRAME-DROP`: An **explicit drop rule** for malformed TCP IP total
  lengths is added as a finite policy, not derived from any RFC. Source:
  this document.

## Inherited Limitations and Known Differences

The underlying `tcp-wire-endpoint` component inherits limitations from the
modern TCP data/window/reassembly subset:

- TCP retains 16-byte send/receive buffers, SMSS4 and initial send window8.
  General piggyback ACK/window advancement on data and out-of-order reassembly
  are outside the inherited profile.
- Fixed timers based on a simplified retransmission model (not full RFC 6298).
- **UNKNOWN** entries in the original TCP model remain unresolved.
- **lwIP 2750ms** observation: In the TCP wire profile, the initial RTO is
  1000 ms, while lwIP is observed to use a 2750 ms SYN-loss retransmission
  difference. This is not a confirmed lwIP default or a Linux difference; it is
  an observed discrepancy in the finite profiles.
- **LinuxTCP Differences**: The model does not replicate Linux-specific TCP
  behaviors such as delayed ACKs, quick ACK mode, or congestion control details.
  Piggyback ACK/window advancement on data and out-of-order reassembly are not
  implemented.

## Verification Status

- **No live composed execution evidence** exists. Actual reference/generated-C
  and fixed-input independent Z3 checks passed 45 legacy literal projections
  (150 transitions), four core coupling paths and four positive malformed-length
  paths. Fourteen hostile-domain model gaps have reference/C checks, not negative
  formal admission proofs. The separate 46 generic backend methods also pass.
- The 45 legacy literal regressions and 18 policy variants passed in the
  approved gate, but **all-input safety is not claimed**.
- No general compiler or unbounded TCP correctness proof is provided; all
  conclusions are limited to the exact pinned profile.

The application test interface queues bytes with `T.app.send(data)`, triggers
the explicit transmit event with `T.app.transmit({})`, and reads buffered data
with `T.app.receive(count)`. `T.application_data` is a declared output message.
These are test/service operations, not an upper-layer application implementation.

## Reproduce the finite native experiment

With the formal Python dependencies and a C99 compiler installed:

```sh
.venv/bin/python tools/build_tcp_ipv4_endpoint.py --out /tmp/tcp-ipv4-rebuilt.json
cmp model/tcp-ipv4-endpoint.json /tmp/tcp-ipv4-rebuilt.json
.venv/bin/python examples/run_native_suite.py model/tcp-ipv4-endpoint.json \
  --scenario-dir scenarios/tcp-ipv4-endpoint --formal-replay \
  --out /tmp/tcp-ipv4-native-fresh
```

The output directory must be fresh. This compiles and actually runs generated C
for four frozen scenarios, including ARP resolution followed by bidirectional
TCP data and close. It retains the executable, compiler report, native stdout,
Difference, fixed-input SMT/results and hashes. It performs no live networking.
The source oracle is `spec/tcp-ipv4-endpoint-oracle.json` (SHA256
`8f66ce0af1f88072d2de8990dd55b584edad299abc9b5baf55bcf00e6bedb919`).

The new CI workflow repeats these finite checks on the actual Git head. A
ten-stage formal flow task is not added with an invented passing theorem: the
full composed all-input safety/overlap obligations remain unproved.

## Sources and References

- `docs/arp-endpoint.md`, `docs/arp-udp-transmit.md`, `docs/component-state-lowering.md`
- `docs/ipv4-udp-icmp-endpoint.md`, `docs/tcp-data.md`, `docs/tcp-wire-endpoint.md`
- `docs/udp-wire-transmit.md`
- RFC 768, RFC 791, RFC 792, RFC 826, RFC 894, RFC 1122, RFC 6298, RFC 6864, RFC 9293 (relevant sections)

All novel profile choices in this document are explicitly **modeling choices**;
they are not normative protocol requirements.
