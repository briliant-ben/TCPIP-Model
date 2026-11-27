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
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp [rule_0, rule_1, rule_2, rule_3, rule_4, rule_5, rule_6, rule_7, rule_8,
      rule_9, rule_10, rule_11, rule_12] at arm

private theorem targets_declared_checked : targets_declared := by
  intro r hr; rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp [declaredStates, rule_0, rule_1, rule_2, rule_3, rule_4, rule_5, rule_6,
      rule_7, rule_8, rule_9, rule_10, rule_11, rule_12]

private theorem coverage_checked : timer_coverage := by
  intro s _ _ _ _ known; simp [declaredTimers] at known

private theorem eval_inv (s : Snapshot) (h : invariantsHold model s = true) :
    ((s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.booleans 4 = false) ∨
     (s.state = 1 ∧ s.values.integers 0 = 1 ∧ s.values.booleans 4 = false) ∨
     (s.state = 2 ∧ s.values.integers 0 ≥ 2 ∧ s.values.booleans 4 = false) ∨
     (s.state = 3 ∧ s.values.integers 0 ≥ 1 ∧ s.values.booleans 4 = true)) ∧
    0 ≤ s.values.integers 2 ∧ 0 ≤ s.values.integers 3 ∧
    s.values.integers 2 + s.values.integers 3 ≤ s.values.integers 1 ∧
    s.values.integers 1 ≤ 2048 := by
  have hall : ∀ e ∈ model.invariants, TypedMachine.eval s zeroValues e = true :=
    fun e he => List.all_eq_true.mp h e he
  have h1 := hall e58 (by rw [model_invariants]; simp)
  have h2 := hall e67 (by rw [model_invariants]; simp)
  simp only [TypedMachine.eval, context, e58, e57, e56, e45, e48, e51, e55,
    e40, e44, e41, e43, e42, e46, e47, e38, e49, e50, e39, e52, e54, e53,
    e67, e66, e65, e59, e60, e63, e64, e61, e62, e17, e18, e0, e3, e20, e5, e21,
    TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2
  refine ⟨?_, of_decide_eq_true h2.1, of_decide_eq_true h2.2.1,
    of_decide_eq_true h2.2.2.1, of_decide_eq_true h2.2.2.2⟩
  rcases h1 with c0 | c1 | c2 | c3
  · exact Or.inl ⟨of_decide_eq_true c0.1, of_decide_eq_true c0.2.1, c0.2.2⟩
  · exact Or.inr (Or.inl ⟨of_decide_eq_true c1.1, of_decide_eq_true c1.2.1, c1.2.2⟩)
  · exact Or.inr (Or.inr (Or.inl ⟨of_decide_eq_true c2.1, of_decide_eq_true c2.2.1, c2.2.2⟩))
  · exact Or.inr (Or.inr (Or.inr ⟨of_decide_eq_true c3.1, of_decide_eq_true c3.2.1, c3.2.2⟩))

private theorem inv_from_bounds (s : Snapshot)
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.booleans 4 = false) ∨
           (s.state = 1 ∧ s.values.integers 0 = 1 ∧ s.values.booleans 4 = false) ∨
           (s.state = 2 ∧ s.values.integers 0 ≥ 2 ∧ s.values.booleans 4 = false) ∨
           (s.state = 3 ∧ s.values.integers 0 ≥ 1 ∧ s.values.booleans 4 = true))
    (hh0 : 0 ≤ s.values.integers 2) (hp0 : 0 ≤ s.values.integers 3)
    (hle : s.values.integers 2 + s.values.integers 3 ≤ s.values.integers 1)
    (hmax : s.values.integers 1 ≤ 2048) :
    invariantsHold model s = true := by
  rw [invariantsHold, List.all_eq_true]
  intro inv hmem
  rw [model_invariants] at hmem
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl
  · simp only [TypedMachine.eval, context, e58, e57, e56, e45, e48, e51, e55,
      e40, e44, e41, e43, e42, e46, e47, e38, e49, e50, e39, e52, e54, e53,
      e21, e0, e3, e20, TypedIR.eval, equalValue, getValue, Bool.or_eq_true, Bool.and_eq_true, Bool.not_eq_true']
    rcases hst with ⟨hs, hr, hp⟩ | ⟨hs, hr, hp⟩ | ⟨hs, hr, hp⟩ | ⟨hs, hr, hp⟩
    · exact Or.inl ⟨decide_eq_true hs, decide_eq_true hr, hp⟩
    · exact Or.inr (Or.inl ⟨decide_eq_true hs, decide_eq_true hr, hp⟩)
    · exact Or.inr (Or.inr (Or.inl ⟨decide_eq_true hs, decide_eq_true hr, hp⟩))
    · exact Or.inr (Or.inr (Or.inr ⟨decide_eq_true hs, decide_eq_true hr, hp⟩))
  · simp [TypedMachine.eval, context, e67, e66, e65, e59, e60, e63, e64, e61, e62,
      e17, e18, e0, e5, TypedIR.eval, getValue, hh0, hp0, hle, hmax]

private theorem state1_facts {s : Snapshot}
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.booleans 4 = false) ∨
           (s.state = 1 ∧ s.values.integers 0 = 1 ∧ s.values.booleans 4 = false) ∨
           (s.state = 2 ∧ s.values.integers 0 ≥ 2 ∧ s.values.booleans 4 = false) ∨
           (s.state = 3 ∧ s.values.integers 0 ≥ 1 ∧ s.values.booleans 4 = true))
    (hs : s.state = 1) : s.values.integers 0 = 1 ∧ s.values.booleans 4 = false := by
  rcases hst with ⟨h, _⟩ | ⟨_, hr, hp⟩ | ⟨h, _⟩ | ⟨h, _⟩
  · omega
  · exact ⟨hr, hp⟩
  · omega
  · omega

