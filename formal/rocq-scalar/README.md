# Generated scalar IR execution pilot

This pilot translates the actual ordered assignments and equality invariants in
model/seq32-contract.json to data constructors, then states theorems about executing
that generated program in Semantics.v. It covers a single nonterminal state, one
application event, an unconditional self-transition, int/seq32 scalars, ordered set
operations and equality invariants. Unsupported fields, guards, control, timers,
messages, types and expressions are rejected. The proof body is specific to the
current scalar contract layout; compilation is not a general proof generator.

compile.py has a producer and a separate inverse constructor parser. The parser
reconstructs complete source expressions, actions in order, initial values, event
sequence domains and invariants; extra definitions/code or omitted/changed terms
are rejected. Source/checker hashes bind this structural bridge, which remains
trusted Python code, not a kernel proof of JSON parsing or the compiler itself.

Semantics.v defines evaluation and ordered state updates for this fragment. The
kernel statements quantify over execution of the actual generated Compiled.v,
all initial environments and typed event inputs; the offset integer is unbounded.
They are not merely hashes attached to separately handwritten arithmetic equations.
The formal denotation, compiler/binding checker and relation to the documented IR
remain explicit trust boundaries. No universal Python interpreter/Z3 translator,
TCP state machine, byte/time, liveness, implementation or Linux theorem follows.

Run check.py --docker in a fresh output directory. The image is digest-pinned to
Rocq9.2.0. The gate compiles semantics/generated data/theorem bodies, requires two
empty-axiom audits, and independently kernel-checks all three objects. Wrong-inverse
and wrong-order source IR variants must compile as generated data but fail the
execution theorem in separate fresh workspaces; legal reference invariant-failure
witnesses and logs are retained. Axiom injection must be detected by the audit.

Without the compiler/Docker, source generation and structural validation may finish
but kernel_checked_proof stays false and status is not_run. Local binding tests do
not count as kernel execution. Each completed CI needs provenance, ZIP/object/log
hashes and an independent evidence binding gate before accepting its result.
