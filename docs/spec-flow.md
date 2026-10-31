# Provider-neutral specification modeling flow

The active deliverable is a repeatable modeling/verification flow, rather than
completion of the entire TCP/IP stack or closure of all outstanding proof queries.
The first end-to-end acceptance case is a small, explicitly scoped TCP/IPv4 slice;
a second small specification must demonstrate portability. Model/API/harness choice
is an integration decision. Neither an LLM subscription nor a particular MCP,
Skill, AGENTS.md or multi-agent framework is a runtime dependency.

Each stage accepts files and emits versioned JSON plus immutable artifacts. A
candidate proposed by an agent is not accepted until executable tools validate it.
Parallel agents use independent checkouts and fresh output directories; candidate
integration is serial and evidence must refer to the integrated source version.

| Stage | Input | Output / gate |
|---|---|---|
| specification | pinned spec, scope and assumptions | source clauses, interpretation and ambiguity records |
| model | source interpretation | typed declarative Protocol IR, source references |
| reference/formal | IR | reference executions, Z3 verdicts/counterexamples, unsupported/unknown preserved |
| tests | IR plus coverage objectives | reproducible positive/negative scenarios and fault variants |
| generate/build | IR, backend domain | independent native source, build log, executable/version hashes |
| observe | native executable and test inputs | actual execution trace and eventually wire/PCAP evidence |
| compare | reference and independent observations | differences linked to rules, input/model/tool/output hashes |
| iterate | classified differences | revised candidates, re-execution and evidence-bound acceptance |

Existing reference/Z3/test/wire tools are retained. The first new implementation
milestone is `protocol_lab.codegen`, a direct C99 scalar backend. It lowers the
actual source guards, ordered actions, timers, emitted message fields and
invariants into explicit compiled C. It does not embed a JSON model interpreter,
call Python, or delegate protocol behavior to Linux/lwIP. Its event-level line
interface and structured JSON observations are reusable without an LLM service.

```
python3 -m protocol_lab.codegen model/tcp.json --out /tmp/new-generation
python3 -m protocol_lab.codegen.execute build /tmp/new-generation --out /tmp/new-build
python3 -m protocol_lab.codegen.execute run /tmp/new-generation \
  --compiled /tmp/new-build --scenario scenarios/syn-loss.json --out /tmp/new-execution
```

All directories must be fresh. Stage stdout uses schema `spec-flow-stage-v1`.
Generation rejects unsupported semantics. Build verifies source hashes and
reconstructs generated C before compilation. Execution verifies source and binary
bindings, sends only input events to the native program, then separately runs the
reference oracle and compares exact transitions, outputs, snapshots and timers.
No expected reference values are supplied to the executable.

Native-v1 covers atomic-ordered-v1 IR0.1/0.2 with int/bool/seq32 state/inputs,
scalar operators, fixed string message literals, ordinary/conditional emissions
and timer actions. Arbitrary-precision IR integers are narrowed to an explicit
signed64 execution domain; computed overflow is rejected, never wrapped silently.
Buffers, rational values, clock-v3, post-action targets and dynamic strings are
explicitly unsupported. Trace/input/step capacities are bounded and failure is
explicit. Whole operations stage state, timers and observations atomically,
including any timers fired before a rejected external input.

The backend runs the four existing active-open cases, including loss/backoff and
32-bit wrap, against the same IR as the Python reference. The separate scalar
algebra contract exercises ordered assignments through the same backend. This is
not yet the required second protocol/spec portability demonstration, a proof of
the generator or a complete TCP implementation. The optional wire binding below
adds selected TCP/IPv4 header observations to this event interface.

The second small-spec migration case is now `flows/udp-header.json`; its finite
scope and acceptance are recorded below. Server reproduction uses the external
client described in `docs/spec-flow-server.md`. New Ubuntu acceptance remains a
separate gate until the corresponding CI run completes. Byte-capable native data generation and broader IPv4 behavior
are later extensions beyond the first fixed-header active-open slice. A pipeline must distinguish unsupported models, conflicts, invariant
failures, environment/resource limits, stale evidence and implementation
differences. UNKNOWN remains UNKNOWN. Existing pinned evidence and 2750ms lwIP
Difference remain intact. Completing this first backend does not complete the goal.