private theorem state2_facts {s : Snapshot}
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.booleans 4 = false) ∨
           (s.state = 1 ∧ s.values.integers 0 = 1 ∧ s.values.booleans 4 = false) ∨
           (s.state = 2 ∧ s.values.integers 0 ≥ 2 ∧ s.values.booleans 4 = false) ∨
           (s.state = 3 ∧ s.values.integers 0 ≥ 1 ∧ s.values.booleans 4 = true))
    (hs : s.state = 2) : s.values.integers 0 ≥ 2 ∧ s.values.booleans 4 = false := by
  rcases hst with ⟨h, _⟩ | ⟨h, _⟩ | ⟨_, hr, hp⟩ | ⟨h, _⟩
  · omega
  · omega
  · exact ⟨hr, hp⟩
  · omega

private theorem state3_facts {s : Snapshot}
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.booleans 4 = false) ∨
           (s.state = 1 ∧ s.values.integers 0 = 1 ∧ s.values.booleans 4 = false) ∨
           (s.state = 2 ∧ s.values.integers 0 ≥ 2 ∧ s.values.booleans 4 = false) ∨
           (s.state = 3 ∧ s.values.integers 0 ≥ 1 ∧ s.values.booleans 4 = true))
    (hs : s.state = 3) : s.values.integers 0 ≥ 1 ∧ s.values.booleans 4 = true := by
  rcases hst with ⟨h, _⟩ | ⟨h, _⟩ | ⟨h, _⟩ | ⟨_, hr, hp⟩
  · omega
  · omega
  · omega
  · exact ⟨hr, hp⟩

