import TCPIPAudit
namespace TimedProof
open Approved FormalSpecAgent BatchTotality TimedObligations TypedFiringContracts
theorem initial : Approved.initial_admitted := TCPIPAudit.endpoint_initial_admitted
theorem timers : TimerContracts model declaredStates declaredTimers := TCPIPAudit.endpoint_timer_contract
theorem preservation : Each (fun p => FiringPreserves model p.1 p.2) (rawChecks model declaredTimers) := TCPIPAudit.endpoint_all_preservation
end TimedProof
