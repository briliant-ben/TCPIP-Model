# Explicit full-sequence invariant induction strategy

Task schema spec-flow-task-v4 fixes formal.strategy=sequence-invariant-induction
and optional solver_timeout_ms100..60000/default10000. It deliberately has no
BMC depth or symbolic-initial list. Schemas1..3 retain their existing bounded
configuration and reject this strategy field. Unknown strategies/fields reject.
This is a separate theorem/encoding choice, never a relabelled old BMC answer.

The checker admits only validated IR0.4/0.5 flat atomic-ordered-v1 with no terminal
states or target cases and with time/event-free declared invariants. Unsupported
IR/semantics refuse. Every variable in preservation is unconstrained in its full
type, subject ONLY to listed pre-invariants and active-timer due>=now. Bytes use
full finite Seq(BV8), integers mathematical Int and seq32 full BV32: no length
projection, concrete payload restriction, capacity truncation, Python callbacks
or reference interpreter evaluation to build constraints. Guard and action ASTs
are translated by the independent symbolic Encoding.

Initial validity is checked under actual default initialization; a suffix-padding
choice removes unexecuted protocol events from this initial-state-only query.
Initialization nonemptiness is checked separately. This padding is existential
initialization scaffolding, not a restriction of preservation to no events.
Each transition has a separate arbitrary-legal-prestate preservation obligation:
assume listed pre-invariants, assert full selected-rule relation, refute listed
post-invariants or timer-duration/active-deadline contracts. Choice/source/target
constants are substituted exactly into the original relation and simplified in a
fresh solver. No poststate variable, property, guard, input or output is supplied
by a reference run. All guards remain encoded; selected branch actions are exact.
Each rule also needs a separate SAT nonvacuity answer. Every same-source/event
rule-pair group has an arbitrary-prestate overlap query; cross-source pairs are
exclusive by the single state value. SAT failing prestates are not claimed
reachable counterexamples. UNKNOWN/vacuous/failure never pass.

Only all initial/preservation/overlap UNSAT and all nonvacuity SAT yield
inductive_invariants_pass. The worker/verifier bind that distinct result to the
v4 strategy; no conversion to bounded_pass. Original BMC UNKNOWN files/results
remain unchanged. Verification checks complete obligation/rule/property mapping,
raw query hashes, domain/scope/checker/model identity and verdict consistency;
it does not rerun a solver or treat hashes as run authenticity.

The resulting induction concerns only the listed invariants on initialized,
defined atomic-v1 transitions. Between expiries, syntactically time/event-free
invariants do not change on time advance; existing atomic-v1 scheduler/preemption
semantics remain trusted, not a proof of interpreter scheduling. Other trusted
components include IR parsing/expansion, symbolic translation and Z3 results.
There is no full protocol/unbounded protocol, English-to-IR, byte output checksum,
event-domain coverage, compiler/native correspondence, liveness or wire timing
proof. Literal and fault scenarios/native/independent observations remain separate
acceptance channels. An invariant-preserving wrong-MAC emission can still pass
this checker and must fail independent wire oracle checks.
