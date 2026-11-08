# Finite IPv4 prototype closeout

The functional prototype and its accepted Linux observations remain as described
in [the review guide](ipv4-prototype-review.md). Closeout does not expand the
fixed endpoint or finite TCP profile into a production protocol stack.

## Execution coverage accounting

`protocol_lab.pipeline.coverage.summarize(rule_ids, records)` is a pure data
helper. Its caller supplies already validated observations. Passing records
contribute their committed transitions; failed and unknown records do not.
Declared seeds, model-generated cases, accepted rejection cases and live
observations have separate origin totals. Default initial states and explicit
initial overrides have separate totals. Unknown rule IDs, duplicate case keys
and malformed input are rejected. The helper does not verify a trace, establish
reachability, execute a model, or change a flow verdict.

[The retained accounting report](../artifacts/ipv4-closeout-20261108/execution-coverage.json)
reads the original hash-pinned flow TAR and live ZIP without running archived
Python, ELF or solver code. For all 32 flow cases, the stored reference trace
equals both the expected and observed trace in the passing comparison. The
accepted live report is `finite_ipv4_peer_pass`; its native trace supplies one
additional record. All 33 records use default initial states.

| Metric | Distinct rules |
|---|---:|
| Original declared exploration | 10/335 |
| All retained flow case traces | 32/335 |
| Flow traces plus accepted live trace | 36/335 |
| Not observed in the latter union | 299/335 |

Origin-specific coverage overlaps and must not be added: declared seeds 26,
model-generated cases 10, accepted rejection prefix 1, live observations 13.
The 91 transition occurrences in the union are not 91 distinct rules.
No new network execution or formal proof is claimed by this read-only report.
The original task, report and **unresolved** verdict are unchanged. This helper
is not yet integrated as a replacement for the pipeline exploration metric.

DeepSeek produced the helper and its tests in server jobs 0140–0142. The 0142
response wrapped the result in `completed_source`; that original envelope is
retained, and only its explicit file payload was selected for qualification.
Root review corrected one mixed-key error-message expression so malformed keys
raise the documented ValueError instead of a sorting TypeError. The final
helper passes 31 candidate tests and five controller-authored independent tests.
The existing pipeline suite passes 20 tests. These are targeted checks, not a
claim that the entire repository suite was rerun. Independent DeepSeek review 0145 of the qualified final source returned empty blocking/findings/limitations arrays; that is advisory review, not a correctness proof.

## Additional frozen-scenario regression

Server job 0144 executed the unchanged old 45-scenario literal corpus (SHA-256
`1494d7445a0f66560232751c5f7c3a2daf604d0bb79dda6cda349157fa1053e0`)
against the final virtual-link model and existing immutable generated C build.
All 45 reference/native comparisons passed: 150 transitions and 50 distinct
rules. All six TCP scenarios additionally have original fixed-input Z3 SAT and
reference-replay match receipts, including partial ACK, retransmission and
sequence wrap. These finite paths do not establish general TCP behavior.

The [new accounting report](../artifacts/ipv4-closeout-20261108/execution-coverage-with-legacy.json)
combines those observations with the earlier flow/live evidence: 78 records,
241 transition occurrences, **58/335 distinct rules**, and **277 unobserved**.
The default-initial subset itself covers all 58; one explicit-initial scenario
covers eight rules already present in that set. These 45 extra cases are a
separate regression channel, not silently added to the original 32-case task.
Original exploration coverage and the original flow verdict remain unchanged.

[Read-only audit](../artifacts/ipv4-closeout-20261108/validation-readonly-audit.json)
checks all 45 original scenarios against the unchanged frozen corpus, execution
output hashes, exact native/reference traces, and six original SMT/report hashes.
It parses but does not execute archived Python, ELF or solver code. The second
original public bundle has 447 files, SHA-256
`68bd402ca600a8d25b68b9d09b48aefcf3d36b783e8625c3cf494258974ba639`.
No new network observation is claimed by these offline generated-C executions.

## Full-input formal diagnosis

The original depth-one safety and overlap query hashes remain unchanged.
Job 0140 tried the existing exact-v1 policy at the original 10,000 ms budget;
both queries remained UNKNOWN. A missing public documentation file then stopped
the formal role **before** any API call. Job 0141 supplied that context without
rerunning the solver diagnostic. Its proposal to constrain input bytes to
0..32 was rejected because a bounded transition depth does not imply a bounded
input-byte domain. Its claimed checksum bottleneck is a hypothesis, not an
established cause of the timeout.

Job 0142 supplied an exact partition diagnostic candidate, qualified by five
candidate tests and four independent tests. Job 0143 checks the complete
original formulas with the original budget, using all rule indices grouped by
event plus idle and clock. It must solve a coverage-of-partitions obligation
before claiming completeness; every query is persisted before solving. Any
partial UNSAT result leaves the original overall UNKNOWN intact. SAT models
are diagnostic only until independently replayed. This experiment does not
change the production formal backend or the ten-stage flow verdict.

Subsequent work must use actual diagnostics to choose an exact transformation,
and add actual witnesses or explicit checked unreachable-rule findings for
missing rules. Increasing reported coverage alone cannot close the flow.

## Original evidence and repository separation

The terminal 0140–0142 public original bundle contains 34 files, SHA-256
`86477d6d8ae517e724ca64a2c816203d02a9db3872c2134fa2b24770d91df12a`.
It retains proposals, sanitized API usage, source snapshots and original
failures. Private credentials, provider reasoning and the private ledger are
not copied. No failed or uncertain paid request was automatically retried.

[Repository boundaries](repository-boundaries.md) keep TCP/IP outputs here and
reserve Formal-Spec-Agent for the later framework extraction. Automation stays
paused; no main merge or protocol/oracle/hash relaxation is authorized by this
closeout work.
