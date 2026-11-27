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
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp [rule_0, rule_1, rule_2, rule_3, rule_4, rule_5, rule_6, rule_7,
      rule_8, rule_9, rule_10, rule_11, rule_12, rule_13, rule_14, rule_15] at arm

private theorem targets_declared_checked : targets_declared := by
  intro r hr; rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp [declaredStates, rule_0, rule_1, rule_2, rule_3, rule_4, rule_5, rule_6,
      rule_7, rule_8, rule_9, rule_10, rule_11, rule_12, rule_13, rule_14, rule_15]

private theorem coverage_checked : timer_coverage := by
  intro s _ _ _ _ known; simp [declaredTimers] at known

private theorem eval_inv (s : Snapshot) (h : invariantsHold model s = true) :
    (((s.state = 0 ∨ s.state = 1) ∧ s.values.booleans 2 = false) ∨
     ((s.state = 2 ∨ s.state = 3 ∨ s.state = 4) ∧ s.values.booleans 2 = true)) ∧
    (s.values.booleans 3 = true → s.state = 3) ∧
    0 ≤ s.values.integers 0 ∧ s.values.integers 0 ≤ 128 ∧
    0 ≤ s.values.integers 1 ∧ s.values.integers 1 ≤ 64 := by
  have hall : ∀ e ∈ model.invariants, TypedMachine.eval s zeroValues e = true :=
    fun e he => List.all_eq_true.mp h e he
  have h1 := hall e32 (by rw [model_invariants]; simp)
  have h2 := hall e34 (by rw [model_invariants]; simp)
  have h3 := hall e43 (by rw [model_invariants]; simp)
  simp only [TypedMachine.eval, context, e32, e25, e31, e22, e24, e30, e29, e20, e21, e23,
    e26, e27, e28, e34, e33, e43, e38, e42, e35, e37, e39, e41, e3, e8, e0, e36, e40,
    TypedIR.eval, getValue, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2 h3
  refine ⟨?_, ?_, of_decide_eq_true h3.1.1, of_decide_eq_true h3.1.2,
    of_decide_eq_true h3.2.1, of_decide_eq_true h3.2.2⟩
  · rcases h1 with c | c
    · exact Or.inl ⟨c.1.elim (fun a => Or.inl (of_decide_eq_true a)) (fun b => Or.inr (of_decide_eq_true b)), c.2⟩
    · refine Or.inr ⟨?_, c.2⟩
      rcases c.1 with a | b | b
      · exact Or.inl (of_decide_eq_true a)
      · exact Or.inr (Or.inl (of_decide_eq_true b))
      · exact Or.inr (Or.inr (of_decide_eq_true b))
  · intro hw
    rcases h2 with hnot | hst
    · rw [hw] at hnot; cases hnot
    · exact of_decide_eq_true hst

private theorem inv_from_bounds (s : Snapshot)
    (hbusy : ((s.state = 0 ∨ s.state = 1) ∧ s.values.booleans 2 = false) ∨
             ((s.state = 2 ∨ s.state = 3 ∨ s.state = 4) ∧ s.values.booleans 2 = true))
    (hrpc : s.values.booleans 3 = true → s.state = 3)
    (hx0 : 0 ≤ s.values.integers 0) (hx128 : s.values.integers 0 ≤ 128)
    (hp0 : 0 ≤ s.values.integers 1) (hp64 : s.values.integers 1 ≤ 64) :
    invariantsHold model s = true := by
  rw [invariantsHold, List.all_eq_true]
  intro inv hmem
  rw [model_invariants] at hmem
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl | rfl
  · simp only [TypedMachine.eval, context, e32, e25, e31, e22, e24, e30, e29, e20, e21, e23,
      e26, e27, e28, TypedIR.eval, getValue, Bool.or_eq_true, Bool.and_eq_true, Bool.not_eq_true']
    rcases hbusy with ⟨hs, hb⟩ | ⟨hs, hb⟩
    · refine Or.inl ⟨hs.elim (fun h => Or.inl (decide_eq_true h)) (fun h => Or.inr (decide_eq_true h)), hb⟩
    · rcases hs with h | h | h
      · exact Or.inr ⟨Or.inl (decide_eq_true h), hb⟩
      · exact Or.inr ⟨Or.inr (Or.inl (decide_eq_true h)), hb⟩
      · exact Or.inr ⟨Or.inr (Or.inr (decide_eq_true h)), hb⟩
  · simp only [TypedMachine.eval, context, e34, e33, e27, TypedIR.eval, getValue, Bool.or_eq_true, Bool.not_eq_true']
    cases hw : s.values.booleans 3
    · exact Or.inl rfl
    · exact Or.inr (decide_eq_true (hrpc hw))
  · simp [TypedMachine.eval, context, e43, e38, e42, e35, e37, e39, e41, e3, e8, e0, e36, e40,
      TypedIR.eval, getValue, hx0, hx128, hp0, hp64]

private theorem idle_bool {s : Snapshot}
    (hb : ((s.state = 0 ∨ s.state = 1) ∧ s.values.booleans 2 = false) ∨
          ((s.state = 2 ∨ s.state = 3 ∨ s.state = 4) ∧ s.values.booleans 2 = true))
    (hs : s.state = 1) : s.values.booleans 2 = false := by
  rcases hb with ⟨_, h⟩ | ⟨h, _⟩
  · exact h
  · rcases h with h | h | h <;> omega

private theorem busy_bool {s : Snapshot}
    (hb : ((s.state = 0 ∨ s.state = 1) ∧ s.values.booleans 2 = false) ∨
          ((s.state = 2 ∨ s.state = 3 ∨ s.state = 4) ∧ s.values.booleans 2 = true))
    (hs : s.state = 2 ∨ s.state = 3 ∨ s.state = 4) : s.values.booleans 2 = true := by
  rcases hb with ⟨h, _⟩ | ⟨_, hb⟩
  · rcases h with h | h <;> rcases hs with k | k | k <;> omega
  · exact hb

private theorem preserves_rule (r : Rule) : r ∈ model.rules → FiringPreserves model r none := by
  intro hr s f hInv hSrc hGuard
  obtain ⟨hbusy, hrpc, hx0, hx128, hp0, hp64⟩ := eval_inv s hInv
  rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inl ⟨Or.inr (by simp [rule_0]), by simp [rule_0, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hb; simp [rule_0, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue] at hb
    · simp [rule_0, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_0, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_0, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_0, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
  · simp only [rule_1, e5, e3, e4, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 0 ≤ 127 := of_decide_eq_true hGuard
    have hb := idle_bool hbusy hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inl ⟨Or.inr (by simp [rule_1]), by simp [rule_1, withoutFiring, work, setValue, hb]⟩
    · intro h3; simp [rule_1, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · simp [rule_1, withoutFiring, work, e7, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, e7, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, setValue, hp0]
    · simp [rule_1, withoutFiring, work, setValue, hp64]
  · simp only [rule_2, e5, e3, e4, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 0 ≤ 127 := of_decide_eq_true hGuard
    have hb := busy_bool hbusy (Or.inl hSrc)
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inl (by simp [rule_2]), by simp [rule_2, withoutFiring, work, setValue, hb]⟩
    · intro h3; simp [rule_2, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · simp [rule_2, withoutFiring, work, e7, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_2, withoutFiring, work, e7, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_2, withoutFiring, work, setValue, hp0]
    · simp [rule_2, withoutFiring, work, setValue, hp64]
  · simp only [rule_3, e5, e3, e4, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 0 ≤ 127 := of_decide_eq_true hGuard
    have hb := busy_bool hbusy (Or.inr (Or.inl hSrc))
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inr (Or.inl (by simp [rule_3])), by simp [rule_3, withoutFiring, work, setValue, hb]⟩
    · intro _; simp [rule_3]
    · simp [rule_3, withoutFiring, work, e7, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_3, withoutFiring, work, e7, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_3, withoutFiring, work, setValue, hp0]
    · simp [rule_3, withoutFiring, work, setValue, hp64]
  · simp only [rule_4, e5, e3, e4, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 0 ≤ 127 := of_decide_eq_true hGuard
    have hb := busy_bool hbusy (Or.inr (Or.inr hSrc))
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inr (Or.inr (by simp [rule_4])), by simp [rule_4, withoutFiring, work, setValue, hb]⟩
    · intro h3; simp [rule_4, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · simp [rule_4, withoutFiring, work, e7, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_4, withoutFiring, work, e7, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_4, withoutFiring, work, setValue, hp0]
    · simp [rule_4, withoutFiring, work, setValue, hp64]
  · simp only [rule_5, e10, e8, e9, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 1 ≤ 63 := of_decide_eq_true hGuard
    have hb := idle_bool hbusy hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inl ⟨Or.inr (by simp [rule_5]), by simp [rule_5, withoutFiring, work, setValue, hb]⟩
    · intro h3; simp [rule_5, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · simp [rule_5, withoutFiring, work, setValue, hx0]
    · simp [rule_5, withoutFiring, work, setValue, hx128]
    · simp [rule_5, withoutFiring, work, e11, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_5, withoutFiring, work, e11, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
  · simp only [rule_6, e10, e8, e9, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 1 ≤ 63 := of_decide_eq_true hGuard
    have hb := busy_bool hbusy (Or.inl hSrc)
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inl (by simp [rule_6]), by simp [rule_6, withoutFiring, work, setValue, hb]⟩
    · intro h3; simp [rule_6, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · simp [rule_6, withoutFiring, work, setValue, hx0]
    · simp [rule_6, withoutFiring, work, setValue, hx128]
    · simp [rule_6, withoutFiring, work, e11, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_6, withoutFiring, work, e11, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
  · simp only [rule_7, e10, e8, e9, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 1 ≤ 63 := of_decide_eq_true hGuard
    have hb := busy_bool hbusy (Or.inr (Or.inl hSrc))
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inr (Or.inl (by simp [rule_7])), by simp [rule_7, withoutFiring, work, setValue, hb]⟩
    · intro _; simp [rule_7]
    · simp [rule_7, withoutFiring, work, setValue, hx0]
    · simp [rule_7, withoutFiring, work, setValue, hx128]
    · simp [rule_7, withoutFiring, work, e11, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_7, withoutFiring, work, e11, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
  · simp only [rule_8, e10, e8, e9, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 1 ≤ 63 := of_decide_eq_true hGuard
    have hb := busy_bool hbusy (Or.inr (Or.inr hSrc))
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inr (Or.inr (by simp [rule_8])), by simp [rule_8, withoutFiring, work, setValue, hb]⟩
    · intro h3; simp [rule_8, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · simp [rule_8, withoutFiring, work, setValue, hx0]
    · simp [rule_8, withoutFiring, work, setValue, hx128]
    · simp [rule_8, withoutFiring, work, e11, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_8, withoutFiring, work, e11, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
  · simp only [rule_9, e12, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 0 ≥ 1 := of_decide_eq_true hGuard
    have hs1 : s.state = 1 := hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inl (by simp [rule_9]), by simp [rule_9, withoutFiring, work, e2, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro h3; simp [rule_9, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · simp [rule_9, withoutFiring, work, e13, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_9, withoutFiring, work, e13, e3, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_9, withoutFiring, work, setValue, hp0]
    · simp [rule_9, withoutFiring, work, setValue, hp64]
  · simp only [rule_10, e16, e14, e15, e3, e8, e0, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hSrc hGuard
    have hg : s.values.integers 1 ≥ 1 := of_decide_eq_true hGuard.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inr (Or.inl (by simp [rule_10])), by simp [rule_10, withoutFiring, work, e2, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro _; simp [rule_10]
    · simp [rule_10, withoutFiring, work, setValue, hx0]
    · simp [rule_10, withoutFiring, work, setValue, hx128]
    · simp [rule_10, withoutFiring, work, e17, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_10, withoutFiring, work, e17, e8, e6, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
  · have hs1 : s.state = 1 := hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr ⟨Or.inr (Or.inr (by simp [rule_11])), by simp [rule_11, withoutFiring, work, e2, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro h3; simp [rule_11, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · exact hx0
    · exact hx128
    · exact hp0
    · exact hp64
  · have hs2 : s.state = 2 := hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inl ⟨Or.inr (by simp [rule_12]), by simp [rule_12, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro h3; simp [rule_12, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
    · exact hx0
    · exact hx128
    · exact hp0
    · exact hp64
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ hx0 hx128 hp0 hp64⟩
    · exact Or.inl ⟨Or.inr (by simp [rule_13]), by simp [rule_13, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro h3; simp [rule_13, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue] at h3
  · have hs4 : s.state = 4 := hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ hx0 hx128 hp0 hp64⟩
    · exact Or.inl ⟨Or.inr (by simp [rule_14]), by simp [rule_14, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro h3; simp [rule_14, withoutFiring, work, setValue] at h3; have h3' := hrpc h3; omega
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ hx0 hx128 hp0 hp64⟩
    · exact Or.inl ⟨Or.inl (by simp [rule_15]), by simp [rule_15, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro h3; simp [rule_15, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue] at h3

theorem preservation : Each (fun p => FiringPreserves model p.1 p.2)
    (rawChecks model declaredTimers) := by
  have exactCat : rawChecks model declaredTimers = rawCatalog := rfl
  rw [exactCat, rawCatalog]
  exact ⟨preserves_rule rule_0 (by rw [model_rules]; simp),
    preserves_rule rule_1 (by rw [model_rules]; simp),
    preserves_rule rule_2 (by rw [model_rules]; simp),
    preserves_rule rule_3 (by rw [model_rules]; simp),
    preserves_rule rule_4 (by rw [model_rules]; simp),
    preserves_rule rule_5 (by rw [model_rules]; simp),
    preserves_rule rule_6 (by rw [model_rules]; simp),
    preserves_rule rule_7 (by rw [model_rules]; simp),
    preserves_rule rule_8 (by rw [model_rules]; simp),
    preserves_rule rule_9 (by rw [model_rules]; simp),
    preserves_rule rule_10 (by rw [model_rules]; simp),
    preserves_rule rule_11 (by rw [model_rules]; simp),
    preserves_rule rule_12 (by rw [model_rules]; simp),
    preserves_rule rule_13 (by rw [model_rules]; simp),
    preserves_rule rule_14 (by rw [model_rules]; simp),
    preserves_rule rule_15 (by rw [model_rules]; simp),
    trivial⟩

private theorem conflict_disjoint : Each (ConflictFree model) (conflictChecks model) := by
  have exactCat : conflictChecks model = conflictCatalog := rfl
  rw [exactCat, conflictCatalog]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, trivial⟩
  · intro s _ _ l hl r hr d _; simp [conflictGroup_0] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_1] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_2] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_3] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_4] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_5] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_6] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_7] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_8] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _
    simp only [conflictGroup_9, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_9, rule_10, e12, e16, e14, e15, e3, e8, e0, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.and_eq_false_iff]
      by_cases hx : s.values.integers 0 ≥ 1
      · have hne : s.values.integers 0 ≠ 0 := by omega
        exact Or.inr (Or.inl (decide_eq_false hne))
      · exact Or.inl (decide_eq_false hx)
    · simp only [rule_9, rule_11, e12, e19, e14, e18, e3, e8, e0, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.and_eq_false_iff]
      by_cases hx : s.values.integers 0 ≥ 1
      · have hne : s.values.integers 0 ≠ 0 := by omega
        exact Or.inr (Or.inl (decide_eq_false hne))
      · exact Or.inl (decide_eq_false hx)
    · simp only [rule_9, rule_10, e12, e16, e14, e15, e3, e8, e0, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.and_eq_false_iff]
      by_cases hx : s.values.integers 0 ≥ 1
      · have hne : s.values.integers 0 ≠ 0 := by omega
        exact Or.inl (Or.inl (decide_eq_false hne))
      · exact Or.inr (decide_eq_false hx)
    · exact (d rfl).elim
    · simp only [rule_10, rule_11, e16, e19, e14, e15, e18, e3, e8, e0, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.and_eq_false_iff]
      by_cases hp : s.values.integers 1 ≥ 1
      · have hne : s.values.integers 1 ≠ 0 := by omega
        exact Or.inr (Or.inr (decide_eq_false hne))
      · exact Or.inl (Or.inr (decide_eq_false hp))
    · simp only [rule_9, rule_11, e12, e19, e14, e18, e3, e8, e0, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.and_eq_false_iff]
      by_cases hx : s.values.integers 0 ≥ 1
      · have hne : s.values.integers 0 ≠ 0 := by omega
        exact Or.inl (Or.inl (decide_eq_false hne))
      · exact Or.inr (decide_eq_false hx)
    · simp only [rule_10, rule_11, e16, e19, e14, e15, e18, e3, e8, e0, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.and_eq_false_iff]
      by_cases hp : s.values.integers 1 ≥ 1
      · have hne : s.values.integers 1 ≠ 0 := by omega
        exact Or.inl (Or.inr (decide_eq_false hne))
      · exact Or.inr (Or.inr (decide_eq_false hp))
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_10] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_11] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_12] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_13] at hl hr; rw [hl, hr] at d; exact (d rfl).elim

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers targets_declared_checked
    arms_declared_checked rule_ids_checked coverage_checked preservation conflict_disjoint

end TimedProof
