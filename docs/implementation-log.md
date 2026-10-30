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

## 2026-10-25：FIN payload/window、队列 EOF 与 post-target-v2（验收进行中）

核对当前 e478e09 分支，工作区干净。新增声明式 tcp-fin 扩展：canonical net.fin_segment 显式提供 seq/ack/window/data，SEG.LEN 包含末尾 FIN；单一标记与相对 offset 由不变量绑定全 32 位序号，直到此前所有字节连续后才消费并发一次累计 ACK/EOF。接受窗口裁剪、零窗口、先前字节冲突、重复/矛盾 FIN、半关闭和自己的 FIN ACK 同段处理有明确有限策略，legacy net.fin 不冒充完整 header。

新增显式 post-target-v2 语义版本，条件输出及动作后优先目标表全部在 IR；独立后端编码同样位置和选择，旧语义拒绝新特性。场景 0.2 的 typed expect_trace 逐项检查新产生的完整消息行、顺序和时间，区分 TraceContractMismatch 并保存预期/实际。新 tcp-fin-v1 投影允许 FIN payload，保留原投影的拒绝范围，字段/哈希/来源门槛未放宽。

初版状态归纳若干查询限时 unknown；显式 offset 消除重复模距离并增加 FIN 位置约束后减少不确定分支，再将归纳查询按每个声明目标（含默认）穷尽分解，保留全部不变量/输入域/动作故障，不假定后态安全或提高限时；176 条规则、105 不变量的该轮义务通过。一个完整字节固定输入重放限时 unknown 后，仅将已有初值/事件/时间/choice 约束等价常量化，不使用参考后态/输出约束；23 新输入重放匹配。历史查询将单独保留，实际全量重建结果在后续补记。

新增 23 个输入，并继承 61 数据/关闭输入和 101 连接回归。正反场景及故障变体检查乱序 EOF、窗口更新、控制序号+1、尾部裁剪、重复 EOF、目标遗漏及输出时间顺序。Rocq 旧证据的语义/解释器源绑定已过期，不能直接重新标记；将实际重跑 CI 的原语检查并保存新绑定，不声称它证明新的 EFSM 翻译。独立实现数据闭环和完整恢复仍未完成。

## 2026-10-26：FIN 组合阶段本地验收

当前源码全量 190 项 unittest 通过。七个 profile 重建并经 suite-verify 验收：原主动打开/连接 depth=6 bounded_pass；五个数据 profile 的原 BMC 仍 unknown，各自状态归纳通过。tcp-fin 的 176 规则、105 不变量、201 个穷尽目标子检查、26 个 guard 组与非空完整字节样本通过；84 固定输入重放 match，合成 codec/Difference 均 match_synthetic_only。初值、长度公式、201 保持子查询及 26 重叠查询在独立 Z3 进程全部 unsat，样本 sat，记录 artifacts/tcp-fin-query-check.json。

旧投影仍拒绝 FIN payload，新投影逐项比较原字段和窗口/字节，未放宽 oracle。漏目标、错 FIN 消费、缺少 EOF 尾部裁剪、重复 EOF、自动定时器输出遗漏/乱序及错误字面值类型均有正反测试。历史 unknown 查询和一次固定重放限时日志保存在 diagnostics，不当作当前通过证据。lwIP 两连接执行成功、2750ms 差异保持，lwip-verify 通过；本机 Linux 入口仍 not_run。

Rocq 原语的旧源绑定已过期，以下提交将触发锁定工具链 CI 真正重检，再下载并逐项核对新证据。该原语证明不会提升为 post-target 翻译或 TCP/实现正确性证明。完整恢复、独立数据/关闭实现观测和后续协议仍未完成，目标保持 active。

Rocq 新源绑定已实际验收：提交 27d3ae2 的 push 作业 40209751198 / job 121218249808 和 PR 作业 40209753935 均 success。六个命题均 Closed under the global context，rocq check 成功，错误证明和注入公理负控制通过。下载 artifact 12605034480，归档 SHA256 483d61c8fbff1d512015f0038153e3c24f0afa7fa5238762ea046831508b04f8；核对全部当前输入和产物哈希后更新 artifacts/rocq 及 CI 来源。只是通用原语的新绑定，不是 post-target 翻译、TCP 内容/时序或实现精化证明，也不是 Linux TCP 证据。

## 2026-10-26：IR 0.3 与 TCP 精确 RTT/RTO/Karn

在 d807b41 后保留并继续工作区中的 IR/后端和 tcp-rto 原型。新增规范有理数 JSON 值与显式事件时钟；拒绝浮点、不规范分数、旧版本新语义及非字面 scale 系数。参考 Fraction 和独立 SMT Real/ceil 分别实现，时钟 guard 使用当前事件时刻，失败连同时钟回滚。

tcp-rto 的声明规则覆盖首次／后续 RTT 估计、先 RTTVAR 后 SRTT、部分确认锚点、重传区间重叠的 Karn 歧义、新发送替换歧义样本、SYN/FIN、1s 下限／60s 上限和超时退避。九个手算输入包含分数 RTO 与截止点负／正输出契约；新增故障控制针对 Karn 放宽和用新 SRTT 计算偏差。

初版归纳出现两个 sat：CLOSED/LISTEN 合法任意前状态可保留旧估计器，打开规则未重置。补齐打开初始化，不限制前状态、不删除不变量，单独重跑初值／176 规则的 201 目标子检查和 guard 组均通过。首次反例及完整 SMT 查询保留在 artifacts/diagnostics/tcp-rto-initial；不宣称反例前状态一定可达。

新增采样统计在关闭时清理，保留继承 rto_ms 作为最后诊断值，避免无依据改写旧场景期望。一般原始分段发送历史时序仍未建模，不能宣称完整 RFC 6298 §5 的不提前重传性质；Rocq 六原语也不证明估计器或解释／翻译对应。全量验证、八 profile 的重建及新 Rocq 输入绑定将在后续补记。

一般时序缺口已用当前模型实际复现：21ms 发送两字节，1000ms 追加四字节，继承前缀重传在 1021ms 发送四字节，其中后两字节距首次发送仅 21ms。完整参考轨迹和模型语义哈希保存于 artifacts/diagnostics/tcp-rto-initial/no-early-history-gap.json，明确不是验收通过证据。下一里程碑应显式加入发送历史及对应时序约束，不能用当前状态归纳消除此反例。

新源绑定 Rocq 已实际验收：提交 d317429 的 push 作业 40212417377 / job 121226304836 success。下载 artifact 12605924177，ZIP SHA256 3c321e362f54fc8bd1dea8c8ef8d6387950aff1059a3aaaea603dda87ce83308；核对当前输入、全部下载产物及六个空公理审计后保存新证据。原始下载 result 保存在 artifacts/rocq-ci-downloaded-result.json；仅本地 ci-origin 来源元数据及其绑定哈希在核验后更新，证明对象和检查日志原样保存。通用六原语不证明 IR 0.3 有理估计器、EFSM 翻译、TCP 或 Linux 实机。

IR 数值测试补充独立 ceil 编码性质和代数无理见证拒绝，共 7 项通过；RTO 新场景完整字节重放通过。一次早期 196 项回归运行期间 profiles 范围清单被本轮更新，原运行严格报 Stack scope changed（1 error），没有绕过绑定。已在固定全部输入后重新运行完整回归；最终结果待该进程结束记录。

固定输入后的完整回归 206 项通过（754.286s）。之后新增无理见证拒绝和估计器长样本封顶两项：当前 rational 模块 7 项及长 RTT 封顶单项复查通过；将全部日志中的通过方法 ID 与当前 unittest discovery 集合逐项比较，恰覆盖当前 208 个唯一方法，无遗漏。日志、方法覆盖说明和当前输入哈希在 artifacts/rto-validation；不声称一次执行运行了 208 项。长样本 78977ms 得到 SRTT=79047/8、RTTVAR=39491/2，并将估计器 RTO 封顶 60000ms。

八个 profile 的完整重建已结束：93 个 RTT/RTO 固定输入完整字节重放全部 match，合成 codec/Difference 全部 match_synthetic_only。主动打开／连接 depth=6 bounded_pass；六个数据 profile BMC 均保留 unknown。RTO 在整个 suite 进程中的一次 FIN-WAIT-1 保持子查询超时 unknown，其余子查询 unsat；原结果与完整保持查询保存在 artifacts/diagnostics/tcp-rto-suite-unknown，不能删除或直接提升状态。

同一模型语义哈希 697682c7041608e5e897a60193ca9719f0a27fa297ba28d344c2169565c06579 在干净进程、相同逐查询 10000ms 限时完整重查：初值／长度、201 个目标保持、26 个 guard 组及非空完整字节样本通过。仅以实际新查询／结果重建 RTO 的报告、命题绑定和顶层摘要，重建前断言所有当前输入哈希未变。独立 CLI 再执行导出文件得到 201 保持及 26 guard 全部 unsat、样本 sat；该 CLI 的进程限时不同，结果单独保存，未用来替换内部 unknown。上下文见 artifacts/tcp-rto-clean-recheck.json、tcp-rto-query-check.json。close／FIN 的独立导出复查也已重新生成；suite-verify 和 lwip-verify 通过。该里程碑仍保留一般过早重传的真实反例与完整恢复／独立数据实现缺口，完整目标未完成。

## 2026-10-26：逐字节发送历史与精确查询分组（开发检查点）

在已验收并推送的 272b77b 之后继续修复真实提前重传反例。tcp-tx-history overlay 以 16 个显式整数时间槽和独立 FIN 时刻保存历史；新发送登记、累计／部分 ACK 移位和清理、实际重传更新均为 IR 动作。timer.rtx 只选择达到当前退避前 RTO 时龄的最旧连续前缀，窗口／MSS 约束保持；若尚未到期，明确等待且不输出空包、不退避或虚增重试。Karn 使用实际裁剪长度。1021ms 的输出现为旧字节 [0,1]，后发字节仍保留 1000ms 的时间。

首版 176 规则／143 不变量归纳初值、长度和 guard 组通过，两个 FIN-WAIT-1 保持目标 unknown；原 overlay、结果与完整查询保存在 artifacts/diagnostics/tcp-tx-history-v1。对两个规则的 ACK 域作重复／在途新确认／其他的互斥穷尽显式分解，不改变动作或输入范围；结构比较、完整 SMT 互斥／穷尽断言及六个具体分支均经测试。当前 180 规则／217 目标中 215 unsat、2 unknown，原报告保存在 artifacts/tcp-tx-history/inductive，未改成通过。

新增独立 formal/partition_queries.py：保留原查询的每条其他断言，完整划分所选违例析取式，先检查等价、再逐组检查，导出全部查询；verify 校验源码／求解器／查询哈希、完整项覆盖、原约束逐项一致，并重新求解。拒绝不支持的脚本命令。两个 unknown 的 160／161 项分别分成 10／11 组，全部组和两个等价义务 unsat，独立进程 verify 通过。六个正反测试检查可满足分支不能被隐藏、遗漏约束后重新哈希仍拒绝、缺组、unknown 重标、源／版本变化及不支持语义。该结果仅是独立查询精化，尚未进入标准 suite/claims 验收，不能替换原 unknown 或提升为内核证明。

当前发送历史模块 14 项测试通过（367.647s），包括继承的全部 194 个参考场景、四个手算时序契约完整字节符号重放、FIN 独立计时、1ms 边界、零窗口导致的非单调历史、部分 ACK／回绕、早定时器故障注入、缺失时间登记和错误资格阈值。独立输出年龄断言从实际输出重建历史，不依赖模型自报的时间槽，保留旧模型的违规对照。结合 272b77b 已检查且源未变的 208 个方法，当前 228 个唯一测试方法均有通过日志，分批覆盖而非一次执行；精确方法集合及输入／日志哈希见 artifacts/tcp-tx-history/validation。

