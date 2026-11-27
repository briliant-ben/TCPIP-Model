import Approved

namespace TimedProof
open Approved FormalSpecAgent TypedMachine TypedIR
open TypedContracts TypedFiringContracts BatchTotality TimedObligations

private theorem initial_valid_checked : TypedContracts.InitialValid model initial := by rfl

private theorem initial_declared_checked : TimerDomain.Declared declaredTimers initial := by
  intro entry member
  change entry ∈ ([] : List TimerEntry) at member
  simp at member

theorem initial : Approved.initial_admitted :=
  ⟨initial_valid_checked, by decide, initial_declared_checked, by rfl⟩

private theorem rule_ids_checked : rule_ids_unique := by unfold rule_ids_unique; decide

private theorem arms_declared_checked : arms_declared := by
  intro rule member timer delay arm
  rw [model_rules] at member
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at member
  rcases member with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp_all [declaredTimers, rule_0, rule_1, rule_2, rule_3, rule_4,
      rule_5, rule_6, rule_7, rule_8, rule_9]

private theorem targets_declared_checked : targets_declared := by
  intro rule member
  rw [model_rules] at member
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at member
  rcases member with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp [declaredStates, rule_0, rule_1, rule_2, rule_3, rule_4,
      rule_5, rule_6, rule_7, rule_8, rule_9]

