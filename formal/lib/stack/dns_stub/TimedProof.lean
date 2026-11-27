import Approved

namespace TimedProof
open Approved FormalSpecAgent TypedMachine TypedIR
open TypedContracts TypedFiringContracts BatchTotality TimedObligations

private theorem initial_valid_checked : TypedContracts.InitialValid model initial := by rfl
private theorem initial_declared_checked : TimerDomain.Declared declaredTimers initial := by
  intro e m; change e ∈ ([] : List TimerEntry) at m; simp at m
theorem initial : Approved.initial_admitted :=
  ⟨initial_valid_checked, by decide, initial_declared_checked, by rfl⟩
private theorem rule_ids_checked : rule_ids_unique := by unfold rule_ids_unique; decide

private theorem arms_declared_checked : arms_declared := by
  intro r hr t d arm; rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp_all [declaredTimers, rule_0]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))
  · simp_all [declaredTimers, rule_1]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))
  · simp_all [declaredTimers, rule_2]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))
  · simp_all [declaredTimers, rule_3]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))
  · simp_all [declaredTimers, rule_4]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))
  · simp_all [declaredTimers, rule_5]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))
  · simp_all [declaredTimers, rule_6]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))
  · simp_all [declaredTimers, rule_7]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))
  · simp_all [declaredTimers, rule_8]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> simp))

private theorem targets_declared_checked : targets_declared := by
  intro r hr; rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp [declaredStates, rule_0]
  · simp [declaredStates, rule_1]
  · simp [declaredStates, rule_2]
  · simp [declaredStates, rule_3]
  · simp [declaredStates, rule_4]
  · simp [declaredStates, rule_5]
  · simp [declaredStates, rule_6]
  · simp [declaredStates, rule_7]
  · simp [declaredStates, rule_8]

private theorem eval_inv (s : Snapshot) (h : invariantsHold model s = true) :
    0 ≤ s.values.integers 0 ∧ s.values.integers 0 ≤ 8 ∧
    0 ≤ s.values.integers 1 ∧ s.values.integers 1 ≤ 3 ∧
    ((0 ∈ s.timers.map TimerEntry.timer) → s.state = 1) := by
  have hall : ∀ e ∈ model.invariants, TypedMachine.eval s zeroValues e = true := fun e he => List.all_eq_true.mp h e he
  have h1 := hall e18 (by rw [model_invariants]; simp)
  have h2 := hall e21 (by rw [model_invariants]; simp)
  have h3 := hall e24 (by rw [model_invariants]; simp)
  simp only [TypedMachine.eval, context, e24, e23, e22, e21, e20, e14, e19, e10, e18, e17, e8, e16, e0, e3, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2 h3
  refine ⟨of_decide_eq_true h1.1, of_decide_eq_true h1.2, of_decide_eq_true h2.1, of_decide_eq_true h2.2, ?_⟩
  · intro hm; rcases h3 with hnot | hor
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · exact of_decide_eq_true hor

private theorem inv_from_bounds (s : Snapshot)
    (hv0a : 0 ≤ s.values.integers 0) (hv0b : s.values.integers 0 ≤ 8) (hv1a : 0 ≤ s.values.integers 1) (hv1b : s.values.integers 1 ≤ 3) (ht0 : (0 ∈ s.timers.map TimerEntry.timer) → s.state = 1) :
    invariantsHold model s = true := by
  rw [invariantsHold, List.all_eq_true]; intro inv hmem; rw [model_invariants] at hmem
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl | rfl
  · simp [TypedMachine.eval, context, e18, e17, e8, e16, e0, e3, TypedIR.eval, getValue, hv0a, hv0b]
  · simp [TypedMachine.eval, context, e21, e20, e14, e19, e0, e10, TypedIR.eval, getValue, hv1a, hv1b]
  · simp only [TypedMachine.eval, context, e24, e23, e22, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 0 ∈ s.timers.map TimerEntry.timer
    · exact Or.inr (decide_eq_true (ht0 hm))
    · exact Or.inl (decide_eq_false hm)

private theorem mem_timer_filter_ne {ts : List TimerEntry} {t x : Nat} :
    x ∈ (ts.filter (fun te => te.timer != t)).map TimerEntry.timer ↔ (x ∈ ts.map TimerEntry.timer ∧ x ≠ t) := by
  constructor
  · intro h; obtain ⟨e, he, hid⟩ := List.mem_map.mp h
    obtain ⟨hes, hflt⟩ := List.mem_filter.mp he
    refine ⟨List.mem_map.mpr ⟨e, hes, hid⟩, ?_⟩
    intro hxt; subst hid; subst hxt; simp at hflt
  · rintro ⟨h, hne⟩; obtain ⟨e, he, hid⟩ := List.mem_map.mp h
    refine List.mem_map.mpr ⟨e, List.mem_filter.mpr ⟨he, ?_⟩, hid⟩
    simp [hid, hne]

private theorem mem_timer_append_singleton {ts : List TimerEntry} {e : TimerEntry} {x : Nat} :
    x ∈ (ts ++ [e]).map TimerEntry.timer ↔ (x = e.timer ∨ x ∈ ts.map TimerEntry.timer) := by
  simp only [List.map_append, List.map_cons, List.map_nil, List.mem_append, List.mem_cons,
    List.not_mem_nil, or_false]
  exact or_comm

private theorem n01 : (0 : Nat) ≠ 1 := by decide
private theorem n10 : (1 : Nat) ≠ 0 := by decide

private theorem coverage_checked : timer_coverage := by
  intro s _ valid entry inside known
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s valid
  simp only [declaredTimers, List.mem_cons, List.mem_nil_iff, or_false] at known
  have heq : entry.timer = 0 := known
  have hact : 0 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, heq⟩
  have hst := ht0 hact
  by_cases hret : s.values.integers 1 ≤ 2
  · refine ⟨rule_4, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
    simp [TypedMachine.eval, context, rule_4, e12, e11, e10, TypedIR.eval, getValue, hret]
  · refine ⟨rule_5, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
    have heq3 : s.values.integers 1 = 3 := by omega
    simp [TypedMachine.eval, context, rule_5, e15, e14, e10, TypedIR.eval, equalValue, getValue, heq3]

private theorem pres_0 : FiringPreserves model rule_0 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_0]

private theorem pres_1 : FiringPreserves model rule_1 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_1]

