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

2026-10-30：71a3e1a8冻结的442项标准回归已终态全部通过，unittest5269.704秒／runner5270.056719秒，0失败／错误／跳过，1260依赖与环境未变；原进程exit0，不再是running。原始started／输入／ID／终态／完整日志及独立核对见artifacts/full-regression-71a3e1a8。后续20新方法不在此集合，其51专项另计；当前462完整组合尚未跑。旧历史running记录保留但以此终态为准，不提升协议或形式unknown声明，完整目标未完成。

2026-10-30：原账本数量280精确16case里程碑见artifacts/ack-finite-280；复查`.venv/bin/python artifacts/ack-finite-280/accept.py --out /tmp/new-ack280-recheck`。最后case的局部等价与叶均需独立证据，不接受只补叶的原型状态。56专项通过，当前467全量未跑，原442已通过；其他原未决查询批量验收单独记录，范围及全部原Difference保持。

2026-10-30：68原ACK分支批次已终态验收，48独立UNSAT／20UNKNOWN；入口`.venv/bin/python artifacts/ack-piecewise-remaining68/accept.py --out /tmp/new-ack68-recheck`会逐项重建和真实CLI复查。按source SHA结合另外280等证据，19未决清单与349/368具名索引见coverage-index.json（不计重复／不代表完整目标或规范覆盖）。原442通过，56专项通过，467全量未跑。后续优先19个账本／父基缺口及字节内容、输出顺序、时序与实现桥，维持完整原目标和全部Difference。

2026-10-30：DAG cut里程碑见formal/query-lemmas.md及artifacts/ack-query-reuse，复查`.venv/bin/python artifacts/ack-query-reuse/accept.py --out /tmp/new-ack-query-reuse-check`会重放58父证书、两目标和1260输入／模型／export锚点；checker或模型改变应保留命名旧检查点，不放宽hash。351/368具名查询、17未决，原unknown与Difference均保留。67专项通过、478完整发现未跑，旧442通过；query-verification Ubuntu CI只计新证书专项，等待实际CI验收。当前实际分支codex/tcp-modular／PR#4，以远端状态为准，完整原目标保持。

2026-10-30：PR#4已合入main eebd27e5。本轮aaee733c保留并转codex/tcp-query-dag，合并main的13ff8c93与aaee源码完全相同，已新建并挂接草稿PR#5。Ubuntu新专项CI41079885224／job124145857544实际通过：67／67、10.319269秒、0失败／错误／跳过，1268源码输入与source head13ff8c93逐Git blob一致，checkout merge748b94ab；原ZIP／官方API来源／完整job及unit日志与离线验收见artifacts/query-verification-ci-13ff8c93。新Linux checker1bfaf5bb与Mac2f4cc814分别绑定，不放宽旧hash；CI只跑新证书单元测试，不计Linux TCP／PCAP／kernel证据。

478项标准发现已在独立临时检出/private/tmp/tcpip-full478-_2gsnde8、detached13ff8c93启动，冻结1281输入。原进程PID21869／统一exec session4411已确认运行，输出/tmp/tcpip-full-regression-13ff8c93.log及同名目录保存started／inputs／test IDs；未到终态，不称全量通过。不得编辑该检出或因观察超时重启；主仓库继续开发不影响此冻结集合。旧442通过仍独立有效，67本地／Linux专项均不替代478完整组合。完整目标继续，剩17原ACK项及父基／字节时序／实现与后续协议缺口不变。

2026-10-31：实际分支codex/tcp-query-dag／草稿PR#5（推送前再次检查远端，若已合并需保留本地工作并新分支／PR）。缓存f3c2753c的73本地／Ubuntu专项与官方ZIP／Git blob验收均通过。新artifacts/ack-query-head-chain原15个头几何查询已通过producer双native及安全解包的新session全依赖／目标重检；`.venv/bin/python artifacts/ack-query-head-chain/accept.py --out /tmp/new-ack-head-check`重做该命名检查点，完整archive与runtime SHA绑定，勿修改旧版本字段。新索引366/368、仍295／296，探索296 UNSAT不等于验收；完整ACK／父基及字节／时间／实现仍未证。旧ack-query-reuse保留13ff8c93命名epoch，新helper不得放宽hash适配旧DAG。

