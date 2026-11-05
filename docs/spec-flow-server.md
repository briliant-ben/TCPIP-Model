# Server and external-agent handoff

The executable interface is files plus a CLI. A model vendor, MCP, Skill or agent
framework is not required. An agent proposes the interpretation, IR and candidate
files; the trusted acceptance caller owns pinned source/oracle/scope/bounds and
the approved task SHA. Runtime tools, rather than an LLM's success statement,
produce the stage verdicts and observations. The flow does not automatically
translate an arbitrary English specification into a correct IR.

## Rebuild a trusted tool environment

Use a POSIX host (Linux or macOS), Python3.11+, a C99 `cc` and the pinned Z3 Python
dependency. Check out an explicitly reviewed Git commit. In that trusted checkout:

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-formal.txt
.venv/bin/python -m unittest discover -s tests -p test_flow_migration.py -v
.venv/bin/python -m unittest discover -s tests -p test_pipeline.py -v
.venv/bin/python -m unittest discover -s tests -p test_codegen_wire.py -v
```

No TUN, packetdrill, network privileges, model API, model SDK or credentials are
needed for these event/virtual-link acceptance tasks. These commands do not
produce Linux TCP implementation evidence. Dedicated older Linux/lwIP channels
remain separate. Tool source should be deployed read-only; the venv and compiled
programs are rebuilt on each host rather than committed as standalone binaries.

## Invoke one isolated candidate

`examples/run_spec_candidate.py` is a thin, executable client of the same CLI.
It works from an unrelated current directory and does not import candidate Python.
It starts the trusted checkout's interpreter/module with candidate files passed
through `--workspace`; tasks cannot supply Python/shell commands. It retains the
raw run JSONL, stderr, final job and read-only verification, and reports its own
source/interpreter hashes and the caller's task digest.

```sh
# Values are absolute paths chosen by the deployment caller.
TOOL_ROOT=/srv/spec-flow/tools
CANDIDATE_ROOT=/srv/spec-flow/candidates/candidate-001
RESULT_ROOT=/srv/spec-flow/results/candidate-001
APPROVED_TASK_SHA=replace_with_independently_approved_64_hex_task_digest
"$TOOL_ROOT/.venv/bin/python" "$TOOL_ROOT/examples/run_spec_candidate.py" \
  --workspace "$CANDIDATE_ROOT" --task task.json \
  --task-sha256 "$APPROVED_TASK_SHA" --out "$RESULT_ROOT"
```

These are deployment examples, not a claim that this repository was deployed to
an unspecified user server. For a local self-check of the recorded task version,
use the checkout as workspace, `flows/tcp-active-open-ipv4.json` or
`flows/udp-header.json` as task, and a fresh output directory. Computing that
file's SHA checks version binding; it is not independent external approval.

The candidate workspace must contain the task, its model/base chain, pinned
specifications, profile interpretation, exploration and seed files at the
relative paths declared in the task. Preserve the declared source hashes.
A modeler changes the IR candidate, then calls the client. A trusted reviewer
resolves scope/interpretation ambiguities and separately approves intentional
source/oracle changes. Never let a candidate fix failure by weakening its own
acceptance task or expected output.

## Results and iteration contract

Client stdout is one `spec-flow-client-v1` JSON object. `accepted=true` requires
both a successful actual run and read-only verify for the requested task SHA.
Client exit0 means this declared slice passed; exit1 includes validation failure,
UNKNOWN, environment limits and invalid client input. Inspect `run_returncode`,
`assessment`, `client-result.json` and the nested `job/flow.json` for the reason.
The client preserves the pipeline's original exit2 for invalid admission in
`run_returncode`; no missing job or failed verification is promoted to success.

Direct pipeline stdout is JSONL progress plus a final `spec-flow-run-v1` report.
Each of the ten stages has status, classification, data and retained artifacts.
A caller should use failures as the next candidate's work items:

| Outcome | Next action |
|---|---|
| source/task integrity or invalidated inputs | restore the approved version; create a fresh run |
| unsupported semantics/backend domain | extend the declared backend or narrow an explicitly approved scope; do not silently omit |
| model gap | record unsupported behavior or add a source-backed rule and tests |
| conflict/invariant/counterexample | repair candidate guards/actions and replay the witness |
| independent scenario contract failure | reconsider spec interpretation/candidate; do not regenerate expected outputs from it |
| native/wire difference | inspect exact input, C/binary hashes, output bytes and rule/source map |
| UNKNOWN/resource/environment/dependency | preserve outcome; adjust approved resources or unblock only that channel |
| accepted slice | retain evidence; integrate candidate serially and rerun on the integrated version |

The current test generator explores a declared finite input domain. Independent
pinned seeds supplement model-derived tests; neither all-rule coverage nor all
scenarios passing means complete spec coverage. Z3 has an explicit step bound.
Traceability records exact source versions/clauses and modeling interpretation,
not a proof of English-to-IR or generator correctness.

## One agent or concurrent agents

One caller can invoke the client serially. Multiple agents use separate candidate
checkouts/workspaces and unique result directories; invoke exactly the same
client concurrently. The tests actually launch one TCP-wire and one UDP candidate
in separate workspaces from an unrelated working directory and verify both with
different run IDs. They are ordinary subprocesses, not model-vendor agent services.

Do not let agents edit the trusted tools, shared acceptance inputs or another
candidate's workspace during a run. Workers capture all bound data and trusted
tool sources before execution. A live source edit invalidates acceptance even
though the workers continue on the frozen version. The runner exclusively owns
its new output directory and cleans bounded worker process groups; scheduling,
cancellation policy, API retries and candidate integration belong to the external
harness. This process isolation is not a security sandbox for arbitrary untrusted
code. Compiler and native output stay local artifacts; no implicit publication,
network stack manipulation or model API calls occur.

For retained evidence from older commits, use its named trusted checker/source
epoch; never disable input hashes to accommodate a newer checkout. Retained
verification is integrity checking, not fresh execution or authenticity.
The CI workflow runs and archives both specifications on Ubuntu; its exact
commit/run identity must be checked before calling that server epoch accepted.
