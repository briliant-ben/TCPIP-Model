# Rocq sent-credit arithmetic pilot

Five frozen abstract integer statements: credit<=16+3=19 and its sharpness,
original-record mass conservation, deferred cumulative-ACK credit and
emitted-plus-pending budget preservation under accepted writes and first sends.
These check the arithmetic used to design the ledger. They do not establish that
the JSON actions implement these equations, that the interpreter/SMT translator
agrees, or that lwIP/TCP refines the model. Such bridges remain separate work.

Run `python3 formal/rocq-ledger/check.py --docker` using the same digest-pinned
Rocq9.2.0 image as the existing six-primitive pilot. Fresh sources are compiled,
all five wrappers must have an empty axiom allowlist, and rocq check independently
rechecks the proof objects. False-proof and axiom-injection negative controls run.
Result JSON binds statements, proof bodies, orchestration, intended model/source
context, compiler package/version, logs and proof-object hashes. Model-context
binding is provenance, not a proved semantic bridge. Missing local Docker records
not_run/kernel_checked_proof=false; CI is the independent compiler channel.
