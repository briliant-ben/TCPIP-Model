From Stdlib Require Import ZArith Lia.
Open Scope Z_scope.

(* Abstract integer accounting only. No TCP transition relation or Python bridge. *)
Definition deferred_credit (unacked partial_prefix : Z) : Z :=
  unacked + partial_prefix.

Theorem callback_credit_bound : forall (unacked partial_prefix released : Z),
  0 <= unacked <= 16 -> 0 <= partial_prefix <= 3 ->
  0 <= released -> released <= deferred_credit unacked partial_prefix ->
  0 <= released <= 19.
Proof. intros; unfold deferred_credit in *; lia. Qed.

Theorem callback_credit_bound_sharp : deferred_credit 16 3 = 19.
Proof. reflexivity. Qed.

Theorem original_record_mass : forall (emitted acked abandoned live new_bytes released dropped : Z),
  emitted = acked + abandoned + live ->
  emitted + new_bytes =
    (acked + released) + (abandoned + dropped) + (live - released - dropped + new_bytes).
Proof. intros; lia. Qed.

Theorem unsent_budget_transfer : forall (emitted pending written sent accepted : Z),
  emitted + pending <= written ->
  (emitted + sent) + (pending + accepted - sent) <= written + accepted.
Proof. intros; lia. Qed.

Theorem deferred_ack_credit : forall (callback partial_prefix tcp_ack delta released next_prefix : Z),
  callback + partial_prefix <= tcp_ack ->
  next_prefix = partial_prefix + delta - released ->
  (callback + released) + next_prefix <= tcp_ack + delta.
Proof. intros; lia. Qed.
