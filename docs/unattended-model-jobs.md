# Bounded unattended modeling jobs

User2026-11-01 authorized server-side agents with occasional controller checks.
`agents/run_model_job.py` runs two independent DeepSeek JSON roles concurrently:
a declarative IR proposer and a specification-only literal scenario reviewer.
The reviewer does not see candidate IR. Its scenarios are frozen before candidate
validation; repairs cannot alter them. This is independent model generation,
not independent human approval: reviewers can be wrong and pass remains a
candidate requiring controller inspection and further pinned acceptance tasks.

The first job is `agents/jobs/udp-payload.json`: RFC768 and RFC1122§4.1.3.4
source-hash-bound excerpts, fixed byte service interface, empty/odd/NUL content,
UDP-length slicing, padding, duplicates and checksum/discard descriptors.
It is a prerequisite slice for byte-level cross-layer work; it does not implement
UDP wire/checksum arithmetic, ICMP port unreachable, PCAP or the whole endpoint.
No arbitrary Python/shell/file paths from provider responses are executed.
Only the fixed controller validator generates/compiles C from admitted IR.

A job runs at most two initial requests and two model repairs; output caps are
8192/6000 tokens and gateway requests share the existing lifetime12-call ledger.
Completed identical requests reuse cached responses; uncertain/failed requests
never automatically retry. Only completed model proposals failing tool validation
may receive explicit new repair prompts. Timeout/UNKNOWN stops with unresolved;
there is no paid repair for solver deadlines. No self-resetting budget or infinite
daemon. Job wall budget is two hours, each validation subprocess at most240s.
Separate private credentials remain outside prompts/results/Git.

Actual validation runs reference scenario0.2 contracts, generated-native exact
comparison, independent fixed-input Z3 replay, then depth3 safety/overlap checks.
No UNKNOWN promotion or all-input/unbounded/compiler proof claim. A source/initial
state/interface change is rejected. Candidate-ready means only these candidate
slice gates passed; it is never automatically committed, pushed or merged.
The controller must examine literal reviewer outputs, scope and source mappings.

The process runs detached under the existing server account in the project-owned
controller/job directories and survives SSH disconnects. `status.json` is atomic;
`controller.lock` prevents concurrent controllers for the same job. A STOP file in
the job directory prevents the next API request (an in-flight request/validation
may finish). Partial validation is retained for inspection. Terminal jobs exit;
no daily billable scheduling is installed on the server. A sparse local heartbeat
inspects meaningful changes without provider calls during read-only monitoring.

## Current deployment and monitoring

Controller Git source: d1b19c9dc13c3e30fb9cf14abf513fb29cc2f3c6.
Server controller: /home/blxu/protocol-flow/controllers/d1b19c9d/agents/run_model_job.py.
Current job: /home/blxu/protocol-flow/candidates/udp-payload-0002/status.json.
Detached process initially586075; verify process identity before any operation.
Log: /home/blxu/protocol-flow/controllers/d1b19c9d/job.log.
Tools/venv: /home/blxu/protocol-flow/releases/native-bytes-2a2fed2c.
A local thread heartbeat checks about every four hours and stays quiet on unchanged
state. It requires the local Codex scheduler to be available; server execution itself
does not require the local app or SSH connection to remain open.

The first0001 run stopped before validation because the reviewer omitted scenario
version and step time envelopes; its independent literal output rows contained the
times. Both initial paid results succeeded (12591 tokens total) and are retained.
The revised controller adds only missing version metadata and copies each step's
time from its single reviewer-authored literal trace row, recording every addition;
it does not alter expected content or infer it from the model. Both initial role
requests in0002 reuse the exact cached requests, not new paid calls. The initial IR
used invalid and/send syntax; tool diagnosis now drives a bounded model repair.
Four offline controller methods pass, including output-preserving normalization.
A task may finish or stop before the next heartbeat; it is not an infinite coding
service or authority to bypass the shared budget/acceptance review.


2026-11-01后台巡检：0002作业终态unresolved，六个原生场景和固定输入Z3匹配，但depth3 safety UNKNOWN/canceled、overlap UNSAT。控制器发现真实合同缺陷：接收规则缺uint16及bytes<=4096域条件，负端口被接收，超容量输入未排除；六个场景通过不足以验收。原始候选/ELF/SMT/UNKNOWN及拒绝审查在artifacts/udp-payload-agent-0002，未集成。共享台账八请求56821已知token（本轮三调用21210，修正输入缓存4224）。在原12上限内仅安排一次新修正，固定oracle不变，并新增九个恶意域探针。最新后台作业/home/blxu/protocol-flow/candidates/udp-payload-0003/status.json，控制器/home/blxu/protocol-flow/controllers/6efcc2e7/agents/repair_model_job.py，日志同控制器目录job.log，初始PID593317；以实际进程及状态为准，不自动重启。原UNKNOWN不改写，不为solver期限付费重试。


续：0003一次付费修正完成后因两处三元and被严格IR拒绝（Boolean type mismatch）；原候选保留，不自动付费重试。累计九调用66113已知token，预算仍12。控制器在新0004工作区仅把两处and(a,b,c)显式结合为and(and(a,b),c)，操作数/顺序不变，normalization.json绑定原模型SHA及两处路径；无API调用，不改原六场景。最新状态/home/blxu/protocol-flow/candidates/udp-payload-0004/status.json，日志controller.log，初始PID593635，原固定九域探针及参考/C/固定输入Z3/depth3门禁重新实际运行。此结构规范化不构成批准，仍待实际结果；0002 UNKNOWN保持。


执行补记：0004首次内联验证脚本因SSH引号丢失导致SyntaxError，未执行任何native/Z3步骤，原controller.log保留。改为传输仓库agents/validate_normalized_job.py文件启动，零API，实际进程593884，日志validation-controller.log；不得将原启动记录当作完成验证。


巡检结果：0004固定验证实际通过，六原生场景/13字面量trace步骤、六独立固定输入Z3匹配、九非法接收域探针、depth3 safety及overlap均UNSAT。控制器已逐完整模型JSON核对仅两处and结构规范化、原场景SHA不变，重渲染C/重比较六原观测、六生成器输入对2a2fed2c不可变Git及SMT哈希一致；76原始文件在artifacts/udp-payload-agent-0004。零API本地核验，不执行归档Python/ELF/solver；旧0002 UNKNOWN单独保留。累计九调用66113已知token，原12上限不重置。候选有限切片门槛通过但尚未集成model/与十阶段flow，也不是UDP线端/PCAP或完整IPv4栈。下一检查点先固定源/场景/探索域/task并串行集成，再推进wire/跨层。0004进程已自然结束，不应重启已完成作业。
