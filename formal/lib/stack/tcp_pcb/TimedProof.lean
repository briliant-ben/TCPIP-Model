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
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp_all [declaredTimers, rule_0]
  · simp_all [declaredTimers, rule_1]
  · simp_all [declaredTimers, rule_2]
  · simp_all [declaredTimers, rule_3]
  · simp_all [declaredTimers, rule_4]
  · simp_all [declaredTimers, rule_5]
  · simp_all [declaredTimers, rule_6]
  · simp_all [declaredTimers, rule_7]
  · simp_all [declaredTimers, rule_8]
  · simp_all [declaredTimers, rule_9]
  · simp_all [declaredTimers, rule_10]
  · simp_all [declaredTimers, rule_11]
  · simp_all [declaredTimers, rule_12]
  · simp_all [declaredTimers, rule_13]
  · simp_all [declaredTimers, rule_14]
  · simp_all [declaredTimers, rule_15]
  · simp_all [declaredTimers, rule_16]
  · simp_all [declaredTimers, rule_17]
  · simp_all [declaredTimers, rule_18]
  · simp_all [declaredTimers, rule_19]
  · simp_all [declaredTimers, rule_20]
  · simp_all [declaredTimers, rule_21]
  · simp_all [declaredTimers, rule_22]
  · simp_all [declaredTimers, rule_23]
  · simp_all [declaredTimers, rule_24]
  · simp_all [declaredTimers, rule_25]
  · simp_all [declaredTimers, rule_26]
  · simp_all [declaredTimers, rule_27]
  · simp_all [declaredTimers, rule_28]
  · simp_all [declaredTimers, rule_29]
  · simp_all [declaredTimers, rule_30]
  · simp_all [declaredTimers, rule_31]
  · simp_all [declaredTimers, rule_32]
  · simp_all [declaredTimers, rule_33]
  · simp_all [declaredTimers, rule_34]
  · simp_all [declaredTimers, rule_35]
  · simp_all [declaredTimers, rule_36]
  · simp_all [declaredTimers, rule_37]
  · simp_all [declaredTimers, rule_38]
  · simp_all [declaredTimers, rule_39]
  · simp_all [declaredTimers, rule_40]
  · simp_all [declaredTimers, rule_41]
  · simp_all [declaredTimers, rule_42]
  · simp_all [declaredTimers, rule_43]
  · simp_all [declaredTimers, rule_44]
  · simp_all [declaredTimers, rule_45]
  · simp_all [declaredTimers, rule_46]
  · simp_all [declaredTimers, rule_47]
  · simp_all [declaredTimers, rule_48]
  · simp_all [declaredTimers, rule_49]
  · simp_all [declaredTimers, rule_50]
  · simp_all [declaredTimers, rule_51]

