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

## Finite incoming-data case

`--scenario receive-four-zero-octets` uses the current composed `tcp-sws` IR.
It injects one in-order four-zero-octet segment and observes all kernel traffic
through the declared5020ms interval without application reads. The complete
`tcp-connection-v1` oracle includes flags, SEQ/ACK, windows, payload and time.
Model MSS4/window16 are not forced onto Linux. Window/time/ACK differences stay
visible; model receive-buffer contents are not claimed as observed kernel state.

The stimulus script expects only the first outgoing SYN (for ISN anchoring) and
injects the two declared peer inputs. All outgoing ACKs are observation-only in
packetdrill and remain in independent tcpdump and the full strict oracle. The
saved driver-policy.json makes that distinction explicit. The model's40ms
delayed ACK at60ms does not force kernel ACK timing. Missing/extra output ACKs
are Differences if input and full-window capture gates pass, not automatic capture
failures. Quiet timing is anchored at the final injected stimulus20ms, not a
possibly later model-generated ACK.

Pinned packetdrill grammar specifies TCP payload length but not arbitrary TCP
byte strings. Only its four-zero-octet input is admitted here; nonzero or changed
stimuli are rejected. No PSH, outbound data, read/socket-buffer-content, general
segmentation or recovery claim follows. Independent PCAP still checks every byte.
The command now explicitly binds the existing12.5% dynamic tool tolerance as well
as its50000us minimum. The independent oracle remains0ms.
