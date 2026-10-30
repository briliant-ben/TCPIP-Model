From Stdlib Require Import List ZArith Lia.
From ScalarIR Require Import Semantics Compiled.
Import ListNotations.
Open Scope Z_scope.

(* Statements quantify over execution of the actual generated source program.
   The proof body is specific to the current scalar contract layout. *)
Theorem checked_generated_initial :
  Forall (fun property => holds property (initial compiled_initial) (fun _ => 0))
    compiled_invariants.
Proof. unfold compiled_invariants; repeat constructor. Qed.
Print Assumptions checked_generated_initial.

Theorem checked_generated_step : forall (state fields : env),
  Forall (fun index => 0 <= fields index < 4294967296) compiled_seq_fields ->
  Forall (fun property => holds property (execute compiled_actions state fields) fields)
    compiled_invariants.
Proof.
  intros state fields H.
  pose proof ((proj1 (@Forall_forall nat
    (fun index => 0 <= fields index < 4294967296) compiled_seq_fields)) H) as Hfields.
  pose proof (Hfields 0%nat (or_introl eq_refl)) as Ha.
  pose proof (Hfields 1%nat (or_intror (or_introl eq_refl))) as Hb.
  unfold compiled_invariants; constructor.
  - change ((fields 0%nat + (fields 1%nat - fields 0%nat) mod 4294967296)
      mod 4294967296 = fields 1%nat).
    rewrite Z.add_mod_idemp_r by lia.
    replace (fields 0%nat + (fields 1%nat - fields 0%nat)) with (fields 1%nat) by lia.
    apply Z.mod_small; exact Hb.
  - constructor.
    + change ((((fields 0%nat + fields 2%nat) mod 4294967296) +
        (0 - fields 2%nat)) mod 4294967296 = fields 0%nat).
      rewrite Z.add_mod_idemp_l by lia.
      replace (fields 0%nat + fields 2%nat + (0 - fields 2%nat)) with (fields 0%nat) by lia.
      apply Z.mod_small; exact Ha.
    + constructor.
Qed.
Print Assumptions checked_generated_step.
