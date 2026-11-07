# One generated IR subject: ARP, IPv4 and outbound UDP

Run only on a disposable Linux host with root, TAP, iproute2, tcpdump,
C99 and the formal requirements installed:

```
sudo .venv/bin/python ports/linux-arp-udp-peer/run.py --out artifacts/linux-arp-udp-peer
sudo .venv/bin/python ports/linux-arp-udp-peer/verify.py --out artifacts/linux-arp-udp-peer
```

The subject is one C process generated from `model/arp-udp-transmit.json`.
A cold `app.send` produces an ARP request. The independent Linux kernel replies;
the original frame enters `net.frame`, and the IR learns the MAC, flushes its
single pending IPv4/UDP packet and emits Ethernet. A Linux UDP socket receives
that four-byte `cold` data, then cached empty, odd/NUL and 1472-byte data.
There are four UDP deliveries and six selected Ethernet frames total. The adapter forwards
raw Ethernet bytes and mechanically samples the public timer snapshots. It
never chooses a subject MAC, builds ARP/UDP, calls `app.resolve`, manages the
pending queue, restarts C, or replays a prefix. The socket only receives: IPv4
receive is outside the current subject model.

The test link is one nonpersistent TAP in a fresh, proven-distinct network
namespace: subject 192.0.2.1/MAC020000000001:40000, peer
192.0.2.2/MAC020000000002:8080, MTU1500. No host network changes, peer ARP
policy tuning, neighbor preloading, byte rewriting, or protocol callbacks.

Independent immediate tcpdump records ARP and UDP without a packet cap.
Acceptance requires six original packets (ARP request/reply and four UDP),
zero capture drops, complete 100ms quiet observation, exact C/TAP/PCAP bytes,
independent field/checksum decoding, exact Linux socket deliveries, one live
PID, one initialization, full native/reference trace equality, and a separate
fixed-input Z3 SAT witness for the actual trace after live exchange has ended.
The source, generated C, compiler report, executable, tools, original raw files,
monotonic/operation transcript and evidence hashes remain bound. Capture must
stop before the C process, peer socket or TAP closes.

`verify.py --offline` reconstructs retained bindings using the original checker
without running archived code, executable or solver. The original runtime
verification and trusted CI provenance are still required. Matching hashes do
not establish provenance or a new Linux run.

The five unit methods use real generated C and synthetic mixed captures, not
Linux peer evidence. Their corruptions cover payloads, capture drops, shortened
quiet windows, ingress, PID continuity and packet bytes. The workflow also runs
the independent supplementary ICMP invariant task; that different theorem does
not promote any existing bounded-check UNKNOWN.

This is finite virtual Ethernet transmit interoperability, not physical
Ethernet, live fault/retry/cache-expiry validation, inbound IP/UDP/ICMP, a complete
IPv4 endpoint, universal protocol correctness or a compiler proof. Exact wire
latency is not claimed; PCAP timestamps and IR logical time remain distinct.
