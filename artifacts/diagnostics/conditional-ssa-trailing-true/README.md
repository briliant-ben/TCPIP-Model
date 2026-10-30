The first seven-method local run failed its genuine wrong-update SAT case:
verification found an assertion-count mismatch. Z3 Solver.to_smt2() omitted the
trailing `assert true` produced by specialization. The verifier rejected this;
no TCP query had been accepted and no proof was promoted.

The retained prototype and failing exported leaf show that mismatch. The current
helper uses Solver.sexpr() plus check-sat to retain every assertion. The wrong
update test now explicitly requires all four assertions, including trailing true,
and independently verifies SAT. No protocol/domain/budget/oracle changed.

The first actual-query admission traversal revisited shared DAG subexpressions
repeatedly and was explicitly interrupted before producing any query bundle. Its
raw traceback is retained losslessly as admission-interrupt.log.gz. The accepted
version memoizes visited node IDs; no constraints or solver budgets changed.