新模型仍是开发模型，未注册为正式 suite profile；标准归纳精化集成、非空正式见证、完整新 profile 证据、SYN 超时历史及输出／实现精化待推进。旧八 profile 的 suite-verify、lwip-verify 再次通过，2750ms 差异、Linux 未运行及后续协议缺口均保持。完整目标仍 active。

聚合复查发现共享全局 Z3 context 的资源敏感性：原独立 verify 均通过，但后来在同一聚合过程中某个组再次 unknown；旧工具、完整查询与结果均保存在 artifacts/diagnostics/query-partition-global-context。辅助检查器改为每条查询使用新 context，翻译全部原公式，不删约束、不增限时；6 项测试重新通过，分组证据必须用新源码实际重建及复查。此变化不修改标准后端或原 unknown 报告。

独立 context 的 16 项分组仍有 pending 的 group-003 在 10s 内 unknown，结果及日志保存在 artifacts/diagnostics/query-partition-isolated-16。保持所有项和原断言，将该目标的每组大小从 16 精确细分到 8（160 项／20 组）；other 仍为 161 项／11 组。当前两者全部 31 组及等价义务实际 unsat，分别在新进程 verify 通过；不是更换随机种子或扩大限时。原标准归纳两个 unknown 保持，尚未接入 suite／claims。

当前新 context／细分证据最终聚合复查也通过：两个 unknown 的 31 组及两个等价义务重新求解 unsat。验证摘要逐项检查两条原 unknown 都被精确覆盖、原 SMT 文件／当前模型哈希一致，校验旧 208 方法源未变、当前新增 20 方法日志通过，并核对当前 unittest discovery 的 228 个方法 ID 无缺漏。摘要及输入哈希保存在 artifacts/tcp-tx-history/validation/result.json。标准归纳报告仍 unknown，开发模型仍未注册 suite，后续统一验收集成和其余恢复／协议范围继续。

## 2026-10-26：精确查询精化接入统一平台

从 1cd5a3b 的干净工作区继续。新增独立 refinement 结果和验收器：严格校验主归纳的完整规则／目标／guard 组、编码／初始域／查询标签／哈希，保持主结果只读；对每个 unknown 保持目标保留全部上下文，生成完整分组、独立复查并保留辅助超时。补充通过后还要求完整字节／BV32 的非空初始执行见证、原非符号初值一致和参考重放。证据目录迁移只允许源 SHA 不变。主归纳通过则标为 not_needed_primary_pass；初值或 guard 未解决不能跳过。

新增 CLI inductive-refine / inductive-refine-verify、profile 可选配置及第四个独立 claims 命题。原 inductive-state unknown 和 BMC unknown 不改名；只有原始义务全部覆盖、补充查询与非空见证实际通过，才标 verified_refined_inductive_state_properties。formal/partition_queries.py 及全部相关运行时代码进入输入／检查器哈希。tcp-tx-history 已注册为第九个 profile，有限数据 profile 启用同一可选机制。尚未声称 TCP 或内核证明完成。

14 项新集成测试通过：漏目标／错标签、主查询丢失后重新哈希、删约束后层层重绑、辅助复查超时、未解决初值、可满足主义务、缺文件／源码绑定、不支持的编码、迁移目录及空／不同初值见证都不会误验收。已有 claims 六项和辅助检查器六项针对性回归通过。真实发送历史主查询的实际补充生成与独立验收已通过；接下来固定源码／文档／profile 输入，运行全部回归和九 profile 统一重建，再记录实际结论，不使用旧证据改绑哈希。

新发现并保留后续必须修复的纯时钟范围缺口：普通 SYNACK 在 10ms 取得 RTT 后，调用无到期事件的 tick(20)，rtt_sample_used 仍为 true，T-INV-KARN 把已存样本与后来的全局时钟比较而为 false；该无事件 tick 没有触发不变量失败，也没有新增轨迹行。实际前后状态和直接求值保存在 artifacts/diagnostics/clock-only-invariant-gap/report.json。当前形式命题仅覆盖初值及已声明规则的保持，不覆盖纯时钟推进或解释器／翻译对应，因此此诊断不被现有子集结论排除。后续应优先修正样本时刻的 IR 不变量，并显式补齐无事件时间推进的参考检查和独立形式覆盖，再扩大恢复机制；不能把当前集成验收当作这一范围已经证明。

## 2026-10-27：当前集成验收结果及 SYN 开发切片

完整回归 242 项通过（1567.990s），九个 profile 完整重建，suite-verify 与 lwip-verify 通过。active-open／connection depth=6 bounded_pass；七个数据 profile 的 BMC 都保留 unknown。data／reassembly／segments／close／fin 的主归纳通过，补充层写 not_needed_primary_pass。RTO 主归纳仍 unknown，其一个未知目标的完整补充精化／非空样本通过，claims 同时保留原 unknown 与 verified_refined_inductive_state_properties；发送历史主归纳四个未知目标中三个补充通过、一个分组仍 unknown，补充层整体 refinement_unknown，未提升。发送历史 97 个固定输入完整字节重放均 match，合成 codec 均 match_synthetic_only。外部 CLI 对当前导出查询单独复查，预算为每进程 120s，不替换主 10s 查询结论；发送历史复查未完成全部目标则如实为 inconclusive。旧 272b77b 的干净 RTO 复查记录和精确原 SMT 已移入 diagnostics/tcp-rto-clean-recheck-272b77b，未重绑旧哈希。

另新增未注册的 tcp-syn-history 开发 overlay，复用单一序列空间／rtx 及数据／FIN历史。即时同时打开 SYNACK 回复在 900ms 登记实际 SYN 时刻，并把替换报文的 RTX 截止点设为 1900ms，用户 30000ms 超时不延长；1000ms 不产生事件／重传，1900ms 才发送并退避。资格等待分支只处理提前定时器故障／任意归纳前态，不把普通回复误计为真实 SYN 超时或伪造 Karn 样本。按 RFC 6298 §5／5.7、RFC 9293 §3.10.7.3／3.10.8 记录解释，保留原模型实际 100ms 间隔的对照。初版等待旧截止点的策略与原 unknown 查询亦保留；当前规则改为直接重设回复截止点，避免制造 §5.7 的解释歧义。

SYN 切片 11 项测试通过（235.167s）：三个手算契约完整字节重放、继承的 97 个数据／FIN／RTO输入、ACK 在新截止点前完成、真实超时与同刻回复排序、3s 数据初始化、回绕、被动 abort、用户超时及早截止／错资格／漏登记故障。当前 180 规则／147 不变量的主归纳四个 FIN 处理目标 unknown，补充 refinement_unknown；原报告和所有分组保留于 artifacts/tcp-syn-history，开发模型不标为验收通过。合并既有 242 与新增 11 的通过方法 ID，恰覆盖当前 253 个方法，分批而非一次执行。

旧实验精确分组的检查器源码已从 git 1cd5a3b 原样保存为 artifacts/tcp-tx-history/legacy-checker-1cd5a3b.py，其 SHA 与原两份记录完全匹配，未修改旧证明绑定。当前统一流程使用新的 suite 目录和实际新源码证据。纯时钟推进诊断仍未修复，接下来必须优先补齐该语义／采样时刻不变量及参考和形式检查，再推进 SYN 正式验收、delayed ACK、persist、拥塞与恢复、独立实现和后续协议。2750ms 差异与 Linux 未运行保持，完整目标 active。


## 2026-10-27：纯时钟缺口修复，统一验收待完成

保留原 clock-only-invariant-gap 诊断，IR 新增显式 RTT 采样时刻及边界不变量；RTO／发送历史／SYN overlay 同步更新严格动作锚点。参考 tick 在最终时刻也检查不变量，失败回滚整个调用；dispatch 仍是时间推进和外部事件的原子操作。独立 Z3 新增不越过定时器的纯时钟步及归纳保持查询，claims／精化均拒绝遗漏或未解决的时钟义务。空时钟不能充当非空声明规则样本。

固定输入查询提前只编码所选动作，但保留全部 guard／故障／输入条件及独立参考重放；与完整关系的等价和冲突故障已检查。15 项新增时钟／负控制、6 项 claims、14 项发送历史、10 项归纳测试通过。RTO 新纯时钟义务 unsat，主归纳仍 unknown。完整回归、九 profile 重建及实际新源绑定 Rocq 检查仍待完成；旧快照不改哈希冒充新证据。


当前修复的独立诊断保存在 artifacts/diagnostics/clock-progress-correction：三个继承模型 ACK(10) 后 tick(20/99) 的完整快照、零新增协议事件及全部不变量检查，另保留 RTO 纯时钟 SMT 和独立 Z3 进程 unsat 结果。此前错误诊断未修改。SYN 当前开发模型的 180 规则／148 不变量、纯时钟 unsat、主归纳 unknown 和补充 refinement_unknown 原始查询，保存在 diagnostics/syn-clock-progress-e6880f3，仍未注册为已验收 profile。

Rocq 当前源实际检查完成：e6880f3 的 push run 40363008238 / job 121713157227 success，artifact 12668593429，ZIP SHA256 24fc8bea40b4cdf12e6effe100d5b4fec42e47aeab3ec8fda57b89fc5b4bee60。下载后逐项核对六个当前输入及全部原产物哈希、六个空公理审计和两个负控制；保存原下载 manifest，仅更新本地来源元数据及对应摘要。仍仅证明六个通用原语，不证明此次时钟修复、估计器、翻译或 TCP／Linux 实机。


## 2026-10-27：SYN 未知目标的完整单项分组验收

保持当前代码／模型输入冻结。针对 SYN 开发模型剩余的困难查询，原每组 8 项在一组超时；改用已有 API 的 group_size=1，不改检查器、不删约束、不延长 10000ms 时限。三个原 unknown 目标的 166／166／167 项全部保留，499 个分组及各等价义务均 unsat，生成阶段独立复查通过；完整字节非空声明规则样本 match，随后完整 verify 进程也通过。原主归纳 unknown 与原 8 项分组 unknown 记录保持。新补充原始产物和验证日志在 artifacts/diagnostics/syn-singleton-refinement-e6880f3，绑定同一 e6880f3 原模型／主查询／检查器。仅为已列状态性质的补充归纳证据；SYN 仍未注册 suite，不代表 BMC、安全全覆盖、输出／时间精化、Rocq 或 Linux 实机。


## 2026-10-27：纯时钟修复的完整统一验收

冻结输入未发生变化，完整 268 方法回归通过（1567.336s）；九 profile 的 depth=6 suite 重建和 suite-verify 通过，原始日志及冻结输入保存在 artifacts/clock-regression。主动打开／连接 bounded_pass；七个数据 profile BMC unknown 保留。data／reassembly／segments／close／fin 主归纳通过；RTO 主 unknown、补充通过；发送历史主 unknown、补充 refinement_unknown。RTO／发送历史新增纯时钟义务均 unsat。根 build/formal 与 lwIP 执行／证据验收完成，保留 SYN-loss 时序差异和 Linux not_run。新的 delayed ACK 开发 overlay 不在该 268 方法／九 profile 验收范围内，须单独验证后接入。


## 2026-10-27：delayed ACK 声明式开发切片

