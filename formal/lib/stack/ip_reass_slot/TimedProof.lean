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
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp_all [declaredTimers, rule_0, rule_1, rule_2, rule_3, rule_4, rule_5, rule_6]

private theorem targets_declared_checked : targets_declared := by
  intro r hr; rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
    simp [declaredStates, rule_0, rule_1, rule_2, rule_3, rule_4, rule_5, rule_6]

private theorem eval_inv (s : Snapshot) (h : invariantsHold model s = true) :
    0 ≤ s.values.integers 0 ∧ s.values.integers 0 ≤ 8192 ∧
    0 ≤ s.values.integers 1 ∧ s.values.integers 1 ≤ 8192 ∧
    0 ≤ s.values.integers 3 ∧ s.values.integers 3 ≤ 32 ∧
    (s.values.booleans 2 = true → s.values.integers 1 ≥ 1) ∧
    ((s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0 ∧
      s.values.booleans 2 = false ∧ s.values.integers 3 = 0) ∨
     (s.state = 1 ∧ s.values.integers 3 ≥ 1) ∨
     (s.state = 2 ∧ s.values.booleans 2 = true ∧
      s.values.integers 0 = s.values.integers 1 ∧ s.values.integers 3 ≥ 1)) ∧
    ((0 ∈ s.timers.map TimerEntry.timer) → s.state = 1) := by
  have hall : ∀ e ∈ model.invariants, TypedMachine.eval s zeroValues e = true :=
    fun e he => List.all_eq_true.mp h e he
  have h1 := hall e55 (by rw [model_invariants]; simp)
  have h2 := hall e58 (by rw [model_invariants]; simp)
  have h3 := hall e62 (by rw [model_invariants]; simp)
  have h4 := hall e64 (by rw [model_invariants]; simp)
  have h5 := hall e83 (by rw [model_invariants]; simp)
  have h6 := hall e85 (by rw [model_invariants]; simp)
  simp only [TypedMachine.eval, context, e55, e53, e54, e58, e56, e57, e62, e59, e61,
    e64, e63, e83, e73, e82, e76, e81, e65, e72, e66, e71, e67, e70, e68, e69,
    e74, e75, e77, e80, e79, e78, e85, e84, e39, e27, e41, e23, e0, e5, e7, e60, e1,
    TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2 h3 h4 h5 h6
  refine ⟨of_decide_eq_true h1.1, of_decide_eq_true h1.2,
    of_decide_eq_true h2.1, of_decide_eq_true h2.2,
    of_decide_eq_true h3.1, of_decide_eq_true h3.2, ?_, ?_, ?_⟩
  · intro hb
    rcases h4 with hnot | hlen
    · rw [hb] at hnot; cases hnot
    · exact of_decide_eq_true hlen
  · rcases h5 with c0 | c1 | c2
    · exact Or.inl ⟨of_decide_eq_true c0.1, of_decide_eq_true c0.2.1,
        of_decide_eq_true c0.2.2.1, of_decide_eq_true c0.2.2.2.1, of_decide_eq_true c0.2.2.2.2⟩
    · exact Or.inr (Or.inl ⟨of_decide_eq_true c1.1, of_decide_eq_true c1.2⟩)
    · exact Or.inr (Or.inr ⟨of_decide_eq_true c2.1, c2.2.1,
        of_decide_eq_true c2.2.2.1, of_decide_eq_true c2.2.2.2⟩)
  · intro hm
    rcases h6 with hnot | hst
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · exact of_decide_eq_true hst

private theorem inv_from_bounds (s : Snapshot)
    (hr0 : 0 ≤ s.values.integers 0) (hr8 : s.values.integers 0 ≤ 8192)
    (ht0 : 0 ≤ s.values.integers 1) (ht8 : s.values.integers 1 ≤ 8192)
    (hf0 : 0 ≤ s.values.integers 3) (hf32 : s.values.integers 3 ≤ 32)
    (hlast : s.values.booleans 2 = true → s.values.integers 1 ≥ 1)
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0 ∧
            s.values.booleans 2 = false ∧ s.values.integers 3 = 0) ∨
           (s.state = 1 ∧ s.values.integers 3 ≥ 1) ∨
           (s.state = 2 ∧ s.values.booleans 2 = true ∧
            s.values.integers 0 = s.values.integers 1 ∧ s.values.integers 3 ≥ 1))
    (htmr : (0 ∈ s.timers.map TimerEntry.timer) → s.state = 1) :
    invariantsHold model s = true := by
  rw [invariantsHold, List.all_eq_true]
  intro inv hmem
  rw [model_invariants] at hmem
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl | rfl | rfl | rfl | rfl
  · simp [TypedMachine.eval, context, e55, e53, e54, e0, e27, e7, TypedIR.eval, getValue, hr0, hr8]
  · simp [TypedMachine.eval, context, e58, e56, e57, e0, e41, e7, TypedIR.eval, getValue, ht0, ht8]
  · simp [TypedMachine.eval, context, e62, e59, e61, e0, e23, e60, TypedIR.eval, getValue, hf0, hf32]
  · simp only [TypedMachine.eval, context, e64, e63, e39, e41, e5, TypedIR.eval, getValue, Bool.or_eq_true, Bool.not_eq_true']
    cases hb : s.values.booleans 2
    · exact Or.inl rfl
    · exact Or.inr (decide_eq_true (hlast hb))
  · simp only [TypedMachine.eval, context, e83, e73, e82, e76, e81, e65, e72, e66, e71, e67, e70, e68, e69,
      e74, e75, e77, e80, e79, e78, e39, e27, e41, e23, e0, e5, e1,
      TypedIR.eval, equalValue, getValue, Bool.or_eq_true, Bool.and_eq_true]
    rcases hst with ⟨hs, hr, ht, hl, hf⟩ | ⟨hs, hf⟩ | ⟨hs, hl, heq, hf⟩
    · exact Or.inl ⟨decide_eq_true hs, decide_eq_true hr, decide_eq_true ht, decide_eq_true hl, decide_eq_true hf⟩
    · exact Or.inr (Or.inl ⟨decide_eq_true hs, decide_eq_true hf⟩)
    · exact Or.inr (Or.inr ⟨decide_eq_true hs, hl, decide_eq_true heq, decide_eq_true hf⟩)
  · simp only [TypedMachine.eval, context, e85, e84, e74, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 0 ∈ s.timers.map TimerEntry.timer
    · exact Or.inr (decide_eq_true (htmr hm))
    · exact Or.inl (decide_eq_false hm)

private theorem coverage_checked : timer_coverage := by
  intro s _ valid entry inside known
  have id : entry.timer = 0 := List.mem_singleton.mp known
  have active : 0 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, id⟩
  have hst := (eval_inv s valid).2.2.2.2.2.2.2.2 active
  refine ⟨rule_4, by rw [model_rules]; simp, hst.symm, by rw [id]; rfl, ?_⟩
  simp [rule_4, e12, TypedMachine.eval, TypedIR.eval]

private theorem timer0_drop (s : Snapshot) :
    0 ∉ (cancelTimer s 0).timers.map TimerEntry.timer := by
  intro h; obtain ⟨e, he, hid⟩ := List.mem_map.mp h
  have hf := (List.mem_filter.mp he).2; simp [hid] at hf

private theorem s1_frag {s : Snapshot}
    (hst : (s.state = 0 ∧ s.values.integers 0 = 0 ∧ s.values.integers 1 = 0 ∧
            s.values.booleans 2 = false ∧ s.values.integers 3 = 0) ∨
           (s.state = 1 ∧ s.values.integers 3 ≥ 1) ∨
           (s.state = 2 ∧ s.values.booleans 2 = true ∧
            s.values.integers 0 = s.values.integers 1 ∧ s.values.integers 3 ≥ 1))
    (hs : s.state = 1) : s.values.integers 3 ≥ 1 := by
  rcases hst with ⟨h, _⟩ | ⟨_, hf⟩ | ⟨h, _⟩
  · omega
  · exact hf
  · omega

private theorem preserves_rule (r : Rule) (fin : Option Nat) :
    (r, fin) ∈ rawCatalog → FiringPreserves model r fin := by
  intro hr s f hInv hSrc hGuard
  obtain ⟨r0, r8, t0, t8, f0, f32, hlast, hst, htmr⟩ := eval_inv s hInv
  simp only [rawCatalog, List.mem_cons, List.not_mem_nil, or_false, Prod.mk.injEq] at hr
  rcases hr with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · simp only [rule_0, e10, e3, e9, e6, e8, e2, e1, e4, e5, e7,
      TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
    have g1 : f.integers 0 ≥ 1 := of_decide_eq_true hGuard.2.1
    have g2 : f.integers 0 ≤ 8192 := of_decide_eq_true hGuard.2.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_0, withoutFiring, work, armTimer, e11, e4, e0, e1, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_0, withoutFiring, work, armTimer, e11, e4, e0, e1, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact g2
    · simp [rule_0, withoutFiring, work, armTimer, e11, e4, e0, e1, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e11, e4, e0, e1, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e11, e4, e0, e1, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e11, e4, e0, e1, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_0, withoutFiring, work, armTimer, e11, e4, e0, e1, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · exact Or.inr (Or.inl ⟨by simp [rule_0], by simp [rule_0, withoutFiring, work, armTimer, e11, e4, e0, e1, e5, TypedMachine.eval, TypedIR.eval, setValue]⟩)
    · intro _; simp [rule_0]
  · simp only [rule_1, e20, e13, e19, e6, e18, e16, e17, e2, e12, e4, e5, e14, e15, e7,
      TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
    have g1 : f.integers 0 ≥ 1 := of_decide_eq_true hGuard.2.1
    have g2 : f.integers 2 ≥ f.integers 0 + 1 := of_decide_eq_true hGuard.2.2.1
    have g3 : f.integers 2 ≤ 8192 := of_decide_eq_true hGuard.2.2.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_1, withoutFiring, work, armTimer, e11, e4, e14, e12, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, armTimer, e11, e4, e14, e12, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, armTimer, e11, e4, e14, e12, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_1, withoutFiring, work, armTimer, e11, e4, e14, e12, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact g3
    · simp [rule_1, withoutFiring, work, armTimer, e11, e4, e14, e12, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_1, withoutFiring, work, armTimer, e11, e4, e14, e12, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
    · simp [rule_1, withoutFiring, work, armTimer, e11, e4, e14, e12, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · exact Or.inr (Or.inl ⟨by simp [rule_1], by simp [rule_1, withoutFiring, work, armTimer, e11, e4, e14, e12, e5, TypedMachine.eval, TypedIR.eval, setValue]⟩)
    · intro _; simp [rule_1]
  · simp only [rule_2, e38, e22, e37, e25, e36, e30, e35, e26, e29, e3, e34, e31, e33, e32,
      e21, e1, e23, e24, e4, e27, e28, e7, e2, e14, e5, e0,
      TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true] at hGuard
    have hf1 := s1_frag hst hSrc
    have gfc : s.values.integers 3 ≤ 31 := of_decide_eq_true hGuard.2.1
    have gab : f.integers 0 ≥ 0 := of_decide_eq_true hGuard.2.2.1.1
    have gub : s.values.integers 0 + f.integers 0 ≤ 8192 := of_decide_eq_true hGuard.2.2.1.2
    have gor := hGuard.2.2.2
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_2, withoutFiring, work, e28, e27, e4, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_2, withoutFiring, work, e28, e27, e4, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact gub
    · simp [rule_2, withoutFiring, work, e42, e41, e14, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
      by_cases hfl : f.booleans 1 = true
      · simp [hfl]; rcases gor with hl | hr
        · simp [hfl] at hl
        · have : f.integers 2 ≥ 1 := of_decide_eq_true hr.2.1; omega
      · simp [hfl]; exact t0
    · simp [rule_2, withoutFiring, work, e42, e41, e14, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
      by_cases hfl : f.booleans 1 = true
      · simp [hfl]; rcases gor with hl | hr
        · simp [hfl] at hl
        · exact of_decide_eq_true hr.2.2
      · simp [hfl]; exact t8
    · simp [rule_2, withoutFiring, work, e43, e23, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_2, withoutFiring, work, e43, e23, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_2, withoutFiring, work, e40, e42, e39, e41, e14, e12, e2, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]
      by_cases hfl : f.booleans 1 = true
      · simp [hfl]; rcases gor with hl | hr
        · simp [hfl] at hl
        · exact of_decide_eq_true hr.2.1
      · simp [hfl]; exact hlast
    · exact Or.inr (Or.inl ⟨by simp [rule_2], by simp [rule_2, withoutFiring, work, e43, e23, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega⟩)
    · intro _; simp [rule_2]
  · simp only [rule_3, e52, e44, e51, e25, e50, e26, e49, e45, e48, e32, e47, e17, e46,
      e21, e12, e23, e24, e4, e39, e2, e14, e28, e27, e7, e5, e0,
      TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true] at hGuard
    have hf1 := s1_frag hst hSrc
    have gfc : s.values.integers 3 ≤ 31 := of_decide_eq_true hGuard.2.1
    have gf1 : f.integers 2 ≥ 1 := of_decide_eq_true hGuard.2.2.2.2.1
    have gf8 : f.integers 2 ≤ 8192 := of_decide_eq_true hGuard.2.2.2.2.2.1
    refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_3, withoutFiring, cancelTimer, work, e14, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_3, withoutFiring, cancelTimer, work, e14, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact gf8
    · simp [rule_3, withoutFiring, cancelTimer, work, e14, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_3, withoutFiring, cancelTimer, work, e14, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact gf8
    · simp [rule_3, withoutFiring, cancelTimer, work, e43, e23, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_3, withoutFiring, cancelTimer, work, e43, e23, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega
    · simp [rule_3, withoutFiring, cancelTimer, work, e14, e12, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; exact gf1
    · exact Or.inr (Or.inr ⟨by simp [rule_3], by simp [rule_3, withoutFiring, cancelTimer, work, e12, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_3, withoutFiring, cancelTimer, work, e14, TypedMachine.eval, context, TypedIR.eval, getValue, setValue],
        by simp [rule_3, withoutFiring, cancelTimer, work, e43, e23, e5, TypedMachine.eval, context, TypedIR.eval, getValue, setValue]; omega⟩)
    · intro hm; simp only [rule_3, withoutFiring, work] at hm; exact absurd hm (timer0_drop s)
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_4, withoutFiring, cancelTimer, work, e1, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inl ⟨by simp [rule_4], by simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_4, withoutFiring, cancelTimer, work, e1, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_4, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hm; simp only [rule_4, withoutFiring, work] at hm; exact absurd hm (timer0_drop s)
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_5, withoutFiring, cancelTimer, work, e1, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inl ⟨by simp [rule_5], by simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_5, withoutFiring, cancelTimer, work, e1, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_5, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hm; simp only [rule_5, withoutFiring, work] at hm; exact absurd hm (timer0_drop s)
  · refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
    · simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]
    · simp [rule_6, withoutFiring, cancelTimer, work, e1, TypedMachine.eval, TypedIR.eval, setValue]
    · exact Or.inl ⟨by simp [rule_6], by simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_6, withoutFiring, cancelTimer, work, e1, TypedMachine.eval, TypedIR.eval, setValue],
        by simp [rule_6, withoutFiring, cancelTimer, work, e0, TypedMachine.eval, TypedIR.eval, setValue]⟩
    · intro hm; simp only [rule_6, withoutFiring, work] at hm; have hs1 : s.state = 1 := htmr hm; have hs2 : s.state = 2 := hSrc; omega

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
  refine ⟨?_, ?_, ?_, ?_, ?_, trivial⟩
  · intro s fields _ l hl r hr d _
    simp only [conflictGroup_0, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_0, rule_1, e10, e20, e3, e13, e9, e19, e2, e1, e12,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hb : fields.booleans 1 = true
      · simp [hb]
      · simp [hb]
    · simp only [rule_0, rule_1, e10, e20, e3, e13, e9, e19, e2, e1, e12,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hb : fields.booleans 1 = true
      · simp [hb]
      · simp [hb]
    · exact (d rfl).elim
  · intro s fields _ l hl r hr d _
    simp only [conflictGroup_1, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl <;> rcases hr with rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_2, rule_3, e38, e52, e22, e44, e21, e1, e12,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hd : fields.booleans 3 = true
      · simp [hd]
      · simp [hd]
    · simp only [rule_2, rule_3, e38, e52, e22, e44, e21, e1, e12,
        TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hd : fields.booleans 3 = true
      · simp [hd]
      · simp [hd]
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_2] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_3] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_4] at hl hr; rw [hl, hr] at d; exact (d rfl).elim

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers targets_declared_checked
    arms_declared_checked rule_ids_checked coverage_checked preservation conflict_disjoint

end TimedProof