private theorem eval_inv (s : Snapshot) (h : invariantsHold model s = true) :
    0 ≤ s.values.integers 0 ∧ s.values.integers 0 ≤ 64 ∧
    0 ≤ s.values.integers 1 ∧ s.values.integers 1 ≤ s.values.integers 0 ∧
    0 ≤ s.values.integers 2 ∧ s.values.integers 2 ≤ 32 ∧
    (s.values.integers 2 = 0 ∨ s.values.integers 1 = 0) ∧
    (s.state = 1 ∨ (s.values.integers 1 = 0 ∧ s.values.integers 2 = 0)) ∧
    ((0 ∈ s.timers.map TimerEntry.timer) → s.state = 1) := by
  have hall : ∀ e ∈ model.invariants, TypedMachine.eval s zeroValues e = true :=
    fun e he => List.all_eq_true.mp h e he
  have h1 := hall e36 (by rw [model_invariants]; simp)
  have h2 := hall e39 (by rw [model_invariants]; simp)
  have h3 := hall e42 (by rw [model_invariants]; simp)
  have h4 := hall e43 (by rw [model_invariants]; simp)
  have h5 := hall e46 (by rw [model_invariants]; simp)
  have h6 := hall e48 (by rw [model_invariants]; simp)
  simp only [TypedMachine.eval, context, e36, e34, e35, e39, e37, e38, e42, e40, e41, e43,
    e46, e44, e45, e48, e47, e10, e20, e0, e4, e28, e7, e11, e13, TypedIR.eval,
    equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2 h3 h4 h5 h6
  refine ⟨of_decide_eq_true h1.1, of_decide_eq_true h1.2,
    of_decide_eq_true h2.1, of_decide_eq_true h2.2,
    of_decide_eq_true h3.1, of_decide_eq_true h3.2, ?_, ?_, ?_⟩
  · exact h4.elim (fun a => Or.inl (of_decide_eq_true a)) (fun b => Or.inr (of_decide_eq_true b))
  · exact h5.elim (fun a => Or.inl (of_decide_eq_true a))
      (fun b => Or.inr ⟨of_decide_eq_true b.1, of_decide_eq_true b.2⟩)
  · intro hmem
    rcases h6 with hnot | hst
    · exact absurd (decide_eq_true hmem) (Bool.eq_false_iff.mp hnot)
    · exact of_decide_eq_true hst

private theorem coverage_checked : timer_coverage := by
  intro s _ valid entry inside known
  have id : entry.timer = 0 := List.mem_singleton.mp known
  have active : 0 ∈ s.timers.map TimerEntry.timer :=
    List.mem_map.mpr ⟨entry, inside, id⟩
  have inv := eval_inv s valid
  have atActive : s.state = 1 := inv.2.2.2.2.2.2.2.2 active
  have wNonneg : 0 ≤ s.values.integers 2 := inv.2.2.2.2.1
  by_cases hw : 1 ≤ s.values.integers 2
  · refine ⟨rule_7, ?_, atActive.symm, ?_, ?_⟩
    · rw [model_rules]; simp
    · rw [id]; rfl
    · simp [rule_7, e8, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue, hw]
  · have hw0 : s.values.integers 2 = 0 := by omega
    refine ⟨rule_8, ?_, atActive.symm, ?_, ?_⟩
    · rw [model_rules]; simp
    · rw [id]; rfl
    · simp [rule_8, e10, e7, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, hw0]

private theorem timer0_drop (s : Snapshot) :
    0 ∉ (cancelTimer s 0).timers.map TimerEntry.timer := by
  intro h
  obtain ⟨e, he, hid⟩ := List.mem_map.mp h
  have hf := (List.mem_filter.mp he).2
  simp [hid] at hf

private theorem arm_delay_pos (x : Int) (hx : 1 ≤ x) : ¬ min x 60000 ≤ 0 := by omega

private theorem inv_from_bounds (s : Snapshot)
    (hc0 : 0 ≤ s.values.integers 0) (hc64 : s.values.integers 0 ≤ 64)
    (hk0 : 0 ≤ s.values.integers 1) (hkc : s.values.integers 1 ≤ s.values.integers 0)
    (hw0 : 0 ≤ s.values.integers 2) (hw32 : s.values.integers 2 ≤ 32)
    (hwtok : s.values.integers 2 = 0 ∨ s.values.integers 1 = 0)
    (hst : s.state = 1 ∨ (s.values.integers 1 = 0 ∧ s.values.integers 2 = 0))
    (htmr : (0 ∈ s.timers.map TimerEntry.timer) → s.state = 1) :
    invariantsHold model s = true := by
  rw [invariantsHold, List.all_eq_true]
  intro inv hmem
  rw [model_invariants] at hmem
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl | rfl | rfl | rfl | rfl
  · simp [TypedMachine.eval, context, e36, e34, e35, e0, e4, e13, TypedIR.eval, getValue, hc0, hc64]
  · simp [TypedMachine.eval, context, e39, e37, e38, e0, e11, e13, TypedIR.eval, getValue, hk0, hkc]
  · simp [TypedMachine.eval, context, e42, e40, e41, e0, e7, e28, TypedIR.eval, getValue, hw0, hw32]
  · simp only [TypedMachine.eval, context, e43, e10, e20, e0, e7, e11, TypedIR.eval, equalValue, getValue, Bool.or_eq_true]
    exact hwtok.elim (fun h => Or.inl (decide_eq_true h)) (fun h => Or.inr (decide_eq_true h))
  · simp only [TypedMachine.eval, context, e46, e44, e45, e20, e10, e0, e7, e11, TypedIR.eval, equalValue, getValue, Bool.or_eq_true, Bool.and_eq_true]
    exact hst.elim (fun h => Or.inl (decide_eq_true h)) (fun h => Or.inr ⟨decide_eq_true h.1, decide_eq_true h.2⟩)
  · simp only [TypedMachine.eval, context, e48, e47, e44, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 0 ∈ s.timers.map TimerEntry.timer
    · exact Or.inr (decide_eq_true (htmr hm))
    · exact Or.inl (decide_eq_false hm)

private theorem preserves_rule (r : Rule) (fin : Option Nat) :
    (r = rule_0 ∧ fin = none) ∨ (r = rule_1 ∧ fin = none) ∨ (r = rule_2 ∧ fin = none) ∨
    (r = rule_3 ∧ fin = none) ∨ (r = rule_4 ∧ fin = none) ∨ (r = rule_5 ∧ fin = none) ∨
    (r = rule_6 ∧ fin = none) ∨ (r = rule_7 ∧ fin = some 0) ∨ (r = rule_8 ∧ fin = some 0) ∨
    (r = rule_9 ∧ fin = none) →
    FiringPreserves model r fin := by
  intro hr s f hInv hSrc hGuard
  obtain ⟨c0, c64, k0, kc, w0, w32, wtok, hst, htmr⟩ := eval_inv s hInv
  rcases hr with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ |
    ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · simp only [rule_0, e6, e3, e5, e1, e2, e4, TypedMachine.eval, context, TypedIR.eval,
      getValue, Bool.and_eq_true] at hSrc hGuard
    have hg1 : f.integers 0 ≥ 1 := of_decide_eq_true hGuard.1
    have hg2 : f.integers 0 ≤ 64 := of_decide_eq_true hGuard.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_0, withoutFiring, work, e1, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_0, withoutFiring, work, e1, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact hg2
    · simp [rule_0, withoutFiring, work, e0, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_0, withoutFiring, work, e1, e0, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_0, withoutFiring, work, e0, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_0, withoutFiring, work, e0, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_0, withoutFiring, work, e0, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_0, withoutFiring, work, rule_0]
    · intro _; simp [rule_0, withoutFiring, work]
  · simp only [rule_1, e8, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 2 ≥ 1 := of_decide_eq_true hGuard
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_1, withoutFiring, work, setValue, c0]
    · simp [rule_1, withoutFiring, work, setValue, c64]
    · simp [rule_1, withoutFiring, work, setValue, k0]
    · simp [rule_1, withoutFiring, work, setValue, kc]
    · simp [rule_1, withoutFiring, work, e9, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, e9, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, e9, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
      rcases wtok with hw0 | hk0
      · omega
      · exact Or.inr hk0
    · simp [rule_1]
    · intro _; simp [rule_1]
  · simp only [rule_2, e15, e10, e14, e7, e0, e12, e11, e2, e13,
      TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hSrc hGuard
    have hg1 : s.values.integers 2 = 0 := of_decide_eq_true hGuard.1
    have hg2 : s.values.integers 1 + 1 ≤ s.values.integers 0 := of_decide_eq_true hGuard.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_2, withoutFiring, work, setValue, c0]
    · simp [rule_2, withoutFiring, work, setValue, c64]
    · simp [rule_2, withoutFiring, work, e12, e11, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_2, withoutFiring, work, e12, e11, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact hg2
    · simp [rule_2, withoutFiring, work, setValue, w0]
    · simp [rule_2, withoutFiring, work, setValue, w32]
    · simp [rule_2, withoutFiring, work, setValue, hg1]
    · simp [rule_2]
    · intro _; simp [rule_2]
  · refine ⟨_, rfl, inv_from_bounds _ c0 c64 k0 kc w0 w32 wtok (Or.inl rfl) (fun _ => rfl)⟩
  · simp only [rule_4, e18, e11, e2, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 1 ≥ 1 := of_decide_eq_true hGuard
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_4, withoutFiring, work, setValue, c0]
    · simp [rule_4, withoutFiring, work, setValue, c64]
    · simp [rule_4, withoutFiring, work, e19, e11, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_4, withoutFiring, work, e19, e11, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_4, withoutFiring, work, setValue, w0]
    · simp [rule_4, withoutFiring, work, setValue, w32]
    · simp [rule_4, withoutFiring, work, setValue]
      rcases wtok with hw0 | hk0
      · exact Or.inl hw0
      · omega
    · simp [rule_4]
    · intro _; simp [rule_4]
  · simp only [rule_5, e24, e20, e23, e22, e3, e11, e0, e7, e21, e1, e2,
      TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hSrc hGuard
    have hg1 : s.values.integers 1 = 0 := of_decide_eq_true hGuard.1
    have hg2 : s.values.integers 2 ≤ 31 := of_decide_eq_true hGuard.2.1
    have hg3 : f.integers 0 ≥ 1 := of_decide_eq_true hGuard.2.2
    have hpos : ¬ min (f.integers 0) 60000 ≤ 0 := arm_delay_pos (f.integers 0) hg3
    let tr : Transition :=
      { after :=
          { values := setValue .integer 2 (s.values.integers 2 + 1) s.values
            state := 1
            now := s.now
            timers := s.timers.filter (fun te => te.timer != 0) ++
              [{ timer := 0, due := s.now + min (f.integers 0) 60000 }] }
        rule := 5, event := 2, fields := f,
        emitted := [{ name := 5, fields := [{ slot := 0, kind := .integer, value := s.values.integers 2 + 1 }] }] }
    refine ⟨tr, ?_, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [tr, candidate, rule_5, withoutFiring, work, armTimer, e27, e1, e26, e25, e7, e2,
        TypedMachine.eval, context, TypedIR.eval, getValue, setValue, hpos]
    · simpa [tr, setValue] using c0
    · simpa [tr, setValue] using c64
    · simpa [tr, setValue] using k0
    · simpa [tr, setValue] using kc
    · simp [tr, setValue]; omega
    · simp [tr, setValue]; omega
    · simpa [tr, setValue] using Or.inr hg1
    · exact Or.inl rfl
    · intro _; rfl
  · refine ⟨_, rfl, inv_from_bounds _ c0 c64 k0 kc w0 w32 wtok (Or.inl rfl) (fun _ => rfl)⟩
  · simp only [rule_7, e8, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 2 ≥ 1 := of_decide_eq_true hGuard
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_7, withoutFiring, cancelTimer, work, setValue, c0]
    · simp [rule_7, withoutFiring, cancelTimer, work, setValue, c64]
    · simp [rule_7, withoutFiring, cancelTimer, work, setValue, k0]
    · simp [rule_7, withoutFiring, cancelTimer, work, setValue, kc]
    · simp [rule_7, withoutFiring, cancelTimer, work, e9, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_7, withoutFiring, cancelTimer, work, e9, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_7, withoutFiring, cancelTimer, work, e9, e7, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
      rcases wtok with hw0 | hk0
      · omega
      · exact Or.inr hk0
    · simp [rule_7]
    · intro _; simp [rule_7]
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_8, withoutFiring, cancelTimer, work, c0]
    · simp [rule_8, withoutFiring, cancelTimer, work, c64]
    · simp [rule_8, withoutFiring, cancelTimer, work, k0]
    · simp [rule_8, withoutFiring, cancelTimer, work, kc]
    · simp [rule_8, withoutFiring, cancelTimer, work, w0]
    · simp [rule_8, withoutFiring, cancelTimer, work, w32]
    · simp [rule_8, withoutFiring, cancelTimer, work, wtok]
    · simp [rule_8]
    · intro _; simp [rule_8]
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_9, withoutFiring, cancelTimer, work, setValue, c0]
    · simp [rule_9, withoutFiring, cancelTimer, work, setValue, c64]
    · simp [rule_9, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_9, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue, c0]
    · simp [rule_9, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_9, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_9, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inr ⟨by simp [setValue, TypedMachine.eval, TypedIR.eval, e0], by simp [setValue, TypedMachine.eval, TypedIR.eval, e0]⟩
    · intro hm; exact absurd hm (timer0_drop s)

theorem preservation : Each (fun p => FiringPreserves model p.1 p.2)
    (rawChecks model declaredTimers) := by
  have exactCat : rawChecks model declaredTimers = rawCatalog := rfl
  rw [exactCat, rawCatalog]
  exact ⟨preserves_rule rule_0 none (Or.inl ⟨rfl, rfl⟩),
    preserves_rule rule_1 none (Or.inr (Or.inl ⟨rfl, rfl⟩)),
    preserves_rule rule_2 none (Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩))),
    preserves_rule rule_3 none (Or.inr (Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩)))),
    preserves_rule rule_4 none (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩))))),
    preserves_rule rule_5 none (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩)))))),
    preserves_rule rule_6 none (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩))))))),
    preserves_rule rule_7 (some 0) (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩)))))))),
    preserves_rule rule_8 (some 0) (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩))))))))),
    preserves_rule rule_9 none (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr ⟨rfl, rfl⟩))))))))),
    trivial⟩

