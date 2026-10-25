# 持续实施记录

## 2026-10-24：本地基线恢复

当前仓库 HEAD 为 `bb921b5`，克隆时工作区干净，仓库和父目录未发现 AGENTS.md。未回退或覆盖已有改动。

环境：macOS arm64 / Darwin 27.0.0、Python 3.12.14、Apple clang 21.0.0、Z3 4.15.4.0。系统 Python 3.9 不满足要求，虚拟环境由本地新版 Python 创建；依赖按 requirements-formal.txt 固定安装。虚拟环境、编译二进制和 macOS 调试符号均不入库。

验证：78 项 unittest 通过；build、formal（深度 6）、suite --formal --depth 6、suite-verify 通过。lwIP 实际 C 执行两次连接均成功；handshake 投影匹配，syn-loss 重传为 2750ms，仍与模型 1000ms 配置不同；lwip 返回 1，lwip-verify 为 valid_execution_evidence。未改动上游或 oracle。

Linux 通道：本机有 tcpdump，但没有 packetdrill、Linux /dev/net/tun、ip 网络命名空间或 Linux capabilities。没有 Linux 实机证据；未更改宿主网络。仅该通道受阻，继续模型开发。

## 实施里程碑

1. 基线恢复（已完成）：重建全部本地证据，保留实现差异。
2. IR 数据基础：版本化字节串、长度、拼接、切片及序列空间谓词；参考与独立 Z3 后端同步，覆盖边界、回绕和故障变体。
3. TCP 有限数据切片：显式缓冲、分段、累计 ACK、窗口与重传，固定支持范围和场景；不得标为完整 TCP。
4. 连接组合与恢复：保持唯一序列号/定时器语义，逐步加入乱序、RTT/RTO、delayed ACK、persist、拥塞与恢复，以及独立实现验证。
5. 后续协议：按用户给定顺序推进 UDP、IPv4、ICMP、ARP、IPv6/NDP、socket 与组合，分别固定规范、假设和验收条件。

每个完成的里程碑提交文档、代码、测试与当前证据。形式结果始终有步数边界；场景和规则覆盖不等于规范完整性。

## 2026-10-24：IR 数据基础

新增 opt-in IR 0.2；bytes 的 JSON 八位组表示、截断切片、长度与拼接，整数 sub/min，32 位前向距离及半空间比较在参考解释器与独立 Z3 后端同步实现。语义与条款链接见 semantics.md；RFC 9293 §3.4 为 TCP 规范依据，RFC 1982 §3.2 仅是通用串行数比较参考。没有把任意回调引入 IR。

字节列表在初值、事件、状态、输出和轨迹间采用复制的值语义；失败事务回滚。新操作在旧版模型中明确拒绝，未知后端操作报错。Z3 资源异常转为带原因的 unknown，保持不确定结果不能通过的门槛。

11 项新增测试通过：包括字节容量 BMC 深度 3、全 BV32 对的半空间谓词查询、具体字节/回绕见证重放、边界与错误类型、错误序列推进故障反例。已知限制：混合字节长度与序列关系的通用 BMC 可能超时；该性质未宣布通过。

## 2026-10-24：有限 TCP 数据切片（M3 首段，非完整 M3）

`tcp-data.json` 声明式扩展现有连接模型，展开为 117 条规则的单一 IR。新增 16 字节发送/接收容量、MSS=4 分段、累计/部分 ACK、WL1/WL2 窗口更新、重复/旧/未来 ACK、字节前缀重传、重叠裁剪、接收窗口重开及排空后关闭。连接模型仅将固定输出窗口参数化为 local_window（默认 65535），数据 profile 使用 16；原控制行为与上游 lwIP 未改动。协议决策全部位于 JSON guard/action。

新增 15 个数据场景；测试同时将 101 个控制场景投射到组合模型。新增固定输入符号重放产物和三个故障变体：重传错误推进序列号、完整 ACK 漏取消定时器、部分 ACK 错删前缀，均可产生并重放不变量反例。字节/窗口 PCAP 投影使用独立解析器，默认主动打开通道继续拒绝 payload。

实际限制：数据深度 6 的全输入 safety 和 overlap 查询均为 unknown（求解限时），suite 如实为 formal_pending_stack_incomplete；具体场景符号重放不是替代证明。乱序重组、一般 piggyback、窗口右边缘收缩、未排空时 FIN、完整 RTO、拥塞恢复和数据独立实现闭环仍未完成。下一实施顺序见 roadmap.md。

本里程碑全量回归为 103 项测试；数据 suite 另保存固定输入查询/见证/重放，以及带 payload/window 的合成 PCAP 独立解析、归一化和 Difference。合成往返标注 synthetic_codec_roundtrip_only，绝不升级为实机证据。复查还修正了接近半空间时分别对 UNA/NXT 分类旧/未来 ACK 可能重叠的问题：统一以 UNA 前向距离分区，并加入边界回归。旧模型、lwIP 和全部输入/产物哈希在当前源码上重新生成后验收。

