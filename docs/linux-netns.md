# Linux kernel validation channel

The producer in `ports/linux-netns/` runs actual kernel TCP in an isolated network namespace on an ephemeral Ubuntu CI VM. The local macOS environment cannot run this channel. The peer is injected by pinned official packetdrill; tcpdump independently captures the selected four-tuple. This is kernel execution evidence, with an explicit VM/toolchain trust boundary. It does not test a physical NIC or an independent remote peer.

## Accepted checkpoint

Source1551c535ef7fd1f8323fcf2a3b3a66a5a57f4a9e, [CI41004399031](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41004399031), Linux7.0.0-1017-azure. The evidence directory `artifacts/linux-netns-ci-1551c535/` retains the original GitHub ZIP, provenance, full job log, raw capture, runtime verification and separate offline recheck. `acceptance.json` states the exact scope; `archive-hashes.json` binds every archived member. Integrity checks do not establish authenticity independently of CI provenance.

The current `model/tcp.json` / `scenarios/handshake.json` active-open scenario generated the packetdrill expectations. A public SO_ERROR check and capture-stop barrier keep the socket open through the declared5010ms quiet interval. tcpdump has no packet-count cap; capture stops before socket cleanup. The observed interval is5010.89946ms, with three selected packets and zero kernel capture drops. No extra selected packet was seen in that finite interval. This does not observe internal RTO state or establish unbounded silence.

The unchanged active-open-v1 projection checks direction, flags, relative SEQ/ACK and time, with strict checksums and0ms Difference tolerance. SYN+ACK10.093ms and final ACK10.131ms differ from model10ms. The packetdrill execution scheduling minimum is50000us. Its pinned upstream default also permits12.5% of the event interval, taking the larger allowance; for a1s retransmission interval this is125ms. This does not loosen the independent0ms comparison. The official source/default investigation is retained in artifacts/linux-netns-ci-de084a26/upstream-timing/. Windows, TCP options, payload, data transfer and recovery are outside this projection. CI passes when execution and evidence validation succeed, including a valid retained implementation Difference.

## Reproduce and verify

Read `ports/linux-netns/README.md` and the workflow for Linux prerequisites, privileges, commands and tool pin. Do not run the namespace producer against host networking. Runtime verification checks the actual tool binary/compiler/source pin and namespace as well as model/script/query/capture hashes. Offline mode deliberately reports that it has not rerun Linux or rechecked the CI binary.

At the named source checkpoint:

```sh
.venv/bin/python ports/linux-netns/verify.py --out artifacts/linux-netns-ci-1551c535/download --offline
.venv/bin/python artifacts/linux-netns-ci-1551c535/faults.py
.venv/bin/python artifacts/linux-netns-ci-1551c535/accept.py
```

Four temporary-copy controls reject altered reference timing, a corrupted TCP checksum, a shortened quiet interval and a reintroduced three-packet cap, even after corresponding report metadata is rehashed. Original evidence remains unchanged. Source changes intentionally make checkpoint verification stale; use the named commit rather than weakening hashes. Re-running controls may produce new logs and requires regenerating an archive manifest in a new evidence snapshot.

## Retained history and remaining scope

The first driver failure is retained under `artifacts/diagnostics/linux-netns-first-run/`: tool setup delayed an absolute-zero socket event and no packets were captured. The driver now starts the socket relative to completed setup without changing expectations or tolerances. The e62f799d snapshot under `artifacts/linux-netns-ci-e62f799d/` validates only the terminal three-packet prefix, not the5010ms quiet interval. Its original source bindings remain strict.

Next acceptance units must explicitly cover TCP data, window and recovery observations using their current IR and independent capture; this single handshake is not their evidence. Full protocol coverage, interpreter/translator correspondence and unbounded correctness remain open. The independent lwIP SYN-loss2750ms difference is preserved.

## Two-case checkpoint de084a26

