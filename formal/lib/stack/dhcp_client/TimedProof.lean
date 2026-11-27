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
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp_all [declaredTimers, rule_0]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_1]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_2]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_3]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_4]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_5]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_6]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_7]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_8]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_9]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_10]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_11]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_12]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_13]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_14]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_15]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_16]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_17]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_18]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_19]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_20]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))
  · simp_all [declaredTimers, rule_21]; all_goals (try (rcases arm with ⟨rfl, _⟩ | ⟨rfl, _⟩ <;> decide))

private theorem targets_declared_checked : targets_declared := by
  intro r hr; rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp [declaredStates, rule_0]
  · simp [declaredStates, rule_1]
  · simp [declaredStates, rule_2]
  · simp [declaredStates, rule_3]
  · simp [declaredStates, rule_4]
  · simp [declaredStates, rule_5]
  · simp [declaredStates, rule_6]
  · simp [declaredStates, rule_7]
  · simp [declaredStates, rule_8]
  · simp [declaredStates, rule_9]
  · simp [declaredStates, rule_10]
  · simp [declaredStates, rule_11]
  · simp [declaredStates, rule_12]
  · simp [declaredStates, rule_13]
  · simp [declaredStates, rule_14]
  · simp [declaredStates, rule_15]
  · simp [declaredStates, rule_16]
  · simp [declaredStates, rule_17]
  · simp [declaredStates, rule_18]
  · simp [declaredStates, rule_19]
  · simp [declaredStates, rule_20]
  · simp [declaredStates, rule_21]

