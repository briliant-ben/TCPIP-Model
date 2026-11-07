# Replaying scheduled transitions

The interpreter exposes two different execution granularities. `tick(t)` and an
external `dispatch(..., t)` run every due timer in `(deadline, timer name)` order
before returning. A symbolic witness records one logical transition per step,
including the intermediate state between two timers with the same deadline.
Calling `tick(t)` for each such witness step incorrectly compares the state after
the whole timer batch against the state after its first transition.

`Machine.step_timer(t)` commits exactly one scheduled transition. It selects the
actual earliest active timer, requires its exact deadline, and uses the same
private scheduler operation as the existing batch advance. The caller cannot
choose a timer name, bypass a cancellation or rearm, or inject a timer through
external dispatch. A failed single step leaves the original machine unchanged.
Public batch execution and generated C execution retain their existing behavior.

Symbolic replay uses this operation for timer-origin steps. It checks the actual
event, fields, transition ID, time, post-state and emissions. An external witness
step cannot silently omit due timer transitions. Clock-only steps remain limited
to the declared clock semantics and must not produce a transition or emission.
This changes witness consumption, not symbolic constraints, input domains,
model guards, checksums, solver timeout or oracle expectations.

The original composed-model failure is retained in server job
`tcp-owner-validation-20261107-0094`: its query was SAT, but replay batched
`L.query` and `T.rtx` at 1000ms and rejected the first intermediate post-state.
Its SMT SHA-256 is
`e1fc5e16a5bb26d9ce9183b3d4529684ca10c1ed1e25da7be4e57b1cf2df67bb`.
A fresh validation must retain the byte-identical query and independently record
SAT plus successful replay; it must not relabel the original failed run.

Seven regression methods exercise tied timers and witness prefixes, unchanged
batch records, cancellation/rearm, forged event/rule/origin metadata, omitted
scheduled transitions, transactional failure and malformed clock witnesses.
These finite checks do not establish compiler correctness, complete protocol
coverage or an unbounded equivalence theorem.