private theorem targets_declared_checked : targets_declared := by
  intro r hr; rw [model_rules] at hr
  simp only [List.mem_cons, List.mem_nil_iff, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
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
  · simp [declaredStates, rule_22]
  · simp [declaredStates, rule_23]
  · simp [declaredStates, rule_24]
  · simp [declaredStates, rule_25]
  · simp [declaredStates, rule_26]
  · simp [declaredStates, rule_27]
  · simp [declaredStates, rule_28]
  · simp [declaredStates, rule_29]
  · simp [declaredStates, rule_30]
  · simp [declaredStates, rule_31]
  · simp [declaredStates, rule_32]
  · simp [declaredStates, rule_33]
  · simp [declaredStates, rule_34]
  · simp [declaredStates, rule_35]
  · simp [declaredStates, rule_36]
  · simp [declaredStates, rule_37]
  · simp [declaredStates, rule_38]
  · simp [declaredStates, rule_39]
  · simp [declaredStates, rule_40]
  · simp [declaredStates, rule_41]
  · simp [declaredStates, rule_42]
  · simp [declaredStates, rule_43]
  · simp [declaredStates, rule_44]
  · simp [declaredStates, rule_45]
  · simp [declaredStates, rule_46]
  · simp [declaredStates, rule_47]
  · simp [declaredStates, rule_48]
  · simp [declaredStates, rule_49]
  · simp [declaredStates, rule_50]
  · simp [declaredStates, rule_51]

private theorem eval_inv (s : Snapshot) (h : invariantsHold model s = true) :
    1460 ≤ s.values.integers 0 ∧ s.values.integers 0 ≤ 65535 ∧
    0 ≤ s.values.integers 1 ∧ s.values.integers 1 ≤ 3 ∧
    0 ≤ s.values.integers 2 ∧ s.values.integers 2 ≤ 8 ∧
    200 ≤ s.values.integers 3 ∧ s.values.integers 3 ≤ 60000 ∧
    0 ≤ s.values.integers 4 ∧ s.values.integers 4 ≤ 65535 ∧
    2920 ≤ s.values.integers 5 ∧ s.values.integers 5 ≤ 65535 ∧
    0 ≤ s.values.integers 6 ∧ s.values.integers 6 ≤ 65535 ∧
    ((1 ∈ s.timers.map TimerEntry.timer) → s.state = 2 ∨ s.state = 3 ∨ s.state = 4 ∨ s.state = 5 ∨ s.state = 8 ∨ s.state = 9) ∧
    ((0 ∈ s.timers.map TimerEntry.timer) → s.state = 4) ∧
    ((2 ∈ s.timers.map TimerEntry.timer) → s.state = 10) := by
  have hall : ∀ e ∈ model.invariants, TypedMachine.eval s zeroValues e = true :=
    fun e he => List.all_eq_true.mp h e he
  have h1 := hall e72 (by rw [model_invariants]; simp)
  have h2 := hall e75 (by rw [model_invariants]; simp)
  have h3 := hall e78 (by rw [model_invariants]; simp)
  have h4 := hall e81 (by rw [model_invariants]; simp)
  have h5 := hall e84 (by rw [model_invariants]; simp)
  have h6 := hall e88 (by rw [model_invariants]; simp)
  have h7 := hall e91 (by rw [model_invariants]; simp)
  have h8 := hall e104 (by rw [model_invariants]; simp)
  have h9 := hall e106 (by rw [model_invariants]; simp)
  have h10 := hall e109 (by rw [model_invariants]; simp)
  simp only [TypedMachine.eval, context, e109, e108, e107, e106, e105, e104, e103, e102, e101, e100, e99, e98, e97, e96, e95, e94, e93, e92, e91, e90, e89, e14, e88, e87, e86, e0, e85, e84, e83, e82, e17, e81, e80, e36, e79, e34, e58, e78, e77, e67, e76, e55, e75, e74, e53, e73, e1, e48, e72, e71, e4, e70, e12, e69,
    TypedIR.eval, equalValue, getValue, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2 h3 h4 h5 h6 h7 h8 h9 h10
  refine ⟨of_decide_eq_true h1.1, of_decide_eq_true h1.2,
    of_decide_eq_true h2.1, of_decide_eq_true h2.2,
    of_decide_eq_true h3.1, of_decide_eq_true h3.2,
    of_decide_eq_true h4.1, of_decide_eq_true h4.2,
    of_decide_eq_true h5.1, of_decide_eq_true h5.2,
    of_decide_eq_true h6.1, of_decide_eq_true h6.2,
    of_decide_eq_true h7.1, of_decide_eq_true h7.2, ?_, ?_, ?_⟩
  · intro hm
    rcases h8 with hnot | hor
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · rcases hor with h2 | h3 | h4 | h5 | h8s | h9
      · exact Or.inl (of_decide_eq_true h2)
      · exact Or.inr (Or.inl (of_decide_eq_true h3))
      · exact Or.inr (Or.inr (Or.inl (of_decide_eq_true h4)))
      · exact Or.inr (Or.inr (Or.inr (Or.inl (of_decide_eq_true h5))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (of_decide_eq_true h8s)))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (of_decide_eq_true h9)))))
  · intro hm; rcases h9 with hnot | hs4
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · exact of_decide_eq_true hs4
  · intro hm; rcases h10 with hnot | hs10
    · exact absurd (decide_eq_true hm) (Bool.eq_false_iff.mp hnot)
    · exact of_decide_eq_true hs10

