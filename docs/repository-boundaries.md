# Repository ownership after finite-prototype extraction

User decision: TCPIP-Model owns protocol subjects and evidence;
Formal-Spec-Agent owns the reusable modeling/agent framework.
The finite IPv4 prototype has passed its previously fixed finite delivery
contract. That acceptance does not upgrade incomplete exploration or old UNKNOWN.

## Authoritative maintenance locations

- **Formal-Spec-Agent**: active generic Protocol IR semantics/reference interpreter,
  independent Z3 backends, test generation, standalone C lowering/runtime,
  ten-stage evidence flow, provider adapters and generic proposal-role execution.
- **TCPIP-Model**: TCP/IP models and specification bindings, independent oracles,
  generated implementation reproduction inputs, simulation/test scenarios,
  Linux/lwIP/PCAP observation adapters, Difference and original experiments.

`framework` is a pinned one-way Git submodule; `framework.lock.json` binds its
commit and executable-source file set. New execution uses
`tools/run_framework_candidate.py` in a separate process. See
[the working client commands](framework-client.md).

The old `protocol_lab` is a **frozen historical compatibility snapshot**, not a
second development branch for generic semantics. Its selected source hashes are
in `frozen-legacy-framework.json` and checked by regression tests. It remains
available so historical evidence can use its named original checker; old hash
checks are not relaxed. Generic changes occur only in Formal-Spec-Agent, then
explicit dependency-pin updates and new benchmark execution consume them.
A same-named internal package is never mixed with the old snapshot in one process.

Initial extraction is traceable to Git e91436f0 (owner-merged PR27), with per-file
hashes and explicit transformations in the framework's provenance manifest.
TCP/IP model/oracle/PCAP trees, private ledgers, credentials, venvs and compiled
binaries were not migrated. No automatic main merge or scheduler restart occurs.

## Scope is not expanded by moving repositories

The reusable core is executable, with a non-TCP mailbox example and external
TCP/UDP task checks. Optional independent JSON proposal roles are an initial
provider layer, not a complete autonomous arbitrary-spec agent implementation.
MCP, Skill and an external multi-agent harness may call the same interface;
none is mandatory. A model response cannot approve its own semantics or oracle.

The finite prototype remains fixed-peer/MTU1500/TCP16-byte-buffer/SMSS4.
General routing/fragmentation/TCP recovery/socket/IPv6/upper layers are excluded.
Old UNKNOWN and Linux/lwIP implementation Differences stay visible. Future
framework work does not retrospectively certify an old protocol or compiler.
