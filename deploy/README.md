# Small server release

The repository retains large historical evidence. `package.py` exports only the
accepted runtime/tool files, task/source/oracle closure, external client and37
specialized tests from a named Git commit. No credentials, venv, build binaries or
historical artifacts enter this release. The first accepted package revision is
59 source files, about276KB compressed; it includes the event baseline required
by tests as well as TCP-wire and UDP tasks. The initial58-file package omitted
the event task and correctly failed testing; it was not accepted or overwritten.

```
.venv/bin/python deploy/package.py --source REVIEWED_COMMIT --out NEW_BUNDLE
python3 deploy/unpack.py NEW_BUNDLE/spec-flow-server.tar.gz --sha256 APPROVED_SHA --out NEW_RELEASE
python3 deploy/bootstrap.py NEW_RELEASE --out NEW_RESULT
```

Transfer the archive and trusted unpack/bootstrap helpers through the existing
SSH connection. Verify the independently supplied archive SHA before unpack.
Unpack rejects links, traversal, duplicates, excess bytes and manifest mismatch;
it never executes archive programs. Bootstrap requires Python3.12+ and an existing
C compiler, creates its own venv, installs the fixed dependency, then actually
runs37 specialized tests and three tasks plus verify. Missing prerequisites or
failed gates stop deployment; no system package/network/service settings change.

The first deployment is to the user's previously used local Linux server in a
new project-owned `protocol-flow` directory. Existing projects and network/SSH
configuration are untouched. Credentials live only in the project-private server
directory with owner-only permissions, outside release/candidate/result manifests
and outside Git. Never paste credentials in an example, prompt, git commit or log.

`agents/deepseek_gateway.py` reads `DEEPSEEK_API_KEY` or an owner-private credential
file and sends authentication only to the official DeepSeek endpoint. Its locked
write-ahead ledger shares request-count limits across concurrent calls, deduplicates
completed inputs and refuses automatic retries for failed/uncertain inputs. Known
provider token usage, including cache hits/misses, is retained. It adds no arbitrary
model-supplied shell/tool execution. Model roles/outputs are separate from trusted
execution and acceptance. See docs/ipv4-endpoint-roadmap.md for the current broader
implementation scope and limits.

An API response is not a protocol acceptance. The first two-role trial returned
an independent scenario set and one rejected model JSON response; the controller
found a literal discard-count error in that scenario set too. Neither result was
silently treated as correct. Original provider usage remains accounted for and
no automatic retry bypassed the shared budget.


The optional fixed `native-bytes` profile additionally includes the inherited TCP
data model chain, its local interpretation sources,15 data and101 connection scenarios and the generic
native suite driver. Bootstrap runs26 additional native methods and the fixed-
input Z3/native data suite plus101 native connection cases. Its pass scope is concrete input correspondence, not whole-
model TCP safety. Existing flow-only releases and private credentials stay separate.

The fixed `udp-payload` profile adds the integrated byte-descriptor task and four
UDP payload methods to the default release:41 methods and four full task runs/verify.
It leaves flow/native-bytes profiles unchanged. No provider requests are needed.
