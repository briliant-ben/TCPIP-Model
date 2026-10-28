Finite Limited Transmit developer milestone. All protocol actions are explicit IR; no runtime callbacks. Default SMSS4/queue16, no SACK or complete TCP claim. Four handwritten fixed-input byte/output-order/time contracts; synthetic codec is model evidence only. Independent lwIP observations are separately bound in artifacts/lwip-limited-transmit.

Reproduce model tests:
.venv/bin/python -m unittest discover -s tests -p test_limited_transmit.py -v

Rebuild/verify development scenario evidence:
PYTHONPATH=. .venv/bin/python artifacts/tcp-limited-transmit-development/acceptance/development-driver.py
PYTHONPATH=. .venv/bin/python artifacts/tcp-limited-transmit-development/acceptance/development-verifier.py

Primary and supplementary obligations:
.venv/bin/python -m protocol_lab inductive model/tcp-limited-transmit.json --out artifacts/limited-transmit-current-induction
.venv/bin/python -m protocol_lab inductive-refine model/tcp-limited-transmit.json --inductive artifacts/limited-transmit-current-induction --out artifacts/limited-transmit-current-refinement --group-size 1
.venv/bin/python -m protocol_lab inductive-refine-verify model/tcp-limited-transmit.json --inductive artifacts/limited-transmit-current-induction --out artifacts/limited-transmit-current-refinement

Keep original snapshots or use fresh output directories before rebuilding. Primary unknown is retained regardless of supplementary checks. Historical arbitrary-state SAT and mistaken port test assumptions are preserved at diagnostics/limited-transmit-induction-epoch-v1; the original model is isolated in its archive and never restored to the active chain. No upstream changes, relaxed hashes or oracle filtering. The finite queue makes threshold clamping numerically indistinguishable, so the distinct loss basis is itself explicit and tested. Later full regression must be bound to the recorded new commit; the ongoing357 run is not extended retroactively.
