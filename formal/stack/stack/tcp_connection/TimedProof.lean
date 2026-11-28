import Approved
import StackCert

set_option maxRecDepth 16384

namespace TimedProof
open Approved FormalSpecAgent TypedIR TypedMachine BatchTotality TimerDomain TimedObligations StackCert

private def targetsValid : Bool :=
  model.rules.all (fun r => declaredStates.contains r.target)

private def armsValid : Bool :=
  model.rules.all (fun r => r.actions.all fun a =>
    match a with
    | .arm id _ => declaredTimers.contains id
    | _ => true)

theorem initial : Approved.initial_admitted := by
  refine ⟨rfl, by decide, ?_, ?_⟩
  · intro entry member
    change entry ∈ ([] : List TimerEntry) at member
    simp at member
  · apply (TimerRank.wellTimed_iff Approved.initial).mpr
    intro entry member
    change entry ∈ ([] : List TimerEntry) at member
    simp at member

theorem preservation :
    Each (fun p => TypedFiringContracts.FiringPreserves model p.1 p.2) (rawChecks model declaredTimers) :=
  preserves_all model declaredTimers rfl

theorem timers : TimerContracts model declaredStates declaredTimers :=
  timer_contracts_from_checks model declaredStates declaredTimers
    (by
      have checked : targetsValid = true := rfl
      intro r member
      exact List.contains_iff_mem.mp (List.all_eq_true.mp checked r member))
    (by
      have checked : armsValid = true := rfl
      intro r member timer delay armed
      exact List.contains_iff_mem.mp (List.all_eq_true.mp (List.all_eq_true.mp checked r member)
        (.arm timer delay) armed))
    (by decide +kernel)
    (covers_all model declaredStates declaredTimers rfl)
    preservation
    (conflicts_all model rfl)

end TimedProof
