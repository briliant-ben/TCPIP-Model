From Stdlib Require Import List ZArith Lia.
From ByteIR Require Import Semantics Compiled.
Import ListNotations.
Open Scope Z_scope.

Theorem checked_generated_initial :
  Forall (fun property => holds property (initial compiled_initial)
    (fun _ => []) (fun _ => 0)) compiled_invariants.
Proof. unfold compiled_invariants; repeat constructor. Qed.
Print Assumptions checked_generated_initial.

Theorem checked_generated_step : forall (state fields : benv) (ints : ienv),
  Forall (fun property => holds property (execute compiled_actions state fields ints)
    fields ints) compiled_invariants.
Proof.
  intros state fields ints; unfold compiled_invariants; constructor; [|constructor].
  change (slice (state 0%nat ++ fields 0%nat) 0 (ints 1%nat) ++
    slice (state 0%nat ++ fields 0%nat) (ints 1%nat)
      (Z.of_nat (length (state 0%nat ++ fields 0%nat))) =
    state 0%nat ++ fields 0%nat).
  unfold slice; rewrite Nat2Z.id; simpl skipn.
  assert (Htail : forall (xs : list Z) (n : nat),
    firstn (length xs) (skipn n xs) = skipn n xs).
  { intros xs n; apply firstn_all2; rewrite skipn_length; lia. }
  rewrite Htail; apply firstn_skipn.
Qed.
Print Assumptions checked_generated_step.