478旧组合回归保持独立/private/tmp/tcpip-full478-_2gsnde8，detached13ff8c93、session4411、1281输入，日志/tmp/tcpip-full-regression-13ff8c93.log，尚无新全量通过声明；当前标准发现484，6个缓存方法已包含73专项。必须先查原session实际终态和result／inputs／IDs／log，再归档验证；不因观察等待重启或编辑该检出。用户原两处untracked refinement目录保留，全部旧UNKNOWN、2750ms及严格oracle不变。完整目标继续。

2026-10-31：独立13ff8c93冻结的478项标准回归已终态全部通过，unittest5348.520秒／runner5348.724803秒，0失败／错误／跳过，1281依赖及环境未变，原session4411实际exit0。原started／输入／478唯一ID／result／完整日志与独立验收存artifacts/full-regression-13ff8c93；1281输入还逐不可变Git blob及运行结束后的独立检出原字节核对通过，检出clean且保留。此前running叙述仅为历史，以此终态为准，不再轮询或重启原进程。该478是命名旧source集合；后续缓存／候选生成器方法与专项另计，不能推算为后续组合全通过。没有新增Linux TCP／PCAP、kernel或完整协议证明；原UNKNOWN及2750ms等Difference保留，完整目标继续。

2026-10-31：raw finite生成器ca9d6f24的实际Ubuntu CI41165740563／job124432792129／artifact13029157918通过77/77，14.931918秒、0失败／错误／跳过。原ZIP SHA4e96a94a、官方来源／decoded job gzip／unit日志及验收存artifacts/finite-proposal-ci-ca9d6f24；source head ca9d6f24／checkout merge7ee7ecdd分开绑定，1271源输入逐不可变Git blob核对，77 IDs与本地相同。仅新证书专项和真实共享合取结构回归，不计Linux TCP／PCAP、旧Mac实证重放或kernel。当前488组合未跑，旧478标准回归已通过；295／296虽各已独立证书验收，最终来源／故障／安全解包验收尚在进行，具名索引仍366/368。完整目标继续。

2026-10-31：原ACK分区最后295／296的完整16-case证书、源域覆盖、全部局部等价与叶、新目录安全解包复查、1260输入／IR-export锚点及4项真实故障拒绝通过，见artifacts/ack-prefix-bounds。具名证据现368/368；原始完整target的合并证明、全父基及字节／时间／实现仍另行待证，旧主UNKNOWN未改。77专项本地与实际Ubuntu CI通过；13ff8c93的478完整回归终态通过，当前488组合未完整跑。下一步做具名目标的完整组合验收，并继续其他模型义务及全字节时序／实现桥，完整协议平台目标仍有效。

2026-10-31：cover v2实际Ubuntu CI41169349726／job124443724284／artifact13029694863通过84/84，18.208204秒、0失败／错误／跳过。官方原ZIP SHAa30fc2d7、source head f2acf9f9／checkout merge5299b9e8、完整decoded job gzip／unit日志及独立验收见artifacts/query-cover-ci-f2acf9f9；1274输入逐不可变Git blob核对，84 IDs与本地同。仅新证书专项，不计真实TCP目标已证、Linux TCP／PCAP、旧Mac协议证据重放或kernel。真实全368 cover v1因286旧tactic10s UNKNOWN失败保留，v2换同原source证书后已过286但整体仍在重放，未宣称命名原target关闭。当前495组合未跑，旧478完整回归和原368组件证据保持，完整协议平台目标继续。

2026-10-31：S-ACK-VALID→ESTABLISHED的原完整状态／长度保持query已通过fresh全368分支重放、无协议前提partition等价、原断言保留与Boolean组合、SAT非空上下文及IR/compiler输入前后锚点，见artifacts/ack-complete-cover。不同于此前仅组件索引，现闭合一个命名原target；其余模型／父基、全字节时序／实现及完整TCP仍未证。首次286旧tactic10s UNKNOWN及旧主报告保留；v2只引用同source的piecewise证书，旧包、模型、预算与oracle不动。84专项本地／Ubuntu、旧478冻结完整回归分别通过，当前495组合未完整跑，完整目标继续。