## One repeatable task

```
TASK_SHA=$(shasum -a 256 flows/tcp-active-open.json | cut -d ' ' -f 1)
python3 -m protocol_lab.pipeline run flows/tcp-active-open.json \
  --workspace . --out /tmp/new-flow-job --task-sha256 "$TASK_SHA"
python3 -m protocol_lab.pipeline verify /tmp/new-flow-job --workspace . \
  --task-sha256 "$TASK_SHA"
```

The task declares pinned source bytes/versions, requirement-to-source references,
a candidate IR, finite exploration inputs, seed cases, formal bounds and resource
limits. The caller/modeling agent supplies the interpreted candidate and its
bindings. This runner does not automatically translate English into IR and does
not claim that hash/URI binding proves the interpretation correct. Any provider or
agent harness can prepare these files and invoke the same CLI; no API keys or
provider-specific client is required.

The ten fixed stages are sources, IR, formal, tests, reference, generate, build,
execute, compare and traceability. There are no task-supplied Python/shell commands.
Bounded exploration generates one rule witness per initial configuration/rule and
explicit IR rejection cases; pinned seeds supplement these model-derived tests.
The current baseline produces six witnesses, five seeds and two model-gap
rejections (13 native cases). The additional seed independently fixes the exact
SYN/retransmission/ACK trace and final state using the existing scenario0.2 contract
checker; reference execution must satisfy it before comparison. Model-derived
tests alone cannot detect a shared model/implementation mistake. A
successful rejection test means the native implementation matches IR rejection,
not that the unmodeled invalid-ACK behavior satisfies the TCP specification.

Each stage runs in a separate POSIX process group with a deadline. Timed-out
workers and descendant compiler/native processes are cleaned up. Independent
source/formal/reference channels continue if a compiler is missing. Conflicts,
invariants, source integrity failures, unsupported semantics, backend integer or
resource limits, dependencies and implementation differences remain distinct.
Unique run IDs and exclusively created output directories permit concurrent
callers. Source/workspace file hashes and the closed tool-source file set are
checked before accepting a run; tool code should be deployed read-only and each
modeling agent should edit its own candidate workspace/check-out.

Task-v2 pins every exploration/seed input as well as specification sources. An
acceptance caller can supply an independently approved task SHA via
`--task-sha256`; changing bounds, scope or oracle data then changes the approved
task. Computing a SHA from a candidate is useful for version binding, but is not
external approval or authentication. The approval digest belongs to the caller,
separate from the agent proposing IR changes. Unpinned exploratory runs remain
possible and report that fact explicitly.

Before stages start, the runner freezes all bound workspace files and its trusted
tool sources into the job. Workers read only this captured version. Live edits
cannot mix candidates across stages; final checks still invalidate a job if its
original inputs changed. Retained verification checks the frozen copies as well
as the original source epoch. This is reproducibility/isolation, not a sandbox
for executing untrusted task-supplied code.

CLI stdout is JSONL: stage-start events followed by the final report. The report
separates execution_status from assessment. A completed process is not a successful
validation. Assessments include verified_event_slice, failed, unresolved, blocked
and invalidated_inputs. Z3 UNKNOWN remains unresolved and does not prevent other
independent stages from running. Exit0 denotes the accepted event-level slice;
exit1 denotes completed but failed/unresolved/blocked assessment; exit2 denotes
invalid request/evidence. Nonzero results retain diagnostic files.

The final manifest binds all task/model/spec/tool inputs and every artifact,
including generated tests, queries, C source, binary, exact stdin/stdout, reference
operations, per-case differences, source clauses and worker receipts. Verification
is read-only retained-integrity checking, not fresh execution or authenticity
attestation; it also rejects incomplete dependencies, UNKNOWN promotion and
broadened observation/proof scope. Rerun the task in a fresh directory for new
execution. Do not copy reference observations into a claimed native result.

The event-only task explicitly reports no PCAP or IPv4 evidence. Its scope stays
separate from the optional native wire task below. Neither task claims a universal
generator/English-to-IR proof or whole-goal completion.


