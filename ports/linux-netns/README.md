# Linux kernel active-open channel

This channel targets a dedicated ephemeral Linux VM (GitHub Actions ubuntu-24.04).
Root launches a new `unshare --net` namespace; the child verifies its namespace is
different before any link/sysctl/tool operation. It changes no host routes or
production/SSH network. Missing tools/TUN/capabilities block this channel only.

The existing authoritative `model/tcp.json` and handshake / syn-loss scenarios generate the
unchanged packetdrill packet expectations. The execution wrapper adds a public
endpoint bind and TUN offload setup, and starts the first socket call relative
to setup completion. Protocol time is normalized to the first SYN; execution
and Difference tolerances are unchanged. The pinned unmodified official packetdrill
coordinates syscalls and packet injection; independent tcpdump captures every
selected packet through the source scenario's declared settle interval (handshake5010ms; SYN-loss6010ms), without a
packet-count cap. A public SO_ERROR check and file barrier keep the socket alive
until capture has stopped, excluding only later tool-exit cleanup. Capture lifetime,
quiet-boundary timestamps and zero kernel packet drops are checked. Capture uses classic LINUX_SLL PCAP,
strict checksums, no deduplication and the existing active-open-v1 projection.

Packetdrill execution tolerance remains50000us; the independent Difference uses
0ms and retains timing mismatches. The model projection excludes options, window
and payload; no broader TCP claim follows from packetdrill success. Kernel/tool
versions, source/compiler/binary/script/model hashes, namespace identity,
configuration, logs and raw capture are preserved. No synthetic PCAP or lwIP
output is accepted here as Linux evidence.

Runtime verification requires the original Linux kernel/namespace parent and
tool binary. A separately named offline snapshot check does not rerun Linux or
recheck a missing binary and requires the original bound runtime verification;
trusted CI artifact provenance must be checked separately. Integrity is not
authenticity. The old lwIP/suite hash gates are unchanged.

Local `tests.py` checks preparation and rejection only, not Linux execution.
The CI prototype is not accepted until a real run and independent evidence gate
have completed; failures and incomplete captures are retained.

Use `--scenario handshake` (default) or `--scenario syn-loss`; only these named
source scenarios are accepted. Each CI matrix job uses its own VM/artifact. In
the SYN-loss scenario both outgoing SYNs remain in the egress capture/oracle:
the first is unanswered, and the injected peer responds only after the expected
retransmission. This is response withholding by an injected peer, not a physical
network loss experiment. The reference has one retransmission at1000ms and
peer response at1010ms. Actual kernel times are captured independently and
compared with the unchanged0ms oracle; the lwIP2750ms observation is separate.
No source model, timer setting, packetdrill tolerance or upstream code is changed
to force a match. The selected scenario identity, input file and settle boundary
are bound into the report and independently reconstructed.

The1551c535 accepted handshake snapshot is immutable and must be rechecked with
its named source checkpoint. New scenario support changes strict source bindings;
it does not retroactively relabel or weaken old evidence.
