Reproduce with `.venv/bin/python artifacts/output-schedule-alignment/check.py`.
This reuses an independently verified, real lwIP memory-netif capture; no new
implementation execution or Linux evidence is claimed. All seven original source
steps are consumed once. Three declared segment choices match all nine frames
with strict checksums, order, bytes and zero time tolerance, and public callbacks
report written8/acknowledged4. The original canonical final contract still FAILS;
its full differences are mandatory output. The original strict Difference is
unchanged. A fourth segment satisfies that old final contract but contradicts
both wire and callback observations. This finite existential witness establishes
neither universal refinement nor general Nagle/SWS or partial-ACK callback behavior.