[CI41005706790](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41005706790) independently executed handshake and SYN-loss matrix jobs on actual Linux7.0.0-1017-azure. Evidence and acceptance: `artifacts/linux-netns-ci-de084a26/`. Handshake covers5010.313562ms; SYN-loss covers6071.244654ms for the declared6010ms. Both have zero kernel capture drops and no packet-count cap. SYN-loss means both egress SYNs are captured while the injected peer withholds the first response; this is not physical network loss.

SYN retransmission at1061.092ms differs from model1000ms; peer reply1071.217ms and ACK1071.238ms differ from1010ms. The handshake case retains10.051/10.064ms versus10ms. All other selected projection fields match. The50ms minimum plus upstream12.5% dynamic execution allowance explains why a61ms discrepancy can pass packetdrill while the strict Difference remains. Internal RTO values and quantization/scheduling causes were not measured; this is not an RFC-bug finding. lwIP2750ms remains a separate unchanged observation.

At source de084a26, verify each `handshake/download` and `syn-loss/download` with the same `--offline` command, then run this checkpoint's `faults.py` and `accept.py`. Ten rehashed temporary-copy controls cover reference times, checksum, quiet length, packet cap and scenario identity. Local checks are not more kernel executions. Kernel data/window/recovery and the general formal correspondence remain open.

## Incoming-data preparation

The new named receive-four-zero-octets case uses the current composed tcp-sws IR without modifying it. Its full tcp-connection-v1 comparison includes flags, sequence/ACK, advertised windows, complete payload and time. Model MSS4/window16 are not imposed on Linux. A source-bound driver-policy explicitly distinguishes initial SYN/tool input handling from outgoing ACK observation; every ACK remains in the independent uncapped capture and complete oracle. Missing output ACKs are Differences after input/capture validity checks, not invalid evidence by themselves.

The pinned packetdrill grammar accepts TCP payload length, not arbitrary bytes; its builder zeroes the packet buffer. The finite adapter therefore supports one four-zero-octet incoming segment and rejects other bytes/stimuli. This does not establish application read semantics, kernel buffer contents, PSH, outgoing-data behavior or recovery. The5020ms observation is anchored at the first SYN and delayed from the final injected stimulus20ms, rather than from a later modeled ACK.

Twelve preparation/negative methods and a current composed-IR fixed-byte query/fresh CLI SAT pass. Those artifacts in artifacts/linux-receive-preparation are explicitly not Linux execution evidence; the new real CI and independent runtime gate must finish before such a claim. The tool command now explicitly passes its existing12.5% dynamic allowance, retaining the0ms independent oracle.

## Accepted incoming-data checkpoint2ab2a472

[CI41014477824](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41014477824) now completes actual kernel execution and independent runtime verification for the finite receive case plus both control regressions. The earlier preparation-only paragraph is historical. See artifacts/linux-receive-ci-2ab2a472/acceptance.json for the original ZIPs/provenance/PCAPs/logs and the separate offline checks.

The receive case captures five packets over5020.014606ms with zero kernel capture drops. Complete payload [0,0,0,0] and cumulative ACK9005 match. Three window and four time Differences remain at0ms tolerance: actual ACK20.059ms versus model60ms, actual advertised window64240→64236 versus model16→12. No kernel state/quick-ACK mechanism or exact MSS/RMSS relation was measured, and these policy/configuration observations are not RFC-bug findings. RFC9293 §3.8.6.3 does not require every ACK to occur at the model's selected40ms delay.

Independent current-source offline regeneration and query-equivalence UNSAT pass for all three retained runs. Five rehashed temporary-copy controls reject modified reference payloads, ACK policies, checksums, quiet boundaries and even a wrong payload with a valid recomputed TCP checksum. They do not constitute more kernel executions. Source changes intentionally make current-source snapshots stale; reproduce with the named checkpoint rather than relaxing bindings.

General receive/reordering/window/recovery, arbitrary payload byte strings, application reads, outbound data/PSH and later protocols remain open. The old Linux1061.092ms and lwIP2750ms SYN observations remain separate historical runs.
