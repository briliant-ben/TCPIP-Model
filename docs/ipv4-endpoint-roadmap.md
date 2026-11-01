# IPv4 endpoint implementation programme

User scope confirmed2026-11-01: IPv4 + TCP/UDP + ARP/ICMP, no upper-layer
applications and no IPv6/NDP in this implementation phase. The accepted spec-flow
prototype is the development/verification base; deployment is not completion of
this protocol implementation programme. Existing richer TCP IR/reference models
are reused, not replaced by calls to a host TCP stack.

| Milestone | Concrete acceptance |
|---|---|
| Server base | Immutable small source release, private venv/C compiler, three actual task runs/verify and37 specialized tests. No server route/interface/SSH changes. |
| Bounded agent loop | Separate IR proposer and independent scenario/spec reviewer, isolated candidates, fixed task/oracles, bounded provider requests and output, usage ledger and no automatic paid retries. Model output remains unaccepted until tools/controller approve it. |
| Native data semantics | Add generic byte buffers/content/slice/length and required IR0.3/timer semantics to direct native generation, matching independent Z3/reference semantics. Explicit backend bounds/resource failures. No protocol decisions hidden in codec callbacks. |
| Ethernet/ARP | Source-backed frame/interface IR, address resolution/cache ageing/queued transmission, positive and hostile/duplicate/loss cases, native byte output and independent capture. |
| IPv4 | Endpoint header/address/checksum/length/TTL rules, outbound construction/routing/MTU, required reassembly/resource timers and options scope. Native byte codec mirrors declared IR policy. Fixed-header admission descriptors are an initial slice, not full IPv4. |
| UDP | Actual payload preservation, length/checksum/pseudoheader/odd-length and zero-checksum handling, address/port demux and datagram service. Existing metadata-only model is a migration baseline, not this acceptance. |
| ICMP | Echo request/reply with identical content, necessary errors and their suppression/quoting rules, IP/TCP/UDP feedback, independent peer observations. |
| TCP | Generate and compose existing connection/data/reassembly/ACK/window/close/RTO/delayed-ACK/persist/congestion/recovery semantics. Preserve sequence wrap and all source/guard/action/timer contracts. Add missing supported behavior rather than declaring all existing complex IR compilable. |
| Integrated endpoint | Minimal connect/listen/accept/send/receive/shutdown/close service interface, actual arbitrary nonzero payload exchange against independent Linux/lwIP peers, losses/reorder/duplicates/window/close/recovery, clean resource handling and source-bound Difference evidence. Test peers are not an implementation substitute. |

Each module fixes RFC versions, interpretation, support matrix, bounds, assumptions
and acceptance tests before expanding coverage. Unsupported and unknown remain
explicit. Rule/state coverage, a model proposal, local unit tests or a single
capture cannot establish full module coverage. A full implementation claim needs
audited mandatory requirements and integrated independent execution in the agreed
scope. No unbounded protocol/compiler/English-to-IR proof is presumed.

The server keeps tools/releases, candidate workspaces, results and credentials
separate. Model API calls contain only task/source excerpts and relevant candidate
data. The first two roles use the same stable context prefix for provider caching,
then role-specific instructions; actual hit/miss usage is recorded rather than
assumed. Repeated identical completed calls reuse the local result without a paid
request. Responses that fail syntax/type/semantic checks are not integrated.
Independent reviewer output itself can be wrong: the controller checks literal
counts, source clauses and hostile variants before approving seed contracts.

Initial gateway settings are two concurrent roles, at most12 reserved requests
in the shared ledger, prompt<=96000 bytes and output<=8192 tokens per call.
Limits are per controlled gateway ledger, not an account-level billing cap.
No retry or budget reset is initiated by a model. Timeout/uncertain request usage
is retained as unknown; provider-reported usage is used when present. No infinite
agent daemon, unattended main-branch merge or authority to weaken accepted tools
or oracles is implied. The external controller schedules and reviews milestones.