新增独立 overlay tcp-delayed-ack，继承 SYN／数据／FIN／RTT 历史父链；183 规则、154 不变量，另设 delack 定时器，不改变旧 profile。依据 RFC 9293 §3.8.6.3，RMSS=4、默认 40ms／允许 1..499ms，首段计时不重启，第二完整段或 2×RMSS 新字节立即累计确认；乱序、重复、补洞、裁剪、FIN 与零窗口保留立即 ACK。实际当前累计确认的 piggyback／窗口／FIN 输出取消等待，未发生的条件输出不取消；关闭／重置清理。全部决定在 JSON AST 中显式表达。

15 项新增测试通过（63.441s），含 7 个独立手写输出／时刻场景的完整字节重放，错误延长截止点／丢定时 ACK／漏取消的故障变体、499ms 与回绕、FIN-WAIT 两状态、一般 ACK/window/RTT 组合、早 RTO 故障及 delack/rtx 同刻优先级。与上一完整 268 方法运行的通过 ID 合并，恰覆盖当前 283 方法（分批，非一次完整运行），记录在 artifacts/delayed-ack-regression。

初次独立归纳初值、全部 guard 组与纯时钟保持 unsat，三个 FIN 处理目标 unknown；不提升为输出／时序或完整 TCP 证明。开发 profile 证据生成使用已有 tcp-fin-v1 投影；误用 tcp-data-v1 时 FIN+payload 被严格拒绝，未放宽校验。当前重新生成开发证据，尚未注册 suite。IR 尚无截止点表达式，状态归纳不能单独证明通用 ACK 延迟上限，明确见 tcp-delayed-ack.md。


开发 profile 的 7 个手写场景、完整字节重放及 tcp-fin-v1 合成 codec 均通过；BMC depth=6 unknown、主归纳 unknown、纯时钟保持 unsat。默认 8 项分组生成／首次复查通过，但随后独立完整复查 group-007 在 10000ms 超时；失败日志和 pending 元数据原样保留，原 report/claims 未覆盖。另用 group_size=1 对全部原未知目标完整分组，全部等价／组复查、非空样本和完整 verify 通过。artifacts/tcp-delayed-ack-development/development-verification.json 分别绑定默认超时及单项补充证据；仍不是已注册 suite 验收或完整 TCP／通用时间证明。

当前发送历史的原归纳仅剩一个 unknown 目标；其 163 个单项分组、等价、非空完整字节样本及完整独立 verify 也通过，原主／默认补充 unknown 不改写，完整冻结主查询与新证据保存在 diagnostics/tx-history-singleton-refinement-e6880f3。后续应把分组配置显式接入 profiles／CLI，并统一注册 SYN／delayed ACK、重建和验收；再推进 persist、拥塞恢复及独立数据实现。


## 2026-10-27：统一注册与显式分组配置（验收进行中）

新增不依赖可选 Z3 的 profile_config 校验；配置必须是正整数、refinement 明确启用。run_profile 传递实际配置，claims 绑定配置／实际大小并拒绝错配，CLI 增加 --group-size。保持检查器原查询、约束、独立复查和 10000ms 时限不变。新增配置／CLI／错配／无 Z3 参考路径测试；修正原单项测试夹具显式声明其配置。

注册 SYN 和 delayed ACK，RTO／发送历史／SYN／delayed ACK 显式单项分组。SYN 100 个固定输入；delayed ACK 新 7 个加原样复用的 16 个恢复／SYN 输入，共 23 个，新增继承场景回归。原立即 ACK 数据场景的受影响 oracle 不自动迁移。旧开发超时与单项补充证据保留不重绑。统一 11 profile、本轮完整回归和证据验收尚须实际完成。


## 2026-10-27：11 profile 集成暴露打开投影缺口

原 9afd06d 的完整回归和隔离重现均在新 SYN profile 失败：原 tcp-fin-v1 normalizer 要求主动打开及对端 SYN+ACK，拒绝仅 SYN 超时；被动和同时打开也不符合其旧假设。完整原隔离日志保留，不把注册当作验收通过。修复为显式 tcp-connection-v1，而非放宽旧投影：逐方向独立实际 SYN 原点、按需拒绝缺失锚点，保留严格字节／窗口／顺序、checksum 和包格式校验；SYN／delayed ACK 配置选择新投影。

7 项独立原始 PCAP／场景 codec 正反测试与 28 项原验证测试通过。旧运行已因真实适配器缺口失败，源码修复后其冻结输入不再适用，必须保存失败结果并启动新快照／完整重建，不能拼接旧通过结果或只更新哈希。persist 为独立未注册开发模型，不在原 290 方法／11 profile 范围内。


## 2026-10-27：persist 开发原型与形式反例修复

新增未注册 tcp-persist overlay，复用共享序列空间、发送队列、字节历史及 delayed ACK；首字节探测、重发、累计 ACK 后下一新字节、独立指数间隔、窗口恢复交回 RTO、关闭清理均为显式 IR。以互斥的普通 RTO／persist 归属关系替换父模型 all-flight-is-RTO 假设，保留普通在途必须有 RTO 的义务。双定时器与漏正常 RTO 故障均被拒绝。

初次归纳发现 pending FIN 的 CLOSING 状态遗漏；另有可达参考输入复现，不将任意 SMT 前态误称可达。旧原模型／完整查询／范围和轨迹保存在 diagnostics/persist-before-closing-states-v1。修复覆盖父模型可声明的 CLOSING／LAST-ACK pending-FIN 状态；保留 fin_sent 时不进入 FIN-only persist 的边界。

当前 193 规则／161 不变量；14 项方法通过（97.035s），含 7 固定输入完整字节重放、回绕、半关闭、1..60s persist 指数间隔、早截止等待、ACK piggyback、RTO 交接及故障变体。原主归纳 unknown，初值／guard／纯时钟通过，未知目标完整单项分组和独立 CLI verify 通过，保存于 artifacts/persist-initial。尚非完整 persist／TCP、通用输出时序或实现／Linux 证据；不属于原 290 项／11 profile 验收。

旧 290 方法运行最终结束（2191.211s，2 errors），11 profile 原生成也已终止（exit 2），错误均为 No peer SYN+ACK captured。完整日志归档至 diagnostics/eleven-profiles-opening-gap-9afd06d，原部分产物不接入新验收。修复后重新冻结源码，启动 311 方法完整回归、全部 11 profile 重建和独立 persist 开发 profile；这些新长任务尚未完成。

persist 独立开发流水线实际生成并完成单独验收：30 个固定输入（7 新、23 原恢复／SYN／delayed ACK）参考执行、完整字节重放及 tcp-connection-v1 synthetic-only codec 均匹配；主 depth=6 BMC／归纳 unknown 保留，补充单项复查通过。当前输入、模型与全部 report 哈希、源完整性、claims 重建及独立 recheck 均核对，保存于 artifacts/tcp-persist-development。该未注册开发结果与正在运行的新 11-profile／311 方法验收分开，不计作外部实现或 Linux 数据证据。

## 2026-10-27：修复后 311 方法与 11 profile 完整验收

修复后的完整一次运行实际结束：311 tests，2400.694s，OK。11 profile 全部重新生成（exit 0），suite-verify 完成（exit 0，valid_local_artifacts_stack_incomplete）。重新计算全部 profile 输入集合和完整测试输入集合，分别为 258／293 项，与运行前冻结集合及每个哈希完全一致；没有拼接旧 290 方法通过项。原失败证据保留，当前日志、命令、冻结输入和结论保存在 artifacts/diagnostics/eleven-profiles-revalidated-de9a6ee。

根 build／formal 返回 0；原 lwIP 返回 1，仍是有效执行后的已知 SYN-loss 2750ms／1000ms 配置时序差异，lwip-verify 返回 0。主 BMC／归纳 unknown 与已独立复查的补充结论分开呈现；全套本地证据验收不提升为完整 TCP、通用内容／输出／时间证明或 Linux 实机验证。下一步扩大独立实现数据闭环、完善 persist 和拥塞恢复，继续用户约定的后续协议。

## 2026-10-27：独立 lwIP 四字节数据闭环

新增 ports/lwip-data 独立有限通道，使用锁定、未修改的 lwIP 2.2.1 源码和单独编译配置，复用原 netif 原始抓包工具。公共 raw API 完成主动打开、tcp_write 四字节 [0,128,255,7]、显式发送及完整累计 ACK；C 端仅接收应用字节，actual ISS 来自实际 SYN，不读取模型预期或修改 PCB。MSS=4／本地窗口16／对端窗口8，MORE hint 排除尚未建模 PSH，支持的输入／时刻严格校验。

IR 参考、完整字节固定输入重放、真实 lwIP netif PCAP、独立 checksum／连接原点归一化、0ms 容差 Difference 与证据验收全部通过。实际 sent 回调确认4字节；5个实际收发包投影匹配。绑定输入、编译命令／编译器、上游锁、二进制、日志和产物哈希；验收重新生成 oracle／参考轨迹、求解固定输入并独立检查导出查询与新查询逻辑等价。原查询哈希保留，不以不稳定的 Z3 文本别名作语义标识。

9 项独立 port 集成／故障测试通过（31.415s），覆盖真实 C 执行及完整 payload、篡改 oracle／PCAP／查询／编译命令／回调后重算哈希、必要文件遗漏、伪称 Linux、未支持输入。最初新增验收误把两次 Z3 导出文本哈希当作语义相等，导致正例失败；该测试失败日志保留，已修正并新增查询篡改负控制。测试在 ports 下独立运行，不冒称上轮311方法包含这些新测试。证据见 artifacts/lwip-data，说明见 ports/lwip-data/README.md。

这是单连接、单 MSS、完整 ACK 的内存 netif／虚拟时钟真实实现观测，不是 Linux、完整数据／丢包／重组／关闭／恢复符合性或实现精化证明。原握手／SYN-loss 通道和2750ms差异保持。下一步扩大数据分段、部分 ACK／window、接收重组、关闭和恢复的独立输入映射与实测差异，同时推进 persist 边界、拥塞／恢复及后续协议；完整目标保持未完成。

## 2026-10-27：独立 lwIP 事件驱动分段／ACK／窗口闭环

新增 ports/lwip-stream，原 lwip-data 和握手／SYN-loss 通道及其输入不变。受控事件文件映射公共 raw API 与脚本对端的 SYN+ACK／ACK：主动打开、总写入1..16字节、最多64事件、0..200ms、MSS=4／本地窗口16，支持多段、部分／重复 ACK、窗口关闭／恢复、旧 ACK、future ACK 和不接受 SEQ。所有输入／字段／类型／范围显式校验，C端额外拒绝未知命令、尾随字段、溢出和逆向时钟；出站PCAP仍来自实际pbuf，不读取IR输出或修改PCB。canonical ISS输入坐标映射使用实际观察的SYN。

12项独立port集成／故障测试通过（49.249s），含实际C双段非零字节、输入映射篡改、oracle／PCAP／查询／编译命令／回调重算哈希、必要文件遗漏、伪称Linux、C命令解析负例及编译环境失败分类。新增分阶段失败报告，未支持输入／源完整性／环境／模型未覆盖与冲突／形式／执行／观测失败不被计作实现Difference。

六场景分别实际执行、完整字节固定输入重放、严格0ms归一化比较，并独立验收：two-segments-partial-ack、window-reopens-after-zero、stale-ack-keeps-zero-window、future-ack-keeps-flight、unacceptable-seq-keeps-flight共5个匹配；four-byte-peer-window执行返回1、verify返回0，为保留的有效差异证据。各场景当前输入集合与每个哈希完全一致，结果保存于 artifacts/lwip-stream/acceptance，所有源码／查询／刺激／编译与日志／PCAP绑定。

