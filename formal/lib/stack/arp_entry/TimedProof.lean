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
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp_all [declaredTimers, rule_0, rule_1, rule_2, rule_3, rule_4, rule_5, rule_6, rule_7,
      rule_8, rule_9, rule_10, rule_11, rule_12, rule_13, rule_14, rule_15, rule_16]

private theorem targets_declared_checked : targets_declared := by
  intro r hr; rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp [declaredStates, rule_0, rule_1, rule_2, rule_3, rule_4, rule_5, rule_6, rule_7,
      rule_8, rule_9, rule_10, rule_11, rule_12, rule_13, rule_14, rule_15, rule_16]

private theorem eval_inv (s : Snapshot) (h : invariantsHold model s = true) :
    0 ≤ s.values.integers 0 ∧ s.values.integers 0 ≤ 4 ∧
    0 ≤ s.values.integers 1 ∧ s.values.integers 1 ≤ 5 ∧
    0 ≤ s.values.integers 2 ∧ s.values.integers 2 ≤ 300 ∧
    ((s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0) ∨
     (s.state = 1 ∧ s.values.integers 1 ≥ 1) ∨
     ((s.state = 2 ∨ s.state = 3) ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0)) ∧
    ((1 ∈ s.timers.map TimerEntry.timer) → s.state = 1) ∧
    ((0 ∈ s.timers.map TimerEntry.timer) → (s.state = 2 ∨ s.state = 3)) := by
  have hall : ∀ e ∈ model.invariants, TypedMachine.eval s zeroValues e = true :=
    fun e he => List.all_eq_true.mp h e he
  have h1 := hall e20 (by rw [model_invariants]; simp)
  have h2 := hall e23 (by rw [model_invariants]; simp)
  have h3 := hall e28 (by rw [model_invariants]; simp)
  have h4 := hall e42 (by rw [model_invariants]; simp)
  have h5 := hall e44 (by rw [model_invariants]; simp)
  have h6 := hall e46 (by rw [model_invariants]; simp)
  simp only [TypedMachine.eval, context, e20, e18, e19, e23, e21, e22, e28, e25, e27,
    e42, e33, e41, e36, e40, e29, e32, e30, e31, e34, e35, e39, e37, e38,
    e44, e43, e46, e45, e0, e2, e4, e8, e10, e13, e24, e26,
    TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2 h3 h4 h5 h6
  refine ⟨of_decide_eq_true h1.1, of_decide_eq_true h1.2,
    of_decide_eq_true h2.1, of_decide_eq_true h2.2,
    of_decide_eq_true h3.1, of_decide_eq_true h3.2, ?_, ?_, ?_⟩
  · rcases h4 with c0 | c1 | c2
    · exact Or.inl ⟨of_decide_eq_true c0.1, of_decide_eq_true c0.2.1, of_decide_eq_true c0.2.2⟩
    · exact Or.inr (Or.inl ⟨of_decide_eq_true c1.1, of_decide_eq_true c1.2⟩)
    · exact Or.inr (Or.inr ⟨c2.1.elim (fun a => Or.inl (of_decide_eq_true a)) (fun b => Or.inr (of_decide_eq_true b)),
        of_decide_eq_true c2.2.1, of_decide_eq_true c2.2.2⟩)
  · intro hm
    rcases h5 with hnot | hst
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · exact of_decide_eq_true hst
  · intro hm
    rcases h6 with hnot | hst
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · exact hst.elim (fun a => Or.inl (of_decide_eq_true a)) (fun b => Or.inr (of_decide_eq_true b))

private theorem inv_from_bounds (s : Snapshot)
    (hq0 : 0 ≤ s.values.integers 0) (hq4 : s.values.integers 0 ≤ 4)
    (hr0 : 0 ≤ s.values.integers 1) (hr5 : s.values.integers 1 ≤ 5)
    (ha0 : 0 ≤ s.values.integers 2) (ha300 : s.values.integers 2 ≤ 300)
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0) ∨
           (s.state = 1 ∧ s.values.integers 1 ≥ 1) ∨
           ((s.state = 2 ∨ s.state = 3) ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0))
    (ht1 : (1 ∈ s.timers.map TimerEntry.timer) → s.state = 1)
    (ht0 : (0 ∈ s.timers.map TimerEntry.timer) → (s.state = 2 ∨ s.state = 3)) :
    invariantsHold model s = true := by
  rw [invariantsHold, List.all_eq_true]
  intro inv hmem
  rw [model_invariants] at hmem
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl | rfl | rfl | rfl | rfl
  · simp [TypedMachine.eval, context, e20, e18, e19, e0, e4, e8, TypedIR.eval, getValue, hq0, hq4]
  · simp [TypedMachine.eval, context, e23, e21, e22, e0, e10, e13, TypedIR.eval, getValue, hr0, hr5]
  · simp [TypedMachine.eval, context, e28, e25, e27, e0, e24, e26, TypedIR.eval, getValue, ha0, ha300]
  · simp only [TypedMachine.eval, context, e42, e33, e41, e36, e40, e29, e32, e30, e31, e34, e35,
      e39, e37, e38, e4, e10, e0, e2, TypedIR.eval, equalValue, getValue, Bool.or_eq_true, Bool.and_eq_true]
    rcases hst with ⟨hs, hq, hr⟩ | ⟨hs, hr⟩ | ⟨hs, hq, hr⟩
    · exact Or.inl ⟨decide_eq_true hs, decide_eq_true hq, decide_eq_true hr⟩
    · exact Or.inr (Or.inl ⟨decide_eq_true hs, decide_eq_true hr⟩)
    · exact Or.inr (Or.inr ⟨hs.elim (fun h => Or.inl (decide_eq_true h)) (fun h => Or.inr (decide_eq_true h)),
        decide_eq_true hq, decide_eq_true hr⟩)
  · simp only [TypedMachine.eval, context, e44, e43, e34, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 1 ∈ s.timers.map TimerEntry.timer
    · exact Or.inr (decide_eq_true (ht1 hm))
    · exact Or.inl (decide_eq_false hm)
  · simp only [TypedMachine.eval, context, e46, e45, e39, e37, e38, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 0 ∈ s.timers.map TimerEntry.timer
    · exact Or.inr ((ht0 hm).elim (fun h => Or.inl (decide_eq_true h)) (fun h => Or.inr (decide_eq_true h)))
    · exact Or.inl (decide_eq_false hm)

private theorem coverage_checked : timer_coverage := by
  intro s _ valid entry inside known
  have inv := eval_inv s valid
  simp only [declaredTimers, List.mem_cons, List.not_mem_nil, or_false] at known
  rcases known with h0 | h1
  · have act0 : 0 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, h0⟩
    rcases inv.2.2.2.2.2.2.2.2 act0 with hs2 | hs3
    · refine ⟨rule_12, by rw [model_rules]; simp, hs2.symm, by rw [h0]; rfl, ?_⟩
      simp [rule_12, e1, TypedMachine.eval, TypedIR.eval]
    · refine ⟨rule_13, by rw [model_rules]; simp, hs3.symm, by rw [h0]; rfl, ?_⟩
      simp [rule_13, e1, TypedMachine.eval, TypedIR.eval]
  · have act1 : 1 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, h1⟩
    have hs1 : s.state = 1 := inv.2.2.2.2.2.2.2.1 act1
    have hr5 : s.values.integers 1 ≤ 5 := inv.2.2.2.1
    by_cases hr4 : s.values.integers 1 ≤ 4
    · refine ⟨rule_3, by rw [model_rules]; simp, hs1.symm, by rw [h1]; rfl, ?_⟩
      simp [rule_3, e11, e10, e8, TypedMachine.eval, context, TypedIR.eval, getValue, hr4]
    · have h5 : s.values.integers 1 = 5 := by omega
      refine ⟨rule_4, by rw [model_rules]; simp, hs1.symm, by rw [h1]; rfl, ?_⟩
      simp [rule_4, e14, e10, e13, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, h5]

private theorem drop_timer (t : Nat) (s : Snapshot) :
    t ∉ (cancelTimer s t).timers.map TimerEntry.timer := by
  intro h; obtain ⟨e, he, hid⟩ := List.mem_map.mp h
  have hf := (List.mem_filter.mp he).2; simp [hid] at hf

private theorem drop_timer_arm (k t : Nat) (d : Int) (s : Snapshot) (hne : k ≠ t)
    (hk : k ∉ s.timers.map TimerEntry.timer) :
    k ∉ (s.timers.filter (fun (te : TimerEntry) => te.timer != t) ++
         ([({ timer := t, due := d } : TimerEntry)])).map TimerEntry.timer := by
  intro h
  simp only [List.map_append, List.mem_append, List.map_cons, List.map_nil, List.mem_singleton] at h
  rcases h with hold | heq
  · obtain ⟨e, he, hid⟩ := List.mem_map.mp hold
    exact hk (List.mem_map.mpr ⟨e, (List.mem_filter.mp he).1, hid⟩)
  · exact hne heq

private theorem drop_filter_mem {k t : Nat} {s : Snapshot}
    (hm : k ∈ (s.timers.filter (fun (te : TimerEntry) => te.timer != t)).map TimerEntry.timer) :
    k ∈ s.timers.map TimerEntry.timer := by
  obtain ⟨e, he, hid⟩ := List.mem_map.mp hm
  exact List.mem_map.mpr ⟨e, (List.mem_filter.mp he).1, hid⟩

private theorem s1_ret {s : Snapshot}
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0) ∨
           (s.state = 1 ∧ s.values.integers 1 ≥ 1) ∨
           ((s.state = 2 ∨ s.state = 3) ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0))
    (hs : s.state = 1) : s.values.integers 1 ≥ 1 := by
  rcases hst with ⟨h, _⟩ | ⟨_, hr⟩ | ⟨h, _⟩
  · omega
  · exact hr
  · rcases h with h | h <;> omega

