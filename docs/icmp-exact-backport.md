# PR17 exact solver policy backport

This branch keeps its existing v1/v2/v3 task schemas, protocol models, input
domains, depth and native backend. It does not import later IR0.6, sequence
induction, TCP wire or peer work from descendant PRs.

The ICMP Echo task now explicitly chooses `formal.solver_preprocess=exact-v1`
at the unchanged depth two and 60000ms per-solve budget. The default remains
the original `z3.Solver()`. Exact-v1 uses the ordered built-in Z3 tactics
propagate-values, solve-eqs, simplify, smt through a tactic solver that retains
model converters. Length projection is rejected for this policy. No guards,
actions, invariants, source pins or scenario/oracle values are changed.

Task validation, worker invocation and retained evidence verification bind the
policy, tactics and construction descriptor. This backport uses the descriptor
`z3.Then('propagate-values','solve-eqs','simplify','smt').solver()`; evidence must
be verified with its source-bound checker. Default-none legacy reports remain
compatible. The later fresh-directory query-journal changes are deliberately
absent, keeping this branch's existing formal CLI call site compatible.

DeepSeek supplied the minimal patch on the frozen original Git dc0be249 source.
Two literal whitespace/JSON anchors were corrected without an additional model
call; code semantics and the frozen thirteen tests were retained. Those tests
passed on the server and locally, including SAT witness replay, strict ICMP
UNSAT results, UNKNOWN handling and coherent metadata tampering/deletion.
Five additional related server modules and a complete ICMP ten-stage flow plus
verification passed. The retained archive contains 308 original files; the
flow's 265 output hashes and frozen source bindings were independently checked
without executing archived code, ELF or solver. See
`../artifacts/pr17-exact-backport-0051/`.

This is a new bounded-check result, not a revision of any earlier UNKNOWN.
Z3/tactics, the IR-to-SMT encoding, witness reader and C compiler remain trusted.
The contracts checked at depth two do not prove complete ICMP, checksum/compiler
equivalence or a whole IPv4 endpoint. Fresh CI of this exact Git head remains
required before the PR can be considered ready.
