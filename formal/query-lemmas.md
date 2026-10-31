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

A verification invocation may now share a volatile `VerificationSession` across
DAG nodes. A hit requires the same expected raw-source SHA, the complete relative
file-name/byte tree digest, all eight checker-source digests, the native solver
binary digest and the Python Z3 version. Source/schema/QF checks and canonical
cycle checks run before lookup. Cached transitive query fingerprints are also
checked against the active ancestors, so warming a nested proof cannot conceal
a cycle. Returned results are deep copies. Any changed certificate/checker epoch
requires real verification again; no cache entries are loaded from JSON or a
previous process. `proof_cache` records counts only, never proof authority.
Independent verification starts with an empty session by default and rechecks
all distinct admitted trees. A checker may write its own logs; only exact trees
observed before/after positive verification are reusable within that invocation.

The result schema now includes these descriptive cache statistics, and the helper
source digests have changed. Historical bundles remain bound to their named
checker epoch (for example, `13ff8c93` for `artifacts/ack-query-reuse`). They are
not silently accepted by the new checker. To use their raw statements in a new
DAG, regenerate the DAG under the current helpers and independently replay its
primitive certificates; do not rewrite historical version hashes.
