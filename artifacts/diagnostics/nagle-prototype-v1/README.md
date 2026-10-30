# Nagle prototype diagnostics

The first generator used unsupported gt; loader explicitly rejected it before executing tests. The correction uses existing ge semantics, with no backend extension.

The second generator copied the empty-send housekeeping rule for the option event and unintentionally retained its application empty_send notification. Six of seven methods passed, but the option method exposed that concrete model-output error. The old generator/model/tests/log and completed conditional component evidence are retained. The component property concerns new-data gating only; passing it cannot prove option output correctness, illustrating why this is not whole-model verification. Current option cloning removes the single exactly anchored application empty_send emit while retaining housekeeping and parent TCP effects. No parent oracle is modified.

The additional CLOSE-WAIT/wrap fixture initially omitted the mandatory FIN ACK field. The executor rejected the malformed event before protocol processing; original failed fixture/log are retained. The corrected field uses unchanged current SND.UNA. This is a fixture error, not a TCP behavior discrepancy.

Review found that a directory-wide generated-artifact glob would include prior verification/acceptance reports on a subsequent run, creating stale circular bindings. The current generator names its own outputs explicitly and includes only its symbolic output directory. The earlier script is retained; generation, independent verification and acceptance are repeated over existing outputs to check reproducibility. This review finding is not presented as a protocol defect.