private theorem eval_inv (s : Snapshot) (h : invariantsHold model s = true) :
    0 ≤ s.values.integers 0 ∧ s.values.integers 0 ≤ 86400 ∧
    0 ≤ s.values.integers 1 ∧ s.values.integers 1 ≤ 5 ∧
    ((1 ∈ s.timers.map TimerEntry.timer) → s.state = 1 ∨ s.state = 2 ∨ s.state = 4 ∨ s.state = 5) ∧
    ((0 ∈ s.timers.map TimerEntry.timer) → s.state = 3 ∨ s.state = 4 ∨ s.state = 5) := by
  have hall : ∀ e ∈ model.invariants, TypedMachine.eval s zeroValues e = true := fun e he => List.all_eq_true.mp h e he
  have h1 := hall e21 (by rw [model_invariants]; simp)
  have h2 := hall e24 (by rw [model_invariants]; simp)
  have h3 := hall e33 (by rw [model_invariants]; simp)
  have h4 := hall e37 (by rw [model_invariants]; simp)
  simp only [TypedMachine.eval, context, e37, e36, e35, e34, e33, e32, e31, e30, e29, e28, e27, e26, e25, e24, e23, e16, e22, e12, e21, e20, e6, e19, e0, e18, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2 h3 h4
  refine ⟨of_decide_eq_true h1.1, of_decide_eq_true h1.2, of_decide_eq_true h2.1, of_decide_eq_true h2.2, ?_, ?_⟩
  · intro hm; rcases h3 with hnot | hor
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · rcases hor with hs0 | hs1 | hs2 | hs3
      · exact Or.inl (of_decide_eq_true hs0)
      · exact Or.inr (Or.inl (of_decide_eq_true hs1))
      · exact Or.inr (Or.inr (Or.inl (of_decide_eq_true hs2)))
      · exact Or.inr (Or.inr (Or.inr (of_decide_eq_true hs3)))
  · intro hm; rcases h4 with hnot | hor
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · rcases hor with hs0 | hs1 | hs2
      · exact Or.inl (of_decide_eq_true hs0)
      · exact Or.inr (Or.inl (of_decide_eq_true hs1))
      · exact Or.inr (Or.inr (of_decide_eq_true hs2))

private theorem inv_from_bounds (s : Snapshot)
    (hv0a : 0 ≤ s.values.integers 0) (hv0b : s.values.integers 0 ≤ 86400) (hv1a : 0 ≤ s.values.integers 1) (hv1b : s.values.integers 1 ≤ 5) (ht1 : (1 ∈ s.timers.map TimerEntry.timer) → s.state = 1 ∨ s.state = 2 ∨ s.state = 4 ∨ s.state = 5) (ht0 : (0 ∈ s.timers.map TimerEntry.timer) → s.state = 3 ∨ s.state = 4 ∨ s.state = 5) :
    invariantsHold model s = true := by
  rw [invariantsHold, List.all_eq_true]; intro inv hmem; rw [model_invariants] at hmem
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl | rfl | rfl
  · simp [TypedMachine.eval, context, e21, e20, e6, e19, e0, e18, TypedIR.eval, getValue, hv0a, hv0b]
  · simp [TypedMachine.eval, context, e24, e23, e16, e22, e0, e12, TypedIR.eval, getValue, hv1a, hv1b]
  · simp only [TypedMachine.eval, context, e33, e32, e31, e30, e29, e28, e27, e26, e25, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 1 ∈ s.timers.map TimerEntry.timer
    · rcases ht1 hm with hst | hst | hst | hst
      · exact Or.inr (Or.inl (decide_eq_true hst))
      · exact Or.inr (Or.inr (Or.inl (decide_eq_true hst)))
      · exact Or.inr (Or.inr (Or.inr (Or.inl (decide_eq_true hst))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (decide_eq_true hst))))
    · exact Or.inl (decide_eq_false hm)
  · simp only [TypedMachine.eval, context, e37, e36, e30, e29, e28, e35, e34, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 0 ∈ s.timers.map TimerEntry.timer
    · rcases ht0 hm with hst | hst | hst
      · exact Or.inr (Or.inl (decide_eq_true hst))
      · exact Or.inr (Or.inr (Or.inl (decide_eq_true hst)))
      · exact Or.inr (Or.inr (Or.inr (decide_eq_true hst)))
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
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s valid
  simp only [declaredTimers, List.mem_cons, List.mem_nil_iff, or_false] at known
  rcases known with heq | heq
  · have hact : 0 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, heq⟩
    rcases ht0 hact with hst | hst | hst
    · refine ⟨rule_4, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
      simp [rule_4, e1, TypedMachine.eval, TypedIR.eval]
    · refine ⟨rule_6, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
      simp [rule_6, e1, TypedMachine.eval, TypedIR.eval]
    · refine ⟨rule_8, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
      simp [rule_8, e1, TypedMachine.eval, TypedIR.eval]
  · have hact : 1 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, heq⟩
    rcases ht1 hact with hst | hst | hst | hst
    · by_cases hret : s.values.integers 1 ≤ 4
      · refine ⟨rule_9, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        simp [TypedMachine.eval, context, rule_9, e14, e13, e12, TypedIR.eval, getValue, hret]
      · refine ⟨rule_10, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq5 : s.values.integers 1 = 5 := by omega
        simp [TypedMachine.eval, context, rule_10, e17, e16, e12, TypedIR.eval, equalValue, getValue, heq5]
    · by_cases hret : s.values.integers 1 ≤ 4
      · refine ⟨rule_11, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        simp [TypedMachine.eval, context, rule_11, e14, e13, e12, TypedIR.eval, getValue, hret]
      · refine ⟨rule_12, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq5 : s.values.integers 1 = 5 := by omega
        simp [TypedMachine.eval, context, rule_12, e17, e16, e12, TypedIR.eval, equalValue, getValue, heq5]
    · by_cases hret : s.values.integers 1 ≤ 4
      · refine ⟨rule_13, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        simp [TypedMachine.eval, context, rule_13, e14, e13, e12, TypedIR.eval, getValue, hret]
      · refine ⟨rule_14, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq5 : s.values.integers 1 = 5 := by omega
        simp [TypedMachine.eval, context, rule_14, e17, e16, e12, TypedIR.eval, equalValue, getValue, heq5]
    · by_cases hret : s.values.integers 1 ≤ 4
      · refine ⟨rule_15, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        simp [TypedMachine.eval, context, rule_15, e14, e13, e12, TypedIR.eval, getValue, hret]
      · refine ⟨rule_16, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq5 : s.values.integers 1 = 5 := by omega
        simp [TypedMachine.eval, context, rule_16, e17, e16, e12, TypedIR.eval, equalValue, getValue, heq5]

private theorem pres_0 : FiringPreserves model rule_0 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_0]
  · intro hm
    simp only [rule_0, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 0 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 0 := hSrc; have hst := ht0 hm; omega)

private theorem pres_1 : FiringPreserves model rule_1 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_1]
  · intro hm
    simp only [rule_1, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 1 := hSrc; have hst := ht0 hm; omega)

private theorem pres_2 : FiringPreserves model rule_2 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_2, e8, e7, e6, e5, e4, e3, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_2, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro _; simp [rule_2]

private theorem pres_3 : FiringPreserves model rule_3 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_3, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_3, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)

private theorem pres_4 : FiringPreserves model rule_4 (some 0) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e9, e10, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e9, e10, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e9, e10, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e9, e10, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_4]
  · intro _; simp [rule_4]

