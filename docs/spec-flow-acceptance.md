# Flow acceptance audit — 2026-11-01

The requested deliverable is a provider/framework-neutral repeatable spec-modeling
flow, demonstrated by a minimal TCP/IPv4 slice and a second small specification.
This audit accepts that scoped flow prototype. It does not accept complete TCP/IP,
arbitrary specification support, a proved compiler or universal protocol proofs.
No deployment to an unspecified user server is claimed.

Authoritative server checkpoint: Git d72b7f3d4f0832a876ca87967916b47fbb6cb51c;
Ubuntu run [41222440458](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41222440458),
job124599629037. All declared task stages and the20+9+8 specialized test methods
passed without skips. Original official ZIP/provenance/logs and independently
rechecked Git bindings are retained in `artifacts/spec-flow-migration-ci-d72b7f3d`.
The original validator can be replayed without executing archived code/programs.

| Requirement | Inspected evidence and result |
|---|---|
| Specification/version/scope/assumptions | `flows/tcp-active-open-ipv4.json`, `flows/udp-header.json`; pinned full RFC9293/6298/791 and RFC768/1122 sources, profile assumptions, excluded behaviors and independently pinned seeds. Sources stages pass. Interpretation remains a trusted explicit record. |
| Protocol IR sole modeled authority | TCP `model/tcp.json`, UDP `model/udp-header.json` declare state, variables, events, messages, timers where applicable, guards/actions, invariants and requirement origins. UDP adds no executor callbacks: the29 generic tool files match exactly between all three accepted tasks. The TCP wire codec only represents the declared selected input/output shape; unsupported shapes reject explicitly. |
| Reference execution and independent Z3 | Three formal stages retain SMT queries, depth6 safety/overlap UNSAT, nonvacuous sample execution/replay and explicit bounded scope. Python reference checks exact transitions/state/timers and independent scenario0.2 expectations. This is neither unbounded proof nor English-to-IR proof. |
| Test generation | Bounded declared domains cover TCP's3 and UDP's7 rules, with generated witnesses and explicit model-gap negatives. Independent source-derived seed contracts supplement generated tests. Counts remain scoped to declared domains; all-rule coverage is not full RFC coverage. |
| Independent generated implementation | Actual IR-to-C99 sources, reconstructed-source build gate, GCC13.3 compiler logs/hashes, Linux ELF hashes and native stdin/stdout. No runtime JSON IR interpreter, Python protocol execution or delegation to Linux/lwIP inside generated programs. Both native executables also run with an empty PATH in actual tests. |
| Native TCP/IPv4 observations and Difference | Five complete wire cases,15 native egress packets. C parses ingress bytes/checksums and emits output bytes; recorder wraps original bytes in PCAP. Independent decoder verifies checksums; comparison checks exact absolute sequence/ACK/time/window plus normalized fields. Faulty native sequence/checksum variants fail. One fixed tuple, no options/payload/fragments, virtual time/link only. |
| Second small-spec migration | RFC768 plus RFC1122 section4.1.3.4 UDP descriptor model runs the unchanged ten stages:12 cases,7 rules,14 independent output-contract steps. Wrong default checksum, header length and non-silent discard candidates fail independent contracts, even where reference/native agree or model BMC still passes. Payload/checksum arithmetic/UDP PCAP are explicitly excluded. |
| Failure classes and iteration | Stage envelopes preserve conflicts, invariant failures, model gaps, unsupported semantics, backend-domain limits, environment/resources/dependencies, differences, UNKNOWN and changed inputs. Tests exercise these classes, missing compiler isolation, deadline cleanup and UNKNOWN-promotion refusal. `docs/spec-flow-server.md` maps each result to a next candidate action. |
| Reproducibility/version-bound evidence | Original inputs/output manifests, captured trusted tools and candidate data, source/binary/compiler/interpreter hashes, original logs/PCAP/differences and unique run IDs. Current task digests are caller-bound.53 original CI input/client files match named immutable Git blobs; read-only original-epoch verification passes all three jobs. No old hashes relaxed. |
| Single or concurrent external callers | `examples/run_spec_candidate.py` accepts workspace/task/digest/output, calls trusted CLI from a separate tool checkout, retains raw results and verifies success. Tests actually run TCP-wire and UDP concurrently in separate candidate workspaces from an unrelated CWD, with distinct run IDs. A wrong approved digest rejects before a job starts. No model SDK/API/MCP/Skill/framework dependency. |
| Server reproduction and handoff | The same client and tasks actually run on Ubuntu; setup, invocation, schemas, exit codes, approval boundaries, failure iteration, isolation, source-epoch audit and harness responsibilities are documented in `docs/spec-flow-server.md`. A provider/harness can invoke this file/CLI contract directly. |
| Preserve existing evidence and user work | No existing Protocol IR/runtime/symbolic or upstream lwIP source changed for UDP migration. Original UNKNOWNs, old named evidence/oracles and2750ms lwIP Difference remain separate. The two preexisting untracked sent-ledger artifact directories are preserved. |

## Limits of this acceptance

The supported native domain is the explicitly admitted scalar IR0.1/0.2 fragment;
bytes, rational and other unsupported semantics reject. The TCP demonstration is
active open/retransmission/wrap plus a fixed-header IPv4 representation adapter,
not data transfer or general IPv4 host/router behavior. UDP demonstrates service
metadata using an explicit assumed checksum-validation fact. Full protocols,
UDP wire, arbitrary payloads and broader code-generation backends are extensions.

The flow requires a caller to supply a spec interpretation and IR candidate.
Task/seed/source pins prevent unapproved acceptance changes only when the external
caller controls its approved digest. A digest computed from the candidate is a
version binding, not external approval. Isolation is reproducibility/process
ownership, not an arbitrary-code security sandbox. Retained integrity checks do
not constitute fresh execution or authenticity attestation.

These limits were explicit in the accepted tasks and do not replace the requested
flow with a production network stack or claim validation of modeled exclusions.
The flow's execution/reproduction/migration gates are satisfied by the evidence
above; subsequent protocol expansion is separate work.