private theorem inv_from_bounds (s : Snapshot)
    (hc0 : 1460 ≤ s.values.integers 0) (hc1 : s.values.integers 0 ≤ 65535)
    (hd0 : 0 ≤ s.values.integers 1) (hd1 : s.values.integers 1 ≤ 3)
    (hn0 : 0 ≤ s.values.integers 2) (hn1 : s.values.integers 2 ≤ 8)
    (hr0 : 200 ≤ s.values.integers 3) (hr1 : s.values.integers 3 ≤ 60000)
    (hw0 : 0 ≤ s.values.integers 4) (hw1 : s.values.integers 4 ≤ 65535)
    (hs0 : 2920 ≤ s.values.integers 5) (hs1 : s.values.integers 5 ≤ 65535)
    (hu0 : 0 ≤ s.values.integers 6) (hu1 : s.values.integers 6 ≤ 65535)
    (ht1 : (1 ∈ s.timers.map TimerEntry.timer) → s.state = 2 ∨ s.state = 3 ∨ s.state = 4 ∨ s.state = 5 ∨ s.state = 8 ∨ s.state = 9)
    (ht0 : (0 ∈ s.timers.map TimerEntry.timer) → s.state = 4)
    (ht2 : (2 ∈ s.timers.map TimerEntry.timer) → s.state = 10) :
    invariantsHold model s = true := by
  rw [invariantsHold, List.all_eq_true]; intro inv hmem
  rw [model_invariants] at hmem
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp [TypedMachine.eval, context, e72, e71, e4, e70, e12, e69, TypedIR.eval, getValue, hc0, hc1]
  · simp [TypedMachine.eval, context, e75, e74, e53, e73, e1, e48, TypedIR.eval, getValue, hd0, hd1]
  · simp [TypedMachine.eval, context, e78, e77, e67, e76, e1, e55, TypedIR.eval, getValue, hn0, hn1]
  · simp [TypedMachine.eval, context, e81, e80, e36, e79, e34, e58, TypedIR.eval, getValue, hr0, hr1]
  · simp [TypedMachine.eval, context, e84, e83, e4, e82, e1, e17, TypedIR.eval, getValue, hw0, hw1]
  · simp [TypedMachine.eval, context, e88, e87, e4, e86, e0, e85, TypedIR.eval, getValue, hs0, hs1]
  · simp [TypedMachine.eval, context, e91, e90, e4, e89, e1, e14, TypedIR.eval, getValue, hu0, hu1]
  · simp only [TypedMachine.eval, context, e104, e103, e102, e101, e100, e99, e98, e97, e96, e95, e94, e93, e92, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 1 ∈ s.timers.map TimerEntry.timer
    · rcases ht1 hm with hst | hst | hst | hst | hst | hst
      · exact Or.inr (Or.inl (decide_eq_true hst))
      · exact Or.inr (Or.inr (Or.inl (decide_eq_true hst)))
      · exact Or.inr (Or.inr (Or.inr (Or.inl (decide_eq_true hst))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (decide_eq_true hst)))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (decide_eq_true hst))))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (decide_eq_true hst))))))
    · exact Or.inl (decide_eq_false hm)
  · simp only [TypedMachine.eval, context, e106, e95, e105, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 0 ∈ s.timers.map TimerEntry.timer
    · exact Or.inr (decide_eq_true (ht0 hm))
    · exact Or.inl (decide_eq_false hm)
  · simp only [TypedMachine.eval, context, e109, e108, e107, TypedIR.eval, Bool.or_eq_true, Bool.not_eq_true']
    by_cases hm : 2 ∈ s.timers.map TimerEntry.timer
    · exact Or.inr (decide_eq_true (ht2 hm))
    · exact Or.inl (decide_eq_false hm)

private theorem mem_timer_filter_ne {ts : List TimerEntry} {t x : Nat} :
    x ∈ (ts.filter (fun te => te.timer != t)).map TimerEntry.timer ↔ (x ∈ ts.map TimerEntry.timer ∧ x ≠ t) := by
  constructor
  · intro h; obtain ⟨e, he, hid⟩ := List.mem_map.mp h
    obtain ⟨hes, hflt⟩ := List.mem_filter.mp he
    refine ⟨List.mem_map.mpr ⟨e, hes, hid⟩, ?_⟩
    intro hxt; rw [← hid] at hxt; rw [hxt] at hflt; simp at hflt
  · rintro ⟨h, hne⟩; obtain ⟨e, he, hid⟩ := List.mem_map.mp h
    refine List.mem_map.mpr ⟨e, List.mem_filter.mpr ⟨he, ?_⟩, hid⟩
    simp [hid, hne]

private theorem mem_timer_append_singleton {ts : List TimerEntry} {e : TimerEntry} {x : Nat} :
    x ∈ (ts ++ [e]).map TimerEntry.timer ↔ (x = e.timer ∨ x ∈ ts.map TimerEntry.timer) := by
  simp only [List.map_append, List.map_cons, List.map_nil, List.mem_append, List.mem_cons,
    List.not_mem_nil, or_false]
  exact or_comm

private theorem n01 : (0 : Nat) ≠ 1 := by decide
private theorem n02 : (0 : Nat) ≠ 2 := by decide
private theorem n10 : (1 : Nat) ≠ 0 := by decide
private theorem n12 : (1 : Nat) ≠ 2 := by decide
private theorem n20 : (2 : Nat) ≠ 0 := by decide
private theorem n21 : (2 : Nat) ≠ 1 := by decide

private theorem coverage_checked : timer_coverage := by
  intro s _ valid entry inside known
  obtain ⟨_, _, _, _, hn0, hn1, hr0, hr1, _, _, _, _, _, _, ht1, ht0, ht2⟩ := eval_inv s valid
  simp only [declaredTimers, List.mem_cons, List.mem_nil_iff, or_false] at known
  rcases known with heq | heq | heq
  · have hact : 0 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, heq⟩
    refine ⟨rule_19, by rw [model_rules]; simp, (ht0 hact).symm, by rw [heq]; rfl, ?_⟩
    simp [rule_19, e5, TypedMachine.eval, TypedIR.eval]
  · have hact : 1 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, heq⟩
    rcases ht1 hact with hst | hst | hst | hst | hst | hst
    · by_cases hret : s.values.integers 2 ≤ 7
      · by_cases hrto : s.values.integers 3 ≤ 30000
        · refine ⟨rule_34, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          simp [TypedMachine.eval, context, rule_34, e61, e60, e59, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hrto]
        · refine ⟨rule_35, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          have hge : s.values.integers 3 ≥ 30001 := by omega
          simp [TypedMachine.eval, context, rule_35, e66, e65, e64, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hge]
      · refine ⟨rule_36, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq8 : s.values.integers 2 = 8 := by omega
        simp [TypedMachine.eval, context, rule_36, e68, e67, e55, TypedIR.eval, equalValue, getValue, heq8]
    · by_cases hret : s.values.integers 2 ≤ 7
      · by_cases hrto : s.values.integers 3 ≤ 30000
        · refine ⟨rule_37, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          simp [TypedMachine.eval, context, rule_37, e61, e60, e59, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hrto]
        · refine ⟨rule_38, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          have hge : s.values.integers 3 ≥ 30001 := by omega
          simp [TypedMachine.eval, context, rule_38, e66, e65, e64, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hge]
      · refine ⟨rule_39, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq8 : s.values.integers 2 = 8 := by omega
        simp [TypedMachine.eval, context, rule_39, e68, e67, e55, TypedIR.eval, equalValue, getValue, heq8]
    · by_cases hret : s.values.integers 2 ≤ 7
      · by_cases hrto : s.values.integers 3 ≤ 30000
        · refine ⟨rule_40, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          simp [TypedMachine.eval, context, rule_40, e61, e60, e59, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hrto]
        · refine ⟨rule_41, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          have hge : s.values.integers 3 ≥ 30001 := by omega
          simp [TypedMachine.eval, context, rule_41, e66, e65, e64, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hge]
      · refine ⟨rule_42, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq8 : s.values.integers 2 = 8 := by omega
        simp [TypedMachine.eval, context, rule_42, e68, e67, e55, TypedIR.eval, equalValue, getValue, heq8]
    · by_cases hret : s.values.integers 2 ≤ 7
      · by_cases hrto : s.values.integers 3 ≤ 30000
        · refine ⟨rule_43, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          simp [TypedMachine.eval, context, rule_43, e61, e60, e59, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hrto]
        · refine ⟨rule_44, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          have hge : s.values.integers 3 ≥ 30001 := by omega
          simp [TypedMachine.eval, context, rule_44, e66, e65, e64, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hge]
      · refine ⟨rule_45, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq8 : s.values.integers 2 = 8 := by omega
        simp [TypedMachine.eval, context, rule_45, e68, e67, e55, TypedIR.eval, equalValue, getValue, heq8]
    · by_cases hret : s.values.integers 2 ≤ 7
      · by_cases hrto : s.values.integers 3 ≤ 30000
        · refine ⟨rule_46, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          simp [TypedMachine.eval, context, rule_46, e61, e60, e59, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hrto]
        · refine ⟨rule_47, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          have hge : s.values.integers 3 ≥ 30001 := by omega
          simp [TypedMachine.eval, context, rule_47, e66, e65, e64, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hge]
      · refine ⟨rule_48, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq8 : s.values.integers 2 = 8 := by omega
        simp [TypedMachine.eval, context, rule_48, e68, e67, e55, TypedIR.eval, equalValue, getValue, heq8]
    · by_cases hret : s.values.integers 2 ≤ 7
      · by_cases hrto : s.values.integers 3 ≤ 30000
        · refine ⟨rule_49, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          simp [TypedMachine.eval, context, rule_49, e61, e60, e59, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hrto]
        · refine ⟨rule_50, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
          have hge : s.values.integers 3 ≥ 30001 := by omega
          simp [TypedMachine.eval, context, rule_50, e66, e65, e64, e58, e57, e56, e55, TypedIR.eval, getValue, hret, hge]
      · refine ⟨rule_51, by rw [model_rules]; simp, hst.symm, by rw [heq]; rfl, ?_⟩
        have heq8 : s.values.integers 2 = 8 := by omega
        simp [TypedMachine.eval, context, rule_51, e68, e67, e55, TypedIR.eval, equalValue, getValue, heq8]
  · have hact : 2 ∈ s.timers.map TimerEntry.timer := List.mem_map.mpr ⟨entry, inside, heq⟩
    refine ⟨rule_32, by rw [model_rules]; simp, (ht2 hact).symm, by rw [heq]; rfl, ?_⟩
    simp [rule_32, e5, TypedMachine.eval, TypedIR.eval]


private theorem pres_0 : FiringPreserves model rule_0 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_0, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_0, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht1 hm2 with hst | hst | hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 0 := hSrc; rcases ht1 hm with hst | hst | hst | hst | hst | hst <;> omega)
  · intro hm
    simp only [rule_0, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 0 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_0, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 0 := hSrc; have hst := ht2 hm; omega)

private theorem pres_1 : FiringPreserves model rule_1 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_1, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_1]
  · intro hm
    simp only [rule_1, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 0 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_1, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 0 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 0 := hSrc; have hst := ht2 hm; omega)

