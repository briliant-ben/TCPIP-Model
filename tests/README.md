# Focused example tests

```sh
python3 -m unittest discover -s tests -v
```

These standard-library tests compile and run the actual standalone C, compare a
frozen full input/output fixture, check model/source integrity, rebuild the
recorded HTML and reject changed evidence hashes. No API calls, network privilege,
framework clone or Lean installation is needed.

`example.in` and `expected.json` came unchanged from a previously accepted
reference/native run; [fixture.json](fixture.json) records the source archive,
member and exact hashes. The expected output is model-derived, not an independent
RFC or wire oracle. It is never fed to the subject or recomputed to make it pass.

Broader protocol/formal/network experiments are in the pinned Git history, not
silently claimed by this focused test suite.

Next: [demo](../demo/README.md).

`optimization-regression.json` freezes inputs and complete stdout/stderr digests
from the pre-optimization generated C for 24 existing paths (157 transitions).
The initial optimization gate also compared the new output against the reference
interpreter. These digests must not be refreshed from changed code to make it pass.
The standalone regression uses no framework or expected output as subject input.
