# GitHub 迁移与复现

## 当前恢复点（2026-10-30）

PR#3已合入main的ab9f75ba。当前开发分支是codex/tcp-modular，包含71a3e1a8的精确模查询证书／标量IR契约及main纯历史合并；以实际分支和源码为准。不要回退到早期codex/tcp-data。旧未提交refinement目录保留。

430项冻结回归已通过；新442项回归按71a3e1a8在本地运行，1260依赖已核对未变，运行记录不是通过结果。31项相关专项通过。新标量模型只有2条序列空间定律，modular归纳已验收，BV主检查仍unknown；一个原ACK违例分支有等价重新导出的独立UNSAT，69其余分支未闭合，整体TCP未知报告未改。见formal/modular-normalization.md及artifacts/seq32-contract-development。

真实Linux接收单段4零字节／两个握手控制场景此前已独立验收，保留窗口／ACK时刻差异；新数学实验不产生Linux或PCAP证据。2750ms lwIP差异保持。完整TCP、通用解释／翻译／实现对应及后续协议均未完成，继续原roadmap。

仓库：https://github.com/briliant-ben/TCPIP-Model

仓库包含作者工程、RFC 基线与来源哈希、全部模型和场景、参考执行与 Z3 检查代码、测试、文档、现有证据产物，以及保留原许可证的固定版本 lwIP 源码。不依赖原云主机上的 Git 元数据或 Python 虚拟环境。

## 在新 Linux 机器上开始

需要 Git、Python 3.11+、Python venv 和 C99 编译器。以下命令不需要 TUN 或原始套接字权限：

```bash
git clone https://github.com/briliant-ben/TCPIP-Model.git
cd TCPIP-Model
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-formal.txt
.venv/bin/python -m unittest discover -s tests -v
.venv/bin/python -m protocol_lab build
.venv/bin/python -m protocol_lab formal
.venv/bin/python -m protocol_lab suite --formal --depth 6
.venv/bin/python -m protocol_lab suite-verify
```

lwIP 源码已随仓库保存，普通 clone 即可，不需要初始化子模块。上游版本、来源、许可证和构建输入哈希见 `third_party/README.md` 与 `third_party/lwip.lock.json`。

## 真实 lwIP 执行

```bash
.venv/bin/python -m protocol_lab lwip
.venv/bin/python -m protocol_lab lwip-verify
```

当前固定配置下，`lwip` 会因 SYN 丢包场景的时序投影差异返回 1；连接本身成功，差异保存在报告中。`lwip-verify` 检查执行证据完整性，不将时序差异自动视为 RFC 违规。具体边界见 `docs/lwip-testing.md`。

## 证据与重建

`artifacts/` 中提交的 JSON、SMT-LIB、DOT、PCAP 和日志是开发时的证据快照。编译器路径、命令、二进制哈希与日志可能对应原云环境；这些文件不保证在新机器上逐字一致。

Python 虚拟环境、缓存、上游 `.git` 元数据和编译出的 `lwip-harness` 二进制不入库。新机器应重新运行上述构建/执行命令，再校验新生成的证据。缺少二进制时，直接校验旧 lwIP 报告会失败，这是预期行为。

## 后续 Linux TCP 实机验证

独立的 Linux packetdrill 通道还需要 packetdrill、`/dev/net/tun`、CAP_NET_ADMIN 和 CAP_NET_RAW。该通道与 lwIP 内存接口分别验收，不必先完成它才能继续开发模型。

目前整栈尚未完成；已有模型范围与剩余协议见 `docs/stack-scope.md` 和 `profiles.json`。

## 2026-10-30 Linux CI checkpoint

独立临时VM／网络命名空间已完成一个真实内核主动打开及5010ms静默期验收，仍保留0ms时间Difference；源码1551c535，CI41004399031，证据artifacts/linux-netns-ci-1551c535。重现和范围见[Linux通道](linux-netns.md)。本地macOS环境限制继续存在，后续数据／恢复验证不能由此握手或lwIP证据代替。离线验收不是Linux重跑，源码变化必须保留旧检查点哈希。

2026-10-30：当前分支codex/tcp-modular、草稿PR#4（以远端实际状态为准）。条件SSA里程碑见formal/conditional-ssa.md；复查命令`.venv/bin/python artifacts/ack-conditional-ssa/accept.py --out /tmp/new-ack-ssa-recheck`，输出目录必须新建，逐成员核对后真实再跑CLI，不计新TCP或Linux证明。ACK092／280仍unknown。45专项通过；原442冻结session39524继续，原1260及258输入SHA未变，新456发现不称全量通过。

2026-10-30：ack-piecewise-092新增精确模运算／原分支092验收。复查`.venv/bin/python artifacts/ack-piecewise-092/accept.py --out /tmp/new-ack092-recheck`，真实新CLI重构全部case／证书／约束；原52外新增092，但仍68原未知，不是完整RTT／ACK。51专项通过；当前462发现未完整跑，原442冻结session39524继续，依赖未改。原2750ms与独立实现Difference全部保持。
