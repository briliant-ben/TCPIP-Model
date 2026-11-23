# Recorded demo

Open [review.html](review.html) locally for19 actual transitions and25 original
packets from one IR-generated C process. Expand a transition to inspect its IR
rule/actions/source references, or a packet to inspect its raw bytes.
[ capture.pcap ](capture.pcap) opens directly in Wireshark.

```sh
python3 demo/build_review.py
```

The viewer reads only the original [recording.zip](recording.zip), verifies its
fixed digest and model/packet/trace bindings, and renders HTML. It never runs
archived Python or native binaries. [provenance.json](provenance.json)
records the original source, hashes and trust boundary. One compact original
recording is retained because it supports this demo, not as a replacement for
all historical experiments.

Logical C time and measured capture time remain separate. Regenerating the view
is not a new network execution or proof. For a new local execution use
[code/build.py](../code/README.md); independent live-network qualification is a
separate workflow outside this focused repository.

The recording binds the pre-optimization C hash, retained in `provenance.json`.
The current generated C is separately qualified by the frozen regression in
`tests/optimization-regression.json`; the old capture is not evidence of a new
network execution of the optimized program.