## 2026-10-24：独立状态归纳义务

上一 goal turn 已提交实质进展，本轮先核对干净工作区。完整 Seq/BV32 BMC 仍受限时；尝试仅长度投影、长度+完整模整数后，深度 6 查询仍 unknown，未替换或修改原 BMC 结论。

新增独立归纳路径：对内容不敏感的 guard/标量/长度状态性质使用精确长度投影（全 Seq 拼接/切片公式反例查询 unsat），序列号保留全部 2^32 取值并使用模整数。字节内容比较明确拒绝。分别保存初值、每条规则保持及每个多规则 guard 组的 SMT-LIB 和哈希，另用原完整字节/BV32 后端求非空见证并参考重放。

初次检查得到 116/117 条保持义务 unsat；同时打开的任意前状态暴露缺少 SYN-SENT 中 SND.UNA=ISS 的派生关系，不能认定为可达协议故障。将该关系作为新的 IR 不变量后，初值、117 条规则和 14 个 guard 组均通过，关系自身也在保持义务中验证。删去该关系可复现归纳失败；三个已知可达数据故障变体均使相应保持义务失败。此阶段未实现新的 TCP 数据行为，乱序重组与后续完整范围仍待推进。

本轮验证：113 项 unittest 通过（含 10 项新增归纳/编码测试）；导出的所有保持/重叠脚本在新 Z3 进程中重新执行得到相同 unsat；build、旧两个模型 depth=6、suite-verify 与归纳查询/模型哈希验收通过。数据 BMC 仍为 unknown，suite 保持 formal_pending_stack_incomplete。lwIP 两连接执行成功、丢包时序差异保留，lwip-verify 通过；Linux packetdrill 入口再次记录本机 darwin 环境的 not_run。没有修改上游 lwIP 或 oracle。

## 2026-10-24：显式有限乱序重组

上一 goal turn 已提交独立归纳能力，本轮工作区核对为干净。核对 RFC 9293 §3.10.7.4 Table 6、SHLD-31 和 MUST-59 后，新增 `tcp-reassembly.json` 声明式继承数据与连接模型，替换五条接收规则为一个显式队列转移。16 个单字节/空槽共用原 16 字节接收容量，支持多个缺口、重叠/重复、回绕、窗口裁剪和读出后的队列位移；先接受的字节保留，作为明确的冲突策略，不冒充 RFC 唯一要求。数据全部连续排空后才发一次累计 ACK；复位/ABORT 清理队列，关闭须队列也排空。

仅新增通用同型条件表达式 ite，参考、完整 Seq/BV32 与长度后端同步实现，条件长度恒等式加入原语检查；所有协议决策在展开 JSON 内。Profile 可引用多个场景目录并绑定全部来源，跨目录 ID 冲突或目录逃逸拒绝。旧数据模型和两个连接基线继续独立运行，没有分叉序列或定时器实现。

重组 profile 复用 15 个数据场景并新增 11 个队列场景。针对性测试已覆盖 24 种四段排列、重复、非零字节、读/移位/回绕、Table 6 全跨窗口情况及清理。丢槽与同长度错误覆盖由内容场景发现，提前 ACK 由 Difference 发现，错误移位产生并重放完整字节求解反例，失败事务回滚。该 profile 的独立初值、113 条保持义务、13 个 guard 组、84 个不变量通过；长度证书仍不宣称证明字节内容。

本轮完整验证：127 项测试通过。build、旧 active-open/connection 的 depth=6、四 profile suite 与 suite-verify 通过本地执行/完整性门槛；data 与 reassembly 的原始 BMC 均为 unknown，suite 状态仍 formal_pending_stack_incomplete。重组 26 个场景完整字节符号重放均 match，合成 PCAP 独立归一化/Difference 均 match_synthetic_only，自己的归纳证书通过。lwIP 重建并重新绑定当前源，普通握手匹配、丢包场景连接成功且 2750ms 差异保留，lwip-verify 通过；Linux 入口记录 not_run。未修改上游或放宽 oracle/哈希。一般 ACK/window 与 payload 组合、带数据关闭、完整恢复及后续协议仍未完成。

## 2026-10-25：ACK/window 与 payload 组合及命题绑定

继续当前分支未提交工作，没有回退已提交基线。新增 tcp-segments 声明式扩展重组/数据/连接链，109 条规则与 84 个状态不变量：接收序列有效性先于 ACK/window；接受段的累计/部分 ACK 与文本重组在一个有序事件中处理；未来 ACK 不填补缺口，旧 ACK 仍可携带文本；WL1/WL2 使用明确记录的原始头部选择。允许窗口收缩，阻止负可用窗口的新数据，正窗口限制重传前缀，零窗口且仍有在途数据时只探测最旧一字节。无在途数据 persist、未排空关闭和完整恢复仍待实现。