private theorem pres_2 : FiringPreserves model rule_2 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  simp only [rule_2, e5, e4, e3, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e7, e6, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e7, e6, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e7, e6, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e7, e6, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_2, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_3 : FiringPreserves model rule_3 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  simp only [rule_3, e9, e8, e3, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_3, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_4 : FiringPreserves model rule_4 (some 0) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  simp only [rule_4, e12, e11, e10, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e2, e13, e6, e10, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e2, e13, e6, e10, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e2, e13, e6, e10, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e2, e13, e6, e10, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_4]

private theorem pres_5 : FiringPreserves model rule_5 (some 0) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  simp only [rule_5, e15, e14, e10, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_5, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_6 : FiringPreserves model rule_6 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_6, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_7 : FiringPreserves model rule_7 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_7, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 0 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 0 := hSrc; have hst := ht0 hm; omega)

private theorem pres_8 : FiringPreserves model rule_8 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_8, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)

theorem preservation : Each (fun p => FiringPreserves model p.1 p.2) (rawChecks model declaredTimers) := by
  have exactCat : rawChecks model declaredTimers = rawCatalog := rfl
  rw [exactCat, rawCatalog]; repeat' constructor
  all_goals first | trivial | exact pres_0 | exact pres_1 | exact pres_2 | exact pres_3 | exact pres_4 | exact pres_5 | exact pres_6 | exact pres_7 | exact pres_8

private theorem conflict_disjoint : Each (ConflictFree model) (conflictChecks model) := by
  have exactCat : conflictChecks model = conflictCatalog := rfl
  rw [exactCat, conflictCatalog]; repeat' constructor
  · intro s _ _ l hl r hr d _; simp [conflictGroup_0] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_1] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_2, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_2, rule_3, e9, e8, e5, e4, e3, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 0 ≤ 7
      · have hne : s.values.integers 0 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_2, rule_3, e9, e8, e5, e4, e3, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 0 ≤ 7
      · have hne : s.values.integers 0 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_3, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_4, rule_5, e15, e14, e12, e11, e10, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 2
      · have hne : s.values.integers 1 ≠ 3 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_4, rule_5, e15, e14, e12, e11, e10, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 2
      · have hne : s.values.integers 1 ≠ 3 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_4] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_5] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_6] at hl hr; rw [hl, hr] at d; exact (d rfl).elim

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers targets_declared_checked
    arms_declared_checked rule_ids_checked coverage_checked preservation conflict_disjoint

end TimedProof
