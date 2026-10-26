# Claim manifests and trust boundary

Each suite profile emits `claims.json`. It binds the expanded IR semantic hash, source/input hashes, scope, environmental requirements, actual invariant expressions, rule set, checker version/code hashes and evidence hashes. Its proposition digest covers both statement and context; changing a depth or assumption changes the proposition.

Three claims remain separate:

* `bounded-state`: actual safety/overlap results for typed defined executions up to the recorded depth. `unknown` and vacuity remain inconclusive; neither is a bounded pass.
* `inductive-state`: initial establishment and per-rule preservation of the listed state invariants, plus guard-group disjointness. The prestate assumes all invariants; the poststate does not. Length projection rejects unsupported byte-content decisions and does not prove byte identity.
* `fixed-traces`: full-byte constrained replay for the explicitly listed fixed inputs/rule choices, comparing pre/post state, timers and emitted fields. This is not universal event-sequence verification.

`suite-verify` regenerates the manifest from the current model and saved evidence, checks required artifacts/statuses and compares exact bindings. Rehashing a manifest cannot promote it to a kernel-checked proof. This is an integrity and consistency gate, not authenticity or a second semantic proof of solver answers. Existing artifact/source and induction gates still apply.

Current trusted components include IR parsing/validation, the Python IR-to-solver translator, Z3 and checker/evidence integration. All current claims explicitly set `kernel_checked_proof` to false. No claim establishes full RFC coverage, translator correctness, universal payload identity, implementation refinement, liveness or Linux execution. Rocq evidence will require an actual kernel check with a bound theorem, assumptions, checker version and checked artifact; generated proof text alone is insufficient.

For post-action targets, the induction proposition also binds each rule's default target and ordered target-case expressions. Its certificate must cover every declared destination, including default, with conclusive subqueries; a missing target cannot become a passing claim. Fixed-input trace optimization substitutes only already fixed inputs and choices, never expected outputs or poststates. Scenario output contracts remain separate checks.

启用 inductive_refinement 的 profile 另外绑定 refined-inductive-state 命题：原始归纳状态及每一个 unknown 目标、完整上下文的精确析取分组、固定逐查询限时、原非符号初值及非空完整字节见证。证据集合同时包含原 inductive/ 和新增 inductive-refinement/ 文件，检查器代码还包括 formal/partition_queries.py。原 inductive-state 始终保持原查询结论；只有补充层的全部来源／覆盖／分组复查和样本通过，才允许 verified_refined_inductive_state_properties。辅助验证 unknown、缺组、缺目标、缺源码绑定、空样本都不能提升；若主检查已通过，补充状态仅为 not_needed_primary_pass。
