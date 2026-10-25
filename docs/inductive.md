# State-invariant induction obligations

This is an additional verification path. It does not replace the existing depth-6 BMC, change any protocol guard, constrain payload contents, or turn the data BMC's `unknown` into `bounded_pass`.

```bash
.venv/bin/python -m protocol_lab inductive model/tcp-data.json --out artifacts/suite/tcp-data/inductive
.venv/bin/python -m protocol_lab suite --formal --depth 6
.venv/bin/python -m protocol_lab suite-verify
```

The data profile enables induction alongside its original BMC and full-byte scenario crosschecks. Report status `inductive_invariants_pass` refers only to the following obligations for the declared EFSM and its listed state invariants. It does not mean full TCP, liveness, correct payload contents, correct output packets, conformance of a real implementation, or a verified compiler.

## Exact admitted projection

The current data model observes bytes in control decisions and invariants only through length. In this subset, replacing each finite byte sequence by its nonnegative integer length preserves every guard, scalar assignment, timer condition and listed invariant:

- Literals map to their actual octet count; arbitrary inputs and state values admit every nonnegative length, without a smaller implicit capacity.
- Concatenation length is the sum.
- For truncating slice, `s=max(0,offset)`, `c=max(0,count)` and result length is `min(c,max(0,length-s))`.
- Assignment, emit and ordered action evaluation retain their existing positions. The projection does not represent emitted octet values.
- Typed `ite` uses the same Boolean condition and selects the corresponding branch length. The full-sequence conditional-length identity is checked alongside concatenation and slice.

The backend explicitly rejects byte equality/inequality anywhere in guards, invariants or action expressions. It never interprets content equality as length equality. Unknown operators remain rejected. A future byte-inspecting operation must have an appropriate exact backend rather than being silently projected away. The independent full `Seq(BitVec(8))` backend remains the default for BMC and concrete trace crosschecks.

The length formulas are checked with arbitrary full byte sequences and integer offsets/counts in `length-lemmas.smt2`; their negations are unsatisfiable. See the [official Z3 sequence operations](https://microsoft.github.io/z3guide/docs/theories/Sequences/) for the underlying Seq operations. These solver checks cover the projection primitives, not the entire Python translation implementation.

Sequence numbers use mathematical integers with the explicit domain `0 <= s < 2^32` for **every frame and event field**. Addition and forward distance use modulo `2^32`; order/comparability use exactly the IR's half-space formulas. This is a bijective representation of all BV32 values, not a small-number abstraction or signed comparison. Negative/unbounded integer increments still wrap correctly. Boundary vectors and full-byte traces with wrap crosscheck this representation against the reference interpreter; the original BV32 backend remains independent evidence.

## Obligation structure

1. **Initial state.** Check the negation of the conjunction of all listed invariants at the declared initial state, with the requested symbolic initial variables (ISS by default). Initial timers are inactive. No poststate invariant is assumed.
2. **Preservation.** Start from an arbitrary typed nonterminal state satisfying the entire invariant conjunction. For each declared transition, check for a poststate invariant violation, nonpositive arm delay or an active timer deadline in the past. Guards, ordered actions and expiry priority are independently encoded as in BMC. The conjunction is assumed only in the prestate; it is precisely what each obligation must establish in the poststate. This is induction, not a BMC query filtered by assumed poststate safety.
3. **Guard overlap.** For every source-state/event group containing multiple rules, check whether any pair is simultaneously enabled in an arbitrary invariant state. This is stronger than checking only reachable depth-6 prefixes, but is conditional on the established invariant conjunction and declared terminal boundary.
4. **Nonempty concrete sample.** Solve one defined step with the original full-byte/BV32 backend, save its witness and replay all state/timer/emit fields in the reference interpreter.

The initial and preservation obligations establish an inductive basis for the listed scalar/length state properties within this model and encoding. They make no progress/fairness claim. Byte-content integrity still requires full-byte properties and implementation observations; existing full-byte scenario replay and synthetic codecs have their own narrower evidence scope.

All per-rule and per-group queries are exported in executable SMT-LIB scripts. A fresh Z3 process can run the scripts directly. Reports enumerate all rule IDs, all overlapping-rule groups, invariant IDs, encoding choices, solver version, model semantic hash and query hashes. The suite hashes these artifacts and semantic documents. Missing obligations, changed models and changed queries are rejected.

## Failed induction is not reachability

A satisfiable preservation obligation starts from an arbitrary invariant state. It may expose an insufficient invariant conjunction rather than a reachable failure. Reports label it `inductive_obligation_failure_not_reachability_proof` and retain a length projection; these are not concrete byte witnesses and must not be passed off as reachable runtime counterexamples. The BMC and constrained full-byte fault tests continue to produce/replay reachable witnesses separately.

The first run found such a gap in simultaneous open: the old conjunction allowed an arbitrary SYN-SENT state with `SND.UNA != ISS`, even though OPEN establishes equality and no SYN-SENT transition changes it. The added `C-INV-SYN-SENT-ISS` records that derived relation. Its initial establishment and preservation are checked together with every other invariant; it is not an unproved environment assumption. Removing it reproduces the failed simultaneous-open obligation. With it, the current data profile passes initial, all 117 preservation and all 14 overlap-group obligations. The separate BMC still reports its own actual solver result.

The larger reassembly profile has its own expanded invariant set and certificate: 113 rule-preservation obligations, 13 multi-rule guard groups and 84 invariants. The five old receive rules are replaced by one explicit queue transition, so the smaller rule count does not mean smaller protocol behavior. Queue/cell lengths, right edge and contiguous-head properties are included, but the certificate still does not cover byte-content identity or overlap-content policy. Nonzero-byte permutation scenarios, content fault variants and full-byte symbolic replay check those behaviors separately.

The ACK/window/payload composition profile has 109 preservation obligations, 14 multi-rule guard groups and 84 state invariants. Conditional timer actions guard both effects and delay faults by their explicit when predicate. These obligations do not establish ACK processing order, WL freshness, timer restart policy or byte identity; those are separately checked with expected traces and fault variants. Each profile now emits the exact claim bindings described in [claims.md](claims.md).

Preservation queries now substitute the fixed rule choice before solving and use a fresh solver for each case. This is exact constant reduction of the original one-step constraints, including all prestate invariants, poststate violation checks and action faults; unselected transition bodies become false. Each case is still enumerated. Exported preservation SMT uses reset between cases, and retains its rule choice for diagnostic witnesses. The initial, overlap, length-lemma and full-byte sample obligations are unchanged. This avoids unrelated transitions and incremental learned context consuming each rule budget; it does not increase the timeout or filter counterexamples with assumed poststate safety.

Post-target semantics introduces a finite declared destination set per rule (default plus all target cases). Preservation now exhaustively partitions over every distinct destination. Each subquery fixes the selected rule, its implied source state, and that destination, then exactly reduces constants in the original constraints. No poststate invariant is assumed. Rule status is unsat only when every destination subquery is unsat. The verifier rejects missing targets/subqueries; exported scripts retain every destination check, so their check count is the sum of target counts, not necessarily the number of rules. The statement/claim manifest binds the default and ordered case ASTs. This refinement does not prove conditional output correctness: those observations still require full-byte replay and independent contracts.
