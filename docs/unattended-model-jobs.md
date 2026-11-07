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


2026-11-02：34e47060集成UDP字节flow已在独立Linux发布实际通过41专项及四完整任务/verify（原三基线全部回归）。UDP任务4见证+6原字面量种子+9model-gap拒绝共19例、13独立trace、depth3双UNSAT；70源码/约285KB包。751原服务器文件及原本地探索编码失败在artifacts/udp-payload-flow-34e47060，只读验收逐70不可变Git blob/原Git校验器核验四job，不运行归档Python/ELF/solver。通用protocol_lab源码未改，独立数据模块经相同flow成立；未宣称UDP wire/PCAP/完整IPv4端点。另一有界agent已返回UDP线编码IR语义设计提案，尚未实现或批准，保留artifacts/udp-wire-design-0001；累计10调用75605已知token，原12上限不重置；本轮集成/部署/验收零API，仅此新设计调用9492token。旧2e67601e五CI实际通过，新集成提交CI需单独等终态。下一步审查新字节/packing/checksum显式IR语义并同步参考/独立Z3/C后端；禁止将提案当实现或绕过formal拒绝。


2026-11-02：3180159b的IR0.4纯算术已在Linux独立发布实际通过88专项、五完整任务/verify、15TCPdata原生+固定输入Z3及101连接原生回归；213源码/约349KB包，1562原始文件在artifacts/wire-arithmetic-server-3180159b。原Git只读验收核213输入、五job、重渲染/重比较116原始TCP观测，检查15SMT/result，不执行归档Python/ELF/solver。算术任务12例/11literaltrace，depth2双UNSAT只为长度/range；另外固定odd-carry查询在全新Z3 context重载后UNSAT，单独保存查询/哈希，不扩称全checksum等价。独立DeepSeek源码审查2245token，无具体findings且列出限制，不算证明；台账累计11调用77850已知token，原12上限未重置。服务器新版本所有门禁通过，本轮新CI待新分支PR终态。后续优先补显式字节读取/原始IPv4-UDP线编码IR与PCAP，不能把纯算术当UDP实现。旧UNKNOWN、2750ms差异及用户未提交目录保持。


2026-11-02：修订1b13a36f在Linux独立发布实际通过96专项、六完整任务/verify、15TCPdata原生/固定输入Z3和101连接回归。新发送task9例/10literaltrace、9个实际C生成IPv4/UDP包，其PCAP由原字节封装、独立解码/校验/对六固定oracle全部匹配；模型IR中明示全部layout/checksum/default/zero policy，无新opcode或UDP Ccodec。228不可变源码/约374KB包、1746原文件及原Git只读验收在artifacts/udp-transmit-server-1b13a36f。特别逐字节确认两份全depth2/全输入safety与overlap SMT和原f947诊断完全一致；只为存在性非空样本增加exact固定choice单事件SAT+重放（样本查询/哈希另存），不把未知全输入性质变为固定例证明。原失败/UNKNOWN保持、未来失败test job保留。独立agent静态协议审查无findings但非证明、未审后续采样优化；累计12调用83412已知token，原12上限已达，不自重置；只付费agent通道受限，本地继续。功能仍固定tuple/TTL64/DF1ID0/MTU1500发送虚拟链路，不是UDP接收/ARP/ICMP/Linuxpeer/物理抓包/完整栈。后续补原始包字节读取/接收及独立peer渠道，再跨层组合。新PR/CI按实际状态更新，不自动merge。
