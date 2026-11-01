# Bounded unattended modeling jobs

User2026-11-01 authorized server-side agents with occasional controller checks.
`agents/run_model_job.py` runs two independent DeepSeek JSON roles concurrently:
a declarative IR proposer and a specification-only literal scenario reviewer.
The reviewer does not see candidate IR. Its scenarios are frozen before candidate
validation; repairs cannot alter them. This is independent model generation,
not independent human approval: reviewers can be wrong and pass remains a
candidate requiring controller inspection and further pinned acceptance tasks.

The first job is `agents/jobs/udp-payload.json`: RFC768 and RFC1122§4.1.3.4
source-hash-bound excerpts, fixed byte service interface, empty/odd/NUL content,
UDP-length slicing, padding, duplicates and checksum/discard descriptors.
It is a prerequisite slice for byte-level cross-layer work; it does not implement
UDP wire/checksum arithmetic, ICMP port unreachable, PCAP or the whole endpoint.
No arbitrary Python/shell/file paths from provider responses are executed.
Only the fixed controller validator generates/compiles C from admitted IR.

A job runs at most two initial requests and two model repairs; output caps are
8192/6000 tokens and gateway requests share the existing lifetime12-call ledger.
Completed identical requests reuse cached responses; uncertain/failed requests
never automatically retry. Only completed model proposals failing tool validation
may receive explicit new repair prompts. Timeout/UNKNOWN stops with unresolved;
there is no paid repair for solver deadlines. No self-resetting budget or infinite
daemon. Job wall budget is two hours, each validation subprocess at most240s.
Separate private credentials remain outside prompts/results/Git.

Actual validation runs reference scenario0.2 contracts, generated-native exact
comparison, independent fixed-input Z3 replay, then depth3 safety/overlap checks.
No UNKNOWN promotion or all-input/unbounded/compiler proof claim. A source/initial
state/interface change is rejected. Candidate-ready means only these candidate
slice gates passed; it is never automatically committed, pushed or merged.
The controller must examine literal reviewer outputs, scope and source mappings.

The process runs detached under the existing server account in the project-owned
controller/job directories and survives SSH disconnects. `status.json` is atomic;
`controller.lock` prevents concurrent controllers for the same job. A STOP file in
the job directory prevents the next API request (an in-flight request/validation
may finish). Partial validation is retained for inspection. Terminal jobs exit;
no daily billable scheduling is installed on the server. A sparse local heartbeat
inspects meaningful changes without provider calls during read-only monitoring.