private theorem pres_2 : FiringPreserves model rule_2 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_2, e9, e8, e4, e7, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_w0 : 0 ≤ f.integers 0 := of_decide_eq_true hGuard.1
  have g_w1 : f.integers 0 ≤ 65535 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_2, withoutFiring, work, armTimer, cancelTimer, e2, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_2]
  · intro hm
    simp only [rule_2, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 1 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_2, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 1 := hSrc; have hst := ht2 hm; omega)

private theorem pres_3 : FiringPreserves model rule_3 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_3, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_3, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht1 hm2 with hst | hst | hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 1 := hSrc; rcases ht1 hm with hst | hst | hst | hst | hst | hst <;> omega)
  · intro hm
    simp only [rule_3, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 1 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_3, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 1 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 1 := hSrc; have hst := ht2 hm; omega)

private theorem pres_4 : FiringPreserves model rule_4 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_4, e9, e8, e4, e7, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_w0 : 0 ≤ f.integers 0 := of_decide_eq_true hGuard.1
  have g_w1 : f.integers 0 ≤ 65535 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_4, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_4]
  · intro _; simp [rule_4]
  · intro hm
    simp only [rule_4, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht2 hm; omega)

private theorem pres_5 : FiringPreserves model rule_5 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_5, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_5, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_5, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_5, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht2 hm; omega)

private theorem pres_6 : FiringPreserves model rule_6 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_6, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_6, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_6, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_6, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht2 hm; omega)

private theorem pres_7 : FiringPreserves model rule_7 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_7, e9, e8, e4, e7, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_w0 : 0 ≤ f.integers 0 := of_decide_eq_true hGuard.1
  have g_w1 : f.integers 0 ≤ 65535 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_7, withoutFiring, work, armTimer, cancelTimer, e1, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_7]
  · intro _; simp [rule_7]
  · intro hm
    simp only [rule_7, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht2 hm; omega)

