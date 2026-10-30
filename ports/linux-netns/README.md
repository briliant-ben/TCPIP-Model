# Linux kernel active-open channel

This channel targets a dedicated ephemeral Linux VM (GitHub Actions ubuntu-24.04).
Root launches a new `unshare --net` namespace; the child verifies its namespace is
different before any link/sysctl/tool operation. It changes no host routes or
production/SSH network. Missing tools/TUN/capabilities block this channel only.

The existing authoritative `model/tcp.json` and handshake scenario generate the
unchanged packetdrill packet expectations. The execution wrapper adds a public
endpoint bind and TUN offload setup, and starts the first socket call relative
to setup completion. Protocol time is normalized to the first SYN; execution
and Difference tolerances are unchanged. The pinned unmodified official packetdrill
coordinates syscalls and packet injection; independent tcpdump captures the first
three selected handshake packets, ending at the model's terminal ESTABLISHED
boundary before tool-exit socket cleanup. Capture uses classic LINUX_SLL PCAP,
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