新差异对应未修改上游 tcp_out.c:420 的 min(mss,snd_wnd_max/2) 分段选择：初始窗口4时实际先发两个2字节段，当前IR选择4字节段，后续相同脚本ACK在不同发送前沿上继续分叉。原始包、回调、严格Difference和规范／规则追溯保留于 four-byte-peer-window/analysis.json；不将最大MSS当作必须填满的段长，不直接认定RFC bug或数据丢失，也不更改后续输入来追随实现输出。规范范围RFC9293 §§3.7、3.7.4、3.8.6、3.10.7.4，详见 docs/lwip-stream-testing.md。

旧四字节数据证据独立复查仍通过；原311方法／11profile冻结输入258／293项集合及哈希重新计算完全一致，本轮12方法单独记录，不冒称扩大了旧311方法运行。该里程碑不覆盖接收文本／重组、关闭、丢包／定时器恢复、拥塞或Linux；下一步继续独立数据接收／关闭及恢复证据、persist边界和拥塞／恢复IR，再按用户顺序推进后续协议。主unknown和2750ms差异保留，完整目标未完成。

## 2026-10-27：独立接收重组／EOF／关闭与查询等价精确编码

扩展 ports/lwip-stream，新增原始 DATA／FIN输入和公共 tcp_close／tcp_recv，不改上游、不读取PCB状态。接收回调保存实际pbuf字节、时刻和EOF，不调用tcp_recved，对应IR未读rcv_buf；新连续前缀和FIN消费构成显式观测关系。忽略回调分块边界但保留逐字节顺序、时刻及EOF相对位置，网络与接收Difference分别保存，任一不匹配均为总体差异。范围仍为0..200ms／最多64事件／16应用发送字节／64对端文本（含重复），应用接收16字节、无app.read；app.close后拒绝SEND／TRANSMIT，避免关闭PCB后的应用调用。

新增连续两完整段、乱序补洞、重复乱序、FIN在缺口前、FIN带payload、空主动关闭及发送数据ACK后关闭共7输入，连同原6输入全部重建。17项独立port集成／故障方法通过（63.056s），含原12项、共享前提提取真值表／增删否定约束、真实字节／EOF、接收时刻／顺序篡改并重算日志哈希、回调分块等价、非法新C命令和关闭后写入负例。

首次16方法运行失败：同一进程连续编码后的原XOR等价查询10秒unknown/timeout，使接收正例和后续篡改测试先被拒绝；不是SAT不等价反例。保存原始源码、两个完整查询／原XOR／失败日志／unknown原因于 diagnostics/receive-multiprocess-recheck-v1。新编码用精确布尔等式XOR(C∧A,C∧B)=C∧XOR(A,B)保留共同前提和全部非共同子式，诊断的共同136种断言及两侧各1种剩余得到unsat，导出查询另经独立进程复查。原超时不改写，主TCP BMC／归纳及翻译正确性结论不提升。

当前冻结输入的13场景执行／固定字节重放／独立验收全部完成：6个严格总体匹配、7个有效网络差异；13个接收Difference均match，其中原6发送场景为无接收的空观测，新增7场景为非空字节或EOF（5个有实际字节，4个有EOF），明确区分非空覆盖。新增场景只有连续两个完整段同时网络匹配；补洞两个场景未在捕获末端看到模型同刻ACK，另外4个FIN／关闭场景实际通告窗口比模型小1。未观测到的同刻ACK不意味着从不ACK或超过500ms；源码tcp_ack和FIN窗口／通告信用路径仅为解释线索，不是内部PCB遥测。所有原包、规则／规范来源、回调和严格Difference保留，不归一化掉差异。原窗口4的2字节分段差异也保留。

acceptance/result绑定13报告、两个Difference、执行／复查日志和当前全部输入集合／哈希；完整文档见 docs/lwip-stream-testing.md。旧四字节通道再次独立验收通过；原311方法／11profile的258／293项冻结输入集合及哈希重新计算完全一致。17方法不是新一次全局311运行。此通道仍不是Linux、丢包／RTO／persist／拥塞或完整协议／通用内容时序／实现精化证明；下一步继续恢复机制和拥塞／恢复IR，并扩大独立恢复与组合验证，后续协议顺序不变。

## 2026-10-28：拥塞窗口、慢启动、字节计数拥塞避免与数据 RTO 开发切片

确认PR#1已合入main（3be30033，树内容与本地d252be84相同），保留所有未提交改动并切换新分支codex/tcp-congestion。本阶段不再向已关闭PR#1追加提交。

新增tcp-congestion声明式overlay，继承persist／连接／数据／FIN／RTT与发送历史；193规则、180不变量。保守SMSS=4／IW=4，可配置IW4..16，实验初始阈值16是路径参数而非最大TCP窗口。普通新数据受rwnd与cwnd共同预算约束；耗尽时由互斥blocked规则处理，发送预算不变量专门检测越界，而不错误要求降窗后旧flight<=cwnd。SS按min(N,SMSS)增长，cwnd>=ssthresh进入累计字节CA，达到旧cwnd后加一SMSS并保守清零信用。无效、旧、重复、控制ACK及persist／零窗口探测不赚取信用。数据RTO实际重传才降至一个SMSS，首次最老字节超时按FlightSize调整阈值，逐字节标记随累计ACK移动，重复RTO保持阈值。

全部决策在JSON AST；tools/build_congestion_model.py只生成显式overlay，运行时不调用生成器。复用既有整数／字节／BV32及精确有理／ceil语义，没有添加后端算子。RFC5681 September2009 §§2、3.1官方原文和模块级来源锁已保存、校验并绑定输入哈希；原全局9293／6298清单及旧profile不改。模块尚未注册suite，说明见docs/tcp-congestion.md。

14方法一次运行通过（304.063s），包含101个旧连接输入（沿用既有data/RTO测试的显式ACK/SYNACK window=8桥接，不改预期状态或时钟）、六个手写固定输入完整字节符号重放、部分ACK／CA分割攻击、wrap、过早／重复RTO、标记前移、persist、CLOSE-WAIT及待关闭FIN组合。故障变体检测实际增长越界及一致移除guard／blocked保护后的发送越界。早期两轮失败来自夹具缺失必需timers、缺少schema窗口及故障注入先命中重置或规则冲突；原日志／测试和场景保留于diagnostics/congestion-*，不是协议反例。

最终来源文档下六场景独立重建／claims／输入及产物哈希／新参考／合成codec／新进程SMT重放全部验收。主depth6 safety/overlap unknown（Z3 reason canceled）保留，非执行失败或证明。主状态归纳初值、纯时钟和全部guard重叠unsat，三个继承FIN目标unknown；完整单项692组及695含等价检查、非空见证与独立CLI verify通过。原主报告不提升；独立归纳仅针对声明的标量／长度状态性质，不证明通用字节、顺序、时序、每RTT增长限度或解释／翻译／实现精化。证据在artifacts/tcp-congestion-development、congestion-initial和congestion-initial-refinement，acceptance/result.json绑定各链。

旧11profile的258项输入集合及每个哈希完全未变，旧311回归关联的293个文件均未修改；新14方法另计，没有宣称已跑一次325方法全量。现有lwIP13场景、Rocq六引理及2750ms差异仍是原范围，未冒充本模块实现证据。下一步加入严格duplicate-ACK识别、快速重传／快速恢复、idle restart及独立丢包／RTO／persist组合，再按用户顺序推进后续协议。完整目标未完成。

## 2026-10-28：有限 classic Reno 快速重传／恢复与接收阶段对应

新增tcp-fast-recovery声明式overlay，继承拥塞／persist／连接、ACK/window、FIN、RTT/Karn及逐字节历史，仍为193规则、当前187不变量。纯ACK须有数据在途、ACK=UNA、窗口等于最近被接受的线端ACK窗口，且缓存与线端窗口均正、非persist；窗口更新／payload／FIN／无效SEQ／future ACK不冒充重复ACK。第三次触发UNA处最多一个SMSS前缀重传、以FlightSize减阈值并膨胀cwnd，额外dup膨胀不再重传；首次新UNA（含partial ACK）退出classic Reno并清CA信用，不额外增长。新发数据仍使用显式app.transmit机会，未实现limited transmit或每dup自动发新数据。

fast原因与timeout原因分开，不删除父TX-INV-NO-EARLY-TIMEOUT；更新实际重传前缀时刻和Karn重叠，保留原RTO截止点，由父年龄检查等待过早到期，不虚增重试／退避。实际输出携带当前累计ACK，正确取消delayed ACK。主动／被动握手、CLOSE-WAIT、FIN在途、partial/full ACK、wrap及RTO退出组合均有验证。规范来源固定RFC5681 §§2/3.2、RFC6298 §§3/5及RFC9293 §3.10.7.4，模块级来源锁和原文SHA纳入输入；核心执行器与形式后端无新算子或TCP回调。

三个可达模型缺陷在开发中发现并修复：握手动作把源状态当作目标而丢失窗口知识；只检查线端窗口而漏掉缓存窗口0时，进入恢复却无输出；聚合接收规则错误更新被拒收DATA／FIN的窗口元数据。后二者分别产生固定输入SAT、参考验证／重放与独立进程SAT复查；已加入ENTRY-SEND和忽略段元数据不变不变量，并直接使用父IR的seg_acceptable/ack_is_future，不能凭规则ID推定所有内部分支都接受了段。反例、旧模型／查询／见证、当时较弱性质与unknown结果完整归档于diagnostics/fast-recovery-*；两阶段历史压缩档逐文件SHA验证并从隔离解压源重现，旧成功检查不回填为新性质证明，也不回滚当前模型。

最终19方法一次通过（312.176s），15固定输入（6继承拥塞、9恢复）参考执行、完整字节重放、新进程查询、严格synthetic-only codec、claims及所有冻结输入／产物哈希验收完成。8个固定输入实际触发非空快速输出，被拒收窗口性质亦有非空见证；不是仅初始状态的空证明。主depth6 safety/overlap unknown（Z3 reason canceled）保留；该深度也不能覆盖所有准备后第三dup轨迹。状态归纳初值／纯时钟／guard均unsat，6个接收／FIN目标unknown；完整1460单项分组、1466含等价检查与独立CLI复查通过，主报告不提升。只针对声明的标量／长度状态性质，不等于通用内容、输出顺序／时序、每RTT上限、翻译／实现精化或完整TCP证明。

验收链见artifacts/tcp-fast-recovery-development/acceptance/result.json及fast-recovery-current-*。旧11profile的258项输入集合、旧311回归关联的293文件及父拥塞开发证据输入均未变；原14拥塞方法证据保持独立。本阶段尚未注册suite、无新独立实现恢复或Linux证据，2750ms差异保持。新增tools/run_frozen_regression.py，用标准unittest发现、记录提交和测试ID／依赖SHA，依赖改变即使测试成功也拒绝计为该提交通过；将启动包含新增测试的完整回归，结果另记，未完成前不计通过。后续继续独立快速恢复／丢包实测、limited transmit、空闲重启及一般允许输出对应，再推进用户约定的后续协议，完整目标未完成。

## 2026-10-28：独立快速重传观测与组合回归

91e36724已推送，PR#2保持draft；344项标准unittest发现回归已在该提交启动，冻结输入清单／测试ID／工具环境保存在/tmp/tcpip-full-regression-91e36724，未结束前不计通过。新增ports/lwip-recovery采用私有加载的既有stream传输／证据模块，模型另指tcp-fast-recovery，独立场景及适配器源码也纳入哈希。旧C驱动、上游lwIP、归一化、比较器及在途344测试依赖均未改。默认模型IW4与上游SMSS4时初始窗口16保留；本实验只发送一个SMSS，不声称两侧内部cwnd相等。