private theorem pres_8 : FiringPreserves model rule_8 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_8, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_8]
  · intro hm
    simp only [rule_8, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_8, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht2 hm; omega)

private theorem pres_9 : FiringPreserves model rule_9 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_9, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_9, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_9, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_9, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht2 hm; omega)

private theorem pres_10 : FiringPreserves model rule_10 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_10, e21, e20, e19, e18, e17, e16, e4, e15, e14, e13, e12, e11, e10, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_l0 : 1 ≤ f.integers 0 := of_decide_eq_true hGuard.1
  have g_l1 : f.integers 0 ≤ 1460 := of_decide_eq_true hGuard.2.1
  have g_sum : s.values.integers 6 + f.integers 0 ≤ 65535 := of_decide_eq_true hGuard.2.2.1
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_10, withoutFiring, work, armTimer, cancelTimer, e2, e15, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_10]
  · intro _; simp [rule_10]
  · intro hm
    simp only [rule_10, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_11 : FiringPreserves model rule_11 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_11, e22, e1, e17, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_11, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_11]
  · intro _; simp [rule_11]
  · intro hm
    simp only [rule_11, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_12 : FiringPreserves model rule_12 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_12, e46, e45, e44, e43, e42, e41, e40, e39, e38, e37, e36, e35, e34, e33, e32, e31, e0, e30, e29, e28, e12, e27, e26, e4, e25, e1, e24, e23, e14, e11, e10, e6, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_a0 : 1 ≤ f.integers 0 := of_decide_eq_true hGuard.1
  have g_a1 : f.integers 0 ≤ s.values.integers 6 := of_decide_eq_true hGuard.2.1
  have g_w0 : 0 ≤ f.integers 1 := of_decide_eq_true hGuard.2.2.1
  have g_w1 : f.integers 1 ≤ 65535 := of_decide_eq_true hGuard.2.2.2.1
  have g_c0 : 1460 ≤ f.integers 2 := of_decide_eq_true hGuard.2.2.2.2.1
  have g_c1 : f.integers 2 ≤ 65535 := of_decide_eq_true hGuard.2.2.2.2.2.1
  have g_s0 : 2920 ≤ f.integers 3 := of_decide_eq_true hGuard.2.2.2.2.2.2.1
  have g_s1 : f.integers 3 ≤ 65535 := of_decide_eq_true hGuard.2.2.2.2.2.2.2.1
  have g_r0 : 200 ≤ f.integers 4 := of_decide_eq_true hGuard.2.2.2.2.2.2.2.2.1
  have g_r1 : f.integers 4 ≤ 60000 := of_decide_eq_true hGuard.2.2.2.2.2.2.2.2.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_12, withoutFiring, work, armTimer, cancelTimer, e1, e33, e30, e27, e24, e47, e6, e14, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_12]
  · intro _; simp [rule_12]
  · intro hm
    simp only [rule_12, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_13 : FiringPreserves model rule_13 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_13, e49, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_d : s.values.integers 1 ≤ 1 := of_decide_eq_true hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_13, withoutFiring, work, armTimer, cancelTimer, e50, e10, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_13]
  · intro _; simp [rule_13]
  · intro hm
    simp only [rule_13, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_14 : FiringPreserves model rule_14 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_14, e52, e51, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_14, withoutFiring, work, armTimer, cancelTimer, e2, e12, e53, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_14]
  · intro _; simp [rule_14]
  · intro hm
    simp only [rule_14, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_15 : FiringPreserves model rule_15 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_15, e54, e53, e48, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_15, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_15]
  · intro _; simp [rule_15]
  · intro hm
    simp only [rule_15, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_16 : FiringPreserves model rule_16 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_16, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_16]
  · intro hm
    simp only [rule_16, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_16, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_17 : FiringPreserves model rule_17 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_17, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_17, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_17, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_17, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_18 : FiringPreserves model rule_18 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_18, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_18, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_18, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_18, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_19 : FiringPreserves model rule_19 (some 0) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_19, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_19]
  · intro _; simp [rule_19]
  · intro hm
    simp only [rule_19, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_20 : FiringPreserves model rule_20 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_20, withoutFiring, work, armTimer, cancelTimer, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_20, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_20, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_20, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht2 hm; omega)

private theorem pres_21 : FiringPreserves model rule_21 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_21, withoutFiring, work, armTimer, cancelTimer, e2, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_21]
  · intro hm
    simp only [rule_21, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_21, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht2 hm; omega)

private theorem pres_22 : FiringPreserves model rule_22 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_22, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_22, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_22, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht0 hm; omega)
  · intro _; simp [rule_22]

private theorem pres_23 : FiringPreserves model rule_23 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_23, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_23, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_23, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_23, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht2 hm; omega)

private theorem pres_24 : FiringPreserves model rule_24 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_24, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_24, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 6 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht1 hm2 with hst | hst | hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 6 := hSrc; rcases ht1 hm with hst | hst | hst | hst | hst | hst <;> omega)
  · intro hm
    simp only [rule_24, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 6 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 6 := hSrc; have hst := ht0 hm; omega)
  · intro _; simp [rule_24]

