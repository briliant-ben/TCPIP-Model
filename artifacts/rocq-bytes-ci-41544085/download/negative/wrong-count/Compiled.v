From Stdlib Require Import List ZArith.
From ByteIR Require Import Semantics.
Import ListNotations.
Open Scope Z_scope.
Definition compiled_initial : list (list Z) := [[]; []; []; []; []].
Definition compiled_byte_fields : list nat := [0%nat].
Definition compiled_int_fields : list nat := [1%nat].
Definition compiled_actions : list (nat * bexpr) := [(1%nat, (BConcat (BVar 0%nat) (BField 0%nat))); (2%nat, (BSlice (BVar 1%nat) (ILit 0) (IField 1%nat))); (3%nat, (BSlice (BVar 1%nat) (IField 1%nat) (ILit 0))); (4%nat, (BConcat (BVar 2%nat) (BVar 3%nat)))].
Definition compiled_invariants : list (bexpr * bexpr) := [((BVar 4%nat), (BVar 1%nat))].
