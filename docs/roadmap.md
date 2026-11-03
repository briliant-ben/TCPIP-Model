# 里程碑与验收门槛

当前活动 flow 原型的逐项验收与范围见 [spec-flow-acceptance.md](spec-flow-acceptance.md)，服务器／外部调用方入口见 [spec-flow-server.md](spec-flow-server.md)。下文保留此前更大 TCP 平台路线和历史检查点，不表示这些扩展已完成。

## M0：本地流程切片（本次交付）

规范基线 → 带类型 IR → 参考执行 / 有界检查 → 测试与合成轨迹产物。四个主动打开场景可重复运行，存在规则追溯、覆盖缺口报告、故障注入测试和反例重放。此阶段不代表完整外部闭环。

## M1：补齐首条可信闭环

v0.2 已完成：独立 Z3 符号后端、真实 32 位序列空间、反例与参考重放、经典 PCAP 解析/归一化、统一证据门槛和过期证据拒绝。Ivy 尚未接入；已有后端不构成无界证明。

仍需完成：

1. 在准备好的 Linux 环境执行 `syn-loss`，保存真实 PCAP，以当前归一化器处理并通过该场景的 `assess` 门槛。
2. 验证 packetdrill 版本与脚本兼容性，将运行、单点采集、环境配置和证据上传接入 CI。
3. 根据需要依据 `formal/README.md` 增加 Ivy 后端，或引入归纳/精化证明，扩大形式保证。

统一证据清单必须拒绝过期的模型、脚本或观测哈希。只有这些环节均有真实证据，才把该场景标记为闭环通过。先固定一种环境，随后加入 CI。

## M2：扩展 TCP Connection

v0.3 已增加独立的 11 状态连接控制模型：97 条声明规则与 101 个场景，覆盖非法 ACK、被动/同时打开、代表性 FIN/RST 路径、用户超时和 TIME-WAIT。全部声明规则的场景覆盖不意味着完整 TCP 规范覆盖。窗口外报文、challenge ACK、握手未完成时 CLOSE、多连接监听器和该模型的 packetdrill 适配仍待完成。

另外接入固定 lwIP 上游 C 代码，在内存接口执行两个主动连接场景。普通握手投影匹配；首个 SYN 丢失场景连接成功，但与固定 1s 模型存在时序差异，保留观察与差异。Linux 通道仍未运行。每次新增行为都必须携带规范来源、范围假设、正反场景和实现观测。

针对重复、乱序、丢包加入独立环境模型和可控对端，明确无响应、允许静默和模型未定义三者的区别。根据实现和规范允许的选择升级 oracle，避免强制唯一逐包结果。

## M3：数据传输与语义扩展

加入发送/接收窗口、缓冲区、完整序列号比较、RTO/RTT、delayed ACK，再按依赖扩展拥塞控制。实际需要层级结构或并发区域时才引入 HSM，并更新版本和后端语义契约。

2026-10-24 已完成数据基础与首个有限切片：IR 0.2 字节串/序列空间运算，声明式复用连接模型，16 字节队列、MSS 分段、累计/部分 ACK、非收缩窗口、前缀重传和接收裁剪。15 个数据场景、继承的 101 个控制场景回归与三个故障变体已有测试。见 `docs/tcp-data.md`。数据场景的固定输入符号重放可匹配；深度 6 全输入安全性与重叠查询为 unknown，未宣称形式通过。

M3 仍未完成。下一步先改善混合序列/字节查询的可判定子集或精确有限编码（不得删减性质冒充证明），加入乱序重组队列与一般 piggyback ACK/window 组合，再扩大 close/FIN 数据场景。随后接入独立实现的数据执行证据，逐步推进 RTT/RTO、delayed ACK、persist 和拥塞/恢复。Linux 通道在隔离测试环境可用后单独闭环。

形式通道新增进展：对当前长度/标量性质建立精确长度投影及完整 32 位模整数归纳义务。补齐并验证 SYN-SENT 的 ISS 派生关系后，初值、117 个逐规则保持性义务和 14 个 guard 组均通过；原全输入 BMC unknown 仍保留。该路径拒绝字节内容比较，不能代替后续字节完整性性质、乱序重组或实现验证。接下来继续推进乱序接收，扩展时同步更新原始 Seq 后端及所需归纳支持。

乱序接收已新增 `tcp-reassembly` 有限 profile，声明式继承连接/发送模型，包含 16 位置共享容量的显式队列、多个缺口、重复/冲突重叠策略、右边缘裁剪、回绕及清理。复用 15 个数据场景并新增 11 个队列场景，原数据 profile 保留独立回归；该扩展自己的 113 条规则、13 个 guard 组归纳义务通过。下一步推进一般 piggyback ACK/window 与接收队列组合、带未确认数据关闭及独立实现数据证据，再扩大恢复算法；完整 M3 仍未完成。

## M4：验证可迁移性

先选择一个简单且结构不同的协议，例如 UDP 之上的请求/响应与重试协议，验证通用核心无需新增协议条件分支。协议适配器负责 wire encoding、真实输入归一化和工具映射。之后再接 QUIC、BLE、Thread 或 802.11，按其需求扩展 IR，不承诺它们只需增加 YAML 即可完成。

## 2026-10-25：当前实施顺序与证明流程

ACK/window 与 payload 已在 tcp-segments 有限 profile 中组合：接收序列校验先于 ACK、窗口 freshness、部分 ACK 定时器、窗口收缩及有在途数据零窗口探测。40 个固定输入和逐规则状态归纳分别验收；原 BMC 不确定结论保留。下一步先扩展未确认数据关闭、FIN 与数据重组的序列空间组合，再 RTT/RTO、delayed ACK、完整 persist、拥塞与恢复，并补齐独立实现数据证据。旧 profile 保持回归，不以新 profile 覆盖旧证据。

借鉴 Anthropic/Theorem 的可检查证明流程（见 research/2026-10-25-anthropic-formal-verification.md），保持 IR 与 Z3；新增命题/假设/检查器/产物绑定，随后增量试点 Rocq 的通用 IR 语义引理，再验证解释、翻译及实现对应。未安装检查器或未完成检查时必须标为 not_run，不能以证明文本替代检查。字节内容、输出顺序与时序契约逐步增强；长度归纳和场景匹配不足以证明这些通用性质。

TCP 后按 UDP、IPv4、ICMP、ARP、IPv6/NDP、socket 和跨层组合推进，分别明确规范、范围和验收。M4 的其他协议示例不取代这一实施顺序。

Rocq 首个原语试点已实际通过锁定容器的编译、空公理审计和 proof object 复查（六个切片/拼接/模加法命题，含两个负控制）。当前只是通用值语义数学引理；接下来需要验证其与实际 IR AST 解释/翻译的对应，并扩大到字节内容和输出/时序契约。该结果不提升 TCP profile 的 BMC 状态，也不计作 Linux TCP 实机证据。

## 2026-10-25：数据与关闭的有限组合

新增 tcp-close profile，把待发送/在途字节与 FIN 控制序列号分开计数，保持一个重传定时器。支持未排空关闭、FIN 前分段、部分 ACK/数据与 FIN 分别重传、被动/同时关闭、FIN-WAIT 重组、未读字节保留、零窗口延后 FIN 和清理。范围文档见 tcp-close.md。FIN-only 的队列缓存、FIN 携带 payload、FIN 头部窗口更新及完整重置处理仍须继续补齐，再进入 RTT/RTO、delayed ACK、完整 persist、拥塞与恢复。有限 profile 仍不代表整个 M3 完成。

当前 close 的 173 条状态保持与 31 guard 组通过，61 输入完整字节重放匹配；原始 depth=6 BMC unknown 保留。独立 Z3 进程复查全部导出义务也通过。逐规则保持采用等价固定 choice/新 Solver，历史共享求解 unknown 保存在 diagnostics，未削减不变量或规则；字节内容、输出、时序的通用正确性及实现对应仍须后续证明。

## 2026-10-25：显式 FIN header、重组 EOF 与动作后状态

新增 tcp-fin profile，把 canonical FIN 的窗口/payload 显式纳入 IR，独立 EOF 标记与有界相对游标绑定全序列位置，支持缺口补齐后一次性消费 FIN 和累计 ACK。first accepted FIN/重叠策略明确为模型选择；legacy FIN 仍仅作有限兼容。IR 版本化 post-target-v2 增加条件输出和动作后目标，不使用 Python TCP 回调。场景 0.2 的 typed expect_trace 检查每步全部新消息与时间，含自动定时器；完整字节固定输入查询仅对已固定输入/选择等价常量化。状态归纳穷尽规则所有声明目标，缺失目标拒绝验收。

该阶段不代表 TCP 完成。继续恢复算法（RTT/RTO/Karn、delayed ACK、无在途数据 persist、拥塞/恢复）、一般打开/重置/选项及独立实现数据/关闭闭环；随后继续用户给定的 UDP、IPv4、ICMP、ARP、IPv6/NDP、socket 与跨层组合。通用内容/输出/时间契约、解释/翻译/实现精化仍需扩大，Rocq 仅证明已声明原语。

## 2026-10-26 精确 RTT/RTO/Karn 实施

IR 0.3 增加规范有理值、精确常系数运算、ceil 和显式事件时钟，同时扩展参考和独立 Z3 后端。tcp-rto 声明式继承 tcp-fin，组合 SYN/数据/FIN 单样本、累计／部分 ACK、重传歧义、EWMA、RTO 取整／退避及 SYN 丢失后初始化。范围与未完成的通用发送历史时序见 tcp-rto.md；该 profile 不代表整个恢复阶段完成。

首次归纳发现打开时估计器初始化遗漏，已显式补齐，原反例及查询保留。修复后的单独归纳得到 176 规则／121 不变量、201 个目标保持子检查通过；完整当前输入的 suite、回归和 Rocq 新源绑定仍须本次验收后记录。下一步补齐原始分段／字节发送时间和一般不得过早重传契约，再 delayed ACK、无在途 persist、拥塞／恢复和独立数据实现证据，继而后续协议。