private theorem pres_25 : FiringPreserves model rule_25 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_25, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_25, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 6 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht1 hm2 with hst | hst | hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 6 := hSrc; rcases ht1 hm with hst | hst | hst | hst | hst | hst <;> omega)
  · intro hm
    simp only [rule_25, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 6 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 6 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_25, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 6 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 6 := hSrc; have hst := ht2 hm; omega)

private theorem pres_26 : FiringPreserves model rule_26 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_26, withoutFiring, work, armTimer, cancelTimer, e2, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_26]
  · intro hm
    simp only [rule_26, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 7 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 7 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_26, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 7 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 7 := hSrc; have hst := ht2 hm; omega)

private theorem pres_27 : FiringPreserves model rule_27 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_27, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_27, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 7 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht1 hm2 with hst | hst | hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 7 := hSrc; rcases ht1 hm with hst | hst | hst | hst | hst | hst <;> omega)
  · intro hm
    simp only [rule_27, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 7 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 7 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_27, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 7 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 7 := hSrc; have hst := ht2 hm; omega)

private theorem pres_28 : FiringPreserves model rule_28 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_28, withoutFiring, work, armTimer, cancelTimer, e36, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_28, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_28, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht0 hm; omega)
  · intro _; simp [rule_28]

private theorem pres_29 : FiringPreserves model rule_29 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_29, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_29, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_29, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_29, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht2 hm; omega)

private theorem pres_30 : FiringPreserves model rule_30 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_30, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_30, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_30, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_30, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht2 hm; omega)

private theorem pres_31 : FiringPreserves model rule_31 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_31, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_31, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_31, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_31, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht2 hm; omega)

private theorem pres_32 : FiringPreserves model rule_32 (some 2) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_32, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_32, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 10 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht1 hm2 with hst | hst | hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 10 := hSrc; rcases ht1 hm with hst | hst | hst | hst | hst | hst <;> omega)
  · intro hm
    simp only [rule_32, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 10 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 10 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_32, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_33 : FiringPreserves model rule_33 none := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_33, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_33, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 10 := hSrc; obtain ⟨hm2, _⟩ := hm; rcases ht1 hm2 with hst | hst | hst | hst | hst | hst <;> omega) | (have hsrc : s.state = 10 := hSrc; rcases ht1 hm with hst | hst | hst | hst | hst | hst <;> omega)
  · intro hm
    simp only [rule_33, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 10 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 10 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_33, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega

private theorem pres_34 : FiringPreserves model rule_34 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_34, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  have g_t : s.values.integers 3 ≤ 30000 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_34, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_34]
  · intro hm
    simp only [rule_34, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_34, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht2 hm; omega)

private theorem pres_35 : FiringPreserves model rule_35 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_35, e66, e65, e64, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_35, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_35]
  · intro hm
    simp only [rule_35, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_35, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht2 hm; omega)

private theorem pres_36 : FiringPreserves model rule_36 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_36, e68, e67, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_36, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_36, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_36, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_36, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 2 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 2 := hSrc; have hst := ht2 hm; omega)

private theorem pres_37 : FiringPreserves model rule_37 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_37, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  have g_t : s.values.integers 3 ≤ 30000 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_37, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_37]
  · intro hm
    simp only [rule_37, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_37, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht2 hm; omega)

private theorem pres_38 : FiringPreserves model rule_38 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_38, e66, e65, e64, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_38, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_38]
  · intro hm
    simp only [rule_38, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_38, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht2 hm; omega)

private theorem pres_39 : FiringPreserves model rule_39 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_39, e68, e67, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_39, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_39, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_39, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_39, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 3 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 3 := hSrc; have hst := ht2 hm; omega)

private theorem pres_40 : FiringPreserves model rule_40 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_40, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  have g_t : s.values.integers 3 ≤ 30000 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_40, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_40]
  · intro _; simp [rule_40]
  · intro hm
    simp only [rule_40, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_41 : FiringPreserves model rule_41 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_41, e66, e65, e64, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_41, withoutFiring, work, armTimer, cancelTimer, e2, e1, e12, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_41]
  · intro _; simp [rule_41]
  · intro hm
    simp only [rule_41, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_42 : FiringPreserves model rule_42 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_42, e68, e67, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_42, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_42, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_42, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_42, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 4 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 4 := hSrc; have hst := ht2 hm; omega)

private theorem pres_43 : FiringPreserves model rule_43 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_43, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  have g_t : s.values.integers 3 ≤ 30000 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_43, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_43]
  · intro hm
    simp only [rule_43, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_43, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht2 hm; omega)

private theorem pres_44 : FiringPreserves model rule_44 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_44, e66, e65, e64, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_44, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_44]
  · intro hm
    simp only [rule_44, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_44, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht2 hm; omega)

private theorem pres_45 : FiringPreserves model rule_45 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_45, e68, e67, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_45, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_45, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_45, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_45, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 5 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 5 := hSrc; have hst := ht2 hm; omega)

private theorem pres_46 : FiringPreserves model rule_46 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_46, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  have g_t : s.values.integers 3 ≤ 30000 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_46, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_46]
  · intro hm
    simp only [rule_46, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_46, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht2 hm; omega)

private theorem pres_47 : FiringPreserves model rule_47 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_47, e66, e65, e64, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_47, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_47]
  · intro hm
    simp only [rule_47, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_47, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht2 hm; omega)

