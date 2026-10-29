From Stdlib Require Import ZArith.
From SentLedger Require Import Ledger.
Open Scope Z_scope.

(* Review these frozen statements independently of proof bodies. *)
Theorem checked_callback_credit_bound : forall (unacked partial_prefix released : Z),
  0 <= unacked <= 16 -> 0 <= partial_prefix <= 3 ->
  0 <= released -> released <= deferred_credit unacked partial_prefix ->
  0 <= released <= 19.
Proof. exact callback_credit_bound. Qed.
Print Assumptions checked_callback_credit_bound.

Theorem checked_callback_credit_sharp : deferred_credit 16 3 = 19.
Proof. exact callback_credit_bound_sharp. Qed.
Print Assumptions checked_callback_credit_sharp.

Theorem checked_original_record_mass : forall (emitted acked abandoned live new_bytes released dropped : Z),
  emitted = acked + abandoned + live ->
  emitted + new_bytes =
    (acked + released) + (abandoned + dropped) + (live - released - dropped + new_bytes).
Proof. exact original_record_mass. Qed.
Print Assumptions checked_original_record_mass.

Theorem checked_deferred_ack_credit : forall (callback partial_prefix tcp_ack delta released next_prefix : Z),
  callback + partial_prefix <= tcp_ack ->
  next_prefix = partial_prefix + delta - released ->
  (callback + released) + next_prefix <= tcp_ack + delta.
Proof. exact deferred_ack_credit. Qed.
Print Assumptions checked_deferred_ack_credit.

Theorem checked_unsent_budget_transfer : forall (emitted pending written sent accepted : Z),
  emitted + pending <= written ->
  (emitted + sent) + (pending + accepted - sent) <= written + accepted.
Proof. exact unsent_budget_transfer. Qed.
Print Assumptions checked_unsent_budget_transfer.