## 2026-10-26：发送历史开发切片

新增 tcp-tx-history 开发 overlay：逐在途字节及 FIN 记录发送时刻，ACK 移动时间槽，超时仅选择已等待当前 RTO 的最旧连续前缀，保留实际未重传字节的时刻，并按实际裁剪长度更新 Karn。已修正 1021ms 误重传刚在 1000ms 发出字节的可达反例；旧模型与反例保留。14 项新测试含继承场景、四个完整字节符号重放、部分 ACK、非单调时间槽、FIN、回绕及故障检测通过。

两个 FIN-WAIT-1 规则按重复／新／其他 ACK 作互斥穷尽划分，保持原动作和输入域，得到 180 条规则／143 个状态不变量／217 个目标检查。标准归纳仍有 2 unknown；独立精确布尔分组辅助检查器对两者的完整 31 组及等价义务复查通过。原报告未提升，开发模型暂未注册正式 suite profile。下一步把完整分组覆盖、原命题及非空见证接入标准命题／验收流程，注册并重建新 profile，继续 SYN 时序及一般输出／实现对应，再 delayed ACK、无在途 persist、拥塞／恢复和后续协议。详见 tcp-tx-history.md、query-partition.md。

## 2026-10-26：统一精化验收集成

新增 protocol_lab.refinement 和 CLI，将精确分组作为只读主归纳之上的补充证据；完整目标／来源／约束／初值／非空样本和独立复查都是验收条件。claims 同时显示原 unknown 与补充命题，辅助超时不提升。已注册第九个 tcp-tx-history profile；所有内容不敏感归纳 profile 可选启用同一补充机制。14 项集成故障测试通过，当前输入的完整回归及九 profile 重建正在进行。下一步完成本轮验收，再继续 SYN 超时历史及数据恢复、delayed ACK、无在途 persist、拥塞／恢复与独立数据实现证据，继而用户约定的后续协议；完整目标仍未完成。

2026-10-27：九 profile 统一重建／完整性验收完成，RTO 原 unknown 与补充通过分开呈现，发送历史补充尚有 unknown。253 个当前方法分批通过。SYN 发送历史开发 overlay 已修正同时打开回复后的旧截止点并通过 11 项测试，形式仍 pending，尚未注册。新发现无事件 tick 可使旧 RTT/Karn 时钟不变量为假，且当前参考／形式未覆盖该纯时钟路径；优先修复采样时刻和纯时钟推进的双后端契约，不以现有 per-rule 子集结论排除该问题。随后继续恢复、独立数据实现及后续协议，不改变完整目标范围。


2026-10-27：纯时钟修复已进入代码：显式采样时刻、空 tick 检查／回滚、独立 Z3 时钟步和保持义务，以及不能绕过的 claims／精化门槛。针对性测试通过，完整回归／九 profile／新 Rocq 绑定正在准备，尚不提升验收状态。之后继续 SYN 正式验收、恢复机制、独立实现数据闭环及后续协议。


2026-10-27：当前 SYN 开发模型的三个 unknown 目标已用完整单项分组逐个独立验收（166／166／167 项，共 499 组），完整字节非空样本及搬迁后的 CLI verify 通过，原主归纳 unknown 保留。新证据见 diagnostics/syn-singleton-refinement-e6880f3；尚需统一 profile/配置接入及场景验收，不提前提升为完整 TCP 或输出／时序证明。当前九 profile 重建与全量回归仍沿冻结输入执行。


2026-10-27：纯时钟修复已完成 268 方法完整回归及九 profile 的重新生成／完整性验收，所有旧 unknown 如实保留。继续开发继承 SYN 历史的 delayed ACK overlay，保持父模型和已验收输入冻结；新开发模型须独立固定输入／故障验证及形式检查，再接入统一 profiles，不冒充当前九 profile 的覆盖。


2026-10-27：delayed ACK 开发 overlay 及 15 项测试已落地，183 规则／154 不变量，首段固定期限、第二完整段／2×RMSS、piggyback／窗口／FIN 取消及立即 gap ACK 策略均为显式 IR。7 个新输入完整字节重放通过；当前开发证据生成和未知目标处理仍需完成，尚未注册 suite。下一步统一接入 SYN／delayed ACK 并继续无在途 persist、拥塞恢复和独立数据实现，之后后续协议。


2026-10-27：delayed ACK 开发证据的 7 场景完整字节／合成 codec 通过，主 BMC／归纳 unknown 保留。默认分组后续复查超时已存档，独立单项分组完整验收通过，两者分开绑定。当前发送历史剩余未知目标的 163 单项补充也通过。接下来显式接入分组配置及 SYN／delayed ACK 统一 profile，不能重绑旧证据或把通用输出／时序缺口抹去。


2026-10-27：SYN／delayed ACK 已声明为第 10／11 profile，并接入显式分组配置及 claims 一致性门槛；正在执行针对性检查，接下来冻结输入重建全部 11 profile 和完整回归。delayed ACK 23 输入不等于所有受影响接收场景已迁移；继续补齐协议恢复、通用时间／输出契约和独立实现，完整目标保持未完成。

2026-10-27：11 profile 初次集成因原主动打开 PCAP 原点假设失败，已新增独立选择的连接投影并通过 7 新／28 原测试。旧输入快照作废并保留失败日志，须对修复后的实际源码完整重建与回归，不能宣布原 290 项通过。persist 开发并行推进，仍独立验收。

2026-10-27：无在途起始 persist 开发原型及 14 项测试落地；形式化尝试找出并修复 pending-FIN 关闭状态遗漏，当前主 unknown／单项补充通过分开记录。后续完成开发 pipeline、窗口／FIN 和资源策略边界及独立实现；完整协议与其后模块未完成。统一 11 profile 的旧打开投影错误另行修复后重建，不将两条验收混为一谈。

2026-10-27：打开投影修复后的 311 方法一次完整回归通过，11 profile 全量重建与独立 suite-verify 完成，258 项 profile／293 项完整测试冻结输入集合及哈希完全一致。旧失败与当前通过分开归档；主 unknown 不改写，完整 TCP／Linux／解释翻译对应仍未完成。继续独立实现数据闭环、persist 边界和拥塞恢复，再推进后续协议。

2026-10-27：首个独立 lwIP 数据闭环落地，4字节单段／完整 ACK 的实际 netif PCAP 在0ms容差下与IR匹配，9项独立 port 正反／故障方法及重建后证据验收通过。没有修改上游 lwIP，也未计作Linux或一般数据／实现精化证明。后续扩大分段、部分 ACK/window、接收重组和关闭／恢复实测，并完善 persist／拥塞恢复；其后协议顺序不变。

2026-10-27：事件驱动独立lwIP发送／ACK/window通道完成12项独立port方法及6场景执行／验收，5个严格匹配、1个保留有效分段策略差异。初始窗口4触发上游min(MSS,最大已见窗口/2)的2字节分段，与IR确定4字节选择分叉；不放宽oracle或修改上游。旧311方法输入集合／哈希未变，旧四字节通道复查通过。后续扩大接收重组、关闭和恢复的独立映射，完善persist及拥塞／恢复IR；一般合法输出策略的符合关系、通用内容／时序与实现精化和后续协议仍未完成。

2026-10-27：独立lwIP通道扩展至接收重组、字节／EOF时序及主动关闭，17项独立port方法和13场景全量重建／验收完成；6严格匹配、7保留有效网络差异。7个新接收／EOF输入均有非空匹配观测；同刻gap ACK缺失和FIN通告窗口小1分别保留分析，不自动判定RFC违规。新增固定查询等价的精确共享前提提取，保留原10s超时并独立复查。旧311输入及单段证据不变／复查通过。继续persist边界、拥塞与恢复IR、独立丢包／定时器恢复及一般允许输出对应，再推进后续协议；完整目标未完成。

2026-10-28：PR#1已合入main，本阶段从相同树基线建立codex/tcp-congestion。新增未注册拥塞overlay，组合预算gate、SS／累计字节CA及逐字节首次／重复RTO阈值。14方法（含101控制输入）及6固定字节／合成codec验收通过；主BMC／三个归纳目标unknown保留，692组补充及独立复查通过。声明状态不变量不代表通用内容／时序、每RTT限度或完整拥塞／实现证明。旧11profile输入未变。继续快速重传／恢复、空闲重启和独立恢复组合，再推进UDP等后续协议。

2026-10-28：有限classic Reno快速重传／恢复overlay落地，19方法与15固定输入重建／独立验收通过；三个可达原型缺陷及两个SAT性质见证促成更强入口输出／接受阶段不变量。主BMC及6归纳目标unknown保留，1460组／1466含等价检查和独立复查通过。父模型、旧注册输入与实现差异未改。尚无limited transmit、空闲重启、每dup自动新发、NewReno/SACK或独立恢复实现／Linux／完整TCP证明。继续这些恢复及实现对应工作；当前提交的完整回归将用冻结提交／依赖与测试集合运行，不把在途任务计通过。

2026-10-28：91e36724已推送至draft PR#2；344项标准发现回归在该提交冻结依赖上运行，尚未计通过。另建ports/lwip-recovery独立通道，不改变在途回归输入。四个真实lwIP输入完整重建／独立验收、导出查询新进程SAT和两个专项方法通过；两个匹配、两个保留有效差异。未预处理握手后上游在第四dup33ms重传，模型第三dup32ms；数据前先给无在途ACK时两侧32ms。保留原输入／包／时刻，不推定内部拥塞状态一致。继续实际丢包／定时器恢复、limited transmit、空闲重启与一般允许输出对应，后续协议范围不缩减。

2026-10-28：91e36724冻结提交的344项完整发现回归已完成，一次3108.338s全部通过，无错误／失败／跳过，1091项依赖与工具环境未变；原始开始／结果、测试ID、依赖SHA与日志归档artifacts/full-regression-91e36724。此前running条目为历史记录。本结果不包含后续独立lwIP端的两个方法，不提升主形式unknown或完整协议声明。

