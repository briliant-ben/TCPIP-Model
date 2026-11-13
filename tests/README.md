# 5. Tests and observations

Start with the focused case-study checks:

```sh
.venv/bin/python -m unittest discover -s tests -p test_showcase.py -v
.venv/bin/python -m unittest discover -s tests -p test_framework_client.py -v
.venv/bin/python -m unittest discover -s tests -p test_ipv4_rule_coverage.py -v
```

The showcase tests compile/regenerate the actual C snapshot and run an example;
the client tests exercise the fixed framework pin and source rejection; the
coverage tests execute24 frozen default paths and compare complete traces.
They do not claim a fresh live network run or a rerun of every historical proof.

| Inputs/results | Purpose |
|---|---|
| [scenarios/](../scenarios/) | Frozen literal and scoped model-derived regression inputs |
| [spec/*-oracle.json](../spec/) | Independent protocol byte/output contracts |
| `test_framework_client.py` | Cross-repository execution and frozen legacy-source checks |
| `test_ipv4_rule_coverage.py` | Default-initial generated-C/reference path regression |
| [retained evidence](../artifacts/) | Original query/native/PCAP/log files, including failures |

The remaining tests are still useful component, fault and historical-regression
experiments. Protocol/domain-negative input, rule conflict, invariant failure,
resource UNKNOWN, invalid evidence and implementation Difference stay distinct.
Some external-channel tests need Linux permissions or optional tools and report
that limitation explicitly. Do not treat a synthetic PCAP or lwIP observation
as an independent Linux peer capture.

Next: [recorded demonstration](../demo/README.md).
