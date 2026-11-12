# 6. Recorded execution and demonstration

Open [review.html](review.html) locally. It presents **19 actual transitions and
25 independently captured packets** from the accepted single-process Linux run.
Expand a rule to inspect its exact IR guard/actions/specification references;
expand a packet to inspect the original bytes. UI text is English. Logical C
clock and measured capture clock remain separate.

```sh
.venv/bin/python demo/build_review.py
```

This regenerates an offline view from the hash-pinned original ZIP. It does not
execute archived Python/ELF/solver code, run a network peer, or overwrite the old
historical review page. The [original audit](../artifacts/ipv4-prototype-final-9289/readonly-audit.json)
and [delivery summary](../artifacts/ipv4-prototype-delivery-20261112/summary.json)
are the source of the claims, not the presentation itself.

For a **new local code execution**, use [code/build.py](../code/README.md). For a
new independent Linux capture, use the isolated
[Linux peer harness](../ports/linux-tcp-ipv4-peer/README.md) with its declared
permissions/configuration and retain a separate evidence bundle.

The finite prototype is delivered under its fixed contract; the general flow
remains `unresolved`. This demo is not a production TCP/IP stack, physical
Ethernet qualification or complete protocol/compiler proof.

Back to [the case study](../README.md).
