From Stdlib Require Import List ZArith.
From ScalarIR Require Import Semantics.
Import ListNotations.
Open Scope Z_scope.
Definition compiled_initial : list Z := [0; 0; 0; 0; 0; 0; 0].
Definition compiled_seq_fields : list nat := [0%nat; 1%nat].
Definition compiled_actions : list (nat * expr) := [(0%nat, (EField 0%nat)); (1%nat, (EField 1%nat)); (2%nat, (EField 2%nat)); (3%nat, (EDistance (EVar 0%nat) (EVar 1%nat))); (4%nat, (ESeqAdd (EVar 0%nat) (EVar 3%nat))); (5%nat, (ESeqAdd (EVar 0%nat) (EVar 2%nat))); (6%nat, (ESeqAdd (EVar 5%nat) (EVar 2%nat)))].
Definition compiled_invariants : list (expr * expr) := [((EVar 4%nat), (EVar 1%nat)); ((EVar 6%nat), (EVar 0%nat))].
