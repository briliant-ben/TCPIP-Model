# Server DeepSeek handoff — 2026-11-06

User clarified that protocol implementation work must run through DeepSeek
agents on `blxu@192.168.71.78`, rather than GPT child agents. No new GPT child
agents are used after that correction, and scheduled polling remains stopped.
The project directory and original private credential/ledger already exist.
Credentials are used only inside the existing gateway and never enter prompts,
Git or reports. The user explicitly authorized further paid requests; the
original12 entries/83412 known tokens remain intact. An operational lifetime
limit64 is passed to the existing gateway, with at most2 calls per current job,
cache reuse and no automatic failed/uncertain request retry.

## Actual first job

`/home/blxu/protocol-flow/candidates/tcp-handoff-20261106-0001`
ran under server PID83162. Its preexisting, unaccepted TCP wire draft came from
the previous local work; it is not falsely attributed to DeepSeek. The server
actually passed7 tests/11 reference/native/fixed-Z3 trajectories in72.971s.
Two DeepSeek roles then produced CI diagnosis and TCP acceptance suggestions,
using8401 additional reported tokens (ledger14 requests/91813 known tokens).
Status is `controller_review_required`, not complete protocol implementation.

The first suggestions were not blindly accepted: the CI response suggested
wire scenarios for the old data model, and the TCP response confused incoming
MSS admission with an outgoing MSS option requirement. Frozen profile/oracles
remain unchanged. A more precise second task supplies actual model/fixture
associations and validates only exact admitted path replacements.

## Active CI repair job

`/home/blxu/protocol-flow/candidates/ci-paths-20261106-0002`
was launched as PID84164 with `agents/run_ci_path_job.py`. DeepSeek proposes and
independently reviews the two workflow argument corrections. The controller
only accepts these exact text anchors:

- `scenarios/tcp-data` → `scenarios/data`, model tcp-data,15 cases/fixed Z3.
- `scenarios/tcp-connection` → `scenarios/connection`,101 cases.

All other commands, flags, oracles and gates remain. The controller then runs
the actual generated-C suites. Provider Python/shell is never executed; the
more general handoff allows only anchored JSON candidate-model edits followed
by fixed trusted validation. Candidate-ready still requires controller review;
no automatic Git push/main merge or reviewer-oracle approval occurs.

Each job retains status, controller log, requests/responses, usage and raw
validation outputs. A STOP file prevents the next request; do not restart a
running/terminal job or replace the shared ledger. `run_server_handoff.py`
has3 offline boundary tests (fake provider, no paid API).

## Environment boundary

Python3.12.3/C99 and existing Z3 venv are available. Noninteractive sudo and
unprivileged network-namespace creation were unavailable at inspection. That
blocks this server's privileged live-network channel only; native/reference/Z3
work continues. Do not change global networking/SSH, call host TCP the subject,
or label native/synthetic results as live-network evidence. Original Linux CI,
UNKNOWN and2750ms lwIP differences remain separate.


2026-11-06 actual DeepSeek server CI repair: ci-paths-20261106-0002 PID84164 completed proposal+independent review, exact two workflow path fixes and ALL15data native/fixedZ3+101connection native gates. Originalrun/launch/controller/source/ELF/trace/query/APIusage receipts in artifacts/server-deepseek-ci-20261106, TAR SHA f68dc2b5; local control checked archiveSHA/exact two YAML changes/suitecounts without archive execution. First real CI failure remains artifacts/pr20-missing-scenarios-a0915d79 ZIP SHA80777329 (0TCP cases). Applied only scenarios/tcp-data→scenarios/data andtcp-connection→connection locally; newGitHubCI pending commit, no merge. Shared ledger now16requests/95053 known tokens; no reset. Next server DeepSeek implementer/reviewer job ipv4-compose-20261106-0003 PID85116 started to produce offline singleIR composition builder proposals forTCP+existingARP/UDP/ICMP. Provider Python remains unexecuted pending controller review; no completion claim, no GPT child agents, no scheduling restart.
