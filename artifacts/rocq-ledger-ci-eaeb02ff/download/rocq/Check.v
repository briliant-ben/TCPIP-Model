From Stdlib Require Import List ZArith.
From ProtocolIR Require Import IRPrimitives.
Import ListNotations.

(* Frozen statements: changes to this file change the proof claim and must
   be reviewed independently of proposed proof bodies. *)
Theorem checked_concat_length : forall (A : Type) (xs ys : list A),
  length (xs ++ ys) = (length xs + length ys)%nat.
Proof. exact concat_length. Qed.
Print Assumptions checked_concat_length.

Theorem checked_slice_length : forall (A : Type) (xs : list A) (offset count : Z),
  length (ir_slice xs offset count) =
  Nat.min (Z.to_nat count) (length xs - Z.to_nat offset).
Proof. exact slice_length. Qed.
Print Assumptions checked_slice_length.

Theorem checked_consume_content : forall (A : Type) (xs : list A) (n : nat),
  firstn n xs ++ skipn n xs = xs.
Proof. exact consume_preserves_content. Qed.
Print Assumptions checked_consume_content.

Theorem checked_negative_count : forall (A : Type) (xs : list A) (offset count : Z),
  (count <= 0)%Z -> ir_slice xs offset count = [].
Proof. exact negative_slice_count. Qed.
Print Assumptions checked_negative_count.

Theorem checked_seq_range : forall (a n : Z),
  (0 <= ir_seq_add a n < 4294967296)%Z.
Proof. exact seq_add_range. Qed.
Print Assumptions checked_seq_range.

Theorem checked_seq_compose : forall (a n m : Z),
  ir_seq_add (ir_seq_add a n) m = ir_seq_add a (n + m).
Proof. exact seq_add_compose. Qed.
Print Assumptions checked_seq_compose.