IR 0.2 新增显式 arm_if/cancel_if，参考及完整字节/长度后端同步编码启用条件与故障条件。组合新增 guard 替换、prepend、精确锚定 action edit 和 requirement 追加；父模型动作变化必须拒绝锚定编辑，未将协议逻辑放进 Python 回调。新增 14 场景并复用 26 输入；独立期望和故障变体分别检查处理顺序、窗口 freshness、部分 ACK 重启、错误未来 ACK 和定时器取消。

研究 Anthropic/Theorem 后保留 IR/Z3 主线，新增每 profile 的 claims.json，绑定实际命题、范围、假设、源与查询哈希、检查器版本和可信组件。哈希验收仅是完整性/一致性检查，不冒充翻译器正确性或 Rocq 内核检查。未知、归纳状态性质和固定输入重放分别记录；后续 Rocq 语义引理及实现精化仍须实际机器检查。调研资料与适用性记录在 docs/research 中。

全量 unittest：152 项通过。独立实现重新执行 lwIP，两连接成功、2750ms 与固定 1000ms 的差异保持，lwip-verify 通过。Linux 入口在当前 darwin 缺工具/权限的环境记录 not_run。没有修改上游 lwIP 或放宽 oracle/哈希。完整 suite 的实际查询结果与验收在本条后续补记。

完整证据重建及 suite-verify 已完成：五个 profile 的当前产物/输入与 claims 绑定有效；active-open/connection 的 depth=6 均 bounded_pass；data/reassembly/segments 的原 BMC 均 unknown，三者各自状态归纳通过，15/26/40 个固定输入完整字节重放 match。suite 仍为 formal_pending_stack_incomplete，合成 PCAP 仅作为 codec 检查，未产生数据实机证据。

## 2026-10-25：Rocq 原语试点接入（检查结果待 CI）

ACK/window 里程碑 9ca8d44 已经通过 GitHub 官方 SSH 443 端口推送（22 端口被关闭）。新增独立 Rocq 原语证明/冻结命题包装器和空公理审计，锁定官方 9.2.0 容器 digest；CI 依次编译、新检查 proof objects，并运行错误证明/注入公理负控制。此次只涉及通用切片、拼接和模加法，没有手写第二套 TCP 状态机。绑定源/产物、版本、命令、定理和可信边界；Python/SMT 对应和 TCP 内容性质仍待证明。

本机实际调用检查入口返回 not_run（rocq 不可用），未产生内核证明通过声明。Python 编排语法检查通过；远端 CI 必须实际通过后才验收此试点。未修改运行时语义或上一里程碑证据绑定。

首轮 CI 未通过版本门槛：官方 9.2.0 镜像的编译器实际打印 9.2；未执行后续证明。修正为记录实际展示版本并在锁定容器内额外检查已安装 rocq-runtime 包版本 9.2.0，保留精确 digest；没有放宽证明或公理门槛。

第二轮 CI 已通过六个命题编译、公理审计和精确包版本检查；后续内核复查因命令拼写 chk 被官方 CLI 拒绝。根据实际 help 修正为 rocq check；此前没有将编译通过升级为整个试点通过。

Rocq 试点实际验收完成：提交 425f034 的 push 作业 40173581044 / job 121109429495 和 PR 作业 40173583793 均 success。六个冻结命题均 Closed under the global context；rocq check 报告 Modules were successfully checked；错误证明由编译器拒绝，注入公理由审计拒绝。包版本 9.2.0、实际展示版本 9.2 与锁定镜像 digest 一并保存。

下载 artifact 12591032715，归档 SHA256 aa56254d616c8ae4ef0a1a57640eb56c653048041214b99fd322b5a02294b58a；逐项核对当前源码与全部产物哈希后保存 artifacts/rocq，含两份 .vo、精确命题源、编译/内核/公理/负控制日志及 CI 来源。不是本机执行，不是 Linux TCP 证据，不证明解释器/翻译器对应或 TCP 内容正确性。原平台 suite-verify、lwip-verify 再验收通过。下一协议实施项仍是带未确认数据的关闭/FIN 与恢复机制；Rocq 则继续扩展实际 AST 对应和内容/输出/时序契约。完整目标仍未完成。

## 2026-10-25：待发送/在途数据与关闭组合（验收进行中）