private theorem conflict_disjoint : Each (ConflictFree model) (conflictChecks model) := by
  have exactCat : conflictChecks model = conflictCatalog := rfl
  rw [exactCat, conflictCatalog]
  refine ⟨?_, ?_, ?_, ?_, ?_, trivial⟩
  · intro s _ _ l hl r hr d _; simp [conflictGroup_0] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s fields _ l hl r hr d _
    simp only [conflictGroup_1, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_1, rule_2, e8, e15, e10, e14, e7, e2, e0, e12, e11, e13,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hw : s.values.integers 2 ≥ 1
      · have hne : s.values.integers 2 ≠ 0 := by omega
        exact Or.inr (Or.inl (decide_eq_false hne))
      · exact Or.inl (decide_eq_false hw)
    · simp only [rule_1, rule_3, e8, e17, e10, e16, e7, e2, e0, e11, e13,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hw : s.values.integers 2 ≥ 1
      · have hne : s.values.integers 2 ≠ 0 := by omega
        exact Or.inr (Or.inl (decide_eq_false hne))
      · exact Or.inl (decide_eq_false hw)
    · simp only [rule_1, rule_2, e8, e15, e10, e14, e7, e2, e0, e12, e11, e13,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hw : s.values.integers 2 ≥ 1
      · have hne : s.values.integers 2 ≠ 0 := by omega
        exact Or.inl (Or.inl (decide_eq_false hne))
      · exact Or.inr (decide_eq_false hw)
    · exact (d rfl).elim
    · simp only [rule_2, rule_3, e15, e17, e10, e14, e16, e7, e0, e12, e11, e2, e13,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hc : s.values.integers 1 = s.values.integers 0
      · have hn : ¬ (s.values.integers 1 + 1 ≤ s.values.integers 0) := by omega
        exact Or.inl (Or.inr (decide_eq_false hn))
      · exact Or.inr (Or.inr (decide_eq_false hc))
    · simp only [rule_1, rule_3, e8, e17, e10, e16, e7, e2, e0, e11, e13,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hw : s.values.integers 2 ≥ 1
      · have hne : s.values.integers 2 ≠ 0 := by omega
        exact Or.inl (Or.inl (decide_eq_false hne))
      · exact Or.inr (decide_eq_false hw)
    · simp only [rule_2, rule_3, e15, e17, e10, e14, e16, e7, e0, e12, e11, e2, e13,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hc : s.values.integers 1 = s.values.integers 0
      · have hn : ¬ (s.values.integers 1 + 1 ≤ s.values.integers 0) := by omega
        exact Or.inr (Or.inr (decide_eq_false hn))
      · exact Or.inl (Or.inr (decide_eq_false hc))
    · exact (d rfl).elim
  · intro s fields _ l hl r hr d _
    simp only [conflictGroup_2, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_4, rule_5, e18, e24, e20, e23, e22, e3, e11, e2, e0, e7, e21, e1,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hk : s.values.integers 1 ≥ 1
      · have hne : s.values.integers 1 ≠ 0 := by omega
        exact Or.inr (Or.inl (decide_eq_false hne))
      · exact Or.inl (decide_eq_false hk)
    · simp only [rule_4, rule_6, e18, e32, e20, e31, e29, e30, e11, e2, e0, e7, e28, e1,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hk : s.values.integers 1 ≥ 1
      · have hne : s.values.integers 1 ≠ 0 := by omega
        exact Or.inr (Or.inl (decide_eq_false hne))
      · exact Or.inl (decide_eq_false hk)
    · simp only [rule_4, rule_5, e18, e24, e20, e23, e22, e3, e11, e2, e0, e7, e21, e1,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hk : s.values.integers 1 ≥ 1
      · have hne : s.values.integers 1 ≠ 0 := by omega
        exact Or.inl (Or.inl (decide_eq_false hne))
      · exact Or.inr (decide_eq_false hk)
    · exact (d rfl).elim
    · simp only [rule_5, rule_6, e24, e32, e20, e23, e22, e3, e31, e29, e30, e11, e0, e7, e21, e28, e1, e2,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff, Bool.or_eq_false_iff]
      by_cases ht : fields.integers 0 ≥ 1
      · by_cases hw : s.values.integers 2 ≤ 31
        · have hn1 : s.values.integers 2 ≠ 32 := by omega
          have hn2 : ¬ (fields.integers 0 ≤ 0) := by omega
          exact Or.inr (Or.inr ⟨decide_eq_false hn1, decide_eq_false hn2⟩)
        · exact Or.inl (Or.inr (Or.inl (decide_eq_false hw)))
      · exact Or.inl (Or.inr (Or.inr (decide_eq_false ht)))
    · simp only [rule_4, rule_6, e18, e32, e20, e31, e29, e30, e11, e2, e0, e7, e28, e1,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hk : s.values.integers 1 ≥ 1
      · have hne : s.values.integers 1 ≠ 0 := by omega
        exact Or.inl (Or.inl (decide_eq_false hne))
      · exact Or.inr (decide_eq_false hk)
    · simp only [rule_5, rule_6, e24, e32, e20, e23, e22, e3, e31, e29, e30, e11, e0, e7, e21, e28, e1, e2,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff, Bool.or_eq_false_iff]
      by_cases ht : fields.integers 0 ≥ 1
      · by_cases hw : s.values.integers 2 ≤ 31
        · have hn1 : s.values.integers 2 ≠ 32 := by omega
          have hn2 : ¬ (fields.integers 0 ≤ 0) := by omega
          exact Or.inl (Or.inr ⟨decide_eq_false hn1, decide_eq_false hn2⟩)
        · exact Or.inr (Or.inr (Or.inl (decide_eq_false hw)))
      · exact Or.inr (Or.inr (Or.inr (decide_eq_false ht)))
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _
    simp only [conflictGroup_3, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_7, rule_8, e8, e10, e7, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases hw : s.values.integers 2 ≥ 1
      · have hne : s.values.integers 2 ≠ 0 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false hw)
    · simp only [rule_7, rule_8, e8, e10, e7, e2, e0, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases hw : s.values.integers 2 ≥ 1
      · have hne : s.values.integers 2 ≠ 0 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false hw)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_4] at hl hr; rw [hl, hr] at d; exact (d rfl).elim

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers targets_declared_checked
    arms_declared_checked rule_ids_checked coverage_checked preservation conflict_disjoint

end TimedProof