四输入为两个dup、三个dup、四个dup，以及数据发送前11ms先注入无在途纯ACK后再给三个dup。实际netif包表明，未预处理的第三dup在32ms只有模型重传，上游在第四dup33ms才重传；有预先ACK时两侧均32ms重传，两个dup均不重传。均在40ms确认四字节，回调与实际字节[0,128,255,7]保留。不能用预先ACK场景替换或抹掉原差异。源码tcp_in.c SYN_SENT不在该路径设置snd_wl2；tcp_receive先保存旧右窗口沿、再更新窗口并比较旧值，是差异的解释线索，未读取PCB内部变量，不凭此直接认定RFC违规。RFC5681 September2009 §2/3.2原文和模块来源锁与恢复IR共同绑定；没有改动此前2750ms差异。

独立port两个方法一次171.510s通过，含四输入真实编译／执行、严格投影及字节／EOF校验、拒绝初值覆写／丢包／越界输入、拒绝外来场景，以及模型语义哈希篡改负例。该方法集合不在在途344测试发现内，结果分开报告。四输入正式产物独立verify及导出查询新进程SAT全部通过，两个match、两个有效mismatch；见artifacts/lwip-recovery/verification.json。完整恢复状态、RTO、内部拥塞变量与实现精化仍待验证；脚本dup不等于真实接收端丢包或Linux证据。每个报告保留原始包、Difference、模型轨迹、查询与编译来源。

2026-10-28：91e36724冻结提交的344项完整发现回归已完成，一次3108.338s全部通过，无错误／失败／跳过，1091项依赖与工具环境未变；原始开始／结果、测试ID、依赖SHA与日志归档artifacts/full-regression-91e36724。此前running条目为历史记录。本结果不包含后续独立lwIP端的两个方法，不提升主形式unknown或完整协议声明。

## 2026-10-28：当前RTO约束的有限空闲重启

新增tcp-idle-restart显式overlay及生成工具，组合恢复链且保持193规则／190不变量。RFC5681 September2009 §4.1固定模块来源锁；last-data只在非空tcp_data发出点设置，包含新发、快速／超时重传与零窗口探测，SYN／ACK／FIN-only／排队／阻塞不算。严格大于共享当前RTO才在待发app.transmit机会先置RW=min(IW,cwnd)，清CA累计信用、保留ssthresh；guard选择与action预算采用同一有效cwnd，已在途数据仍允许高于缩窗值，不强加flight<=cwnd假不变量。无新执行器／形式算子、无Python协议回调。

10个主方法一次217.727s通过（含15父拥塞／恢复固定输入），另3个epoch方法一次25.969s通过；分别覆盖999/1000/1001ms、真实RTT学习后1463/1464ms边界、请求与延迟ACK不掩盖空闲、零窗阻塞／probe、fast/RTO时间刷新、清理重连、RW不扩大低于IW的窗口、保留threshold和拒绝一致删除缩窗的故障变体。三个独立手写输出顺序／内容／时刻契约的固定输入完成参考／全字节SMT、导出查询新进程SAT、合成codec／claims和输入产物SHA验收。两次专项测试不冒称一次357项全量通过。

主depth6 safety/overlap仍unknown（reason canceled）；主初值、时钟与guard重叠unsat，7个接收／FIN目标超时。完整1749单项分组及7等价共1756检查与独立CLI复查通过，原主unknown报告保留。仅对声明状态／长度性质；通用内容、输出、时间及解释／翻译／实现对应未获证明，非Linux或独立空闲实现。验收绑定见artifacts/tcp-idle-restart-development/acceptance/result.json；原344回归规范／模型／执行／形式输入均未改，运行工具新增--profile以显式冻结未注册模型规范文档和来源。后续将在新提交启动357项标准发现回归，结果待终态另记。继续limited transmit、实际丢包／定时器恢复和一般允许输出关系及后续协议，完整目标未完成。

## 2026-10-28：有限Limited Transmit与独立输出观测

新增tcp-limited-transmit，继承空闲重启／Reno及共享序列、窗口、缓冲和字节时间链，193规则／193不变量。RFC3042 January2001 §2原文从官方获取并固定SHA，RFC5681 September2009 §3.2 steps1/2为组合来源。前两个被接受的纯dup各自动发至多4新字节，保持cwnd，受rwnd及cwnd+8预算；普通app.transmit的旧预算不扩大。生成器仅复制父IR中既有在途new-data动作的锚定片段并条件化成JSON，包含RTT/Karn、时间历史、ACK piggyback与共享队列；没有运行时回调或新后端算子。已有RTO截止点不重启，FIN已发时拒绝LT，长于当前RTO的idle机会保守留待显式缩窗发送。

第三dup显式以FlightSize减当前周期实际LT字节为阈值基数，UNA推进／恢复入口／实际RTO／persist／清理结束周期。容量16/SMSS4会使不同计算都夹至8，故记录并检验非空基数扣除（如12减8=4），不把相同数值阈值宣称为数值区分证明。13方法一次169.173s通过，覆盖自动字节与顺序、timer不重启、普通发送不借LT信用、1字节窗口、首次无数据、partialACK新周期、RTO、FIN／待关闭、wrap、piggyback及错误基数／错误cwnd增长负例；4手写内容／时刻／顺序契约完成新进程固定字节SAT、合成codec、claims及SHA验收。

初次12普通方法通过后，独立归纳对5个ACK规则产生SAT：任意不变量前态允许fr_dupacks=1、lt_epoch_packets=2，再发便超出2。未证可达，不能称执行协议bug。保留原型源码／所有查询／见证与初次检查，新增packets<=dupacks和packets<=bytes<=4*packets关系；协议动作未因此修改。旧模型已从170成员SHA逐文件验证档中隔离重建，并用旧源码重新生成SAT；导出查询另由独立进程确认。诊断见limited-transmit-induction-epoch-v1。当前主初值、时钟与guard均unsat，无SAT；depth6 BMC及8主归纳目标unknown保留。完整2085单项分组、含等价2093检查及独立CLI验收通过，仅支持声明状态／长度性质，不提升为通用内容、输出时间、翻译或完整TCP证明。

另建ports/lwip-limited-transmit复用未修改的C驱动，先各发送4字节，随后可排队1或3段，再注入前两个dup。3实际PCAP输入、固定查询新进程及独立验收完成，2匹配、1有效差异；2独立port方法175.862s通过并拒绝重哈希伪造oracle。首次测试错误假定lwIP不会发排队数据，两个失败预期及实际包归档。实际一个排队段30ms与模型相同；12排队字节在lwIP按自身普通cwnd预算30ms一次发三段，而模型30/31ms各一段。来源解释是ACK处理末端tcp_output在上游IW16内发送，不是测得内部LT变量或RFC bug，也不能由单段匹配推断LT支持。脚本在31ms结束，全部数据尚未确认；不等于永不发／真实peer丢包或Linux证据。

旧注册258项输入及在途357回归1108依赖未变；后者仍绑定cb163fe7，不将13新方法追加为该次通过。模型验收绑定于artifacts/tcp-limited-transmit-development/acceptance/result.json，独立实现另见artifacts/lwip-limited-transmit/acceptance.json。原2750ms差异与上游源码／oracle／哈希验收保持。继续独立数据计时／丢包恢复、一般允许输出及用户完整后续协议范围，目标未完成。

2026-10-29：cb163fe7冻结提交的357项完整发现回归一次3470.718s全部通过，无错误／失败／跳过，1108冻结依赖和工具环境未变；原始结果／输入／测试ID／日志归档artifacts/full-regression-cb163fe7。先前running条目为历史，不将后续13项LT或独立port测试冒计入本次，主unknown与协议／Linux缺口保持。

## 2026-10-29：独立数据RTO／退避与逐毫秒公共驱动

远端确认PR#2已合入main（ade065bb，包含6fa46e82）。本轮从实际main建立codex/tcp-timers，保留未提交新通道，并cherry-pick357项归档为0da112de。原370回归仍绑定原2d296f89；切换后1125项源码依赖逐项SHA确认未变，不把新分支／端口测试追加入旧发现集合。

ports/lwip-timers复制并明确扩展公共raw API驱动为<=12000ms／64事件；每个虚拟毫秒调用sys_check_timeouts，新增只推进时钟的TICK。不直接调用tcp_tmr／slowtmr、不读写内部PCB计时或拥塞变量。C摘要记录end_ms、clock_step_ms、clock_checks，必须等于真实输入终点、1及end_ms+commands。C/Python两端拒绝非法／非单调／超界TICK；其余16写字节／64peer字节、无PSH／选项／app.read边界保持。IR仍唯一权威，使用共享tcp-limited-transmit链，原模型／执行器／形式后端无改动；重新生成参考轨迹、全字节查询与严格0ms包／接收关系，通过现有独立解析及哈希验收，不能以重哈希伪造oracle或执行时钟。

10项独立port方法一次201.402s通过，5场景全量重建与独立验收、导出查询新进程SAT全部完成。5场景均有效mismatch：无ACK数据在IR为21ms初发、1021/3021/7021重传，实际为21/2750/8750；完整ACK3600后实际与IR都停止后续重传至12000，摘要及12007时钟调用确认窗口走完。partial ACK1003在1000ms到来后，IR2000/4000重传1003处[255,7]，实际3750从1001重发原[0,128,255,7]，随后完整ACK5100后窗口内不再重传。idle6001的新8字节，IR按RW4发一段，实际发两段；不据此推断内部cwnd一致或宣称完整idle符合。

源码opt.h:1375名义初始RTO3000，tcp.c:239调度250ms fast及500ms slow，1275附近按coarse计数／退避；这些是2750相位与后续6000ms间隔的解释线索，不是实际读取PCB RTO，也不直接判定RFC6298违规。tcp_in.c:1288整体释放已全部确认段，是partial ACK后原整段重发的解释线索；严格Difference不因可能的允许输出策略而被抹去。RFC6298 June2011 §§2/3/4/5原文、来源SHA与时钟配置锁均校验，错误SHA／版本／步长／上游修改标志被拒绝。原SYN-loss2750ms证据保持独立。

在12秒无ACK输入中，将单个TICK12000分成48个250ms间隔TICK，仍用同一真实二进制执行，两个原始PCAP逐字节相同；fine52条命令及12052时钟调用、执行日志和原始捕获单独归档clock-partition。此为固定输入驱动分划检查，不是通用调度证明。初次夹具缺expect.timers导致参考阶段KeyError，原夹具／失败日志／incomplete报告保存在lwip-timer-fixture-v1，新增输入门槛拒绝，不计成TCP差异；来源门槛增强前9方法成功日志作为历史保留。

验收与逐包观测见artifacts/lwip-timers/acceptance.json、observations.json和verification.json。编译器／命令／来源／二进制SHA、C日志、原始PCAP、模型轨迹与查询均保留，二进制不提交需迁移后重建。没有独立真实peer丢包、Linux、内部RTO/cwnd、一般合法输出关系或完整TCP／通用精化证明。主模型原unknown不变。370项组合回归仍在运行，10端口方法不在其中；继续输出策略／时序对应及完整后续协议范围。

## 2026-10-29：显式分段调度选择与有限线端前缀见证

新增tcp-segment-choice继承LT／idle／恢复及共享字节／窗口链，共201规则／195不变量。choice.segment(count)是声明的模型调度决策，不是socket参数或真实网络输入；只在已有新发规则可用时允许1..实际take上界，禁止越MSS／发送队列／rwnd／cwnd预算。8条clone完整保留父发送动作，将take换为受guard约束count；原app.transmit保持确定选择。guard上界由父赋值前缀精确替入原take表达式，避免idle缩窗之前的旧cwnd绕过预算。生成器只产JSON，遇非赋值prefix效果或父规则结构变化明确拒绝。无执行器／形式后端算子改动或Python协议回调。RFC9293 August2022 §3.7及其MSS子节为有限分段来源；未覆盖Nagle/SWS等全部发送约束，不能把MSS许可直接当完整TCP符合。