private theorem preserves_rule (r : Rule) : r ∈ model.rules → FiringPreserves model r none := by
  intro hr s f hInv hSrc hGuard
  obtain ⟨hst, hh0, hp0, hle, hmax⟩ := eval_inv s hInv
  rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp only [rule_0, e16, e15, e14, e13, e4, e6, e8, e10, e12, e11, e2, e3, e5, e0, e7, e9,
      TypedMachine.eval, context, TypedIR.eval, getValue, Bool.and_eq_true] at hSrc hGuard
    have g2 : f.integers 0 ≤ 2048 := of_decide_eq_true hGuard.2.1
    have g3 : f.integers 1 ≥ 0 := of_decide_eq_true hGuard.2.2.1
    have g4 : f.integers 2 ≥ 0 := of_decide_eq_true hGuard.2.2.2.1
    have g5 : f.integers 1 + f.integers 2 ≤ f.integers 0 := of_decide_eq_true hGuard.2.2.2.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr (Or.inl ⟨by simp [rule_0],
        by simp [rule_0, withoutFiring, work, e3, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_0, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩)
    · simp [rule_0, withoutFiring, work, e7, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact g3
    · simp [rule_0, withoutFiring, work, e9, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact g4
    · simp [rule_0, withoutFiring, work, e2, e7, e9, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact g5
    · simp [rule_0, withoutFiring, work, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact g2
  · have hpin := (state1_facts hst hSrc).2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr (Or.inr (Or.inl ⟨by simp [rule_1],
        by simp [rule_1, withoutFiring, work, e20, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_1, withoutFiring, work, setValue, hpin]⟩))
    · simp [rule_1, withoutFiring, work, setValue, hh0]
    · simp [rule_1, withoutFiring, work, setValue, hp0]
    · simp [rule_1, withoutFiring, work, setValue, hle]
    · simp [rule_1, withoutFiring, work, setValue, hmax]
  · have href := state2_facts hst hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr (Or.inr (Or.inl ⟨by simp [rule_2],
        by simp [rule_2, withoutFiring, work, e24, e21, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega,
        by simp [rule_2, withoutFiring, work, setValue, href.2]⟩))
    · simp [rule_2, withoutFiring, work, setValue, hh0]
    · simp [rule_2, withoutFiring, work, setValue, hp0]
    · simp [rule_2, withoutFiring, work, setValue, hle]
    · simp [rule_2, withoutFiring, work, setValue, hmax]
  · have href := state3_facts hst hSrc
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr (Or.inr (Or.inr ⟨by simp [rule_3],
        by simp [rule_3, withoutFiring, work, e24, e21, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega,
        by simp [rule_3, withoutFiring, work, setValue, href.2]⟩))
    · simp [rule_3, withoutFiring, work, setValue, hh0]
    · simp [rule_3, withoutFiring, work, setValue, hp0]
    · simp [rule_3, withoutFiring, work, setValue, hle]
    · simp [rule_3, withoutFiring, work, setValue, hmax]
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inl ⟨by simp [rule_4],
        by simp [rule_4, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_4, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · simp [rule_4, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
  · have hpin := (state2_facts hst hSrc).2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr (Or.inl ⟨by simp [rule_5],
        by simp [rule_5, withoutFiring, work, e3, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_5, withoutFiring, work, setValue, hpin]⟩)
    · simp [rule_5, withoutFiring, work, setValue, hh0]
    · simp [rule_5, withoutFiring, work, setValue, hp0]
    · simp [rule_5, withoutFiring, work, setValue, hle]
    · simp [rule_5, withoutFiring, work, setValue, hmax]
  · simp only [rule_6, e27, e21, e26, TypedMachine.eval, context, TypedIR.eval, getValue] at hSrc hGuard
    have hg : s.values.integers 0 ≥ 3 := of_decide_eq_true hGuard
    have hpin := (state2_facts hst hSrc).2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr (Or.inr (Or.inl ⟨by simp [rule_6],
        by simp [rule_6, withoutFiring, work, e28, e21, e3, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega,
        by simp [rule_6, withoutFiring, work, setValue, hpin]⟩))
    · simp [rule_6, withoutFiring, work, setValue, hh0]
    · simp [rule_6, withoutFiring, work, setValue, hp0]
    · simp [rule_6, withoutFiring, work, setValue, hle]
    · simp [rule_6, withoutFiring, work, setValue, hmax]
  · simp only [rule_7, e31, e29, e30, e2, e0, e17, TypedMachine.eval, context, TypedIR.eval, getValue, Bool.and_eq_true] at hSrc hGuard
    have href := state1_facts hst hSrc
    have g1 : 0 ≤ f.integers 0 := of_decide_eq_true hGuard.1
    have g2 : f.integers 0 ≤ s.values.integers 2 := of_decide_eq_true hGuard.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr (Or.inl ⟨by simp [rule_7],
        by simp [rule_7, withoutFiring, work, setValue, href.1],
        by simp [rule_7, withoutFiring, work, setValue, href.2]⟩)
    · simp [rule_7, withoutFiring, work, e32, e17, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_7, withoutFiring, work, e33, e18, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_7, withoutFiring, work, e32, e33, e17, e18, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_7, withoutFiring, work, setValue, hmax]
  · simp only [rule_8, e35, e29, e34, e2, e0, e18, TypedMachine.eval, context, TypedIR.eval, getValue, Bool.and_eq_true] at hSrc hGuard
    have href := state1_facts hst hSrc
    have g1 : 0 ≤ f.integers 0 := of_decide_eq_true hGuard.1
    have g2 : f.integers 0 ≤ s.values.integers 3 := of_decide_eq_true hGuard.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_⟩
    · exact Or.inr (Or.inl ⟨by simp [rule_8],
        by simp [rule_8, withoutFiring, work, setValue, href.1],
        by simp [rule_8, withoutFiring, work, setValue, href.2]⟩)
    · simp [rule_8, withoutFiring, work, e36, e17, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_8, withoutFiring, work, e37, e18, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_8, withoutFiring, work, e36, e37, e17, e18, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_8, withoutFiring, work, setValue, hmax]
  · have hr1 : s.values.integers 0 = 1 := (state1_facts hst hSrc).1
    refine ⟨_, rfl, inv_from_bounds _ ?_ hh0 hp0 hle hmax⟩
    exact Or.inr (Or.inr (Or.inr ⟨by simp [rule_9],
      by simp [rule_9, withoutFiring, work, setValue, hr1],
      by simp [rule_9, withoutFiring, work, e19, TypedMachine.eval, TypedIR.eval, setValue]⟩))
  · have hr2 : s.values.integers 0 ≥ 2 := (state2_facts hst hSrc).1
    refine ⟨_, rfl, inv_from_bounds _ ?_ hh0 hp0 hle hmax⟩
    exact Or.inr (Or.inr (Or.inr ⟨by simp [rule_10],
      by simp [rule_10, withoutFiring, work, setValue]; omega,
      by simp [rule_10, withoutFiring, work, e19, TypedMachine.eval, TypedIR.eval, setValue]⟩))
  · simp only [rule_11, e38, e21, e3, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue] at hGuard
    have hg : s.values.integers 0 = 1 := of_decide_eq_true hGuard
    refine ⟨_, rfl, inv_from_bounds _ ?_ hh0 hp0 hle hmax⟩
    exact Or.inr (Or.inl ⟨by simp [rule_11],
      by simp [rule_11, withoutFiring, work, setValue, hg],
      by simp [rule_11, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩)
  · simp only [rule_12, e39, e21, e20, TypedMachine.eval, context, TypedIR.eval, getValue] at hGuard
    have hg : s.values.integers 0 ≥ 2 := of_decide_eq_true hGuard
    refine ⟨_, rfl, inv_from_bounds _ ?_ hh0 hp0 hle hmax⟩
    exact Or.inr (Or.inr (Or.inl ⟨by simp [rule_12],
      by simp [rule_12, withoutFiring, work, setValue, hg],
      by simp [rule_12, withoutFiring, work, e1, TypedMachine.eval, TypedIR.eval, setValue]⟩))

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
    trivial⟩

private theorem conflict_disjoint : Each (ConflictFree model) (conflictChecks model) := by
  have exactCat : conflictChecks model = conflictCatalog := rfl
  rw [exactCat, conflictCatalog]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, trivial⟩
  · intro s _ _ l hl r hr d _; simp [conflictGroup_0] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_1] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_2] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_3] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_4] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _
    simp only [conflictGroup_5, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_5, rule_6, e25, e27, e21, e20, e26, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h2 : s.values.integers 0 = 2
      · have hne : ¬ (s.values.integers 0 ≥ 3) := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h2)
    · simp only [rule_5, rule_6, e25, e27, e21, e20, e26, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h2 : s.values.integers 0 = 2
      · have hne : ¬ (s.values.integers 0 ≥ 3) := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h2)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_6] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_7] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_8] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_9] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _
    simp only [conflictGroup_10, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_11, rule_12, e38, e39, e21, e3, e20, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h1 : s.values.integers 0 = 1
      · have hne : ¬ (s.values.integers 0 ≥ 2) := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h1)
    · simp only [rule_11, rule_12, e38, e39, e21, e3, e20, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h1 : s.values.integers 0 = 1
      · have hne : ¬ (s.values.integers 0 ≥ 2) := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h1)
    · exact (d rfl).elim

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers targets_declared_checked
    arms_declared_checked rule_ids_checked coverage_checked preservation conflict_disjoint

end TimedProof
