# Linux kernel validation channel

The producer in `ports/linux-netns/` runs actual kernel TCP in an isolated network namespace on an ephemeral Ubuntu CI VM. The local macOS environment cannot run this channel. The peer is injected by pinned official packetdrill; tcpdump independently captures the selected four-tuple. This is kernel execution evidence, with an explicit VM/toolchain trust boundary. It does not test a physical NIC or an independent remote peer.

## Accepted checkpoint

Source1551c535ef7fd1f8323fcf2a3b3a66a5a57f4a9e, [CI41004399031](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41004399031), Linux7.0.0-1017-azure. The evidence directory `artifacts/linux-netns-ci-1551c535/` retains the original GitHub ZIP, provenance, full job log, raw capture, runtime verification and separate offline recheck. `acceptance.json` states the exact scope; `archive-hashes.json` binds every archived member. Integrity checks do not establish authenticity independently of CI provenance.

The current `model/tcp.json` / `scenarios/handshake.json` active-open scenario generated the packetdrill expectations. A public SO_ERROR check and capture-stop barrier keep the socket open through the declared5010ms quiet interval. tcpdump has no packet-count cap; capture stops before socket cleanup. The observed interval is5010.89946ms, with three selected packets and zero kernel capture drops. No extra selected packet was seen in that finite interval. This does not observe internal RTO state or establish unbounded silence.

The unchanged active-open-v1 projection checks direction, flags, relative SEQ/ACK and time, with strict checksums and0ms Difference tolerance. SYN+ACK10.093ms and final ACK10.131ms differ from model10ms. The packetdrill execution scheduling tolerance remains50000us; it does not loosen the independent comparison. Windows, TCP options, payload, data transfer and recovery are outside this projection. CI passes when execution and evidence validation succeed, including a valid retained implementation Difference.

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