8方法一次500.431s通过：2+2字节顺序／首timer／逐字节时刻，负长度／零／超量／耗尽的Uncovered与原子拒绝，最大选择对5种窗口的canonical共享状态相等，idle后预算，wrap／CLOSE-WAIT以及一致错误take的负例。22组旧刺激逐步比较新模型与即时父LT模型的全部共享变量／计时器／输出；初次测试误用LT之前fast-budget-new-data的原契约，失败及旧测试源码保存在segment-choice-parent-contract-v1。未修改任何旧场景／oracle，修正测试为同一父语义的差分比较，不声称旧profile契约跨层自动成立。

三个独立手写字节／输出时刻契约完成参考、完整字节SMT、新进程导出查询、synthetic-only codec、claims和输入／产物SHA验收。主depth6 safety/overlap仍unknown（reason canceled），主初值／clock与guard unsat；8个新选择规则状态保持查询unsat，5个旧接收／ACK目标unknown保留。1342完整单项分组及5等价共1347检查与独立CLI复查通过，只支持声明状态／长度性质，不替代通用字节完整性或翻译证明。

另以旧lwIP四字节peer-window的完整有效抓包建立截至21ms的五包前缀见证：先独立验收旧报告（仍full mismatch），再运行选择2+2的当前IR并全字节复查，原解析器／严格0ms比较得到初始数据前缀match。载荷逆序、错误SEQ、错误时刻均mismatch；原canonical前缀仍mismatch，原完整Difference字节SHA不变。无重新执行独立实现或新伪造PCAP，原raw capture／报告哈希与新见证均绑定。此处不证明完整API调用对应或后续包接受，也不引入重传／时钟／窗口策略容差。见artifacts/segment-choice-prefix/result.json及tcp-segment-choice-development/acceptance/result.json。

370项旧组合回归仍绑定2d296f89，1125冻结输入未改，新8方法单列。全协议、一般允许输出／应用事件关系、内容／时间／解释翻译及实现精化、Linux和后续协议仍未完成；原2750ms差异／上游源码／oracle／SHA验收保持。继续推进可检查内容与事件对应关系，不将有限前缀见证当作完整符合性闭环。
## 2026-10-29：370项冻结回归完成

2d296f8941d41043921ba9c637d4192eb183753c的370项标准发现回归已经终止并全部通过，runner用时3618.822秒，失败／错误／跳过均为零；1125项冻结依赖及工具环境未变。原始开始记录、测试集合、输入SHA、完整日志和最终结果归档artifacts/full-regression-2d296f89，先前“仍运行”条目保留为历史。后续segment-choice八方法、output-schedule专项和独立端口测试均不计入本次完整回归。主形式unknown、完整TCP、Linux及后续协议缺口保持。


## 2026-10-29：完整源输入下的发送机会、服务记账与线端见证

新增未注册tcp-output-schedule，继承segment-choice共享连接／序列／缓冲／恢复链，201规则／200不变量。flush与原有效pure ACK只授予当毫秒的显式发送机会，choice.segment保留父预算及实际发送动作；其他源事件关闭机会，延时选择由guard拒绝。源输入由通用replay_schedule.py按索引顺序各一次消费，禁止伪造网络输入／改字段／重排／省略。默认严格入口继续要求原canonical终态；观察入口只返回该终态的明确差异，必须另做完整线端／公共服务投影判断，宿主无TCP协议回调。服务累计写入、data确认信用及放弃字节在IR中显式质量守恒；固定完整segment ACK范围下才映射C公共sent回调，不推广一般partial ACK。

完整12方法一次495.456秒通过，包含22组旧刺激逐源事件对照父协议全部共享非choice变量、状态、timer与带时刻输出，及输入重排／伪造／遗漏、过期选择、未来ACK、RST放弃而非确认和一致错误确认记账负例。两条手写字节／时刻契约重新生成参考、完整字节SMT和synthetic-only codec，claims／输入SHA／导出查询新进程SAT与独立验收通过。depth6 safety/overlap仍unknown；主归纳初值／clock／长度引理unsat，3个旧FIN-WAIT-1接收目标unknown，845完整单项分组及848含等价检查和独立CLI复查通过。原主报告保持unknown，不是一般字节／时间／翻译或完整TCP证明。

旧lwIP窗口4捕获先经原通道独立验收，完整Difference仍mismatch。消费全部7源输入，选择21ms的2+2、30ms的一段2字节，严格checksum／顺序／0ms比较全部9包match，公共写入8／确认4与IR服务变量相等。最后40ms的ACK1009是future ACK，IR与实际都给纠正ACK；保留snd_una1005、snd_nxt1007、待发[65,129]、待确认[17,33]及rtx1030。因此原canonical终态继续mismatch，报告完整保留这5项差异。30ms再发最后2字节的候选虽然满足原canonical终态，却与抓包／公共确认字节冲突，作为反例保留。载荷／SEQ／时刻故障均mismatch；不改原输入、旧oracle、严格比较器或Difference SHA。此为单输入存在性完整观察窗口见证，不是旧夹具通过、真实隐藏调用因果、一般Nagle/SWS或实现精化；复用旧真实捕获，不计新C执行或Linux证据。

最初四段候选和错误全确认假设归档output-schedule-canonical-final-v1。新增兼容性检查另发现idle_before_cwnd8与4不同，进一步重放确认flush和choice重复执行idle前缀，连实际重启计数也多一次。修正flush为idle_restart=false，延迟缩窗／清CA／计数到实际choice；不排除任何idle字段比较。历史1774成员、失败12方法日志及隔离旧expanded IR重现见output-schedule-idle-prefix-v1；其旧形式结果未发现该可达记账缺陷，不能归给修正后的模型。当前模型与所有形式／固定输入产物均重建复查，诊断同时验证旧计数差异及新模型全部共享变量一致。

验收见artifacts/tcp-output-schedule-development/acceptance.json和artifacts/output-schedule-alignment/result.json。RFC9293 August2022 §§3.7、3.9.1.2、3.10.7.4版本／原文SHA锁定。258项旧注册输入逐一SHA未变，上游lwIP／2750ms差异保留。已完成370项全量回归不含此12方法及此前segment-choice8方法；当前标准发现390方法，下一组合回归按本里程碑提交冻结，未完成前不计通过。继续一般内容／事件／计时对应及完整后续协议目标。

2026-10-29：a7866f0b冻结提交的390项完整发现回归一次4257.189秒全部通过（runner4257.370秒），无失败／错误／跳过，1155项依赖及环境未变。证据归档artifacts/full-regression-a7866f0b，历史running条目不再代表当前状态；新sent-ledger及独立端口方法另行验收，不提升主unknown或完整TCP／Linux声明。

## 2026-10-30：显式发送段账本、部分 ACK 服务观察与条件组件检查

新增tcp-sent-ledger及生成器，继承当前输出调度／恢复链，201规则／220不变量。16槽环形原始发送段记录、序列末端、部分头段前缀、callback／abandoned lifetime计数均为JSON IR；重传不增加原始发送信用，ACK只释放完整原始段，异常清理明确计入放弃量。与父规则逐项比较guards／目标及去掉cb赋值后的actions，无任意Python协议回调／新语义算子。RFC9293 August2022条款及上游lwIP2.2.1源码锁固定；whole-original-segment公共回调是有限实现服务投影，不冒称RFC统一socket语义。

新增11项模型方法一次356.789s通过，覆盖部分／重复／未来ACK、重传、环形槽复用、回绕、重连和负例。具体可达测试发现16在途字节并不限制一次原始段信用至16：部分头段3字节加16未确认字节可释放19。保留旧源码／失败／隔离重放。任意前态归纳又发现11个缺少emitted+pending<=written约束的SAT状态；未证明这些前态可达，不宣称TCP实现bug。只增预算不变量，保持原guards／actions，当前主归纳无SAT但42规则的62目标unknown；depth6 safety／overlap也unknown，原报告不改。

9个固定输入完成参考、全字节SMT、新进程SAT、synthetic-only codec与SHA验收。独立ports/lwip-service仅增加公共tcp_sent时间／字节记录，无PCB读取／上游改动；10方法一次655.913s通过，8真实C捕获及独立CLI／导出查询验收完成。原始严格线端4匹配4差异，服务5匹配3差异。3个替代调度仍消费原刺激一次且有完整字节见证，其中2个完整包与回调匹配；duplicate-future保留自动LT在30ms发出而实际40ms才发的线端差异。所有原Difference与canonical失败保留；替代见证不是新C执行或一般实现精化。wide-window真实4字节段的部分ACK不回调，与window4实际2+2分段的回调区别得到观测。既有2750ms／partial-RTO差异原样保留，不判RFC错误。

新增独立条件组件检查器，只以200个未变父不变量和预算性质自身为前态假设，对初值／201规则各目标／clock等240查询生成与独立复查全部unsat，并有非空全字节SAT重放。498次断言对应检查包含独立AC证书／无条件原语定律与无其他premise的逐clause等价；错误命题重哈希／漏覆盖／父basis变化／重复数丢失等负例被拒绝。组件4方法及AC4方法分别通过。此结论不证明父basis在子模型闭包、其余child不变量、通用字节／解释器／翻译器或实现对应；可信Python/Z3组件明确列出。历史共享上下文超时与序列化／等价失败档案保留，未放宽10s预算或哈希／oracle。

新增Rocq5个抽象整数命题与独立编译／假设审计／kernel重查及故障门槛，使用固定9.2.0镜像。macOS本地无Docker，当前not_run，等待提交后CI；模型哈希只作上下文绑定，未建立IR精化桥。阶段验收位于artifacts/tcp-sent-ledger-development/acceptance.json。已完成390项回归不包含本轮新增19方法；409项完整发现回归应在本轮冻结提交另跑。一般Nagle／短段与LT组合、完整发送／服务／时间关系、Linux实机及全部后续协议仍待推进，完整目标未完成。

