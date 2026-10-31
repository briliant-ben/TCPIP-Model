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
the generator, a complete TCP implementation, or TCP/IPv4 wire acceptance.

Remaining acceptance work: byte-capable native generation and the selected
TCP data slice; minimal IPv4 wire input/output and independent observation;
unified stage orchestration/test-generation/verification manifests; a second
small specification; and reproducible server/multi-agent task isolation and
handoff. A pipeline must distinguish unsupported models, conflicts, invariant
failures, environment/resource limits, stale evidence and implementation
differences. UNKNOWN remains UNKNOWN. Existing pinned evidence and 2750ms lwIP
Difference remain intact. Completing this first backend does not complete the goal.