private theorem s23_zeros {s : Snapshot}
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0) ∨
           (s.state = 1 ∧ s.values.integers 1 ≥ 1) ∨
           ((s.state = 2 ∨ s.state = 3) ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0))
    (hs : s.state = 2 ∨ s.state = 3) :
    s.values.integers 0 = 0 ∧ s.values.integers 1 = 0 := by
  rcases hst with ⟨h, _⟩ | ⟨h, _⟩ | ⟨_, hq, hr⟩
  · rcases hs with k | k <;> omega
  · rcases hs with k | k <;> omega
  · exact ⟨hq, hr⟩

private theorem preserves_rule (r : Rule) (fin : Option Nat) :
    (r, fin) ∈ rawCatalog → FiringPreserves model r fin := by
  intro hr s f hInv hSrc hGuard
  obtain ⟨q0, q4, r0, r5, a0, a300, hst, ht1, ht0⟩ := eval_inv s hInv
  simp only [rawCatalog, List.mem_cons, List.not_mem_nil, or_false, Prod.mk.injEq] at hr
  rcases hr with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ |
    ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ |
    ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · have hs0 : s.state = 0 := hSrc
    have no0 : 0 ∉ s.timers.map TimerEntry.timer := fun hm => by rcases ht0 hm with h | h <;> omega
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_0, withoutFiring, work, armTimer, e3, e2, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e3, e2, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e3, e2, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e3, e2, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e3, e2, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e3, e2, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inl ⟨by simp [rule_0], by simp [rule_0, withoutFiring, work, armTimer, e3, e2, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩)
    · intro _; simp [rule_0]
    · intro hm; simp only [rule_0, withoutFiring, work, armTimer, e3, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 0 1 _ s (by decide) no0)
  · simp only [rule_1, e6, e4, e5, TypedMachine.eval, context, TypedIR.eval, getValue] at hGuard
    have hg : s.values.integers 0 ≤ 3 := of_decide_eq_true hGuard
    have hr1 := s1_ret hst hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_1, withoutFiring, work, e7, e4, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, e7, e4, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, setValue, r0]
    · simp [rule_1, withoutFiring, work, setValue, r5]
    · simp [rule_1, withoutFiring, work, setValue, a0]
    · simp [rule_1, withoutFiring, work, setValue, a300]
    · exact Or.inr (Or.inl ⟨by simp [rule_1], by simp [rule_1, withoutFiring, work, setValue, hr1]⟩)
    · intro _; simp [rule_1]
    · intro hm; simp only [rule_1, withoutFiring, work] at hm
      rcases ht0 hm with h | h <;> omega
  · have hr1 := s1_ret hst hSrc
    refine ⟨_, rfl, inv_from_bounds _ q0 q4 r0 r5 a0 a300 (Or.inr (Or.inl ⟨rfl, hr1⟩)) (fun _ => rfl)
      (fun hm => by rcases ht0 hm with h | h <;> omega)⟩
  · simp only [rule_3, e11, e10, e8, TypedMachine.eval, context, TypedIR.eval, getValue] at hGuard
    have hs1 : s.state = 1 := hSrc
    have hg : s.values.integers 1 ≤ 4 := of_decide_eq_true hGuard
    have no0 : 0 ∉ (cancelTimer s 1).timers.map TimerEntry.timer := fun hm => by
      have h' := ht0 (drop_filter_mem hm); rcases h' with h | h <;> omega
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_3, withoutFiring, cancelTimer, work, armTimer, e12, e10, e2, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue, q0]
    · simp [rule_3, withoutFiring, cancelTimer, work, armTimer, e12, e10, e2, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue, q4]
    · simp [rule_3, withoutFiring, cancelTimer, work, armTimer, e12, e10, e2, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_3, withoutFiring, cancelTimer, work, armTimer, e12, e10, e2, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_3, withoutFiring, cancelTimer, work, armTimer, e12, e10, e2, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue, a0]
    · simp [rule_3, withoutFiring, cancelTimer, work, armTimer, e12, e10, e2, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue, a300]
    · refine Or.inr (Or.inl ⟨by simp [rule_3], ?_⟩)
      simp [rule_3, withoutFiring, cancelTimer, work, armTimer, e12, e10, e2, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · intro _; simp [rule_3]
    · intro hm; simp only [rule_3, withoutFiring, cancelTimer, work, armTimer, e3, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 0 1 _ (cancelTimer s 1) (by decide) no0)
  · simp only [rule_4, e14, e10, e13, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue] at hGuard
    have hs1 : s.state = 1 := hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inl ⟨by simp [rule_4], by simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hm; simp only [rule_4, withoutFiring, work] at hm; exact absurd hm (drop_timer 1 s)
    · intro hm; simp only [rule_4, withoutFiring, cancelTimer, work] at hm
      rcases ht0 (drop_filter_mem hm) with h | h <;> omega
  · have no1 : 1 ∉ (cancelTimer s 1).timers.map TimerEntry.timer := drop_timer 1 s
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_5, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inr ⟨Or.inl (by simp [rule_5]), by simp [rule_5, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_5, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩)
    · intro hm; simp only [rule_5, withoutFiring, work, armTimer, e15, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 1 0 _ (cancelTimer s 1) (by decide) no1)
    · intro _; exact Or.inl (by simp [rule_5])
  · have hs2 : s.state = 2 := hSrc
    have no1 : 1 ∉ s.timers.map TimerEntry.timer := fun hm => by have h := ht1 hm; omega
    have hqz := s23_zeros hst (Or.inl hs2)
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_6, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, q0]
    · simp [rule_6, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, q4]
    · simp [rule_6, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, r0]
    · simp [rule_6, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, r5]
    · simp [rule_6, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_6, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inr ⟨Or.inl (by simp [rule_6]), by simp [rule_6, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, hqz.1],
        by simp [rule_6, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, hqz.2]⟩)
    · intro hm; simp only [rule_6, withoutFiring, work, armTimer, e15, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 1 0 _ s (by decide) no1)
    · intro _; exact Or.inl (by simp [rule_6])
  · have hs3 : s.state = 3 := hSrc
    have no1 : 1 ∉ s.timers.map TimerEntry.timer := fun hm => by have h := ht1 hm; omega
    have hqz := s23_zeros hst (Or.inr hs3)
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_7, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, q0]
    · simp [rule_7, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, q4]
    · simp [rule_7, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, r0]
    · simp [rule_7, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, r5]
    · simp [rule_7, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_7, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inr ⟨Or.inl (by simp [rule_7]), by simp [rule_7, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, hqz.1],
        by simp [rule_7, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, hqz.2]⟩)
    · intro hm; simp only [rule_7, withoutFiring, work, armTimer, e15, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 1 0 _ s (by decide) no1)
    · intro _; exact Or.inl (by simp [rule_7])
  · have hs0 : s.state = 0 := hSrc
    have no1 : 1 ∉ s.timers.map TimerEntry.timer := fun hm => by have h := ht1 hm; omega
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_8, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_8, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_8, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_8, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_8, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_8, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inr ⟨Or.inl (by simp [rule_8]), by simp [rule_8, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_8, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩)
    · intro hm; simp only [rule_8, withoutFiring, work, armTimer, e15, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 1 0 _ s (by decide) no1)
    · intro _; exact Or.inl (by simp [rule_8])
  · have no1 : 1 ∉ (cancelTimer s 1).timers.map TimerEntry.timer := drop_timer 1 s
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_9, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_9, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_9, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_9, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_9, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_9, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inr ⟨Or.inl (by simp [rule_9]), by simp [rule_9, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_9, withoutFiring, cancelTimer, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩)
    · intro hm; simp only [rule_9, withoutFiring, work, armTimer, e15, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 1 0 _ (cancelTimer s 1) (by decide) no1)
    · intro _; exact Or.inl (by simp [rule_9])
  · have hs2 : s.state = 2 := hSrc
    have no1 : 1 ∉ s.timers.map TimerEntry.timer := fun hm => by have h := ht1 hm; omega
    have hqz := s23_zeros hst (Or.inl hs2)
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_10, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, q0]
    · simp [rule_10, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, q4]
    · simp [rule_10, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, r0]
    · simp [rule_10, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, r5]
    · simp [rule_10, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_10, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inr ⟨Or.inl (by simp [rule_10]), by simp [rule_10, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, hqz.1],
        by simp [rule_10, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, hqz.2]⟩)
    · intro hm; simp only [rule_10, withoutFiring, work, armTimer, e15, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 1 0 _ s (by decide) no1)
    · intro _; exact Or.inl (by simp [rule_10])
  · have hs3 : s.state = 3 := hSrc
    have no1 : 1 ∉ s.timers.map TimerEntry.timer := fun hm => by have h := ht1 hm; omega
    have hqz := s23_zeros hst (Or.inr hs3)
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_11, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, q0]
    · simp [rule_11, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, q4]
    · simp [rule_11, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, r0]
    · simp [rule_11, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, r5]
    · simp [rule_11, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_11, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inr ⟨Or.inl (by simp [rule_11]), by simp [rule_11, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, hqz.1],
        by simp [rule_11, withoutFiring, work, armTimer, e15, e0, TypedMachine.eval, TypedIR.eval, setValue, hqz.2]⟩)
    · intro hm; simp only [rule_11, withoutFiring, work, armTimer, e15, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 1 0 _ s (by decide) no1)
    · intro _; exact Or.inl (by simp [rule_11])
  · have hs2 : s.state = 2 := hSrc
    have hqz := s23_zeros hst (Or.inl hs2)
    have no1 : 1 ∉ (cancelTimer s 0).timers.map TimerEntry.timer := fun hm => by
      have h' := ht1 (drop_filter_mem hm); omega
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_12, withoutFiring, cancelTimer, work, armTimer, e16, e17, TypedMachine.eval, TypedIR.eval, setValue, q0]
    · simp [rule_12, withoutFiring, cancelTimer, work, armTimer, e16, e17, TypedMachine.eval, TypedIR.eval, setValue, q4]
    · simp [rule_12, withoutFiring, cancelTimer, work, armTimer, e16, e17, TypedMachine.eval, TypedIR.eval, setValue, r0]
    · simp [rule_12, withoutFiring, cancelTimer, work, armTimer, e16, e17, TypedMachine.eval, TypedIR.eval, setValue, r5]
    · simp [rule_12, withoutFiring, cancelTimer, work, armTimer, e16, e17, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_12, withoutFiring, cancelTimer, work, armTimer, e16, e17, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr (Or.inr ⟨Or.inr (by simp [rule_12]), by simp [rule_12, withoutFiring, cancelTimer, work, armTimer, e16, e17, TypedMachine.eval, TypedIR.eval, setValue, hqz.1],
        by simp [rule_12, withoutFiring, cancelTimer, work, armTimer, e16, e17, TypedMachine.eval, TypedIR.eval, setValue, hqz.2]⟩)
    · intro hm; simp only [rule_12, withoutFiring, cancelTimer, work, armTimer, e17, TypedMachine.eval, TypedIR.eval] at hm
      exact absurd hm (drop_timer_arm 1 0 _ (cancelTimer s 0) (by decide) no1)
    · intro _; exact Or.inr (by simp [rule_12])
  · have hs3 : s.state = 3 := hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_13, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_13, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_13, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_13, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_13, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_13, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inl ⟨by simp [rule_13], by simp [rule_13, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_13, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hm; simp only [rule_13, withoutFiring, cancelTimer, work] at hm
      have h' := ht1 (drop_filter_mem hm); omega
    · intro hm; simp only [rule_13, withoutFiring, work] at hm; exact absurd hm (drop_timer 0 s)
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_14, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_14, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_14, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_14, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_14, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_14, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inl ⟨by simp [rule_14], by simp [rule_14, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_14, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hm; simp only [rule_14, withoutFiring, cancelTimer, work] at hm
      exact absurd (drop_filter_mem hm) (drop_timer 1 s)
    · intro hm; simp only [rule_14, withoutFiring, work] at hm; exact absurd hm (drop_timer 0 (cancelTimer s 1))
  · have hs2 : s.state = 2 := hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_15, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_15, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_15, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_15, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_15, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_15, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inl ⟨by simp [rule_15], by simp [rule_15, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_15, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hm; simp only [rule_15, withoutFiring, cancelTimer, work] at hm
      have h' := ht1 (drop_filter_mem hm); omega
    · intro hm; simp only [rule_15, withoutFiring, work] at hm; exact absurd hm (drop_timer 0 s)
  · have hs3 : s.state = 3 := hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_16, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_16, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_16, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_16, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_16, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_16, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inl ⟨by simp [rule_16], by simp [rule_16, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_16, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hm; simp only [rule_16, withoutFiring, cancelTimer, work] at hm
      have h' := ht1 (drop_filter_mem hm); omega
    · intro hm; simp only [rule_16, withoutFiring, work] at hm; exact absurd hm (drop_timer 0 s)

theorem preservation : Each (fun p => FiringPreserves model p.1 p.2)
    (rawChecks model declaredTimers) := by
  have exactCat : rawChecks model declaredTimers = rawCatalog := rfl
  rw [exactCat, rawCatalog]
  repeat' constructor
  all_goals first
    | trivial
    | exact preserves_rule _ _ (by simp [rawCatalog])

private theorem conflict_disjoint : Each (ConflictFree model) (conflictChecks model) := by
  have exactCat : conflictChecks model = conflictCatalog := rfl
  rw [exactCat, conflictCatalog]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, trivial⟩
  · intro s _ _ l hl r hr d _; simp [conflictGroup_0] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _
    simp only [conflictGroup_1, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_1, rule_2, e6, e9, e4, e5, e8, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases hq : s.values.integers 0 ≤ 3
      · have hne : s.values.integers 0 ≠ 4 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false hq)
    · simp only [rule_1, rule_2, e6, e9, e4, e5, e8, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases hq : s.values.integers 0 ≤ 3
      · have hne : s.values.integers 0 ≠ 4 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false hq)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _
    simp only [conflictGroup_2, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_3, rule_4, e11, e14, e10, e8, e13, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases hr4 : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false hr4)
    · simp only [rule_3, rule_4, e11, e14, e10, e8, e13, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases hr4 : s.values.integers 1 ≤ 4
      · have hne : s.values.integers 1 ≠ 5 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false hr4)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_3] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_4] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_5] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_6] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_7] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_8] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_9] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_10] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_11] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_12] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_13] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_14] at hl hr; rw [hl, hr] at d; exact (d rfl).elim

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers targets_declared_checked
    arms_declared_checked rule_ids_checked coverage_checked preservation conflict_disjoint

end TimedProof
