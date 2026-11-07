# First generated TCP live execution: acceptance failed

Git head 2690a3af979e9780b5ccf7c05008661e5f586ece, push run 42351785157,
job 128341289311, artifact 13565324904 (47 original files).
Original ZIP SHA256 9de4b3190d786da9fcb199a55dce4834c96d42e3a220cfaa0115bc5493f9edb9.

The namespace performed active open, binary echo and close to TIME-WAIT. Retained
native/reference comparison reports pass with nine transitions. Acceptance failed
before the symbolic gate: timer pairs are tuples in the live Python result but
lists after JSON serialization. The strict final snapshot checker accepted only
serialized lists. This is an adapter format failure, not an RFC or model defect.
Original failure is not promoted to accepted TCP evidence. Fixed-input symbolic
network evidence is absent. Original files were read, not executed locally.
The fix accepts either representation of exactly the same sorted name/due pairs;
state, timer values, final snapshot, model and peer are unchanged.