2026-10-30：eaeb02ff的[Rocq CI](https://github.com/briliant-ben/TCPIP-Model/actions/runs/40926132635)完成成功。新增5个发送信用抽象整数命题已编译、空公理审计及独立kernel重查，错误证明／公理注入拒绝；ZIP、证明对象、来源与日志SHA绑定在artifacts/rocq-ledger-ci-eaeb02ff，独立本地绑定验收及损坏对象负例通过。此前local not_run和CI pending记录保留为历史；本地未重跑kernel，也未证明IR动作／解释器／翻译器／TCP／lwIP对应。409项冻结回归仍在运行，完整目标未完成。

## 2026-10-30：基本Nagle与自动LT组合的显式策略

新增tcp-nagle继承sent-ledger，共203规则／222不变量；RFC9293 August2022 §3.7.4的基本合并策略以IR guards／actions表达，固定Eff.snd.MSS4。有在途数据时短choice被拒绝，自动LT只在允许发送完整4字节时生效；ACK处理、dup计数与旧timer保持，不能用LT绕过基本Nagle。app.nodelay(enabled)在ESTABLISHED／CLOSE-WAIT显式切换，当前有限API不直接授予发送机会，新open恢复默认。重传与persist保留父语义；lwIP unsent多节点／FIN／内存压力／fast-recovery例外、动态MSS及完整sender SWS/override未覆盖，不称完整TCP。

8专项方法一次149.494s全部通过，覆盖短段／部分ACK等待、完整ACK放行、fullMSS LT、rwnd／cwnd约束、选项无隐式输出／信用、短段重传、CLOSE-WAIT加wrap／FIN ACK及去除LT门槛故障。初版使用gt被类型检查明确拒绝，随后复用空send规则的option误带empty_send通知由负预期发现并去除精确锚定通知；旧原型源码／失败／其242条件查询单性质通过记录保留，展示局部性质不能证明全部API输出。补充FIN夹具曾漏必需ACK字段，原schema拒绝保留，修正夹具而不改协议语义。

基本新数据门槛单性质242查询与2420断言对应检查独立复查通过，前态假设为220个父不变量加该性质；不证明父basis在child闭包或其余新旧性质，当前overlay全模型BMC／归纳未跑，父整体unknown保持。原duplicate-future真实捕获现在有同原始10输入、2个显式choice的完整严格见证：21ms首2字节，重复ACK不LT发短段，40ms完整ACK后发剩余2字节。全部报文／checksum／顺序／0ms时间及2@40、2@50公共callback匹配；原canonical匹配，但旧模型Difference和服务Difference SHA原样保留。此为复用已有独立C捕获的一场景关系，不计新C执行／Linux或一般lwIP符合。逐字节查询、独立重新执行／生成、查询等价UNSAT、新进程SAT及payload／SEQ／1ms负例全部验收。

验收入口artifacts/tcp-nagle-development/acceptance.json；来源锁spec/sources/tcp-nagle.json，保留RFC3042与lwIP固定版本对变体的解释。生成器确定性及旧258注册输入SHA确认未变。新8方法不属于eaeb02ff正在运行的409项冻结回归，完整发现现为417项，尚不宣称组合全部通过。继续sender SWS／短段队列策略、服务／时序／恢复及IR解释／翻译对应，再按原计划推进UDP与后续协议；完整目标未完成。

2026-10-30：eaeb02ff冻结提交的409项完整发现回归一次5043.817秒全部通过（runner5044.056秒），无失败／错误／跳过，1208项依赖及环境未变。证据归档artifacts/full-regression-eaeb02ff；此前running记录是历史。后续Nagle8项和SWS开发不属于本次409集合，不能追加推算全量通过；主unknown、Linux与完整协议缺口保持，目标未完成。

## 2026-10-30：发送端SWS有限策略、PUSH前缀与独立窗口观测

新增tcp-sws继承Nagle及共享发送／接收／恢复链，209规则／223不变量。RFC9293 August2022 §3.8.6.2.1 MUST-38及推荐算法固定MSS4、Fs1/2，历史最大接受窗口与当前usable window分开。正常choice／自动LT必须发完整MSS、全部已push队列、至少历史最大窗口的一半，或已有超时授权；实际选取prefix满足条件，仍受父Nagle／rwnd／cwnd约束。app.push仅标记当时队列前缀，后来写入不继承，close标记自身前缀。无新运行时算子／Python协议回调，上游lwIP不改。

另设sws timer，默认200ms，配置100..1000。首次pending输出请求启动，更多写入／重复请求不延后；实际新字节推进才开始剩余队列新周期。到期提供同刻choice机会及持续ready，并不直接自动发包，fairness／mandatory输出活性仍开放。清理、队列耗尽或离开发送状态取消。IR尚无actual timer deadline表达式，metadata与实际deadline的独立状态等式未证明；到期guard、精确参考／SMT时序及早／晚arm故障分别验收，不把状态检查提升为通用计时器对应。

13方法一次232.550s全部通过，覆盖exact221ms、奇数半窗口上取整、窗口缩减与future ACK不污染max、push前缀、不相互关闭Nagle／SWS、重复请求不延后、新周期与旧RTO截止点、零窗口不越权、reset重连、65535窗口域及CLOSE-WAIT／wrap／FIN flush。六个独立手写字节／时刻／顺序契约（含push、两轮override、wrap关闭）完成参考、全字节新进程SAT、独立重建／查询等价和synthetic-only codec验收。新depth6 safety与overlap均unknown/canceled，报告保留。

SWS-INV聚合新窗口／prefix／timer所有权／发送理由状态性质，在222父不变量及自身为前态假设下，248查询全部unsat，并独立复查1863个断言对应；此组件不证明父basis在child闭包、其他父性质、字节／解释／翻译或实现对应。八个旧choice guard只增强，其他旧guard保持；六个新event/state组是新鲜单例，表示未扩大旧冲突可能，不替换原整体overlap unknown。

初版max误限16导致24个SAT目标，实际父通告窗口允许0..65535；已在隔离旧IR中用正常window17握手重现可达失败，修正后接受。完整原IR仅一个invariant literal变为65535，guards／actions不改，所有原查询／witness／源码保留；24个原SAT导出保留全部断言并绑定保存witness，在原10s预算下重新SAT。一例无约束重查timeout单独保留，未升级为成功或宣称24前态全可达。初始max算子被类型检查拒绝，改用已有ge／ite；半关闭新夹具曾错误假设数据发送或ACK即发FIN，按父CL-FLUSH-FIN显式调度修正，旧oracle未动，原失败留档。

ports/lwip-sws使用相同公共sent-event C驱动、1ms sys_check_timeouts，4方法一次269.069s通过，3个新真实C执行全部独立CLI／导出SAT验收；1线端匹配、2线端差异、3服务匹配。完整4字节在21ms一致，两个1字节写（含历史窗口16缩至1）实际21ms，模型按所选SWS策略221ms；230ms sent callback一致。保留严格0ms／checksum／顺序Difference，不据此判RFC bug、观测内部SWS或泛化lwIP符合。修正invariant前的3捕获另存历史，与修正后新执行的原始PCAP和公共摘要完全相同，不重标历史hash。PUSH／wire PSH不在此C适配器范围，只有参考／SMT证据；非Linux。

验收见artifacts/tcp-sws-development/acceptance.json。258个旧注册输入SHA、旧模型／oracle及2750ms差异保持。409项完整回归已在eaeb02ff通过；新Nagle8和SWS13不在该集合，当前发现430，须在新冻结提交另跑。Nagle新增冻结profile视图复现原已验收trace，没有新增C执行。后续继续精确语义／时间与输出对应、发送活性边界、receiver SWS／wire PSH／窗口与恢复及Linux，再按原顺序推进后续协议，完整目标未完成。

2026-10-30：新增ports/linux-netns和Linux TCP independent capture CI入口，使用固定官方packetdrill2a8b4d80、临时Ubuntu VM与unshare --net。现有模型生成的全部握手期望保留，仅增public bind与offload配置；独立tcpdump在模型ESTABLISHED三包边界止，严格checksum／0ms Difference。执行子进程核对真实父PID namespace和自身不同后才配置网络。原始capture／kernel／tools／编译／脚本／模型hash及独立runtime验收已编码；Mac本地2项准备测试通过，缺Linux/TUN/unshare/ip/ethtool，CI尚未实际执行，不计Linux证据。430冻结回归继续绑定4db896eb；新增通道不改其冻结输入。

2026-10-30：Linux CI首次在run41002313195构建及namespace成功，但offload配置141ms导致absolute0的socket时间超过执行50ms，独立capture0包；完整失败ZIP／日志／原脚本留档。按固定官方packetdrill相对事件语义把socket改为相对setup结束，未修改任何packet期望、模型、parser、50ms执行容差或0ms Difference。run41002939358实际Linux7.0.0-1017-azure三包握手与独立runtime验收通过；源头e62f799d、命名空间／原始PCAP／kernel／工具／模型／脚本hash及GitHub ZIP摘要绑定。0ms比较仅保留10.055ms SYN+ACK／10.073ms ACK与模型10ms的时间差；非RFC bug结论，非lwIP或合成证据。边界止于ESTABLISHED三包，不含原场景5010ms静默观察，后者继续实施；非窗口／options／payload、恢复或完整TCP证明。匹配源码下离线复查通过且未冒称本地再执行Linux。证据artifacts/linux-netns-ci-e62f799d。

2026-10-30：sent-ledger原62 unknown目标的group8精确细化已终态refinement_unknown，3目标闭合、59仍unknown；2394组unsat、553组unknown。3闭合目标另用独立CLI145检查复核通过；原主unknown不改，不宣称整个220不变量或payload／时间／翻译对应证明。3134原始文件及成员SHA封存artifacts/sent-ledger-refinement-unknown，原未提交目录保留。430冻结回归仍在运行，新Linux／归档工作未改其1244依赖。

2026-10-30：在已验收三包Linux观测之后继续扩展到原handshake场景5010ms settle：去掉tcpdump包数上限，延迟SO_ERROR检查后用文件barrier保持socket打开，只有capture停止后才释放工具清理；保留所有选中包、零drop门槛和0ms oracle。新增capture生命周期／quiet边界校验及model-uncovered、无效capture、执行失败、环境失败分类，3项本地准备测试通过，完整静默窗口CI待执行，尚不计完成。历史e62f三包证据保持原范围与哈希。430冻结输入不变。


## 2026-10-30：真实 Linux 完整握手场景观察窗口验收

[CI run41004399031](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41004399031)在1551c535源码运行成功；证据入口artifacts/linux-netns-ci-1551c535/acceptance.json。实际Linux7.0.0-1017-azure、独立网络命名空间、固定未修改packetdrill及独立tcpdump覆盖原场景5010ms静默期，实际观察5010.89946ms，无包数上限，内核捕获丢包0。socket在抓包停止后才释放清理；有限窗口内仅观察到3个握手包。此前e62f799d仅三包前缀证据保持原范围，不能倒推其覆盖静默期。

原active-open-v1、严格checksum与0ms Difference保持：方向／flags／相对SEQ／ACK匹配，SYN+ACK10.093ms、最终ACK10.131ms对模型10ms的时间差异保留，CI成功不等于投影完全匹配。原始PCAP、编译／源码／脚本／模型及查询哈希、内核／命名空间／捕获生命周期、CI日志／来源和ZIP SHA全部绑定。独立runtime验收成功；当前源码的离线重新生成／查询等价UNSAT及4个重哈希负例（参考时刻、checksum、缩短静默期、重加3包上限）通过。离线重查不是本地Linux重跑或CI二进制再执行。

这是一个真实VM内核、注入对端的有限主动打开场景；不覆盖物理NIC／远端丢包、数据／窗口／选项／payload／恢复／其他协议或一般实现正确性。原lwIP2750ms与其他差异不改；本机macOS权限缺口没有改变，由独立CI通道完成此有限验证。430项回归仍运行，1244冻结依赖未变；精确ledger单目标细化仍运行，整体unknown与完整目标未完成。运行与验收说明见docs/linux-netns.md。

2026-10-30：Linux通道扩展为handshake／syn-loss两个白名单场景，CI各用独立VM。旧model/tcp.json、两个场景、所有原协议算子及oracle未改；loss实验保留两个出口SYN，只对首次SYN不注入响应，非物理网络丢包。按原IR1000ms重传／1010ms响应生成全部预期，syn-loss声明6010ms完整窗口；scenario身份／loss机制／settle逐项绑定验收。7项本地准备／拒绝测试通过，两个固定查询独立解析SAT，证据artifacts/linux-two-case-preparation；这些不是Linux运行证据，新CI待运行。准备测试误用Machine.variables的原始失败归档后改为现有values字段，协议不变。旧1551c535证据仅在其命名源码检查点复查，新源码哈希不被放宽。430回归／精确单目标继续运行，原2750ms差异与完整目标缺口保持。

2026-10-30：S-ACK-VALID→ESTABLISHED的group-size1精确细化已终止unknown：368组中298个producer UNSAT、70个UNKNOWN，逐查询10s不变、原其他断言全部保留，等价查询UNSAT。370成员／6698504字节归档artifacts/sent-ledger-single-target-unknown，逐成员与原源码／checker SHA核对；未对全部组独立重跑，未闭合新目标，原62目标主unknown及group8的3闭合／59unknown均不改。原未提交目录保留。下一步需改善字节／计数／赋值编码，而非增加重复切分或把超时称为证明。Linux双场景CI41005706790正在运行；430冻结回归继续。

## 2026-10-30：双场景真实Linux与工具动态容差澄清

[CI41005706790](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41005706790)在de084a26源码的handshake／syn-loss独立VM jobs均执行及runtime验收成功。原始ZIP SHA、官方来源、完整日志、PCAP、独立离线重建与查询等价、10个重哈希负例及逐成员哈希归档artifacts/linux-netns-ci-de084a26，acceptance.json验收通过。均实际Linux7.0.0-1017-azure，无包数截断／捕获内核丢包，socket清理在抓包停止后。handshake完整窗口5010.313562ms，3包，10.051／10.064ms对10ms；syn-loss完整窗口6071.244654ms，4包，重传1061.092ms对1000ms、响应1071.217／ACK1071.238ms对1010ms。只有时间Difference，0ms oracle原样保留。首次SYN出口仍被抓到，仅注入对端不响应；不是物理网络丢包。

核对固定官方packetdrill源码发现原先“50000us执行容差”的描述只记录minimum，工具还默认tolerance_percent=12.5，按max(minimum,间隔*百分比)验收；1秒事件有效125ms，所以61.092ms延迟可过工具执行而仍为严格Difference。原官方run.c／config.c完整Git blob及SHA来源已存upstream-timing，无修改默认／模型／oracle强行匹配。旧报告50000字段应读作下限，旧证据不重写；此处补齐实际默认配置解释。不把线端间隔称为内部RTO观测或直接判RFC bug，尚未隔离量化／调度原因。lwIP SYN2750ms独立差异保留。

上述只有两个有限主动打开实验，不覆盖Linux数据／窗口／恢复或一般协议证明。10个负例含场景标签更改，均为离线临时复制，不计新内核运行；本地未重跑Linux／CI二进制。原258输入和430回归1244冻结依赖未变；精确ACK单目标已终止unknown并归档，430回归继续，完整目标未完成。

2026-10-30：4db896eb冻结的430项标准发现回归已全部通过，unittest5163.255秒／runner5163.586秒，无失败／错误／跳过，1244依赖及环境未变。原始结果、依赖／测试ID清单及完整日志归档artifacts/full-regression-4db896eb。包含Nagle与SWS新方法，但不含随后新增Linux端口7方法；历史running描述不再代表当前状态。此结果不提升整体形式unknown或完整协议声明，目标未完成。

2026-10-30：新增Linux receive-four-zero-octets有限输入，引用现有tcp-sws组合IR（模型未改），完整tcp-connection-v1投影保留窗口／payload／time及全部ACK。驱动只以出站SYN锚定ISS，并注入SYN+ACK／单个4零字节段；出站ACK为显式observation-only，仍全部进入独立抓包和严格oracle，不强迫内核延迟ACK时刻。捕获完整5020ms并以最后注入20ms为quiet延迟锚点；有效输入／完整抓包下缺少输出ACK记为Difference，不误判证据无效。

固定上游parser.y只有TCP payload长度，tcp_packet.c清零buffer；完整Git blob／SHA来源保存在artifacts/linux-receive-preparation/upstream。不支持非零字节或其他刺激时明确拒绝，不用零值替换，亦不声称应用读取／内核rcv_buf观测。MSS4／window16仅为IR参数，不强制Linux相同，差异保留。驱动显式绑定原12.5%动态与50000us下限，0ms oracle不变。12项准备／负例通过、组合IR固定全字节重放及独立CLI SAT通过；新增Linux CI待运行，这些准备不是实机证据。新inputs补齐所有模型本地规范解释文件绑定；旧CI快照继续使用其命名源码，不放宽哈希。

2026-10-30：新增通用formal/tactic_recheck.py，严格接受单个SMT conjunction，拒绝增量／改选项／多次check，原断言逐项AST对应后用固定simplify→propagate-values→solve-eqs→simplify→smt策略和10s预算执行，再由新CLI进程复查，工具4方法及既有partition6方法通过。未改变IR／解释器／旧翻译器。S-ACK原始368组与等价查询均完整重建；298组加等价299项分别两次新CLI UNSAT，70仍UNKNOWN，终态refinement_unknown。没有新增闭合目标；原主报告、其他断言／domain与所有旧unknown保留。全部脚本／来源／producer及独立日志打包、逐成员核对在artifacts/sent-ledger-tactic-refinement。

Python内pilot曾得group052 UNSAT，但CLI10s未复现，不能晋级；普通赋值展开也未闭合，探索记录保留。此轮增加可迁移的精确查询／独立进程证据门，不把策略重查说成协议或编码正确性证明。下一步需处理模算术与大条件／环形账本赋值的精确编码，不继续用更多启发式替代语义工作。已完成430组合回归不含新增4工具方法（现发现434但未跑完整组合）；Linux接收CI单独验收，完整目标未完成。

## 2026-10-30：首个真实Linux接收数据有限场景验收

[CI41014477824](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41014477824)的2ab2a472源码在Linux7.0.0-1017-azure完成receive-four-zero-octets及两个控制场景；三个独立VM jobs运行时验收全部通过。现有tcp-sws组合IR未改，独立tcpdump捕获5包／完整5020.014606ms／0内核捕获丢包，4个零字节和累计ACK9005匹配。完整方向／flags／SEQ／ACK／window／payload／time的0ms oracle保留7项字段Difference（3窗口＋4时间）：内核ACK20.059ms对模型60ms，通告窗口64240→64236对16→12。未强制内核MSS／窗口，也未观测其内部rcv_buf或应用读取；模型40ms delayed-ACK是RFC9293 §3.8.6.3范围内选定策略，不将提前ACK／配置差异判RFC bug。

出站两个ACK在驱动中明确observation-only，但全部进入独立原始抓包及严格oracle；未删除ACK或修改模型以强行匹配。固定工具只支持此4零字节注入，任意字节／PSH／发送／乱序／恢复仍不计Linux验证。两个控制回归新实际窗口5010.198361／6057.786729ms，SYN重传1047.673ms对1000ms；以前1061.092ms和lwIP2750ms保留原快照不重写。命令显式记录既有50ms下限＋12.5%工具容差，独立oracle仍0ms。

证据入口artifacts/linux-receive-ci-2ab2a472/acceptance.json；三套原ZIP、官方API来源、完整CI日志、原PCAP、全部源码／模型／解释文件／脚本／查询／工具绑定、runtime及独立离线重建／查询等价UNSAT已验收。5个重哈希负例含重新计算正确TCP checksum的错误payload，仍在独立解析／输入门被拒绝，原件未改。离线检查不是更多Linux执行或本地CI二进制重跑。旧258输入SHA仍未变。430组合回归已通过，新增4形式工具方法和Linux端口12方法单独记录，不冒称434全量通过；主形式unknown、一般协议与后续模块目标未完成。

## 2026-10-30：精确模算术证书、声明式序列契约及单个ACK分支

新增formal/modular_normalization.py，只处理已导出SMT的正整数固定模数：同模嵌套、整数加减及常数系数归并；非线性／条件项保持opaque，不跨不同模数，符号／非正模数、量词、增量／改选项／多check显式拒绝。每次实际重写生成不含协议／查询premise的通用整数等式，新CLI证明UNSAT；另一个遍历验证源子树实例、全部原断言的数量／顺序与congruence重构，并在新进程复查每个等式。Python AST检查器与Z3仍可信，未称Rocq或通用IR翻译器证明。没有改旧IR／解释器／后端默认语义或10s预算。

新增独立model/seq32-contract.json：1状态／1事件规则／7变量／2不变量均显式IR。覆盖全部32bit输入及不受界的有符号整数位移，声明距离回加和位移还原两条标量定律。现有modular-int归纳义务与独立verify通过，36原始断言精确绑定，3次实际重写／3通用等式分别独立复查，原／转换query均UNSAT。8组回绕／半空间／大正负位移参考及固定输入SAT／新CLI SAT通过。默认BV32主BMC及CLI仍UNKNOWN，绝不以modular通过替换该报告。两IR故障有合法固定输入SAT见证并触发参考不变量；早期负测试误期望无约束BV搜索必得SAT，UNKNOWN原失败／源码保留，改以合法具体反例，不收窄正向域／模型guard。

独立验收发现负整数的API／SMT AST表示不同；没有忽略或用其他premise掩盖，而对9个非同形断言生成无原查询前提的XOR UNSAT复查，数量／顺序仍完整。原拒绝／源码归档diagnostics/seq32-api-export-v1。5个normalizer新方法＋3个标量契约方法和已有4 tactic／6 partition／13数据语义方法合计31项一次0.959s通过；证据artifacts/seq32-contract-development，源码／命题／工具版本与binary/checker SHA绑定。它只关闭声明的标量IR性质，不证明整个Python／Z3／字节／时序或TCP实现对应。

实际S-ACK-VALID→ESTABLISHED的原违例分支52保留444条原约束、模重写数0；经逐条AST重构的等价重新导出，新CLI两次UNSAT（6.140658／6.137274秒），原序列化仍10s UNKNOWN。新证据只支持该一个原分支，不能归因于模运算优化或宣布完整ACK目标闭合，其余69个原UNKNOWN分支未闭合，旧70UNKNOWN分区／59UNKNOWN目标报告保持原件。谱系及原／导出query、独立日志见artifacts/ack-modular-normalization。下一步仍需精确处理大条件SSA／环形账本赋值，并把受限IR执行与可检查语义桥逐步接入Rocq。

旧258注册输入SHA未变，430冻结回归已通过；当前标准发现442项，新增8方法及旧4方法尚未在完整442集合运行，不以31专项替代全量。Linux／lwIP既有证据与2750ms差异未改；没有新增实机或完整协议证明，持续目标未完成。

2026-10-30：PR#3已合入main的ab9f75ba605bd8b7fd766cc5e75e160dabd4c80e；本轮后续工作转codex/tcp-modular并合并该main（源码无差异）。新442项标准回归已在71a3e1a8冻结运行，1260项依赖当前未变，原始进程仍在运行；不重启、不冒称全量通过。新模运算／标量契约里程碑将独立提交新草稿PR，旧未提交refinement目录保持。完整目标未完成。

2026-10-30：新增formal/rocq-scalar受限执行语义试点。仅接纳单状态／单application事件、无条件自环、int/seq32有序set及eq不变量，定时器／消息／条件／其他类型和额外语义字段显式拒绝。源IR的7条赋值、2个性质、初值和seq32事件域生成Compiled.v数据构造子；另一个逆向解析器逐项恢复原JSON AST与顺序，拒绝漏域／改索引／隐藏定义。Semantics.v定义该片段的求值／有序状态更新，Proofs.v的命题直接量化执行生成程序而不是独立手写方程。Python类型／片段验证及结构绑定检查器仍可信，未声称JSON编译器、Python／Z3或TCP普遍正确性。

7项本地结构／故障方法通过；本机无rocq，生成及源绑定完成但kernel状态not_run，证据artifacts/rocq-scalar-local-preparation。不用此准备称kernel通过。新增digest固定Rocq9.2.0 CI，待实际编译／空公理审计／独立check及两个源IR变体（错误逆位移、错误赋值顺序）新工作目录证明拒绝。新7方法不属于正在运行的442标准发现；其1260冻结依赖未变，完整目标未完成。
