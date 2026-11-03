# Live IR-generated ICMP with an independent Linux/iputils peer

The subject is the unchanged finite model/icmp-echo.json lowered to standalone C.
No host protocol stack, handwritten subject encoder or Python protocol callback.
A generic stdin PIPE/raw stdout PTY holds one generated C PID across all three
requests. Native output bytes go directly into a nonpersistent raw-IP TUN;
original peer request bytes go directly to the C ABI. No prefix replay/reset or
header rewrite. Oracle construction and reference replay occur only after the
live exchange and resource shutdown.

A distinct network namespace is verified before all ip/link operations. Test link
peer192.0.2.2/subject.1, MTU1500. iputils ping requests empty, odd five-byte
0080ff0700 and1472-byte data probes. Normal documented `-4 -M do` selects atomic
IPv4 probes within MTU; this is an explicit stimulus choice, not a claim about
all default Linux PMTU policies. No sysctl policy tuning, forced TTL/ID or PMTU
bypass. The peer retains its own identifier/sequence/timestamp/data generation;
MTU probe's timestamp bytes are observed, never synthesized as expected input.
[Upstream ping options](https://github.com/iputils/iputils/blob/master/doc/ping.xml)
explain `-M do` and the independent peer's payload timestamp.

Each ping process has interval3600s and stays alive with its socket open until
capture stops. The driver selects one request per case and enforces three-second
receive deadlines, full100ms quiet, all peers/native alive, then stops tcpdump,
then signals peers and closes native/TUN. Independent immediate-mode tcpdump
selects all ICMP on the link, has no packet cap, requires6 full packets/zero drops
and exact C/TUN/PCAP byte equality. Extra selected packets fail; unselected
IPv6/non-ICMP records are separately retained. No ICMP wire-latency contract;
actual PCAP timestamps and monotonic-derived logical milliseconds stay separate.

Independent oracle.py is a post-observation acceptance oracle, not used to encode
subject/network packets. It checks the complete reply bytes against RFC792 and
this finite profile: type0/code0, unchanged identifier/seq/data, reversed IPs,
ID0/TTL64/DF1, independently recomputed IP/ICMP checksums. Frozen existing literal
fixtures validate this oracle before real execution, including checksum0000.
Ping itself must also report exactly1 transmitted/received/zero loss per case.

```
sudo .venv/bin/python ports/linux-icmp-peer/run.py --out artifacts/linux-icmp-peer
sudo .venv/bin/python ports/linux-icmp-peer/verify.py --out artifacts/linux-icmp-peer
```

Requires disposable Linux root/TUN/iproute2/ethtool/tcpdump/iputils-ping/C99 and
requirements-formal.txt. Workflow retains failures, original C/ELF, tool/version,
namespace/link configuration, PID/ABI transcript/clock samples, ping output and
original raw PCAP. Offline verification uses original Git tools and trusted CI
provenance without running archived code/ELF/solver; hashes alone are not
execution authenticity. Mac fixture/PTY tests are never network evidence.

This channel adds no IR semantics or formal claims. Existing13 fixed-input Z3
results and bounded depth2 results are separate; direct Linux60s UNKNOWN remains
UNKNOWN even where another immutable-release query returned UNSAT. No complete
ICMP/errors/client, fragmentation/options, physical capture, cross-layer composed
IR, complete IPv4 endpoint or compiler/unbounded proof claim.
