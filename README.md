# Protocol Flow Lab — TCP/IP 模型与验证流程

目标是建立可复用、可审查的协议建模流程。TCP 是第一个样例；通用执行器放在 `protocol_lab/ir.py`，TCP 的规则和适配器分别放在 `model/` 与 `protocol_lab/packets.py`。

GitHub 仓库：[briliant-ben/TCPIP-Model](https://github.com/briliant-ben/TCPIP-Model)。在新机器上的克隆、环境重建和验证步骤见 [迁移与复现说明](docs/github-handoff.md)。

**v0.2 已接入独立 Z3 有界检查、PCAP 归一化和统一证据验收。真实 Linux TCP 验证仍待具备条件的测试主机执行；尚无 Ivy 或无界证明。**

**v0.3 新增 TCP 连接生命周期模型和多模型流程，并接入固定上游 lwIP 的真实 C 代码执行。整个 TCP/IP 协议栈尚未完成。** 详见 [协议栈范围与进度](docs/stack-scope.md)。

| 模型 | 当前范围 |
|---|---|
| `model/tcp.json` | 原有主动握手回归基线，3 状态 |
| `model/tcp-connection.json` | 11 状态连接控制模型，97 条声明规则，101 个控制场景；仍排除 payload/窗口/拥塞等行为 |
| `model/tcp-data.json` | IR 0.2 声明式组合连接模型；有限缓冲、分段、累计/部分 ACK、窗口、字节前缀重传和接收裁剪；数据恢复与完整 TCP 仍未完成 |
| `model/tcp-reassembly.json` | 继承数据/连接模型，加入 16 位置显式乱序队列、多缺口重组、重复/重叠裁剪与回绕；一般 piggyback、FIN 数据和完整恢复仍未完成 |
| `model/tcp-segments.json` | 继承重组/数据/连接模型，组合 ACK/window 与 payload，支持窗口收缩及有在途数据的零窗口探测；完整 persist、带数据关闭及恢复仍未完成 |
| `model/tcp-close.json` | 组合待发送／在途数据、独立 FIN 序列标记、半关闭读取和 FIN-WAIT 重组；FIN+payload、乱序 FIN 缓存及完整恢复仍待实现 |
| `model/tcp-fin.json` | 显式 FIN 窗口／payload、乱序 EOF 标记与字节重组、单次 FIN 消费及条件关闭目标；完整恢复与独立实现闭环仍未完成 |
| `model/tcp-rto.json` | IR 0.3 精确有理 RTT/RTO、Karn 歧义采样、部分 ACK 与 SYN/FIN 组合；一般发送历史时序、delayed ACK、persist、拥塞／恢复仍未完成 |
| `model/tcp-tx-history.json` | 逐字节／FIN 发送历史、ACK 时间槽移动与时龄裁剪，修正数据超时过早重传；原归纳 unknown 保留，独立精确查询分组、非空重放与单独命题已接入 suite 统一验收；完整恢复仍待推进 |

2026-10-24：已恢复本地基线并推进 [IR 数据语义](docs/semantics.md) 和 [有限 TCP 数据切片](docs/tcp-data.md)。数据切片的 15 个场景具有参考轨迹和独立 Z3 固定输入重放；全输入混合查询可能为 `unknown`，suite 明确保留 `formal_pending`。这不影响旧模型的独立有界检查，也不将合成 PCAP 计为 Linux/lwIP 数据验证。持续实施记录见 [实施日志](docs/implementation-log.md)。

新增的[状态不变量归纳义务](docs/inductive.md)独立保存初值、117 条规则保持性和 14 个 guard 组检查；当前数据模型通过这些长度/标量性质义务。它拒绝字节内容比较，不替换原 BMC 结果，也不构成完整 TCP 或 payload 内容正确性证明。

[乱序重组 profile](docs/tcp-reassembly.md)复用原 15 个数据场景并增加 11 个重组场景；其独立归纳检查覆盖 113 条规则、13 个 guard 组及 84 个状态不变量。字节内容由非零字节场景、分段排列、故障变体及完整字节符号重放分别检查，仍无数据实机闭环。

运行新增流程：

```bash
.venv/bin/python -m protocol_lab suite --formal --depth 6
.venv/bin/python -m protocol_lab suite-verify
```

每个 profile 保存状态/规则覆盖、参考轨迹、PCAP、DOT 图和形式检查报告。新连接模型尚无 packetdrill 生命周期适配器，会显式标为 unavailable。见 [连接模型说明](docs/tcp-connection.md)。

运行不需要 TUN 的真实 lwIP 实现通道：

```bash
.venv/bin/python -m protocol_lab build
.venv/bin/python -m protocol_lab lwip
.venv/bin/python -m protocol_lab lwip-verify
```

普通握手投影匹配；丢包场景观察到 lwIP 2750ms 重传，与模型的 1000ms 配置有差异，命令退出 1 并保留证据。见 [lwIP 实现测试](docs/lwip-testing.md)。这不代表 Linux 已通过，也不把该时序差异直接认定为 RFC 错误。

```text
RFC 原文与哈希 → 带来源的 Protocol IR → 类型检查
                                      ├→ 显式探索 / 独立 Z3 检查 → 可重放反例
                                      └→ Python 参考执行 → 带规则 ID 的轨迹
                                                            ├→ packetdrill 测试脚本
                                                            ├→ 合成 PCAP + 帧映射
                                                            └→ 独立 PCAP 解析 → 归一化 → Difference

构建快照 + 求解记录 + packetdrill 运行记录 + PCAP 证据 → 哈希校验 → acceptance.json
```

## 运行

需要 Python 3.11+，本地流程没有第三方运行依赖，无需安装包。在本目录运行：

```bash
python3 -m unittest discover -s tests -v
python3 -m protocol_lab build
```

独立符号检查使用可选的 Z3 依赖：

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-formal.txt
.venv/bin/python -m unittest discover -s tests -v
.venv/bin/python -m protocol_lab formal
```

`.venv` 不纳入版本控制；首次克隆后按上面的命令创建。标准库环境下的测试会明确跳过可选 Z3 测试；完整回归应使用 `.venv/bin/python`。

入口报告是 [`artifacts/report.json`](artifacts/report.json)。主场景产物位于 [`artifacts/syn-loss/`](artifacts/syn-loss/)。重复构建的文件内容相同；报告固定模型、场景、运行时代码、探索配置和产物的 SHA-256。环境探测结果随执行环境变化。

| 环节 | 当前能力与边界 |
|---|---|
| 规范基线 | 保存 RFC 9293 / RFC 6298 原文，校验哈希；条款由人工解释并关联规则 |
| IR | 带类型的平面 EFSM、事件、消息、变量、定时器、不变量、来源；不执行嵌入代码 |
| 参考执行 | 虚拟时间、确定性重放、原子提交、逐事件证据 |
| 模型检查 | 深度 6、两个初始 ISS、指定事件域的显式探索；与参考执行共享语义 |
| 独立形式检查 | Z3 深度 6 有界检查；真实 32 位序列空间、符号 ISS/输入、整数时间；保留 SMT-LIB 查询与反例重放 |
| Packet 模型 | 此切片的 IPv4/TCP 编码和校验和；无通用解析器 |
| 实现测试 | 生成 packetdrill 脚本并提供显式运行入口；本环境未执行 |
| PCAP | 合成模型输出；独立解析经典 PCAP 的 RAW / Ethernet（含 VLAN）/ Linux cooked v1；真实采集仍需外部环境 |
| Difference | 连接过滤、双端 ISS/时间归一化、校验和检查后的有序比较；来源与文件哈希留档 |
| 验收 | `assess` 校验本地输入、求解查询、运行记录和观测文件；旧结果、合成来源和不完整证据不能闭环通过 |

## 主动打开基线场景

1. `handshake`：正常主动握手。
2. `syn-loss`：首个 SYN 丢失，1000 ms 重传，随后握手完成。
3. `two-syn-losses`：连续丢失两个 SYN，验证退避后的 3000 ms 第二次重传。
4. `sequence-wrap`：双方 ISS 为 `2^32−1`，验证 SYN 消耗序列空间后回绕到 0。

上述四个基线场景均在 ESTABLISHED 停止。FIN、RST、被动打开、同时打开和用户超时等路径见独立的 [TCP 连接模型](docs/tcp-connection.md)；数据传输与完整 RTO 算法仍待实现。基线语义详见 [语义与范围](docs/semantics.md)。

## 查看证据

```bash
python3 -m protocol_lab validate
python3 -m protocol_lab check
```

- `bounded-check.json`：探索边界、已覆盖规则、模型覆盖缺口、冲突和反例。
- `trace.json`：每个事件的前后状态、定时器、输出、transition ID、requirement ID。
- `packets.json`：模型的归一化包序列。
- `packet-map.json`：PCAP 帧号与 packetdrill 行号到事件和规范需求的映射。
- `model.synthetic.pcap`：可用 Wireshark 打开，链路类型为 RAW IPv4。
- `test.pkt`：生成的 Linux packetdrill 测试，状态为 generated，尚未执行。

缺少规则会报告 `model_coverage_gap`，不自动认定为规范遗漏。当前探索包含非法 ACK 探针，因此报告会同时出现 `bounded_pass` 和 `gaps_found`：前者仅说明已探索、已定义的路径没有违反所列不变量。

测试包含两个故障变体：删除握手后的定时器取消动作、让 SYN 重传错误推进 SND.NXT。检查器必须发现错误，其中一个反例会被重新执行验证。

## 真实协议栈与差异

在配置好 packetdrill、TUN、CAP_NET_ADMIN 和 CAP_NET_RAW 的 Linux 测试环境中运行：

```bash
python3 -m protocol_lab run-packetdrill artifacts/syn-loss/test.pkt \
  --out artifacts/syn-loss
```

结果单独保存在 `external-run.json` 和 `external.log`，不改写本地构建快照 `report.json`。未满足环境条件时返回非零并记录 `not_run`。本项目不会自动更改宿主机 sysctl 或创建网络命名空间；环境准备和实现差异解释见 [外部测试约定](docs/external-testing.md)。

对已经独立采集、归一化到模型 ISS 的包轨迹：

```bash
python3 -m protocol_lab compare artifacts/syn-loss/packets.json \
  /path/to/normalized-observation.json --out artifacts/syn-loss/difference.json
```

仓库内 `tests/fixtures/*.synthetic.json` 是手写的合成测试夹具，只用于测试比较器，不能用作 Linux 合规性证据。PCAP 解析入口已实现，当前没有真实实现抓包或差异结果。

### 从抓包到统一验收

修改 `packet-profile.json` 中的四元组，使之匹配真实抓包。先完成绑定到当前构建的 packetdrill 运行，再导入相应抓包：

```bash
.venv/bin/python -m protocol_lab observe /path/to/real-capture.pcap \
  --profile packet-profile.json --scenario syn-loss --origin external_capture
.venv/bin/python -m protocol_lab assess --scenario syn-loss
```

入口总报告为 [`artifacts/acceptance.json`](artifacts/acceptance.json)。只有本地快照有效、Z3 检查与重放通过、packetdrill 成功、同一运行绑定的独立观测匹配，指定场景才标记为 `scenario_closed_loop_pass`。它仍只覆盖已声明的模型范围和有界状态性质。

用于本地演示的合成 PCAP 可以走完整解析/比较路径：

```bash
.venv/bin/python -m protocol_lab observe artifacts/syn-loss/model.synthetic.pcap \
  --profile packet-profile.json --scenario syn-loss --origin synthetic
.venv/bin/python -m protocol_lab assess --scenario syn-loss
```

这会得到比较 `match`，但验收为 `pending`，观测为 `synthetic_only`。`assess` 只有全部门槛满足时退出 0；待完成或失败均退出 2。不要把演示结果当作实机验证。

## 结构与下一步

```text
spec/sources/          官方 RFC 原文与来源哈希
model/tcp.json         唯一权威 IR：需求、状态、消息、规则、不变量
model/exploration.json 有界探索的初值与事件域
scenarios/             环境选择、输入事件和验收条件
protocol_lab/          通用执行器、探索器、TCP 适配器、证据构建与 CLI
tests/                 运行时、故障变体、编码、比较器和端到端测试
formal/                Z3 后端语义与 Ivy 后续接入契约
artifacts/             可复现产物和明确区分的检查状态
docs/                  语义、外部测试约定、里程碑
```

下一步在真实测试主机执行并采集独立观测，再扩展 TCP 行为；Ivy 是后续可替换后端之一。见 [后续里程碑](docs/roadmap.md)。

[ACK/window 与 payload 组合](docs/tcp-segments.md)复用 26 个数据/重组场景并增加 14 个输入；109 条规则、84 个状态不变量及 14 个 guard 组分别检查。每个 profile 的 [claims.json 声明](docs/claims.md)绑定实际命题、假设、检查器版本和证据哈希；哈希验收不构成翻译器正确性或 Rocq 内核证明。

[Rocq 原语试点](formal/rocq/README.md)已在锁定 9.2.0 容器中完成六个通用值运算命题的编译、公理审计与 proof object 内核复查，错误证明和公理注入负控制通过；证据见 artifacts/rocq。它不证明 TCP 行为、Python/SMT 翻译或实际协议栈，不能替换上述 Z3 unknown。

[数据与关闭组合](docs/tcp-close.md)保留此前 40 个输入并新增 21 个关闭场景；FIN 与字节队列分别计数，共享一个重传定时器。未宣称完整 TCP 关闭、恢复或数据实机闭环。

[FIN 组合 profile](docs/tcp-fin.md)新增 23 个输入，连同既有 61 个输入分别保存参考执行、完整字节符号重放和合成 codec 证据。场景 0.2 可显式约束消息内容、顺序与时间；新 post-target-v2 语义由参考与独立后端实现。所有声明目标均须纳入状态归纳义务，Rocq 原语证明不代表该翻译器或 TCP 已获内核证明。


[SYN 发送历史](docs/tcp-syn-history.md)与 [delayed ACK](docs/tcp-delayed-ack.md)已列入统一注册表，合计 11 个有限 profile；登记不等于完整 TCP 验收。单项精确分组由 profile/CLI 显式配置，claims 检查实际配置并保留主 unknown。当前重建／验收结果以 suite 报告和实施日志为准，开发快照不直接升级。

[连接打开捕获投影](docs/connection-capture.md)显式覆盖被动、同时及单向 SYN 超时，保留旧投影和严格校验，不以猜测 ISS 或重新对齐重传来消除差异。

[独立 lwIP 数据通道](ports/lwip-data/README.md)新增单连接四字节发送／累计 ACK 的实际内存 netif PCAP，与 IR 在0ms容差下匹配；独立验收重建 oracle、复查固定输入并检查查询等价。9项 port 集成／故障测试与既有311方法完整回归分别记录。该有限场景不代表一般数据恢复、Linux实机或完整TCP证明。

[事件驱动 lwIP ACK/window 实验](docs/lwip-stream-testing.md)进一步支持多段、部分／重复ACK与窗口关闭／恢复。12项独立port方法和6场景执行／验收完成，5个严格匹配，保留初始窗口4时的实际2字节分段策略差异。该差异未直接判定RFC违规，也未修改上游或oracle；接收文本、关闭、恢复、Linux和一般实现精化仍须继续。

同一[独立实现通道](docs/lwip-stream-testing.md)已扩展接收重组、FIN／EOF和主动关闭：17项独立port方法通过，13场景重建／独立验收完成，6个总体匹配、7个网络差异保留。7个新场景的非空字节／EOF观测均匹配；即时补洞ACK与FIN通告窗口差异未被放宽或误报成字节损坏。查询等价保留原超时，并以精确共享前提提取重新检查。Linux、丢包／拥塞恢复和一般实现精化仍未完成。

[拥塞控制开发切片](docs/tcp-congestion.md)新增显式cwnd预算、慢启动、累计字节拥塞避免和数据RTO首次／重复响应，继承persist与关闭／字节历史。14项方法（含101个控制输入）及6固定字节场景通过；主BMC／归纳unknown保留，完整分组补充独立复查通过。尚未注册suite，也未覆盖快速重传／恢复、空闲重启、独立拥塞实现或完整TCP证明。

[有限快速重传／恢复](docs/tcp-fast-recovery.md)显式组合第三dup输出、classic Reno膨胀／退出、Karn、字节历史／早RTO等待和关闭。19方法与15固定字节／合成codec场景验收通过；三个可达原型缺陷及两个SAT见证保留并加强不变量。主unknown不改写，分组补充独立复查通过。仍无完整恢复、通用输出／时间或实现精化证明；完整回归可用tools/run_frozen_regression.py按提交和依赖哈希记录。

[独立lwIP快速重传对照](ports/lwip-recovery/README.md)复用未修改的C驱动，单独绑定恢复IR。四输入重建及独立验收完成：两个严格匹配、两个保留第三／第四重复ACK的时刻差异；两个专项方法一次通过。未预处理与预先无在途ACK场景并存，不以修改oracle消除差异。该通道未观测内部cwnd／阈值，未验证RTO或Linux。
