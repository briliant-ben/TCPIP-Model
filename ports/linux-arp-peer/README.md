# Generated C with an independent Linux ARP peer

Run on an isolated disposable Linux runner with root, TAP, iproute2, tcpdump,
C99 and requirements-formal.txt installed:

```
sudo .venv/bin/python ports/linux-arp-peer/run.py --out artifacts/linux-arp-peer
sudo .venv/bin/python ports/linux-arp-peer/verify.py --out artifacts/linux-arp-peer
```

The subject is generated directly from model/arp-endpoint.json. Each of two
fresh network namespaces has one continuously running C process: active
resolution followed by a cache hit, and a Linux-initiated request followed by
kernel neighbor-cache confirmation. Generic stdin PIPE / raw stdout PTY provides
line buffering without changing generated code. There is one initialization,
no restart or prefix replay. Public timer snapshots and monotonic samples drive
generic clock commands; all ARP decisions remain in IR.

The declared test link is a nonpersistent Ethernet TAP, peer 192.0.2.2 / MAC
020000000002 and subject 192.0.2.1 / MAC 020000000001, MTU1500. A distinct network
namespace is checked before link operations. No peer ARP tuning, preloaded
neighbors, header rewriting or host network changes. Passive UDP is only a
stimulus for kernel ARP; the queued IPv4 frame and other EtherTypes are retained
outside the selected ARP channel.

Independent immediate-mode tcpdump records ARP without a packet cap. Acceptance
requires two exact captured frames per case, zero drops, full quiet interval,
capture stopped before resources close, full native/reference trace agreement,
and raw C/TAP/PCAP byte bindings. Input/source/tool/generated C/ELF hashes, PID,
operation transcript, clock samples, peer neighbor observations and setup logs
are retained. Failures are never promoted. `verify.py --offline` rechecks retained
bindings without executing archived code/ELF/solver; it requires the original
runtime result and trusted CI provenance, not merely matching hashes.

This is a finite ARP profile, not a complete IPv4 endpoint, physical Ethernet
test, live 60-second expiry test, timing-equivalence proof or compiler proof.
Actual capture timestamps are distinct from IR logical milliseconds. Mac tests
exercise the live C ABI but cannot establish Linux peer evidence. The workflow
retains unsuccessful preflight and runtime evidence as well as successes.
