# Checked query dependencies

`query_lemmas.py` composes proofs of exported SMT conjunctions without changing
Protocol IR or adding protocol logic. Given the complete context A:

- a freshly verified parent certificate proves A AND D_i is UNSAT;
- therefore A implies NOT D_i;
- a checked target query A AND V AND every NOT D_i being UNSAT proves A AND V UNSAT.

Every parent must have exactly the same **entire ordered context assertion
vector**, including all type/domain/guard/action constraints. Similar names,
weaker/stronger guards, equal lengths or metadata claims are insufficient. The
new query retains every original target assertion and appends exactly the negated
parent violation formulas. Wrong direction, missing originals and extra facts are
rejected by independent reconstruction. A separate Boolean-only composition
schema is checked with no protocol formulas: its premises represent the parent
and target proof results, and its conclusion is the original target. The schema
does not substitute an already-unsatisfiable protocol query as an unchecked
premise to a local equivalence.

`query_certificates.py` runs only fixed built-in checkers. Supported data formats
are exact tactic, universal modulo normalization, piecewise modulo, finite cases
and an already-verified query-reuse DAG. Finite certificates must prove BOTH each
local equivalence and each leaf; an alternate tactic proof is bound to the exact
missing statement. UNKNOWN, a passing status label, an unsat-core selection or a
certificate-supplied Python/shell command cannot establish a dependency.

Proof names/paths and certificate fields are checked. Self/circular dependencies
are rejected, including repeated canonical query vectors across nested proof DAGs
with different SMT whitespace/comments. Every selected source must have prior
positive evidence and pass a new verification. An explicit caller-provided source
SHA binds standalone verification. Source-model/export provenance remains the
caller's responsibility: proving a self-contained SMT file does not establish
that it came from any particular IR. The ACK application adds a separate anchor
to its resolved model, encoder-input epoch and exact export/partition.

```
.venv/bin/python formal/query_lemmas.py --out /tmp/new-graph --plan plan.json
.venv/bin/python formal/query_lemmas.py --out /tmp/new-graph --verify-out /tmp/new-graph-check
```

The plan maps target names to raw query files and dependency names to certificate
directories. The latter contain certificate.json, a raw original source and proof
data; only the format/kind/source/proof fields are accepted (reuse also names its
target). No certificate-supplied Python is imported. Every positive dependency is
rechecked during production and independent verification. The latter copies all
proof work into a fresh, separate directory and preserves original evidence.

Each SMT CLI keeps the10s budget. The context without the violating assertion is
checked separately: SAT supports nonvacuity; UNSAT is explicitly vacuous; UNKNOWN
is not upgraded. Producer positive leaves must reproduce. Input/checker/dependency/
solver and all source/query/certificate/log hashes are bound. These are exact
query proofs with trusted Python/Z3, source IR translation and orchestration;
there is no kernel, whole invariant-basis, full-byte/time, reachability,
implementation or protocol correctness claim. Full-model induction remains a
separate requirement even if a selected rule's queries close.
