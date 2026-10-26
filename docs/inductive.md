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

IR 0.3 的 rational 采用独立 RealSort 过近似及精确常系数运算；unsat 保持适用于有理状态，sat 见证必须是可序列化的精确有理数。事件时钟 guard 采用推进后的事件时刻，保持性仍从任意满足全部前态不变量的状态检查全部声明目标。RTT/RTO 的状态归纳不会证明通用输出时间契约或原始分段发送历史；具体范围见 tcp-rto.md。

## 纯时钟保持

时钟 v3 模型还必须通过独立的纯时钟保持义务：在任意满足全部前态不变量的状态（包括声明终态），严格推进到下一活动定时器截止点之前，保持其余存储不变，检查全部后态不变量和活动定时器不在过去。查询原文为 `clock-preservation.smt2`，结果为 `clock_advance_query`。没有该查询、结果 unknown 或 sat 时，主归纳不能通过，补充层也不能绕过。非时钟模型明确记录 not_applicable。非空样本必须实际执行声明规则，不能用纯时钟推进充数。

## 精确查询精化的独立验收层

Profile 可显式声明 `inductive_refinement: true`。原 `inductive/result.json` 及其 SAT/UNSAT/unknown 查询保持只读；补充结果写入 `inductive-refinement/`。只有初值、长度公式和全部 guard 组已为 unsat、没有 sat 保持义务、所有规则及声明目标完整覆盖时，才可精化其中的 unknown 保持查询。不支持的主编码／范围、缺失标签或查询文件明确拒绝。

精化保留原查询的每条其他断言，完整分组所选断言的析取项，检查等价并独立重解每一组；默认每组 8 项、每查询 10000ms，fresh Z3 context。每个 unknown 目标均须有精确来源、标签、完整组覆盖及验证结果。独立复查超时仍为 refinement_unknown，不得仅因首次生成 unsat 而通过；任何未解决初值／guard 不得被跳过。主归纳已经通过则写 not_needed_primary_pass，不把它改称新证明。

全部 unknown 被覆盖后仍需生成一个完整字节／BV32 的非空初始执行见证，记录其原 SMT 查询和独立参考重放；非符号初值必须等于 IR 声明，空轨迹或不同初值不能完成该验收。绑定完整模型、主结果及查询哈希、检查器源码、Z3 版本、所有分组和样本。验证时从当前绑定主目录读取原查询，允许证据目录整体迁移，但不允许换成不同哈希的源。

```
.venv/bin/python -m protocol_lab inductive-refine model/tcp-tx-history.json --inductive artifacts/suite/tcp-tx-history/inductive --out artifacts/suite/tcp-tx-history/inductive-refinement
.venv/bin/python -m protocol_lab inductive-refine-verify model/tcp-tx-history.json --inductive artifacts/suite/tcp-tx-history/inductive --out artifacts/suite/tcp-tx-history/inductive-refinement
```

通过时补充状态为 refined_inductive_queries_pass。claims 保留原 inductive-state 的 unknown，另发 refined-inductive-state（verified_refined_inductive_state_properties）；同样不是完整协议、内容／输出精化、活性或 Rocq 内核证明。BMC unknown 不因此提升。工具设计与历史试点见 query-partition.md。