2026-10-28：tcp-idle-restart开发overlay已实现实际数据发送时钟与当前RTO严格边界、RW缩窗和CA信用清零，193规则／190不变量。10+3方法、3固定字节场景及1749分组／1756检查独立验收通过，主BMC及7个归纳目标unknown保留。旧协议／执行／形式源码未变，仅完整回归工具新增--profile以冻结未注册模型的规范输入；后续新提交启动357项组合回归，不提前计通过。继续limited transmit、独立定时器／空闲实现验证和一般输出对应，再推进后续协议。

2026-10-28：Limited Transmit开发overlay完成13方法、4固定字节场景、2085组／2093检查及独立复查，主BMC和8归纳目标unknown保留。新增byte/packet/duplicate关系排除原任意不变量前态SAT，不将其称可达协议bug；隔离旧源码已重现。独立lwIP三输入及2专项方法通过，2匹配、1突发时刻差异保留，不推定内部LT/cwnd一致。357项回归仍绑定cb163fe7在途，1108冻结输入未改；未声称新增后370项全量通过。继续独立数据RTO／丢包／空闲计时、自动恢复新发及一般允许输出关系，后续协议范围保持。

2026-10-29：cb163fe7冻结提交的357项完整发现回归一次3470.718s全部通过，无错误／失败／跳过，1108冻结依赖和工具环境未变；原始结果／输入／测试ID／日志归档artifacts/full-regression-cb163fe7。先前running条目为历史，不将后续13项LT或独立port测试冒计入本次，主unknown与协议／Linux缺口保持。

2026-10-29：PR#2已合入main的ade065bb，本轮转codex/tcp-timers并带入357项回归归档。新增独立数据计时C通道（1ms推进、上限12s），10方法／5真实捕获与新进程字节查询／独立验收通过，5严格差异保留；粗细TICK的非空重传捕获相同。原SYN2750ms不改，数据2750/8750ms与IR1021/3021/7021ms分别记录，partial ACK整段／后缀和idle初窗策略差异不直接判RFC违规。370项主回归在2d296f89冻结运行，源码依赖1125未变，port10方法分开验收。继续一般允许输出／计时对应、自动恢复新发及用户后续协议，目标未完成。

2026-10-29：tcp-segment-choice开发overlay添加8个显式count选择规则，共201规则／195不变量；仅在正MSS／队列／rwnd／cwnd预算内定义，保留原canonical选择。8方法500.431s、3字节契约及1342组／1347检查独立验收完成，8新规则的已声明状态保持性unsat，5个旧接收／ACK主目标unknown保留。独立旧捕获21ms前缀的2+2见证及3负例通过，完整旧Difference不变；尚无完整应用调用对齐、一般允许输出、Nagle/SWS或计时策略对应。370回归继续绑定2d296f89且1125输入未变，8新方法不计其中。继续字节内容／事件对应和恢复机制，再推进完整后续协议范围。
2026-10-29：2d296f89冻结的370项标准发现回归全部通过，1125项依赖／环境未变，runner3618.822秒，证据归档artifacts/full-regression-2d296f89。后续新模型和端口方法单独验收；历史running描述不再代表当前进程状态。仍需完成发送调度完整输入／线端／服务观察对应、形式unknown及用户原定后续协议。


2026-10-29：tcp-output-schedule有限发送机会与IR服务记账完成201规则／200不变量、12方法495.456秒、22组父模型刺激对应、2固定字节契约和845组／848检查独立验收；主BMC／归纳unknown保留。旧真实lwIP完整7输入／9包及写8确认4有严格存在性见证，原canonical终态和旧Difference继续mismatch，未计新实现执行／Linux／通用精化。兼容性测试发现并修复flush+choice重复idle记账，历史源码／失败／隔离重现归档，不排除共享idle字段。370旧回归已通过，新增后390项需按新提交另跑；继续一般允许输出／服务／时序、恢复对应，再推进后续协议，完整目标未完成。

2026-10-29：a7866f0b冻结提交的390项完整发现回归一次4257.189秒全部通过（runner4257.370秒），无失败／错误／跳过，1155项依赖及环境未变。证据归档artifacts/full-regression-a7866f0b，历史running条目不再代表当前状态；新sent-ledger及独立端口方法另行验收，不提升主unknown或完整TCP／Linux声明。

2026-10-30：发送确认账本201规则／220不变量、9固定字节场景、11模型方法与10独立lwIP端口方法完成有限验收。8真实执行的原始4线端差异与3服务差异保留；2替代完整见证匹配，另1自动LT／短段时刻差异继续开放。预算单性质240条件查询及498断言对应检查通过，不替代整体归纳62目标unknown。Rocq5抽象命题待CI，409项新增后全量回归待冻结运行。下一步收敛Nagle／短段与自动LT组合，完善一般ACK／window／关闭／恢复及服务时序关系，再按原顺序推进后续协议；Linux通道仍单独受环境限制，目标未完成。

