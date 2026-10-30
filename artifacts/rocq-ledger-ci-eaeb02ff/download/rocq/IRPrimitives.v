From Stdlib Require Import List ZArith Lia.
Import ListNotations.

(* Generic IR value operations, no TCP transition system. Z.to_nat clamps
   negative offsets/counts to zero, as required by IR 0.2. *)
Definition ir_slice {A : Type} (xs : list A) (offset count : Z) : list A :=
  firstn (Z.to_nat count) (skipn (Z.to_nat offset) xs).
Definition ir_seq_add (a n : Z) : Z := (a + n) mod 4294967296.

Theorem concat_length : forall (A : Type) (xs ys : list A),
  length (xs ++ ys) = (length xs + length ys)%nat.
Proof. intros; apply app_length. Qed.

Theorem slice_length : forall (A : Type) (xs : list A) (offset count : Z),
  length (ir_slice xs offset count) =
  Nat.min (Z.to_nat count) (length xs - Z.to_nat offset).
Proof. intros; unfold ir_slice; now rewrite firstn_length, skipn_length. Qed.

Theorem consume_preserves_content : forall (A : Type) (xs : list A) (n : nat),
  firstn n xs ++ skipn n xs = xs.
Proof. intros; apply firstn_skipn. Qed.

Theorem negative_slice_count : forall (A : Type) (xs : list A) (offset count : Z),
  (count <= 0)%Z -> ir_slice xs offset count = [].
Proof.
  intros A xs offset count H; unfold ir_slice.
  destruct count; simpl in *; try reflexivity; lia.
Qed.

Theorem seq_add_range : forall (a n : Z),
  (0 <= ir_seq_add a n < 4294967296)%Z.
Proof. intros; unfold ir_seq_add; apply Z.mod_pos_bound; lia. Qed.

Theorem seq_add_compose : forall (a n m : Z),
  ir_seq_add (ir_seq_add a n) m = ir_seq_add a (n + m).
Proof.
  intros; unfold ir_seq_add.
  rewrite Z.add_mod_idemp_l by lia.
  f_equal; lia.
Qed.