private theorem pres_5 : FiringPreserves model rule_5 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_5, e8, e7, e6, e5, e4, e3, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_5, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro _; simp [rule_5]

private theorem pres_6 : FiringPreserves model rule_6 (some 0) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e11, e10, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e11, e10, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e11, e10, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e11, e10, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_6]
  · intro _; simp [rule_6]

private theorem pres_7 : FiringPreserves model rule_7 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_7, e8, e7, e6, e5, e4, e3, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e9, e3, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_7, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro _; simp [rule_7]

private theorem pres_8 : FiringPreserves model rule_8 (some 0) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_8, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_8, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_9 : FiringPreserves model rule_9 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_9, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_9]
  · intro hm
    simp only [rule_9, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 1 := hSrc; have hst := ht0 hm; omega)

private theorem pres_10 : FiringPreserves model rule_10 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_10, e17, e16, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_10, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_10, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 1 := hSrc; have hst := ht0 hm; omega)

private theorem pres_11 : FiringPreserves model rule_11 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_11, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_11]
  · intro hm
    simp only [rule_11, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)

private theorem pres_12 : FiringPreserves model rule_12 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_12, e17, e16, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_12, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_12, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)

private theorem pres_13 : FiringPreserves model rule_13 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_13, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_13]
  · intro _; simp [rule_13]

private theorem pres_14 : FiringPreserves model rule_14 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_14, e17, e16, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_14, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_14, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_15 : FiringPreserves model rule_15 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_15, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, e10, e15, e4, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro _; simp [rule_15]
  · intro _; simp [rule_15]

private theorem pres_16 : FiringPreserves model rule_16 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  simp only [rule_16, e17, e16, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_16, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_16, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_17 : FiringPreserves model rule_17 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_17, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_17, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 1 := hSrc; have hst := ht0 hm; omega)

private theorem pres_18 : FiringPreserves model rule_18 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_18, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_18, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht0 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; rcases ht0 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)

private theorem pres_19 : FiringPreserves model rule_19 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_19, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht1 hm2 with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 3 := hSrc; rcases ht1 hm with hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht1 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht1 hm; omega)
  · intro hm
    simp only [rule_19, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_20 : FiringPreserves model rule_20 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_20, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_20, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_21 : FiringPreserves model rule_21 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hv0a, hv0b, hv1a, hv1b, ht1, ht0⟩ := eval_inv s hInv
  try (have g0 := of_decide_eq_true hGuard.1; have g1 := of_decide_eq_true hGuard.2)
  try (have gs := of_decide_eq_true hGuard)
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; all_goals (simp only [Value] at *; omega)
  · intro hm
    simp only [rule_21, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_21, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n10] at hm
    all_goals first | exact False.elim hm | contradiction | omega

theorem preservation : Each (fun p => FiringPreserves model p.1 p.2) (rawChecks model declaredTimers) := by
  have exactCat : rawChecks model declaredTimers = rawCatalog := rfl
  rw [exactCat, rawCatalog]; repeat' constructor
  all_goals first | trivial | exact pres_0 | exact pres_1 | exact pres_2 | exact pres_3 | exact pres_4 | exact pres_5 | exact pres_6 | exact pres_7 | exact pres_8 | exact pres_9 | exact pres_10 | exact pres_11 | exact pres_12 | exact pres_13 | exact pres_14 | exact pres_15 | exact pres_16 | exact pres_17 | exact pres_18 | exact pres_19 | exact pres_20 | exact pres_21

private theorem conflict_disjoint : Each (ConflictFree model) (conflictChecks model) := by
  have exactCat : conflictChecks model = conflictCatalog := rfl
  rw [exactCat, conflictCatalog]; repeat' constructor
  · intro s _ _ l hl r hr d _; simp [conflictGroup_0] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_1] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_2] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_3] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_4] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_5] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_6] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_7] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_8] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_9, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_9, rule_10, e17, e16, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_9, rule_10, e17, e16, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_10, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_11, rule_12, e17, e16, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_11, rule_12, e17, e16, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_11, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_13, rule_14, e17, e16, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_13, rule_14, e17, e16, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_12, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_15, rule_16, e17, e16, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_15, rule_16, e17, e16, e14, e13, e12, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_13] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_14] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_15] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_16] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_17] at hl hr; rw [hl, hr] at d; exact (d rfl).elim

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers targets_declared_checked
    arms_declared_checked rule_ids_checked coverage_checked preservation conflict_disjoint

end TimedProof