## Native IPv4 virtual-link task

```
TASK_SHA=$(shasum -a 256 flows/tcp-active-open-ipv4.json | cut -d ' ' -f 1)
python3 -m protocol_lab.pipeline run flows/tcp-active-open-ipv4.json \
  --workspace . --out /tmp/new-wire-flow --task-sha256 "$TASK_SHA"
python3 -m protocol_lab.pipeline verify /tmp/new-wire-flow --workspace . \
  --task-sha256 "$TASK_SHA"
```

Task-v3 adds a pinned `wire.binding` and explicit pinned `wire.scenarios` to the
same ten-stage flow. Generation/build create a second native program with the
selected codec; execution retains the original 13 scalar comparisons and runs
five complete wire scenarios (four existing seeds plus the independent contract).
The comparison stage requires both channels to pass. These are repeated executions
of one authoritative IR, not separate TCP state machines.

The program accepts `P milliseconds ipv4-hex` directly and emits `wire_packet`
records containing actual C-produced IPv4 bytes. Input decoding/checksums, output
serialization and the generated EFSM all execute inside that native program;
Python supplies test stimuli and records observations. The PCAP recorder wraps
unchanged native egress bytes plus explicitly supplied ingress stimuli. An
independent existing PCAP decoder checks checksums and fields. Acceptance compares
absolute sequence/ACK/time/window values as well as normalized opening fields, so
normalization cannot waive raw codec differences. A faulty generator emitting
shifted TCP sequences is detected even though its event-level trace still agrees.

`bindings/tcp-active-open-ipv4.json` declares one four-tuple, TTL and the event/message
mapping. RFC791 September1981 section3.1 and RFC9293 August2022 section3.1 provide
header representation/checksum sources; both raw specifications are pinned in
the task. This is a representation adapter, not an IPv4 host/router model. Selected
packets have 20-byte IPv4 and 20-byte TCP headers; ingress is SYN+ACK, without
payload/options/fragments. Unsupported shapes and unrelated tuples are explicit
interface rejections, not claims of RFC-compliant drops or resets. A well-formed
packet with an invalid ACK reaches the IR guard and retains its model-gap rejection.
The native command rolls back timer/output effects on rejection.

Egress DF=1, identification=0 and TTL=64 are profile choices for unfragmented
atomic datagrams, not universal protocol rules. TCP state, sequence/ACK computation,
window advertisement and retransmission timing remain generated from IR. This
uses virtual time and no network stack, sockets, TUN or privileges. It is generated
implementation PCAP evidence, never Linux TCP, physical-network or full IPv4
behavior evidence. The top-level event-task PCAP claim stays false; individual
wire execution reports explicitly name their virtual-link origin and scope.

Original task-v2 actual Ubuntu run41220822030/job124594805326 passed all stages,
its 18-method flow tests and retained verification at a4776f69. That evidence is
for task-v2, not the later wire changes. The new wire CI must pass independently.


## Second specification and external callers

`flows/udp-header.json` feeds RFC768 and RFC1122 section4.1.3.4 through the same
unchanged ten-stage executor, Z3 encoding and native generator. Its seven explicit
rules cover header/service descriptors, default/configurable checksum generation,
source-port zero, length interpretation, and silent checksum/length discards.
Three independently fixed scenario0.2 contracts supplement bounded generated
witnesses and model-gap negatives. See `docs/udp-header-flow.md` for the exact
abstraction: payload bytes, checksum arithmetic, UDP wire and full UDP behavior
are excluded, and `sum_valid` is an assumed input fact.

The provider-neutral client `examples/run_spec_candidate.py` accepts a candidate
workspace, task, approved task digest and fresh output root. It invokes trusted
tools from the tool checkout, runs retained verify after actual success and emits
a structured caller result. A real concurrent test invokes separate TCP-wire and
UDP candidates from an unrelated directory; no vendor-specific harness is used.
`docs/spec-flow-server.md` gives the input/output, failure, iteration and isolation
contract for a single caller or multiple agents. The adapter does not call an LLM
or turn its opinion into acceptance.
