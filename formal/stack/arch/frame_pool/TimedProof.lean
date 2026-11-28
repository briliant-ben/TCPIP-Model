import Approved
import EffectConditions
import GuardDiscriminators

set_option maxRecDepth 16384

namespace TimedProof
open Approved FormalSpecAgent TypedIR TypedMachine TypedContracts TypedFiringContracts
open BatchTotality TimerDomain TimedObligations EffectConditions GuardDiscriminators
abbrev evalBool (e : Expr .boolean) (ctx : Context) : Bool := TypedIR.eval e ctx

theorem initial : Approved.initial_admitted := by
  refine ⟨rfl, by decide, ?_, ?_⟩
  · intro entry member
    change entry ∈ ([] : List TimerEntry) at member
    simp at member
  · apply (TimerRank.wellTimed_iff Approved.initial).mpr
    intro entry member
    change entry ∈ ([] : List TimerEntry) at member
    simp at member

private theorem p0 : FiringPreserves model rule_0 none := by
  apply EffectConditions.preserves
  intro s f valid _ enabled
  have hSum : s.values.integers 0 + s.values.integers 1 = 128 := by
    have h := List.all_eq_true.mp valid e15 (by simp [model_invariants])
    exact of_decide_eq_true h
  have hBounds : 0 ≤ s.values.integers 0 ∧ 0 ≤ s.values.integers 1 := by
    have h := List.all_eq_true.mp valid e18 (by simp [model_invariants])
    have hab : evalBool e16 (context s zeroValues) = true ∧ evalBool e17 (context s zeroValues) = true := by simpa [e18, TypedMachine.eval, TypedIR.eval, Bool.and_eq_true] using h
    exact ⟨of_decide_eq_true hab.1, of_decide_eq_true hab.2⟩
  have hPos : ¬ (s.values.integers 0 ≤ 0) := by
    have hdec : decide (s.values.integers 0 ≤ 0) = false := (Bool.not_eq_true' _).mp enabled
    exact of_decide_eq_false hdec
  change (decide ((s.values.integers 0 - 1) + (s.values.integers 1 + 1) = 128) &&
    ((decide (s.values.integers 0 - 1 ≥ 0) && decide (s.values.integers 1 + 1 ≥ 0)) && true)) = true
  simp only [Bool.and_eq_true, Bool.and_true, ge_iff_le, decide_eq_true_eq]
  refine ⟨by omega, by omega, by omega⟩

private theorem p1 : FiringPreserves model rule_1 none := by
  apply EffectConditions.preserves
  intro s f valid _ enabled
  have hSum : s.values.integers 0 + s.values.integers 1 = 128 := by
    have h := List.all_eq_true.mp valid e15 (by simp [model_invariants])
    exact of_decide_eq_true h
  have hBounds : 0 ≤ s.values.integers 0 ∧ 0 ≤ s.values.integers 1 := by
    have h := List.all_eq_true.mp valid e18 (by simp [model_invariants])
    have hab : evalBool e16 (context s zeroValues) = true ∧ evalBool e17 (context s zeroValues) = true := by simpa [e18, TypedMachine.eval, TypedIR.eval, Bool.and_eq_true] using h
    exact ⟨of_decide_eq_true hab.1, of_decide_eq_true hab.2⟩
  have hPos : ¬ (s.values.integers 1 ≤ 0) := by
    have hdec : decide (s.values.integers 1 ≤ 0) = false := (Bool.not_eq_true' _).mp enabled
    exact of_decide_eq_false hdec
  change (decide ((s.values.integers 0 + 1) + (s.values.integers 1 - 1) = 128) &&
    ((decide (s.values.integers 0 + 1 ≥ 0) && decide (s.values.integers 1 - 1 ≥ 0)) && true)) = true
  simp only [Bool.and_eq_true, Bool.and_true, ge_iff_le, decide_eq_true_eq]
  refine ⟨by omega, by omega, by omega⟩

private theorem p2 : FiringPreserves model rule_2 none := by
  apply EffectConditions.preserves
  intro _ _ _ _ _
  rfl

theorem preservation :
    Each (fun p => FiringPreserves model p.1 p.2) (rawChecks model declaredTimers) := by
  have hcat : rawChecks model declaredTimers = rawCatalog := rfl
  rw [hcat]
  exact ⟨p0, p1, p2, trivial⟩

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers
    (by
      have checked : (model.rules.all (fun r => declaredStates.contains r.target)) = true := rfl
      intro r member
      exact List.contains_iff_mem.mp (List.all_eq_true.mp checked r member))
    (by
      have checked : (model.rules.all (fun r => r.actions.all fun a =>
        match a with | .arm id _ => declaredTimers.contains id | _ => true)) = true := rfl
      intro r member timer delay armed
      exact List.contains_iff_mem.mp (List.all_eq_true.mp (List.all_eq_true.mp checked r member)
        (.arm timer delay) armed))
    (by decide +kernel)
    (by intro _ _ _ entry _ ht; simp [declaredTimers] at ht)
    preservation
    (by
      have hc : conflictChecks model = conflictCatalog := rfl
      rw [hc]
      exact ⟨conflict_from_empty model _ rfl, conflict_from_empty model _ rfl,
             conflict_from_empty model _ rfl, trivial⟩)

end TimedProof