2026-10-30：eaeb02ff的[Rocq CI](https://github.com/briliant-ben/TCPIP-Model/actions/runs/40926132635)完成成功。新增5个发送信用抽象整数命题已编译、空公理审计及独立kernel重查，错误证明／公理注入拒绝；ZIP、证明对象、来源与日志SHA绑定在artifacts/rocq-ledger-ci-eaeb02ff，独立本地绑定验收及损坏对象负例通过。此前local not_run和CI pending记录保留为历史；本地未重跑kernel，也未证明IR动作／解释器／翻译器／TCP／lwIP对应。409项冻结回归仍在运行，完整目标未完成。

2026-10-30：基本Nagle/LT组合203规则／222不变量、8专项149.494秒、242条件查询及独立同输入完整抓包／回调见证验收完成；原Difference未改，未计新C或Linux。2420断言对应只支持单性质条件证明，父basis闭包／全模型／一般实现关系未证明；sender SWS与lwIP多节点等变体仍开放。新增8方法不计在途409冻结回归，下一次发现为417项但未跑全量。接续SWS／发送队列策略与服务时间精化，保留原后续协议范围，目标未完成。

2026-10-30：eaeb02ff冻结提交的409项完整发现回归一次5043.817秒全部通过（runner5044.056秒），无失败／错误／跳过，1208项依赖及环境未变。证据归档artifacts/full-regression-eaeb02ff；此前running记录是历史。后续Nagle8项和SWS开发不属于本次409集合，不能追加推算全量通过；主unknown、Linux与完整协议缺口保持，目标未完成。

2026-10-30：sender SWS有限策略209规则／223不变量，13方法232.550秒、6全字节／时间契约及独立合成codec验收；248条件状态查询与1863断言对应独立通过，depth6整体unknown仍保留。3新lwIP执行／4端口方法269.069秒验收，完整MSS匹配，两个短写21ms实际／221ms模型差异保留，3公共回调匹配。window17可达旧上界错误已隔离复现，仅invariant上界修正65535；guards／actions及旧oracle不动。定时器只给显式发送机会，mandatory/fair输出、receiver SWS、wire PSH、动态MSS／窗口和一般精化仍开放。409旧回归已通过，当前430项待新冻结运行，目标未完成。

2026-10-30：Linux临时VM已获得首个真实内核三包握手抓包并独立runtime验收，两个微小时差在0ms Difference中保留，非完整场景5010ms静默或完整TCP证明；继续补足静默窗口。原ledger精确细化终态3目标独立闭合、59仍unknown，所有查询打包留存。430回归仍绑定4db896eb／1244依赖未改，完整目标未完成。

2026-10-30：Linux完整主动打开／5010ms静默期已在真实CI内核验收（实际5010.89946ms、3包、0捕获丢包），两个0ms时间Difference保留。源码1551c535、CI41004399031与原始证据见artifacts/linux-netns-ci-1551c535；离线4个重哈希故障拒绝。仅此有限内核场景，后续数据／窗口／恢复及其他协议仍待推进；430冻结回归与单目标精确细化仍运行，完整目标未完成。

2026-10-30：Linux通道扩展为handshake／syn-loss两个白名单场景，CI各用独立VM。旧model/tcp.json、两个场景、所有原协议算子及oracle未改；loss实验保留两个出口SYN，只对首次SYN不注入响应，非物理网络丢包。按原IR1000ms重传／1010ms响应生成全部预期，syn-loss声明6010ms完整窗口；scenario身份／loss机制／settle逐项绑定验收。7项本地准备／拒绝测试通过，两个固定查询独立解析SAT，证据artifacts/linux-two-case-preparation；这些不是Linux运行证据，新CI待运行。准备测试误用Machine.variables的原始失败归档后改为现有values字段，协议不变。旧1551c535证据仅在其命名源码检查点复查，新源码哈希不被放宽。430回归／精确单目标继续运行，原2750ms差异与完整目标缺口保持。

2026-10-30：S-ACK-VALID→ESTABLISHED的group-size1精确细化已终止unknown：368组中298个producer UNSAT、70个UNKNOWN，逐查询10s不变、原其他断言全部保留，等价查询UNSAT。370成员／6698504字节归档artifacts/sent-ledger-single-target-unknown，逐成员与原源码／checker SHA核对；未对全部组独立重跑，未闭合新目标，原62目标主unknown及group8的3闭合／59unknown均不改。原未提交目录保留。下一步需改善字节／计数／赋值编码，而非增加重复切分或把超时称为证明。Linux双场景CI41005706790正在运行；430冻结回归继续。

2026-10-30：Linux两个真实CI场景（普通握手／首次SYN不获响应）已runtime及独立离线验收，10重哈希负例拒绝。重传1061.092ms对模型1000ms、两个严格握手时刻差异保留；packetdrill有效max(50ms,间隔12.5%)与0ms独立oracle明确区分。完整PCAP／工具原源码／配置解释见artifacts/linux-netns-ci-de084a26；数据／窗口／恢复仍待Linux验证，430冻结回归继续，完整目标未完成。

2026-10-30：4db896eb冻结的430项标准发现回归已全部通过，unittest5163.255秒／runner5163.586秒，无失败／错误／跳过，1244依赖及环境未变。原始结果、依赖／测试ID清单及完整日志归档artifacts/full-regression-4db896eb。包含Nagle与SWS新方法，但不含随后新增Linux端口7方法；历史running描述不再代表当前状态。此结果不提升整体形式unknown或完整协议声明，目标未完成。

2026-10-30：Linux接收首个4零字节场景准备完成（12方法／参考全字节SMT及独立SAT），现有组合IR未变。全部ACK由独立抓包及含窗口／payload／时间的严格oracle验证；受固定工具payload语法限制，其他字节模式明确拒绝。实际CI待执行，尚不计Linux数据证据。一般发送、乱序、窗口／恢复仍待推进。

2026-10-30：精确SMT策略重查工具4方法／原partition6方法通过；完整368组复查仍298独立UNSAT＋70UNKNOWN（另等价UNSAT），没有新增目标闭合，证据已压缩绑定。跨进程未复现的Python结果不晋级。下一步改善模算术／条件账本精确编码；430全量已通过，新4工具方法单独验收，完整目标未完成。

2026-10-30：首个Linux真实接收数据场景已验收（单段4零字节，5包、5020.014606ms、无捕获丢包），完整字节／累计ACK匹配；早ACK与窗口7字段Difference原样保留。两控制回归及三个离线复查／5重哈希负例通过，原始证据artifacts/linux-receive-ci-2ab2a472。仍不覆盖任意字节、读服务、发送、PSH、乱序、窗口／恢复一般性，继续精确模算术／账本编码及这些独立实现验证，完整目标未完成。

2026-10-30：精确模算术证书与2条声明式标量IR定律完成有限验收（3等式／36断言／8边界／2故障），modular归纳通过、BV主检查UNKNOWN保留。31专项通过；一个原ACK分支在零模重写的等价导出上两次CLI UNSAT，69原未知分支未闭合，完整目标仍未知。接续条件SSA／环形账本精确编码与受限IR→可检查语义桥；442完整组合待冻结运行，旧258输入未变，完整协议目标未完成。

2026-10-30：PR#3已合入main的ab9f75ba605bd8b7fd766cc5e75e160dabd4c80e；本轮后续工作转codex/tcp-modular并合并该main（源码无差异）。新442项标准回归已在71a3e1a8冻结运行，1260项依赖当前未变，原始进程仍在运行；不重启、不冒称全量通过。新模运算／标量契约里程碑将独立提交新草稿PR，旧未提交refinement目录保持。完整目标未完成。

2026-10-30：新增formal/rocq-scalar受限执行语义试点。仅接纳单状态／单application事件、无条件自环、int/seq32有序set及eq不变量，定时器／消息／条件／其他类型和额外语义字段显式拒绝。源IR的7条赋值、2个性质、初值和seq32事件域生成Compiled.v数据构造子；另一个逆向解析器逐项恢复原JSON AST与顺序，拒绝漏域／改索引／隐藏定义。Semantics.v定义该片段的求值／有序状态更新，Proofs.v的命题直接量化执行生成程序而不是独立手写方程。Python类型／片段验证及结构绑定检查器仍可信，未声称JSON编译器、Python／Z3或TCP普遍正确性。

7项本地结构／故障方法通过；本机无rocq，生成及源绑定完成但kernel状态not_run，证据artifacts/rocq-scalar-local-preparation。不用此准备称kernel通过。新增digest固定Rocq9.2.0 CI，待实际编译／空公理审计／独立check及两个源IR变体（错误逆位移、错误赋值顺序）新工作目录证明拒绝。新7方法不属于正在运行的442标准发现；其1260冻结依赖未变，完整目标未完成。

2026-10-30：受限单状态标量IR生成程序的初态／执行定理已在固定Rocq9.2.0实际compile／空公理／kernel检查通过，7有序赋值及2性质逐源绑定；6重哈希／完整性故障拒绝，38专项通过。Python结构桥仍可信，未证通用解释／翻译、TCP字节／时序／网络。两次原失败完整保留，模型／命题／域／上限未改；442冻结回归继续（新7方法不含），完整449未跑。继续实际TCP条件SSA／环形精确语义及完整原roadmap，目标未完成。

2026-10-30：条件SSA精确查询工具完成有限验收（原444断言／每query完整4分支／无协议前提覆盖／局部XOR／独立CLI）。ACK092和280分别2／3叶UNSAT，但各仍有UNKNOWN，未关闭任何新原分支或父基。45专项通过，原442冻结运行不重启；新456全量未跑。后续重点是这3个真实未决叶／环形账本的一般ACK精确语义，不将更多切分或局部数学工具算作完整TCP。见formal/conditional-ssa.md及artifacts/ack-conditional-ssa。

2026-10-30：无协议前提且保留无界fallback的模展开，已精确关闭一个原ACK违例092（4条件分支及直接query均独立UNSAT）；加原052后仍68原未决分支，不称完整ACK／父基闭合。51专项通过，462全量未跑、原442冻结回归继续。当前重点继续原未决账本／ACK的一般精确语义，保留所有旧unknown、字节／时序／实现缺口。见formal/modular-piecewise.md和artifacts/ack-piecewise-092。

2026-10-30：71a3e1a8冻结的442项标准回归已终态全部通过，unittest5269.704秒／runner5270.056719秒，0失败／错误／跳过，1260依赖与环境未变；原进程exit0，不再是running。原始started／输入／ID／终态／完整日志及独立核对见artifacts/full-regression-71a3e1a8。后续20新方法不在此集合，其51专项另计；当前462完整组合尚未跑。旧历史running记录保留但以此终态为准，不提升协议或形式unknown声明，完整目标未完成。

2026-10-30：通用source有限域完整覆盖／局部XOR工具完成，原账本数量280通过完整16头索引复查；head15 default unknown保留，以独立局部等价＋叶的两张精确证据闭合，不接受只证明叶的组合。56专项通过、467全量未跑；原442冻结回归已通过。当前仍需其余原ACK目标／父基／字节时序／IR-解释翻译与实现对应，不把局部闭合当完整协议。

2026-10-30：其余68原ACK未知的精确模展开批次已验收：48独立UNSAT＋20UNKNOWN，原context SAT，归档新目录复查通过。与298旧具名证据及052／092／有限域280按原source SHA去重，现349/368具名证据、19原分支未闭合，完整ACK目标／父基仍未证；不是规范覆盖率。入口artifacts/ack-piecewise-remaining68及coverage-index.json。下一步按19项真实清单推进精确账本／父基与字节时序对应，保持完整协议roadmap。

2026-10-30：通用可检查DAG复用把同前提已证结论作为严格cut，不允许metadata／core代替父证书。58依赖／当前IR-export锚点与原292／300完整重复验收，具名查询351/368、17仍未决；完整ACK与父基未闭合。67专项通过、478组合未跑，旧442已通过。下一步继续17账本缺口／父基，并增强全字节、有序输出、时序与实现对应；DAG query证明不替代IR语义kernel桥或完整协议。

2026-10-30：PR#4已合入main eebd27e5。本轮aaee733c保留并转codex/tcp-query-dag，合并main的13ff8c93与aaee源码完全相同，已新建并挂接草稿PR#5。Ubuntu新专项CI41079885224／job124145857544实际通过：67／67、10.319269秒、0失败／错误／跳过，1268源码输入与source head13ff8c93逐Git blob一致，checkout merge748b94ab；原ZIP／官方API来源／完整job及unit日志与离线验收见artifacts/query-verification-ci-13ff8c93。新Linux checker1bfaf5bb与Mac2f4cc814分别绑定，不放宽旧hash；CI只跑新证书单元测试，不计Linux TCP／PCAP／kernel证据。

478项标准发现已在独立临时检出/private/tmp/tcpip-full478-_2gsnde8、detached13ff8c93启动，冻结1281输入。原进程PID21869／统一exec session4411已确认运行，输出/tmp/tcpip-full-regression-13ff8c93.log及同名目录保存started／inputs／test IDs；未到终态，不称全量通过。不得编辑该检出或因观察超时重启；主仓库继续开发不影响此冻结集合。旧442通过仍独立有效，67本地／Linux专项均不替代478完整组合。完整目标继续，剩17原ACK项及父基／字节时序／实现与后续协议缺口不变。

2026-10-31：新增完整证书树／checker与solver epoch绑定的调用内证明缓存，6个正反方法随73专项通过；独立重检默认从空缓存开始，warm传递依赖环仍拒绝。历史证据保持命名epoch，不重写版本hash。15个头记录UNSAT仍仅探索候选，未独立验收，具名查询仍351/368、17未决；下一步以新版DAG重新bootstrap和验收，295／296 unknown及父基／全字节时序／实现缺口不变。旧478冻结回归继续独立运行。

2026-10-31：[ACK头记录证据链](../artifacts/ack-query-head-chain/README.md)在当前epoch重建依赖后，15个原始查询的两次native UNSAT、安全解包独立重检、366个IR/export来源绑定及3项故障拒绝全部通过。具名证据现366/368，该分区295／296仍未证，完整ACK／父基及全字节时序／实现仍开放。73专项本地与Ubuntu CI通过；旧478冻结回归单独运行，当前484完整组合未宣称通过。整体项目继续。

2026-10-31：独立13ff8c93冻结的478项标准回归已终态全部通过，unittest5348.520秒／runner5348.724803秒，0失败／错误／跳过，1281依赖及环境未变，原session4411实际exit0。原started／输入／478唯一ID／result／完整日志与独立验收存artifacts/full-regression-13ff8c93；1281输入还逐不可变Git blob及运行结束后的独立检出原字节核对通过，检出clean且保留。此前running叙述仅为历史，以此终态为准，不再轮询或重启原进程。该478是命名旧source集合；后续缓存／候选生成器方法与专项另计，不能推算为后续组合全通过。没有新增Linux TCP／PCAP、kernel或完整协议证明；原UNKNOWN及2750ms等Difference保留，完整目标继续。

2026-10-31：raw finite候选生成器用实际序列化后的表达式绑定局部XOR，既有检查器不变；4新正反／真实结构回归与77专项通过。295／296各32候选路线UNSAT仍待独立验收，具名索引保持366/368，不把未执行default或native候选标签当证明。478旧组合终态通过，当前488组合尚未跑；继续两项原查询、父基及全字节时序／实现对应和完整协议roadmap。

2026-10-31：原ACK分区最后295／296的完整16-case证书、源域覆盖、全部局部等价与叶、新目录安全解包复查、1260输入／IR-export锚点及4项真实故障拒绝通过，见artifacts/ack-prefix-bounds。具名证据现368/368；原始完整target的合并证明、全父基及字节／时间／实现仍另行待证，旧主UNKNOWN未改。77专项本地与实际Ubuntu CI通过；13ff8c93的478完整回归终态通过，当前488组合未完整跑。下一步做具名目标的完整组合验收，并继续其他模型义务及全字节时序／实现桥，完整协议平台目标仍有效。

2026-10-31：通用完整partition cover检查器及5正反方法完成，82专项通过；它按哈希引用既有包，安全解包后实际重放，要求全index和完整源前提一致，独立验证partition／断言保留／组合schema并报告vacuity。真实原ACK命名target的全368组合仍在重放，暂不称原query关闭；当前493完整组合未跑。继续完整目标验收、其他模型义务与全字节／时序／实现桥和完整协议范围。

2026-10-31：S-ACK-VALID→ESTABLISHED的原完整状态／长度保持query已通过fresh全368分支重放、无协议前提partition等价、原断言保留与Boolean组合、SAT非空上下文及IR/compiler输入前后锚点，见artifacts/ack-complete-cover。不同于此前仅组件索引，现闭合一个命名原target；其余模型／父基、全字节时序／实现及完整TCP仍未证。首次286旧tactic10s UNKNOWN及旧主报告保留；v2只引用同source的piecewise证书，旧包、模型、预算与oracle不动。84专项本地／Ubuntu、旧478冻结完整回归分别通过，当前495组合未完整跑，完整目标继续。

2026-10-31：当前495项标准回归已在独立临时Git检出/private/tmp/tcpip-full495-i8vc8l0_、detached aec3c95cc95a322011ea006fc8760a64663d4de3启动。源／环境快照已冻结1287输入，原PID40193／统一exec session91353已确认实际运行；输出/tmp/tcpip-full-regression-aec3c95c.log及同名目录保存started／inputs／495 IDs，指针/tmp/tcpip-full495-checkout.json。不得编辑该检出或因观察超时重启；主目录继续工作不影响这份源。当前未到终态，旧13ff8c93的478通过与f2acf9f9的84本地／Ubuntu专项分别独立有效，不推算新495通过。原478 session4411已exit0，不再运行；其检出clean保留。完整平台目标仍未完成。

2026-10-31：冻结 aec3c95c 的当前标准回归已终态通过495/495，5334.775秒，0失败／错误／跳过，输入及环境未改变。完整原始日志、result、495 IDs、1287输入清单及逐不可变Git blob验收见 artifacts/full-regression-aec3c95c；1287输入另与保留的隔离检出逐字节核对。原exec句柄已过期，不冒称恢复了进程exit code；终态报告与日志相符，无重启。这取代此前“495仍运行”的进度，旧478及84 Ubuntu专项仍为各自独立证据。命名ACK保持义务已闭合，但主报告UNKNOWN、其他义务、字节／时序／解释翻译及完整平台缺口保持，目标未完成。

2026-10-31：新增 model/bytes-contract.json 及 formal/rocq-bytes 生成字节IR执行试点，声明式四赋值拼接／总截断prefix／suffix／重构，性质为完整内容相等。类型分离的形式AST与逆向解析绑定全部源赋值及顺序、初值、事件域和性质，未知语义显式拒绝。7本地方法通过，覆盖非零字节、负数／越界偏移、两种真实源反例及重哈希结构故障；与旧scalar 7方法分开保留。当前本机无Rocq／Docker，artifacts/rocq-bytes-local-preparation明确not_run、kernel_checked_proof=false；固定9.2.0 CI将实际编译生成执行定理、空公理审计、独立kernel及错误count／顺序负例。尚不宣称内核通过、通用解释翻译对应、TCP／字节输出顺序／时间。495冻结回归不包含这7新方法，当前502完整组合未跑；旧源输入、ACK命题、UNKNOWN和Difference保持。

2026-10-31：字节IR生成执行试点41544085已实际CI41199833714／job124533279559内核验收通过，artifact13041509676官方ZIP SHA18dd1fa4及原始无损job日志、三模块源码／对象、12具名Git输入、两次空公理审计及独立kernel见 artifacts/rocq-bytes-ci-41544085。四条生成有序赋值／一完整内容等式对任意初态byte列表、任意输入和无界整数偏移成立；无payload长度界。错误suffix count／顺序源模型生成数据编译成功而执行定理失败，参考合法输入亦拒绝；6离线重哈希／完整性故障均拒绝、原件不变。只证明该受限IR契约执行，不是TCP、通用Python／Z3翻译、输出顺序／时序或实现证明；可信桥与范围明确。旧495冻结回归及新7方法分别通过，502组合未完整跑；完整平台目标继续。

2026-10-31：新增 tcp-byte-content 声明式观察overlay，在实际tcp-sws的14条规则上检查完整字节内容；擦除观察赋值恢复全部209条继承动作，额外逐实际emit／emit_if绑定payload及条件，防止过时ghost掩盖线端变化。涵盖队列／拒绝、8条ESTABLISHED与关闭态FIRST／MORE分段、两种重传和ACK。现有独立Seq(BV8)／BV32后端完整一步查询不假设前态不变量或后态性质，21项UNSAT、ACK BC-PARTITION 1项UNKNOWN，14规则及22适用上下文均SAT；独立重建全断言并新CLI复查得到同样结果。所有源／原始查询／双阶段日志、首轮及固定tactic UNKNOWN／序列化拒绝诊断保留artifacts/tcp-byte-content；复查accept.py --replay-out须新目录。7新方法50.567秒通过，原7字节／7标量另过，495冻结输入未变但509组合未完整跑。不是完整归纳、TCP／时序／解释翻译／实现或Linux证明，不改原ACK长度闭合、主UNKNOWN、上游lwIP、oracle及2750ms Difference。详见docs/tcp-byte-content.md；完整平台目标继续。

2026-10-31：用户已将目标调整为供应商／调用框架无关的可重复spec建模flow；完整TCP/IP及闭合所有证明不再是本阶段前提。新增protocol_lab.codegen直接C99标量后端与分离的generate/build/execute_compare JSON阶段；从现有IR显式生成guard／有序action／timer／emit／不变量，原生进程不读取JSON模型、不调用Python或现成协议栈。主动握手四基线场景实际编译执行并与参考全轨迹／状态／timer精确匹配，产物artifacts/spec-flow-c99；12原生正反测试及24旧flow测试通过。显式拒绝bytes／rational／clock-v3／post targets，int64及资源限额越界拒绝、整操作含定时器与输出原子回滚。尚未打通字节／IPv4线端、统一编排及第二份小规范迁移，不宣称完整flow；下一步按docs/spec-flow.md推进。已有模型、UNKNOWN、hash／oracle和2750ms差异不改。PR#6保留旧字节／证明里程碑，新flow代码将独立提交。

2026-10-31：新flow的C99后端0ee33d52已在实际Ubuntu CI41212382314／job124569888828通过12原生测试（3.103秒），GCC13.3.0另实际生成／编译／运行syn-loss，三条规则、报文字段、状态与timer精确匹配独立参考。原官方ZIP artifact13046537061 SHA96e5c854、原始无损job日志、C源码／编译／输入／观测及ELF哈希在artifacts/spec-flow-c99-ci-0ee33d52；10项运行源哈希及基于checkout来源的test／workflow两项均逐具名Git blob核对。只读验收不执行归档ELF、不冒称本机Linux重跑；官方ZIP保留原ELF证据，无独立本地编译二进制入库。Mac／Linux生成C字节一致，平台编译器和binary SHA分别绑定。仅标量代码生成服务器通道，不计TCP网络／PCAP、IPv4、字节、第二spec或完整flow验收；原UNKNOWN及差异保持。当前新分支codex/spec-flow-c99，草稿PR#7叠在尚未合并的PR#6上，合并前核对远端状态。

2026-10-31：新增protocol_lab.pipeline及flows/tcp-active-open.json，供应商／框架无关的十阶段任务入口已实际通过sources、IR、depth6 Z3、bounded test generation、reference、C generate/build、native execute、compare、traceability。6生成规则见证＋4种子＋2模型缺口拒绝合计12例精确匹配；36输入／115产物绑定和原116文件任务在artifacts/spec-flow-pipeline安全数据归档。候选IR及规范解释由调用方／建模agent提供，不假称自动或已证明English→IR。12流程正反／真实并发／进程组超时测试、12原生及24旧flow回归通过，编译器缺失仅阻塞相依通道；坏spec来源、冲突、后端int64范围、实现差异及UNKNOWN提升分别分类。所有步骤固定worker，无任务提供shell/Python回调；源码集合闭合检查、独占新目录、唯一run ID支持并发调用；只读verify非新执行／真实性证明。当前仍为event-level原型，无IPv4／PCAP、字节与第二spec验收，不标记目标complete。命令及调用方交接边界见docs/spec-flow.md。

2026-10-31：十阶段event原型987c0994已实际Ubuntu CI41216276646／job124581357915通过12流程方法及全任务／verify；artifact13048601703官方ZIP SHAbc78a22b、无损原job日志及验收在artifacts/spec-flow-pipeline-ci-987c0994。36原输入逐不可变Git blob匹配；独立数据解包后导出原Git校验器源码进行只读复核，不运行归档Python／ELF／solver且不放宽旧hash，支持后续工具版本演进。原任务为0.1种子，不能据此声称0.2 expect_trace已检查；复查发现新reference步骤未调用旧trace-contract门禁，后续检查点将修复并加入独立验收契约。IPv4／字节／第二spec及完整目标仍开放。


2026-11-01：修复十阶段reference遗漏scenario0.2 expect_trace门禁的问题，调用原run_scenario核对独立轨迹／最终状态；新增固定SYN、1000ms重传及ACK的独立契约，当前6生成＋5种子＋2IR拒绝共13例。task-v2固定spec、探索域和全部种子来源，外部调用方可用--task-sha256绑定验收任务；候选自产SHA不是外部审批或真实性证明。运行前冻结37项数据／可信工具输入，worker使用同一捕获版本，原工作区变化仍使验收失效。18专项实际通过，包括错误IR、同时篡改oracle、弱化任务、运行中修改候选及并发隔离；本地新任务十阶段通过，158产物只读核验一致、2项独立轨迹契约通过。旧987c0994证据按原Git校验器保留，不放宽hash。仍无IPv4／PCAP及第二份规范迁移验收；目标未完成。


2026-11-01：新增可选原生IPv4/TCP fixed-header适配，task-v3接入原十阶段flow；生成实现本身解码P命令IPv4字节、核对双校验和，通过IR guard/动作执行TCP，再产生真实C端IPv4字节。记录器仅封装原字节，不从参考输出合成egress；现有独立PCAP解码器核验，额外比较absolute seq/ACK/time/window防止归一化掩盖编码差异。一个任务保留13标量比较，并执行5完整wire种子；42输入和204产物核验一致。9 wire正反/故障测试通过，包括错误校验和、格式/四元组超范围、合法包错误ACK及生成器序列偏移；旧12原生、20流程和24旧flow分别实际通过。RFC791原文已从官方获取并固定SHA6cfb387f，格式依据§3.1及RFC9293§3.1。仅无payload/options/fragments的虚拟链路切片，无LinuxTCP/物理网络/完整IPv4行为；TCP状态与计时保持IR唯一权威。第二份规范迁移和服务器交接验收继续开放。此前task-v2 Ubuntu41220822030/job124594805326实际success，不能替代新wire版本CI。


2026-11-01：第二份官方规范迁移案例已落地：model/udp-header.json＋RFC768/RFC1122 §4.1.3.4，声明7规则、默认／可配置checksum、零source port、长度解释及静默discard；范围为header/service descriptor，明确假设sum_valid输入，不含payload字节／checksum算术／UDP wire。未修改任何protocol_lab通用工具；同十阶段在本地实际通过，7规则覆盖、12例和14独立契约步骤，depth6 safety/overlap UNSAT仅为有界IR检查。8迁移／客户端测试通过，包括错误默认checksum、header长度及错误discard响应的独立契约拒绝。新增examples/run_spec_candidate.py和docs/spec-flow-server.md，外部调用方传独立workspace／taskSHA／out，真实并发TCP-wire＋UDP候选从无关CWD运行、独立runID并核验；无供应商API/SDK或特定agent框架依赖。客户端保留自身／Python SHA、原始JSONL和verify。此前wire Ubuntu41221600238/job124597120710全部实际success；本次新UDP／交接Ubuntu验收待对应新CI终态，不以旧CI代替。目标尚未宣布完成。


2026-11-01：新双规范Ubuntu41222440458/job124599629037在d72b7f3d实际success；20流程＋9wire＋8迁移/客户端测试无skip，并实际运行/verify TCP事件、TCP-wire及UDP三任务。官方ZIP13050482735、946217字节、SHAfd69b4bc、原始无损日志及accept在artifacts/spec-flow-migration-ci-d72b7f3d；53输入/客户端逐不可变Git blob匹配，29通用工具源在三任务完全相同。独立安全解包后仅运行原Git只读校验器，三任务复核一致，不执行归档Python/ELF/solver、不放宽hash。逐目标验收见docs/spec-flow-acceptance.md；当前约定的可运行/可复现/可迁移flow原型门槛满足，完整TCP/IP、payload/UDP wire、通用编译器或无界证明仍不作结论。服务器/单多调用方交接见docs/spec-flow-server.md。


2026-11-01：按用户授权定位此前常用本地免密服务器，独立目录部署59源码/约276KB包，Python3.12.3/C99。首次58文件包遗漏旧事件任务，测试失败保留；修订包实际通过37专项及TCP事件/TCP-wire/UDP三个运行与verify。凭据仅服务器私有0600文件，不入Git/提示/日志。新增受限DeepSeek JSON网关（共享上限12、输出/字节限制、写前台账、完成去重、失败不自动付费重试），实际4请求30519token含失败；一次显式格式修正命中7808输入缓存token。首次model JSON失败原内容未保存，仅状态/usage，已修复后续原响应留存；独立critic也有计数错误，控制器先核对修订，不直接信任多agent输出。新IPv4输入头部IR经审查移除伪model-gap空操作、补字段域/坏IHL，修正四次discard计数；4规则/9例/7独立契约、depth6 safety/overlap UNSAT、本地与服务器原生执行通过。6部署/网关离线故障测试及5IPv4专项通过。696文件原服务器证据、模型建议、显式修订及脱敏用量见artifacts/server-deployment-20261101。完整IPv4+TCP/UDP+ARP/ICMP实现仍未完成；后续先原生字节语义和跨层组合，范围矩阵见docs/ipv4-endpoint-roadmap.md。


2026-11-01：新增direct-c99-bytes-v2，从IR显式生成字节状态／事件／输出、长度、拼接、offset/count切片、完整内容比较及条件值；tx_flags等字符串状态按源字面量封闭集合生成，保留NUL/Unicode完整身份。每值／中间值4096字节、signed64、输出容量等执行域显式拒绝，整操作含先行timer与输出原子回滚。14字节专项实际通过（含ASan/UBSan、非零内容、极端切片、timer/输出容量失败、同长度内容故障及false-return注入）；此前12标量、9wire、20流程、8迁移、5IPv4专项分别通过，非整仓完整回归。15现有TCPdata原生场景与独立固定输入Z3重放匹配，101连接原生回归通过；当前最终源码的Linux独立发布验证待完成。旧IR／参考／Z3后端未改，TCP depth6 UNKNOWN不提升。一次DeepSeek独立审查因1536输出限额截断，计5092token，保留原响应且不记审查通过、不自动付费重试。代码生成器正确性、TCP payload PCAP、完整IPv4/UDP/ARP/ICMP端点仍开放，见docs/native-bytes.md。


2026-11-01：原生字节里程碑2a2fed2c已在既有Linux服务器独立发布目录实际通过63专项（20流程/9wire/8迁移/12标量/14字节，含ASan/UBSan）、三基线任务/verify、15TCPdata原生及独立固定输入Z3匹配、101连接原生回归。184具名Git文件及1188原始服务器证据在artifacts/native-bytes-server-2a2fed2c；只读验收导出原Git工具复核三任务、重渲染C、重比较116原始观测，核对15SMT/result但不执行归档Python/ELF/solver。两种归档/重哈希观测故障均拒绝。源包约314KB，旧发布不变，无网络/SSH变更、测试零API调用。字节后端有限域可用，完整IPv4端点与payload线端组合仍开放，不标记总体完成；旧depth6 UNKNOWN和2750ms差异保持。


2026-11-02：0004候选串行集成model/udp-payload.json、六原字节不变场景、单步21输入探索及flows/udp-payload.json，新增profile requirement明确4096/端口8080/暂未ICMP/校验和假设，修正agent页码/内容抽象说明，guard/action等协议逻辑不改。首轮flow探索错误使用原始list而非IR bytes字面量，失败保留；修正探索表达形式并重绑定task后，本地十阶段+只读verify全部通过：4规则见证+6固定种子+9域拒绝共19例，13独立trace步骤，depth3 safety/overlap UNSAT；非UDP wire/PCAP。新增4内容/默认checksum/域故障专项、旧8迁移与6部署方法分别通过，无通用protocol_lab代码改动。udp-payload独立release profile将跑41专项及四完整任务；实际Linux新发布待完成。API台账仍九请求66113已知token，本轮零API。


2026-11-02：34e47060集成UDP字节flow已在独立Linux发布实际通过41专项及四完整任务/verify（原三基线全部回归）。UDP任务4见证+6原字面量种子+9model-gap拒绝共19例、13独立trace、depth3双UNSAT；70源码/约285KB包。751原服务器文件及原本地探索编码失败在artifacts/udp-payload-flow-34e47060，只读验收逐70不可变Git blob/原Git校验器核验四job，不运行归档Python/ELF/solver。通用protocol_lab源码未改，独立数据模块经相同flow成立；未宣称UDP wire/PCAP/完整IPv4端点。另一有界agent已返回UDP线编码IR语义设计提案，尚未实现或批准，保留artifacts/udp-wire-design-0001；累计10调用75605已知token，原12上限不重置；本轮集成/部署/验收零API，仅此新设计调用9492token。旧2e67601e五CI实际通过，新集成提交CI需单独等终态。下一步审查新字节/packing/checksum显式IR语义并同步参考/独立Z3/C后端；禁止将提案当实现或绕过formal拒绝。


2026-11-02：新codex/wire-primitives分支接850b81cc（PR9）；其五CI已实际success。控制器拒绝原UDP wire设计整体：AC2真实checksum=ff8e而非零、AC4长度/内容矛盾，且UDP策略混入算子、pseudoheader/容量/位宽表述不一致；原提案保留，审查在controller-review.json。实现最小纯算术IR0.4子集：显式mod8/mod16be打包与Internet checksum16，参考任意整数总语义，独立Z3精确递归Seq/BV17携带加法，不调用参考、不设内容截断；C有界uint32逐字折叠，UDP缺省/零映射仍须模型显式写。新backend v3，旧证据不放宽hash；长度投影与未知/旧版本算子显式拒绝。RFC1071官方原文SHA e10dfd68固定；新docs/wire-arithmetic.md完整语义，旧冻结semantics源不改。8新专项通过（含SMT递归定义导出重载、任意整数打包义务、内容翻译故障、满4096边界）；旧12标量/14字节/9wire/13数据语义/20流程/8迁移/4UDP/6部署分别通过，非全仓回归。11字面量种子+1规则见证的新十阶段任务本地全部通过/verify，depth2 safety/overlap UNSAT仅为长度/range合同；无完整checksum或编译器正确性证明。新88测试/五任务Linux发布待实际完成；仍未实现UDP wire/PCAP/完整栈。API保持10调用75605已知token，本轮零API。


2026-11-02：3180159b的IR0.4纯算术已在Linux独立发布实际通过88专项、五完整任务/verify、15TCPdata原生+固定输入Z3及101连接原生回归；213源码/约349KB包，1562原始文件在artifacts/wire-arithmetic-server-3180159b。原Git只读验收核213输入、五job、重渲染/重比较116原始TCP观测，检查15SMT/result，不执行归档Python/ELF/solver。算术任务12例/11literaltrace，depth2双UNSAT只为长度/range；另外固定odd-carry查询在全新Z3 context重载后UNSAT，单独保存查询/哈希，不扩称全checksum等价。独立DeepSeek源码审查2245token，无具体findings且列出限制，不算证明；台账累计11调用77850已知token，原12上限未重置。服务器新版本所有门禁通过，本轮新CI待新分支PR终态。后续优先补显式字节读取/原始IPv4-UDP线编码IR与PCAP，不能把纯算术当UDP实现。旧UNKNOWN、2750ms差异及用户未提交目录保持。


2026-11-02：新codex/udp-wire-transmit接71b23357（PR10九CI已全部success）。无需新opcode/协议codec回调，从IR0.4显式拼完整IPv4/UDP发送字节：固定文档地址/40000→8080、TTL64、DF1/ID0、MTU1500/data1472，所有长度、pseudoheader、checksum默认/配置及0→FFFF映射均为guard/action/表达式。RFC6864§4/4.1官方源SHA e00ff443固定，ID0只限原子数据报。新增独立观测解码器和provider-neutral后置门禁：先普通十阶段flow，再把实际C emission原字节封入PCAP，独立解码/校验并对固定rawhex/字段/时间oracle，绝不从参考输出造PCAP。六固定种子、2规则见证、1超MTU拒绝共9例，10literaltrace步骤、9实际native packets，本地全部通过/verify，depth2长度/MTU双UNSAT不等checksum/协议完整证明。7新测试及旧20流程/6部署分别通过，含zero-map故障、合法checksum但payload旋转、PCAP/校验和/长度/fragment故障、stdout/oracle篡改拒绝。仍为发送虚拟链路，无UDP接收/ARP/ICMP/Linuxpeer/物理抓包/完整栈。新95测试/六flow+PCAP Linux发布待实际完成；保留旧UNKNOWN/2750ms。最后一次有界DeepSeek独立IR审查已启动，原12上限不重置，结果另计，不执行模型输出。


2026-11-02 Linux首次f9472593未验收：九native packet/PCAP固定oracle通过，但总体formal UNKNOWN使新测试失败，原log/source和原源码独立诊断在artifacts/udp-transmit-f9472593-failed。诊断明确全depth2 safety及overlap均UNSAT，仅后续存在性sample SAT搜索canceled；旧版未导出sample查询、unittest临时job已清理，不能冒称恢复。改进只在IR0.4非空样本阶段：用已有exact fixed-choice后端构造单实际事件样本（全部guards保留，仅选中动作），再any单事件，再原 unrestricted，真实SAT+参考重放才满足nonvacuity；原全深度/全输入安全与冲突查询不收窄，不改模型/不变量/oracle/资源。采样子查询/结果/哈希全保存，all-input UNKNOWN不得被替代。新8项（含强制all-input solver异常仍UNKNOWN）通过、旧13数据/8算术通过；新增bootstrap失败作业保留，修订96专项/六任务Linux发布待实际验证，旧失败不覆盖。


2026-11-02：修订1b13a36f在Linux独立发布实际通过96专项、六完整任务/verify、15TCPdata原生/固定输入Z3和101连接回归。新发送task9例/10literaltrace、9个实际C生成IPv4/UDP包，其PCAP由原字节封装、独立解码/校验/对六固定oracle全部匹配；模型IR中明示全部layout/checksum/default/zero policy，无新opcode或UDP Ccodec。228不可变源码/约374KB包、1746原文件及原Git只读验收在artifacts/udp-transmit-server-1b13a36f。特别逐字节确认两份全depth2/全输入safety与overlap SMT和原f947诊断完全一致；只为存在性非空样本增加exact固定choice单事件SAT+重放（样本查询/哈希另存），不把未知全输入性质变为固定例证明。原失败/UNKNOWN保持、未来失败test job保留。独立agent静态协议审查无findings但非证明、未审后续采样优化；累计12调用83412已知token，原12上限已达，不自重置；只付费agent通道受限，本地继续。功能仍固定tuple/TTL64/DF1ID0/MTU1500发送虚拟链路，不是UDP接收/ARP/ICMP/Linuxpeer/物理抓包/完整栈。后续补原始包字节读取/接收及独立peer渠道，再跨层组合。新PR/CI按实际状态更新，不自动merge。


2026-11-02：codex/byte-read接PR11头1e4be0cc（十CI实际success）。IR0.5新增唯一纯算子bytes_at_or_zero(bytes,int)->int：有效索引返回octet，负数/越界明确返回0，协议必须另写长度guard；非Python负索引、非隐式packet acceptance。参考显式边界、独立Z3 Seq(BV8)/Int/ITE、C先sign/length检查，三个后端同步；旧版本及length投影拒绝。IR0.4算术可在0.5使用，native signed64/4096域及clock/post/rational限制不变；新backend v4，旧证据用原Git。七新专项实际通过，含任意序列/索引range和越界Z3义务、全部256字节种子、signed64两端、4096边界、错误有效索引C翻译被精确内容oracle抓获；非通用编译器等价证明。八字面量种子+一规则见证共九例/八trace，十阶段/verify本地通过，depth2 safety/overlap UNSAT仅range合同。103专项/七任务新Linux发布待完成。尚未实现UDP接收；本阶段只补显式读取前置语义，后续raw IPv4/UDP receive guard/action/policy仍须全在IR。API原12次83412已知token预算已尽，本轮零API，旧UNKNOWN/2750ms差异和用户目录保留。


2026-11-02：b959876b的IR0.5读取前置里程碑已实际通过本地103专项+6部署测试、9例/8字面量trace十阶段/verify、15TCPdata原生/固定输入Z3及101连接回归。241 Git源码绑定、787原文件及只读原Git复核在artifacts/byte-access-local-b959876b（不执行归档Python/ELF/solver）。初次冻结审查因执行后symbolic注释改动被hash正确拒绝，原包/拒绝保留；从最终提交完整重跑flow后验收，未放宽hash。现有服务器SCP连接192.168.71.74:22超时255，新包仅准备、未部署，不宣称新Linux验收；旧Linux udp-transmit-1b13a36f证据不变。新草稿PR12叠仍开PR11，不合main；PR11十CI已全部success，b959876b新读取/发送/算术/流程/原生/部署/精确查询七CI已success，四其余运行中，不能外推后续头。下一轮先复核最新CI/SSH可达性；可达再部署byte-access固定profile，补raw IPv4/UDP接收IR（读取能力不等接收模型），不重启旧agent/不付费重试。预算仍12请求83412已知token，零新增。


2026-11-02：PR12头d5eeca9f十CI通过但Linux TCP receive项失败（handshake/syn-loss成功）。已下载原artifact13120317376/run41399161597/job125126976381，ZIP SHA d9faceef540dfa35bcf3b6e61f5a4be18a477953064a13da3e835d446651c07d；原包/日志/诊断保留artifacts/linux-capture-deadline-d5eeca9f。完整抓包解码得到origin1793600452886596000，quiet marker mtime1793600457906512460，即5019.91646ms，小于5020ms83540ns；原失败仍无效，不追认为通过/TCP bug。修复驱动以实际首selected PCAP时间+原settle等待且要求capture/socket存活，记录真实stop-request epoch/monotonic与deadline；最终解码须同origin，独立verify重算完整最小窗口。不改模型/oracle/0ms容忍/packetdrill容忍/上游/抓包范围，仍先停止capture再释放socket；16本地driver正反检查通过，新增CI门禁。新Linux运行待CI实际结果，旧archive须原Git checker。服务器本轮一次只读SSH仍超时，只阻塞项目服务器发布；API零新增，12上限不重置。


2026-11-02：为项目服务器SSH不可达增加替代的隔离GitHub Ubuntu24.04 byte-access immutable-release CI job：从当前Git HEAD导出固定241源码包、hash核验解包至/tmp独立release/venv，执行既有bootstrap的103专项/七task+verify/15TCPdata固定Z3+101连接/9UDP native-PCAP门禁；保留bundle/source/hash及原run，不打包venv/私有目录、不调用模型API/不改项目服务器或全局网络。CI已安排但结果未到，不能先宣布通过；该runner发布验证不等192.168.71.74部署或物理网络抓包。


2026-11-03：7c28f324（GitHub实际merge a3de424c，与head同tree）十一CI实际全部success。新增隔离Linux immutable-release实际103专项/七完整task+verify/15TCPdata原生固定Z3+101连接/9UDP native-PCAP六固定oracle全部通过；241 Git源码/1896原ZIP文件。原Linux receive重新执行runtime verifier有效，实际完整窗口5028.700806ms>=5020、零抓包drops；原83.54us短窗口失败仍无效/保留。严格Difference继续mismatch：最后ACK模型60ms vsLinux20.055ms，窗口12 vs64236，不改oracle/0ms容忍/模型配置、不称RFC bug。release及实际Linux TCP raw ZIP、provenance和原Git只读复核在artifacts/byte-access-linux-ci-7c28f324；核七job/116TCP/9UDP及86Linux源码binding/原runtime-queryhash，不执行归档Python/ELF/solver，离线需信任CI provenance。此为GitHub临时Linux发布验收，不是192.168.71.74项目服务器部署（本轮SSH仍timeout）；也不是UDP接收/跨层/完整栈，后续raw IPv4/UDP receive仍下一模型里程碑。PR12叠PR11继续draft、不自动merge；本次证据文档新头需单独查CI，不外推7c28f324。无新付费API，原12请求83412token上限仍耗尽；旧TCPdepth6 UNKNOWN/lwIP2750ms差异及用户两目录不动。


2026-11-03：新codex/udp-wire-receive接716f4b91（PR12仍开，刚查询其十一CI仍运行中，不能外推旧7c全绿）。新有限raw IPv4/UDP receive使用IR0.5现有算子，无protocol_lab/生成器/common opcode改动。固定peer192.0.2.2:8080→local192.0.2.1:40000/IHL5/TOS0/TTL64/DF1ID0/MTU1500，显式IP/UDP读取/长度/pseudoheader/checksum/absent可配置接收/静默drop及精确udp.rx字节投递；12原始包oracle先用独立struct构造并冻结，含真computed0→FFFF、默认允许/配置拒绝absent、badIP/UDPchecksum/长度、short和1472边界。非匹配header/端点/TTL/options/fragment/超MTU及UDP surplus保留model_gap，未冒称RFC必须drop，RFC768/791/1122版本/解释及所有假设固定。参考/实际C/12固定输入独立Z3及8新专项（含有效checksum的payload位移故障、stale payload清除、FFFF在require模式可收）通过。本地完整十阶段/verify：8规则见证+12固定种子+7model_gap=27例、13literaltrace；depth2 safety/overlap UNSAT只证明payload范围/dropempty等声明不变量，无通用checksum/编译器/完整协议证明。新111方法/八task固定Linux CI profile已准备，未先宣布Linux通过；项目server一次SSH仍timeout，只该通道阻塞。无UDP真实peer/新抓包/完整端点组合；旧UNKNOWN/lwIP2750ms及用户目录不动，原12付费调用预算不重置，本轮零API。


2026-11-03：新接收源码79d6879f本地111专项+6部署全部通过。260 Git源码绑定/369原文件在artifacts/udp-receive-local-79d6879f；原Git只读audit核新flow27例/13literaltrace、重渲染/重比较12实际原生接收以及12固定输入Z3报告/查询hash，不运行归档Python/ELF/solver。探索在64prefix预算内覆盖8规则，非全域穷举；全输入depth2 safety/overlap UNSAT仅payload/dropempty合同。独立12原始字节oracle/官方源/解释仍固定不变，无通用protocol_lab改动。f266e4ac修正专用CI的测试文件selector（79d初稿误留旧byte_access名字，release111已有正确8项），PR13叠仍开PR12；f266当前native/deploy/exact三CI success，receive/flow/Linux三项仍运行，不能先当Linux验收。server SSH仍timeout，本轮零API，原12上限不动；下一步等本次隔离Linux新接收release实际结果/原始证据，再推进独立UDP peer与跨层，不自动合main。


2026-11-03：f266e4ac专用receive CI双job（8新专项/27例flow和immutable-release）已实际success；tested merge040addc0与head整Git tree相同。隔离Ubuntu新发布实际111专项、八完整task/verify、15TCPdata原生固定Z3+101连接以及9UDP TX/六oracle全部通过。260源码/2161原ZIP文件在artifacts/udp-receive-linux-ci-f266e4ac，artifact13184583736/run41538066860 SHA85bda7d5固定；可达原Git只读audit核260blob/八job/116TCP/9UDP与15TCP查询hash，不运行归档Python/ELF/solver。新receive27例/13literaltrace与depth2范围/dropempty/overlap双UNSAT保持；12固定接收Z3在Linux单测实际重放，分开的12原SMT/result/native保存在本地79d包，不改标Linux查询证据。父PR12头716十一CI已实际全success；873ff808新证据头当前四CI success、receive/Linux仍运行，最后提交亦需单独查，不外推。此为有限raw UDP RX entry模型/C平台里程碑，不是网络peer/UDP新抓包/跨层/完整栈；项目server仍SSH超时。下一步先核最终头/CI，按官方规范扩展必要IR接收域并打通独立UDP peer/观测，再ARP/ICMP/TCP组合。保持RFC版本/范围/未知结果与旧差异，不自动main合并，原12付费上限不重置。


2026-11-03：新codex/linux-udp-peer接84c95a33（其六CI已全部success，PR13仍开）。新增私有netns/TUN独立Linux UDP peer通道：两端subject C仍从原TX/RX IR生成（无IR/协议生成器改动），C TX真实raw bytes写TUN，Linux socket8080接收/回送，原TUN回包不改写交C RX；独立tcpdump RAW记录全UDP包、100msquiet后先停capture再close，保留源/编译/ELF/stdout/原raw/PCAP/peer字节/配置/namespace/工具hash。逻辑IR time0与实际抓包timestamp分开，无UDP线时延合同。Linux默认TTL/PMTU/ID不强迫匹配，RX固定profile域外仍model_gap；该harness配对不称单一组合IR/完整栈/真实Ethernet。五adapter/capture/实际C/篡改反例方法本地通过；本地macOS preflight正确阻塞，raw blocked/unit日志在artifacts/linux-udp-peer-preflight-local，不是Linux证据。server本轮只读SSH已变connection refused，未改变网络/SSH。新专用CI已准备，必须真实运行和runtime gate通过再称互通；全部旧agent终态不重启，付费原12上限耗尽零新增，不放宽oracle/hash或改上游。


2026-11-03：首43f4e3d7真实Linux peer run41567670353失败保留（artifact13199742937，SHA cf6286a6固定，74原文件）：peer已收到/回送3datagram，原RX因合法atomic ID42967/42968/42972均model_gap，独立tcpdump则0 captured/6 filter receipts/0 drops（缓冲尚未交付），原capture仍无效不追认。官方RFC6864§4/4.1核对后新增显式继承IR udp-wire-receive-atomic：仅忽略DF1/MF0/off0 ID语义，原20byte IP checksum仍含实际ID字节；旧ID0模型/oracle/hash不改，未调TTL或其他domain/未patch peer字节。独立冻结ID1/1234/FFFF/repeat/ID变更坏checksum与非atomic/fragment负例，4新专项+5adapter及旧8RX通过；新flow本地22例（8见证+5seed+9gap）/6literaltrace、depth2 safety/overlap UNSAT仅继承payload/dropempty合同。新tcpdump immediate-mode为修复实际buffer交付，原100msquiet/无packet cap/校验和/字节比较均保持，strict verifier检查该配置；原失败source/rawbytes完整留artifacts/linux-udp-peer-failed-43f4e3d7。CI加原子IR flow/5固定输入Z3产物及runtimepeergate，修订待实跑。每次git读取仅对当前已授权ROOT显式safe.directory（不用global，避免sudo checkout所有权metadata失败）。未改protocol_lab/common生成器/上游/规范oracle，不增付费API。


2026-11-03：b10fca8d修订真实Linux UDP peer/runtime gate已实际success（run41568756821/job125696495591，tested merged2d9fa03与head整tree一致）。生成C TX→原字节TUN→独立Linux UDP socket→原始TUN回包→生成C atomic RX三往返（空/oddNUL/1472）精确投递，独立tcpdump6 captured/6 filter/0drop；未改Linux默认ID/TTL/PMTU、未改写header/checksum/payload。370原文件/82 Git source bindings及原Git只读audit在artifacts/linux-udp-peer-b10fca8d，artifact13199869218 SHA0b2fb5da固定；核真实capture/native/peer所有字节及runtime原proof，另核atomic flow22例/6literal/9gap、depth2双UNSAT声明合同及5原生/固定Z3原SMT/result。审查不执行归档Python/ELF/solver，不称新Linux执行；CI provenance需单独信任。首次43失败仍capture无效/modelgap未追认；旧ID0/RTO2750/unknown证据保持。b10其它flow/native/exact/receive CI已success，LinuxTCP上次仍运行；本次证据新头须单独核CI，不外推。此为真实隔离TUN Linux UDP互通，仍两IR模块由byte harness配对，不是单一组合IR/完整TCPIP/ARPICMP/真实Ethernet/线时序合规；server本轮connection refused未部署，付费API零新增。下一步按范围/规范/独立oracle先推进ARP/ICMP与跨层组合，不引入hoststack替代IR subject，不自动main合并。


2026-11-03：新codex/arp-endpoint接f0046ebf（其六CI已全success，PR14仍开）；server本轮一次只读SSH仍timeout。ARP最小有限模块已用IR0.5现有byte/timer/set/emit表达，无protocol_lab或C后端改动。固定local192.0.2.1/MAC02..01、单peerIP.2/源MAC前缀02、Ethernet-II ARP hardware1/proto0800/6-4长度/op1-2、raw42..60/Egress60零padding。RFC826官方原文新增固定hash；Packet Generation/Reception映射lookup/request/reply，尤其先merge已有sender再检查target；RFC1122§2.3.2.1映射stale清理/flood避免。显式EMPTY/PENDING/RESOLVED、查询合并、1000ms一次retry/2000ms失败、cacheTTL默认60000可配60000..3600000并refresh重置，时间为profile选择非RFC强制。无一般cache、待发IP包队列、ACD/proxy/完整host。独立struct oracle先冻结13正/故障场景，30域负例覆盖三状态；修正VLAN probe为真正802.1Q标签及有效但域外MAC前缀，未改subject规则。8新方法通过：13literal/独立Z3/实际C、merge-before-target/refresh fault、错误MAC但invariant仍过的native fault、计时同刻顺序及30原子gap。第一flow64例=21见证+13seed+30gap，32literaltrace，160prefix预算内21规则覆盖，depth3 safety/overlap双UNSAT仅state/cache/timer/retry/TTL声明合同；最终修正fixture第二flow另验。新119方法/九task/ARP13固定Z3原始产物+旧15/101/9TX固定Linux profile已准备，待实际CI，不先称ARP互通/物理Ethernet/完整栈；付费API仍零新增，原12上限不重置。
