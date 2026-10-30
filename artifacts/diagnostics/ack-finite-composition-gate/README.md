# Unaccepted composition prototype

The default finite specialization has15 UNSAT cases and one UNKNOWN local
XOR/leaf (head15). A first composition prototype added a passing tactic proof for
the head15 leaf alone, and prematurely labeled its local output as closed. That
label was **not accepted**, committed as a positive result, or published as a
completed query. A stronger composition gate rejected it because the local XOR
was still unproved. The original reports/code and actual gate failure are retained
here explicitly as an unaccepted diagnostic, not proof evidence.

The corrected composition requires a separate checked certificate for **both**
the local equivalence and leaf when either default result is UNKNOWN. Each exact
tactic script retains every assertion and the10s budget. The local XOR has only
head=value as a premise; original protocol constraints are not asserted as
premises to conceal a missing equivalence proof. Both head15 proofs are now
separate obligations. The final artifact must pass its corrected independent
checker; no root status label by itself establishes closure. A rehashed fault
that substitutes the unproved default local equivalence is explicitly tested.