上一 goal turn 已推送 ACK/window 与 Rocq 原语证据，本轮核对分支 dd7880e，工作区干净。核对已保存及官方 RFC 9293 §3.10.4、§3.10.7.4 和 §3.6.1 后新增 tcp-close 声明式模型：fin_requested、fin_sent、fin_seq 显式记录关闭排队及控制序列空间；先分段此前 SEND，再发一个 FIN；ACK 删除真实字节前缀并单独确认 FIN。待发送/在途数据关闭、窗口阻塞 FIN、FIN-WAIT 重组、被动/同时关闭、未读字节保留和 abort/reset/user-timeout 清理均共用原变量和 rtx 定时器。

初版任意前状态归纳暴露不可接受接收序列却提前转换 FIN 状态的问题，已将接收序列有效性加入转换 guard；ACK 分类统一使用 UNA 前向距离并显式记录 fin_acknowledged，避免重复模比较导致求解限时。修正后当时的 168 条保持、31 个 guard 组和 84 不变量义务通过；后续三个调度空操作及 LAST-ACK 返回行为还需随最终版本再验收。20 个新关闭场景与独立输出/故障测试检查内容、顺序、定时器和 FIN 计数；曾有一项测试把退避后当前 2s RTO 误写为 1s，已按实际 RFC 固定/退避语义修正，并把 FIN 丢包轨迹延伸至真正触发重传。

目前 FIN-only 事件隐含保持对端窗口；提前/乱序 FIN 采取 ACK+drop 等待重传的有限策略，不声称完成乱序 FIN 缓存或 FIN+payload。数据/关闭独立实现证据、完整恢复仍待推进。未改动 Python IR 语义、形式后端、oracle 或上游 lwIP；原 Rocq 原语证据输入仍保持。最终回归/查询/证据结果在后续补记。

最终 171 规则版本的 60 个完整字节固定输入重放全部 match，BMC unknown；状态归纳中一条 FIN-WAIT-1 接收保持义务为 unknown，其余义务通过，未宣称归纳通过。将原复合 guard 等价分割成四个互斥分支（未发送 FIN、接收序列不接受、非 FIN 确认、FIN 确认），输入域和原不变量未削减，展开规则数为 173。后续验收针对这个精确分区版本。

173 规则的共享增量求解仍有两项 unknown，已连同精确查询保存在 artifacts/diagnostics（171 规则的原始 unknown 也单独保存）。改进通用归纳编码：每项保持义务先固定 choice，再等价常量化原约束，并使用新 Solver；保留所有前置不变量、后态违反条件、动作故障和全部逐规则枚举。未增大限时、未假定后态安全。首次该策略对同一 173 规则/84 不变量模型得到全部保持、31 guard 组通过；旧故障/导出查询回归与全部源码绑定证据仍需重建后验收。

补充 peer FIN 先于本地分段到达的场景：进入 CLOSING 时本地 FIN 尚未发送，继续分段此前 SEND，再发送 FIN；精确输出顺序和完整字节后端匹配。关闭输入总数为 21（组合 profile 共 61），不是仅覆盖 FIN 已发出的同时关闭。最终源码版本全量 165 项测试通过；随后新增输入已独立执行并符号重放，继续纳入 profile 重建。

重建过程中补充了第 21 个输入及范围说明，旧 60 输入快照被 suite-verify 正确拒绝为 stale，未改写旧哈希来通过；随后仅对变更的 close profile 完整重建 61 输入并重新聚合/验收其余已有效的五 profile。FIN-only 未观察 wire window，合成编码器默认窗口 65535 只是填充值，不是 FIN-window 行为证据；该真实字段的建模/实现接入仍待补齐。

最终验收完成：六个 profile 当前输入/产物及命题绑定有效。close profile 61 个固定输入完整字节重放全部 match，合成 PCAP 的 codec/Difference 全部 match_synthetic_only；173 条保持、31 guard 组、84 不变量及非空完整字节样本重放通过。初值、长度原语、173 保持和 31 重叠查询在新 Z3 进程重新执行，全部 unsat，记录在 artifacts/tcp-close-query-check.json。旧主动打开/连接 depth=6 bounded_pass；四个数据 profile 原 BMC 仍 unknown，suite 仍 formal_pending_stack_incomplete。

最终运行时版本全量 165 项 unittest 通过；补充的第 21 个关闭输入已通过当前 161 输入（含 101 连接回归）的场景测试和全部关闭场景完整字节符号重放；查询策略元数据/反例所选规则诊断也经针对性检查。lwIP 两连接执行成功、2750ms 差异保留，lwip-verify 通过；Linux 入口仍 not_run。Rocq 六原语的全部源和产物哈希未变，未声称新 TCP 或归纳后端已获 Rocq 证明。未改动上游 lwIP、oracle 或哈希门槛。

后续继续 FIN 携带 payload、FIN 头部窗口与乱序 FIN 缓存，然后 RTT/RTO、delayed ACK、完整 persist、拥塞/恢复及独立实现数据闭环；UDP 等后续协议和实现精化仍未完成。完整目标保持 active。