private theorem pres_48 : FiringPreserves model rule_48 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_48, e68, e67, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_48, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_48, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_48, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_48, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 8 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 8 := hSrc; have hst := ht2 hm; omega)

private theorem pres_49 : FiringPreserves model rule_49 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_49, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  have g_t : s.values.integers 3 ≤ 30000 := of_decide_eq_true hGuard.2
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_49, withoutFiring, work, armTimer, cancelTimer, e2, e63, e51, e58, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_49]
  · intro hm
    simp only [rule_49, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_49, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht2 hm; omega)

private theorem pres_50 : FiringPreserves model rule_50 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_50, e66, e65, e64, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  have g_r : s.values.integers 2 ≤ 7 := of_decide_eq_true hGuard.1
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_50, withoutFiring, work, armTimer, cancelTimer, e2, e36, e62, e10, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro _; simp [rule_50]
  · intro hm
    simp only [rule_50, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_50, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht2 hm; omega)

private theorem pres_51 : FiringPreserves model rule_51 (some 1) := by
  intro s f hInv hSrc hGuard
  obtain ⟨hc0, hc1, hd0, hd1, hn0, hn1, hr0, hr1, hw0, hw1, hs0, hs1, hu0, hu1, ht1, ht0, ht2⟩ := eval_inv s hInv
  simp only [rule_51, e68, e67, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_true] at hGuard
  refine ⟨_, rfl, inv_from_bounds _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_⟩
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · simp [rule_51, withoutFiring, work, armTimer, cancelTimer, e3, e2, e4, e0, e1, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, setValue]; try omega
  · intro hm
    simp only [rule_51, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | contradiction | omega
  · intro hm
    simp only [rule_51, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht0 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht0 hm; omega)
  · intro hm
    simp only [rule_51, withoutFiring, work, armTimer, cancelTimer, mem_timer_append_singleton, mem_timer_filter_ne, ne_eq, decide_eq_true_eq, Bool.false_eq_true, not_false_eq_true, not_true_eq_false, or_self, false_or, or_false, and_false, false_and, and_true, true_and, n01, n02, n10, n12, n20, n21] at hm
    all_goals first | exact False.elim hm | (have hsrc : s.state = 9 := hSrc; obtain ⟨hm2, _⟩ := hm; have hst := ht2 hm2; omega) | (have hsrc : s.state = 9 := hSrc; have hst := ht2 hm; omega)

theorem preservation : Each (fun p => FiringPreserves model p.1 p.2)
    (rawChecks model declaredTimers) := by
  have exactCat : rawChecks model declaredTimers = rawCatalog := rfl
  rw [exactCat, rawCatalog]
  repeat' constructor
  all_goals first | trivial | exact pres_0 | exact pres_1 | exact pres_2 | exact pres_3 | exact pres_4 | exact pres_5 | exact pres_6 | exact pres_7 | exact pres_8 | exact pres_9 | exact pres_10 | exact pres_11 | exact pres_12 | exact pres_13 | exact pres_14 | exact pres_15 | exact pres_16 | exact pres_17 | exact pres_18 | exact pres_19 | exact pres_20 | exact pres_21 | exact pres_22 | exact pres_23 | exact pres_24 | exact pres_25 | exact pres_26 | exact pres_27 | exact pres_28 | exact pres_29 | exact pres_30 | exact pres_31 | exact pres_32 | exact pres_33 | exact pres_34 | exact pres_35 | exact pres_36 | exact pres_37 | exact pres_38 | exact pres_39 | exact pres_40 | exact pres_41 | exact pres_42 | exact pres_43 | exact pres_44 | exact pres_45 | exact pres_46 | exact pres_47 | exact pres_48 | exact pres_49 | exact pres_50 | exact pres_51

private theorem conflict_disjoint : Each (ConflictFree model) (conflictChecks model) := by
  have exactCat : conflictChecks model = conflictCatalog := rfl
  rw [exactCat, conflictCatalog]
  repeat' constructor
  · intro s _ _ l hl r hr d _; simp [conflictGroup_0] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_1] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_2] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
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
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_13, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_13, rule_14, rule_15, e42, e28, e12, e41, e29, e27, e40, e39, e38, e37, e36, e35, e34, e33, e32, e4, e31, e0, e30, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 1
      · have hne : s.values.integers 1 ≠ 2 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_13, rule_14, rule_15, e42, e28, e12, e41, e29, e27, e40, e39, e38, e37, e36, e35, e34, e33, e32, e4, e31, e0, e30, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 1
      · have hne : s.values.integers 1 ≠ 3 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_13, rule_14, rule_15, e42, e28, e12, e41, e29, e27, e40, e39, e38, e37, e36, e35, e34, e33, e32, e4, e31, e0, e30, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 1
      · have hne : s.values.integers 1 ≠ 2 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · exact (d rfl).elim
    · simp only [rule_13, rule_14, rule_15, e42, e28, e12, e41, e29, e27, e40, e39, e38, e37, e36, e35, e34, e33, e32, e4, e31, e0, e30, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 = 2
      · have hne : s.values.integers 1 ≠ 3 := by omega
        exact Or.inr (decide_eq_false hne)
      · exact Or.inl (decide_eq_false h)
    · simp only [rule_13, rule_14, rule_15, e42, e28, e12, e41, e29, e27, e40, e39, e38, e37, e36, e35, e34, e33, e32, e4, e31, e0, e30, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 ≤ 1
      · have hne : s.values.integers 1 ≠ 3 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · simp only [rule_13, rule_14, rule_15, e42, e28, e12, e41, e29, e27, e40, e39, e38, e37, e36, e35, e34, e33, e32, e4, e31, e0, e30, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue]
      by_cases h : s.values.integers 1 = 2
      · have hne : s.values.integers 1 ≠ 3 := by omega
        exact Or.inl (decide_eq_false hne)
      · exact Or.inr (decide_eq_false h)
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_14] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_15] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_16] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_17] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_18] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_19] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_20] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_21] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_22] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_23] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_24] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_25] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_26] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_27] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_28] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_29] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_30] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp [conflictGroup_31] at hl hr; rw [hl, hr] at d; exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_32, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_34, rule_35, rule_36, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inr (Or.inr (decide_eq_false hnge))
      · exact Or.inl (Or.inr (decide_eq_false hrt))
    · simp only [rule_34, rule_35, rule_36, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_34, rule_35, rule_36, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inl (Or.inr (decide_eq_false hnge))
      · exact Or.inr (Or.inr (decide_eq_false hrt))
    · exact (d rfl).elim
    · simp only [rule_34, rule_35, rule_36, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_34, rule_35, rule_36, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · simp only [rule_34, rule_35, rule_36, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_33, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_37, rule_38, rule_39, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inr (Or.inr (decide_eq_false hnge))
      · exact Or.inl (Or.inr (decide_eq_false hrt))
    · simp only [rule_37, rule_38, rule_39, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_37, rule_38, rule_39, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inl (Or.inr (decide_eq_false hnge))
      · exact Or.inr (Or.inr (decide_eq_false hrt))
    · exact (d rfl).elim
    · simp only [rule_37, rule_38, rule_39, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_37, rule_38, rule_39, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · simp only [rule_37, rule_38, rule_39, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_34, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_40, rule_41, rule_42, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inr (Or.inr (decide_eq_false hnge))
      · exact Or.inl (Or.inr (decide_eq_false hrt))
    · simp only [rule_40, rule_41, rule_42, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_40, rule_41, rule_42, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inl (Or.inr (decide_eq_false hnge))
      · exact Or.inr (Or.inr (decide_eq_false hrt))
    · exact (d rfl).elim
    · simp only [rule_40, rule_41, rule_42, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_40, rule_41, rule_42, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · simp only [rule_40, rule_41, rule_42, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_35, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_43, rule_44, rule_45, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inr (Or.inr (decide_eq_false hnge))
      · exact Or.inl (Or.inr (decide_eq_false hrt))
    · simp only [rule_43, rule_44, rule_45, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_43, rule_44, rule_45, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inl (Or.inr (decide_eq_false hnge))
      · exact Or.inr (Or.inr (decide_eq_false hrt))
    · exact (d rfl).elim
    · simp only [rule_43, rule_44, rule_45, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_43, rule_44, rule_45, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · simp only [rule_43, rule_44, rule_45, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_36, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_46, rule_47, rule_48, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inr (Or.inr (decide_eq_false hnge))
      · exact Or.inl (Or.inr (decide_eq_false hrt))
    · simp only [rule_46, rule_47, rule_48, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_46, rule_47, rule_48, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inl (Or.inr (decide_eq_false hnge))
      · exact Or.inr (Or.inr (decide_eq_false hrt))
    · exact (d rfl).elim
    · simp only [rule_46, rule_47, rule_48, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_46, rule_47, rule_48, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · simp only [rule_46, rule_47, rule_48, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · exact (d rfl).elim
  · intro s _ _ l hl r hr d _; simp only [conflictGroup_37, List.mem_cons, List.not_mem_nil, or_false] at hl hr
    rcases hl with rfl | rfl | rfl <;> rcases hr with rfl | rfl | rfl
    · exact (d rfl).elim
    · simp only [rule_49, rule_50, rule_51, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inr (Or.inr (decide_eq_false hnge))
      · exact Or.inl (Or.inr (decide_eq_false hrt))
    · simp only [rule_49, rule_50, rule_51, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_49, rule_50, rule_51, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hrt : s.values.integers 3 ≤ 30000
      · have hnge : ¬(s.values.integers 3 ≥ 30001) := by omega
        exact Or.inl (Or.inr (decide_eq_false hnge))
      · exact Or.inr (Or.inr (decide_eq_false hrt))
    · exact (d rfl).elim
    · simp only [rule_49, rule_50, rule_51, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inr (decide_eq_false hne8)
      · exact Or.inl (Or.inl (decide_eq_false hret))
    · simp only [rule_49, rule_50, rule_51, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · simp only [rule_49, rule_50, rule_51, e68, e67, e66, e65, e64, e61, e60, e59, e58, e57, e56, e55, TypedMachine.eval, context, TypedIR.eval, equalValue, getValue, Bool.and_eq_false_iff]
      by_cases hret : s.values.integers 2 ≤ 7
      · have hne8 : s.values.integers 2 ≠ 8 := by omega
        exact Or.inl (decide_eq_false hne8)
      · exact Or.inr (Or.inl (decide_eq_false hret))
    · exact (d rfl).elim

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers targets_declared_checked
    arms_declared_checked rule_ids_checked coverage_checked preservation conflict_disjoint

end TimedProof
