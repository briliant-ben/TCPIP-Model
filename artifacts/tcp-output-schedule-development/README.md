Unregistered finite output-schedule development profile. Reproduce in order:

```sh
PYTHONPATH=. .venv/bin/python artifacts/tcp-output-schedule-development/generate.py
PYTHONPATH=. .venv/bin/python artifacts/tcp-output-schedule-development/verify.py
.venv/bin/python -m protocol_lab inductive model/tcp-output-schedule.json --out artifacts/output-schedule-current-induction
.venv/bin/python -m protocol_lab inductive-refine model/tcp-output-schedule.json --inductive artifacts/output-schedule-current-induction --out artifacts/output-schedule-current-refinement --group-size 1
.venv/bin/python -m protocol_lab inductive-refine-verify model/tcp-output-schedule.json --inductive artifacts/output-schedule-current-induction --out artifacts/output-schedule-current-refinement > artifacts/output-schedule-current-refinement/verification.log 2>&1
.venv/bin/python artifacts/output-schedule-alignment/check.py
.venv/bin/python -m unittest discover -s tests -p test_output_schedule.py -v > artifacts/tcp-output-schedule-development/unit-tests.log 2>&1
.venv/bin/python artifacts/tcp-output-schedule-development/accept.py
```

The primary induction command currently returns2/unknown; retain that report and
continue the separate refinement command. Primary depth6 BMC also remains unknown.
Fixed-byte replay SAT, synthetic codec checks and content-insensitive invariant
partitions have distinct scopes. The real full-capture witness retains the old
canonical-final failure; it is neither a pass of that old fixture nor a general
implementation refinement. No new C execution, Linux evidence, kernel proof or
complete protocol is claimed. See docs/tcp-output-schedule.md.
