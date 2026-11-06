# GitHub 迁移与复现

当前活动 flow 原型的逐项验收与范围见 [spec-flow-acceptance.md](spec-flow-acceptance.md)，服务器／外部调用方入口见 [spec-flow-server.md](spec-flow-server.md)。下文保留此前更大 TCP 平台路线和历史检查点，不表示这些扩展已完成。

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


2026-11-01：用户授权agent后台运行、偶尔检查并节省token。新增固定JSON双角色建模作业控制器、UDP payload字节服务描述契约及3项离线正反门禁测试；最多两初始请求/两修正，共享原12请求台账，零自动失败重试，240秒验证/两小时作业界限。独立reviewer先产literal oracle并冻结，候选只能改IR，自动跑参考/生成C/固定输入Z3及depth3检查；UNKNOWN/超时保持unresolved，candidate_ready仍需控制器复核，不自动集成/合并。范围为payload跨层的前置描述切片，不冒称UDP线端。PR#9五条CI已实际success。后台进程实际启动与结果另按status/服务器回执记录，见docs/unattended-model-jobs.md。


2026-11-01：已实际启动服务器nohup受限双agent。首次udp-payload-0001因reviewer缺scenario版本/step时间元数据停止，原两请求成功共12591token，未丢原literal输出；审查器元数据规范化仅补0.2并从原单条trace拷贝时间、逐项记账、不改expected内容。修订d1b19c9d在新0002工作区复用两缓存响应（零重复付费），初始错误IR由工具诊断触发有界修正。已核实进程586075运行中，状态/日志及四小时稀疏本聊天巡检位置见docs/unattended-model-jobs.md。4离线门禁通过并加入离线CI；不宣称作业已验收或完整栈完成。


2026-11-01后台巡检：0002作业终态unresolved，六个原生场景和固定输入Z3匹配，但depth3 safety UNKNOWN/canceled、overlap UNSAT。控制器发现真实合同缺陷：接收规则缺uint16及bytes<=4096域条件，负端口被接收，超容量输入未排除；六个场景通过不足以验收。原始候选/ELF/SMT/UNKNOWN及拒绝审查在artifacts/udp-payload-agent-0002，未集成。共享台账八请求56821已知token（本轮三调用21210，修正输入缓存4224）。在原12上限内仅安排一次新修正，固定oracle不变，并新增九个恶意域探针。最新后台作业/home/blxu/protocol-flow/candidates/udp-payload-0003/status.json，控制器/home/blxu/protocol-flow/controllers/6efcc2e7/agents/repair_model_job.py，日志同控制器目录job.log，初始PID593317；以实际进程及状态为准，不自动重启。原UNKNOWN不改写，不为solver期限付费重试。


续：0003一次付费修正完成后因两处三元and被严格IR拒绝（Boolean type mismatch）；原候选保留，不自动付费重试。累计九调用66113已知token，预算仍12。控制器在新0004工作区仅把两处and(a,b,c)显式结合为and(and(a,b),c)，操作数/顺序不变，normalization.json绑定原模型SHA及两处路径；无API调用，不改原六场景。最新状态/home/blxu/protocol-flow/candidates/udp-payload-0004/status.json，日志controller.log，初始PID593635，原固定九域探针及参考/C/固定输入Z3/depth3门禁重新实际运行。此结构规范化不构成批准，仍待实际结果；0002 UNKNOWN保持。


巡检结果：0004固定验证实际通过，六原生场景/13字面量trace步骤、六独立固定输入Z3匹配、九非法接收域探针、depth3 safety及overlap均UNSAT。控制器已逐完整模型JSON核对仅两处and结构规范化、原场景SHA不变，重渲染C/重比较六原观测、六生成器输入对2a2fed2c不可变Git及SMT哈希一致；76原始文件在artifacts/udp-payload-agent-0004。零API本地核验，不执行归档Python/ELF/solver；旧0002 UNKNOWN单独保留。累计九调用66113已知token，原12上限不重置。候选有限切片门槛通过但尚未集成model/与十阶段flow，也不是UDP线端/PCAP或完整IPv4栈。下一检查点先固定源/场景/探索域/task并串行集成，再推进wire/跨层。0004进程已自然结束，不应重启已完成作业。


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


2026-11-03：ARP修正fixture后最终本地flow0002全部通过，119专项+6部署/13固定原生Z3均通过；282源码/599原文件与原Git只读复核在artifacts/arp-endpoint-local-5fce7f74。c39494a9六CI已实际全success（tested merge101701df与head同tree），新固定Linux release实际119方法/九task+verify/15TCPdata+101连接+13ARP原生固定Z3及9UDP TX观察全部通过。282源码/2761原文件在artifacts/arp-endpoint-linux-ci-c39494a9，artifact13210871706/run41592514105 SHA9df93dd0固定；只读原Git核282blob/九job/129原生diff/28原SMT-report及9旧UDP观测，不执行归档Python/ELF/solver。ARP64例/32literal/30gap/21规则/160prefix资源上限及depth3双UNSAT只为声明合同；无真实ARP peer/新Ethernet抓包/完整ARP或跨层。旧真实UDP里程碑保持。新PR15叠仍开PR14，本次证据提交后头须单独查CI不外推c394绿；server一次SSH仍timeout、原12API预算未重置零新增。下一步优先隔离TAP/Ethernet真实ARP peer，必须保持单个有状态生成C进程，禁止重放prefix冒充持续执行；当前C stdout在pipe下缓冲，建议stdin PIPE/stdout raw PTY通用I/O（或有源hash/回归的generic flush），时钟仅按公开native timers和monotonic机械推进，不藏ARP决策。随后ICMP与IR跨层组合；仍不自动main merge/不弱化oracle/hash/不改上游。


2026-11-03：codex/linux-arp-peer 新增隔离TAP双向真实ARP通道（尚待实际Linux执行），不改IR/后端/common语义。通用stdin PIPE/stdout raw PTY保持单生成C PID跨请求/回包/缓存命中，公开timer snapshot与monotonic驱动通用tick；双namespace active/passive分别验证主动解析/缓存命中与Linux发起请求/neighbor确认。原始帧不改写，不预置邻居或调ARP策略；独立immediate tcpdump、100ms quiet、stop后close、全字节/完整trace/PID/source/tool/hash验收。新增5专项实际通过全部13既有C场景、reset/输入/PID篡改/原子gap等，原8ARP专项通过。macOS preflight明确blocked非Linux证据，日志在artifacts/linux-arp-peer-local-preflight。新workflow待实际结果，不外推已有d972六CI全绿。server本轮唯一SSH为connection refused；12付费请求预算仍耗尽，零新增。随后真实ARP结果审查，再ICMP与IR跨层组合；无完整端点/物理Ethernet/无界证明声明。


2026-11-03：8fadeb00/tested merge b3b86925 整Git tree相同，PR16新隔离Linux ARP peer workflow run41621776194/job125869015485已实际success（仅该新workflow触发，不外推整仓CI）。生成C active PID2618持续解析/接收/缓存命中，passive PID2630持续接收Linux ARP请求/发回复；各初始化一次，不重启/replay。两namespace各2captured/2filter/0drop，quiet100.4107/101.299777ms>=100，内核neighbor确认、完整reference/native trace及所有TAP/PCAP字节通过。实际Linux7.0.0-1017-azure另跑5adapter+8既有ARP方法通过。原始68文件/61Git源bindings在artifacts/linux-arp-peer-8fadeb00，artifact13223608824 SHAe320b2b1固定；原Git只读audit核源码/tree/C/compile/ELF/单PID/clock/原raw帧/PCAP/neighbor/runtime证据通过，不运行归档Python/ELF/solver，CI真实性另需信任。无首次失败Linux运行需提升，本机Mac blocked证据保留。此是虚拟Ethernet有限ARP真实peer，不是physicalEthernet/live60s expiry/无界协议或编译器证明/单一组合IR/完整端点。PR16草稿叠仍开PR15，不自动merge；后续证据头CI单独查。下一步最小ICMP（固定规范、范围、独立oracle，再IR/参考/Z3/C/peer），再ARP/IPv4/UDP/TCP显式IR跨层；复杂0.3TCP native/时钟组合仍欠。付费预算原12/83412已耗尽零新增；server本轮唯一SSH connection refused不阻塞本地/临时Linux。


2026-11-03：64f89bbc ARP证据头新peer CI run41622291928已实际success，server本轮唯一SSH connection refused。新codex/icmp-echo有限raw IPv4 Echo responder（尚非完整ICMP）：固定.2→.1/IHL5/TOS0/DF1/MF0off0/TTL1..255/任意atomicID/MTU1500，type8/code0→type0/code0，输出TTL64/ID0，identifier/seq/全部data保留，IP/ICMP长度/checksum/drop策略全IR0.5。5规则/1状态，无新opcode/回调；RFC792官方原文已pin，1122§3.2.2.6/3.2.1.2与791/6864解释固定。13独立struct冻结literal含checksum0000（不套UDP映射）、FFFF/oddNUL/MTU/TTL/ID及四drop，10域gap；8新专项13参考/actualC/exact固定Z3通过，错误identifier但checksum/invariant仍过及错误zero映射均被oracle抓获，6部署检查通过。发现并修复Z3见证读取逐byte重复evaluate原序列的性能问题：只读已求值的Empty/Unit/Concat，无solver/约束修改，2新4096/empty/order检查通过；原中断堆栈/source/model保留artifacts/icmp-echo-witness-diagnostic，不追认重放/恢复丢失查询。icmp-echo immutable profile新增129方法/十task+verify/ICMP13+ARP13固定Z3及旧TCP/UDP回归，待实际flow/Linux执行，不先称通过；无ICMPpeer/capture/完整端点，下一步先实际验收再真实ICMP peer与IR跨层。原付费12/83412预算耗尽零新增、用户artifacts/旧UNKNOWN/Difference不变。


2026-11-03：d511f44f本地129专项+6部署、13actualC/固定Z3与28例/13literal十阶段verify通过，305Git源码/384原文件及原Git只读audit在artifacts/icmp-echo-local-d511f44f。原见证优化前后MTU固定输入SMT逐字相同/均SAT，新读取完成旧未完成，不称恢复旧query。首次Linux push run41655244028双job失败，flow271/release2253原文件及immutable305源保留artifacts/icmp-echo-linux-failed-d511f44f，artifact13240300193 SHA18636599与13239461318 SHA3a9b752e。Linux129方法与旧九task均过，但ICMPdepth2 safety UNKNOWN(canceled/10s)、overlapUNSAT；PRrun41655307938双job亦fail只保留元数据。原Mac与Linux all-input safety SMT已逐字相同比较，不能提升UNKNOWN。后续generic task formal可选solver_timeout_ms100..60000（旧默认10000），checker/report绑定，直接API同样严格校验；本ICMP显式60000/stage180，不改模型/深度/输入/不变量/oracle/SMT约束，非paid重试。新3见证/预算+8ICMP专项通过；更新后130方法/十task/Linux结果待实际，旧失败永久保留。原RFC792空白原样保留，后续优先实际Linux长预算结果，再真实ICMPpeer/IR跨层。


2026-11-03：b7ad7874/tested merge bd618fde整Git tree相同，新ICMP PRrun41656635390结果必须分开：immutable-release job125988583175实际success（130专项、十task+verify、15TCPdata+101连接+13ARP+13ICMP原生/41固定Z3、9UDP TX/六oracle）；direct job125988583447仍depth2 safety UNKNOWN(canceled/60000ms)、overlapUNSAT。两边SMT逐字相同，成功release的UNSAT不提升direct或旧10s UNKNOWN；不继续加时盲试。305Git源码/3147原release文件及271原direct文件在artifacts/icmp-echo-linux-budget-b7ad7874，artifact13240975612 SHA5920b1ef与13240366470 SHA2325ebcd。原Git只读audit核tree/源码/包/bootstrap/十job/142完整nativeDiff/41SMT原报告/旧UDP及pass-vs-unknown查询相同，不执行归档Python/ELF/solver。ICMP28例（5见证+13种子+10gap）、13literal/five规则，depth2 UNSAT仅output-size/dropempty合同，无全checksum/翻译/编译器证明。另本地130专项31.5s/新flow271原文件305source只读audit在artifacts/icmp-echo-budget-b7ad7874；profile ../icmp-echo-release-b7ad7874 已准备，server不可达未部署。PR17草稿叠仍开PR16，最终证据头CI需独立查，不把整体CI称绿。下一步精确查询简化/资源可重复性（不改oracle/模型/深度/域），同时可推进不依赖该UNKNOWN的有限真实ICMP peer，然后IR跨层；当前无ICMPpeer。原12/83412预算耗尽零新增、上游/旧证据/用户目录保留。


2026-11-04：父4501fdb8实际15workflow success，ICMP run41658060042两个job125993597518/125993598526仍fail，不覆盖旧UNKNOWN/b7 accepted release；本轮唯一SSH timeout。新codex/linux-icmp-peer准备真实iputils/Linux ICMP通道，模型/Protocol IR/后端及通用Session未改。隔离namespace先证明后TUN/link，生成C一个PID跨3请求(empty/odd5NUL/1472)，原始bytes双向不改写；iputils -4 -M do是明确atomic测试刺激，不调sysctl/强制TTL或ID/绕PMTU。每peer interval3600s在quiet期间存活，先停immediate无packetcap抓包，再signalpeer/closeC/TUN；100ms完整quiet/6包0drop/peer统计与独立完整Echo oracle/C-reference/rawPCAP/固定actual-inputZ3 witness/hash验收，oracle仅活交换结束后构建。7新专项+8旧ICMP方法本机通过，Mac预检blocked与首个harness missing expect错误保留artifacts/linux-icmp-peer-local-preflight；尚待实际Linux CI，不先称互通/完整ICMP或新证明。下一步核实际job，保留任何失败，仍并行保留查询资源可重复性缺口；全部paid预算原12/83412已尽，零新增。


2026-11-04：a3da1393/tested merge7435b620整Git tree相同，新PR18 peer run41732726799/job126253958385真实隔离Linux7.0.0-1017-azure实际success。生成C PID2809一次初始化+三原始net.packet连续操作，iputils/Linux empty/odd5NUL/1472三Echo均1sent/1received0loss；原C输出/TUN/request/reply/独立PCAP全字节及oracle/reference/Difference一致。6captured/6filter/0drop，quiet100.093978ms>=100，capture停止先于peer signal/C/TUN关闭；无重放/包改写/sysctl策略更改/PMTU绕过/强制ID或TTL。实际三步peer输入一份独立fixed-input Z3 query/result/witness SAT+replay match（非三份all-input proof），64Git source/52原文件及原Git只读audit在artifacts/linux-icmp-peer-a3da1393，artifact13276164688 SHA36aad81c固定。audit核source/tree/C/compile/ELF/PID/clock/peer lifecycle/raw/PCAP/reference及SMT/witness，不执行归档Python/ELF/solver，CI真实性仍单独信任。7adapter+8旧ICMP方法实际Linux过，Mac预检与首个harness missing expect错误保留；下载临时URL403后新URL取得同hash，无重启job。此为虚拟TUN有限Echo真实互通，不是physicalEthernet/完整ICMP错误与client/跨层组合/完整端点或编译器证明；父4501ICMP双fail、direct60s UNKNOWN及b7独立release UNSAT保持。下一步精确查询资源可重复性与最小Ethernet/IPv4/ARP/UDP/ICMP显式IR组合（先固定范围/规范/独立oracle，单调序号/计时语义不分叉），复杂TCP0.3 native仍欠；不可用adapter调度冒充组合IR。新证据头CI需独立查，不外推a3绿。server本轮仅一次SSH timeout，原12/83412 paid预算未变零新增，不自动main合并。


2026-11-04: codex/arp-udp-compose adds the first explicit cross-layer slice. model/arp-udp-transmit.json inherits unchanged ARP and expands to ONE30-rule EFSM owning UDP/IP construction, latest pending packet, ARP/cache/retry timers and Ethernet output. No protocol_lab/backend/opcode change or multi-model runtime dispatch. Twelve UDP set ASTs/guard and inherited ARP action prefixes are regression-anchored to original components. Two PENDING local receptions and QUERY-FAIL split into disjoint QUEUED/UNQUEUED rules. RFC1122 section2.3.2.2 latest queue, official RFC894 and verified erratum570 are pinned; original source whitespace is preserved. Checksum policy freezes at acceptance, replacement preserves query deadlines/retry budget, timers precede same-time sends, and Ethernet padding is excluded from IP/UDP checksums/lengths. Seventeen independent frozen scenarios (51literal steps) plus thirteen original ARP (32literal) pass reference/actualC/exact fixed-inputZ3. Nine new methods + eight oldARP + eight oldUDP methods pass, including lost-latest and valid-IP-checksum wrong-MAC faults. Compact exploration covers30rules/33gaps within600prefixes, with resource cutoff, not exhaustive behavior. Rejected emit_if draft and raw-IP-as-Ethernet oracle failure retained in artifacts/arp-udp-compose-validation-diagnostic; model fixed without relaxing oracle/backend. Full ten-stage/Linux evidence pending execution after immutable commit, no live composed peer/full-endpoint claim. Server sole SSH check refused; original12/83412 paid budget exhausted, zero new calls. Preserve user artifacts/old UNKNOWN/2750ms differences; no main merge/upstream changes.


2026-11-04: Originalf4417ab1/mergec3d8af4b Linux run41746259405 native job126299910997 passes25 methods/30native-fixedZ3 cases; flow126299910721 retains depth3 safety UNKNOWN/overlapUNSAT (nine other stages pass93cases/80 literal-contract input steps/30rules/33gaps).694flow+259native files/94Git bindings and original-Git read-only audit in artifacts/arp-udp-bmc-linux-f4417ab1; local raw BMC/native30 archived in arp-udp-local-f4417ab1, no passed-flow claim. New generic protocol_lab.sequence_induction explicitly supports full SeqBV8 IR0.4/0.5 atomic-v1/nonterminal contracts, no length projection/reference callback/poststate assumptions. Initial validity/nonemptiness,30 arbitrary-legal-prestate preservation+30 nonvacuity and4 overlap obligations pass (66queries). Schema task-v4 explicitly selects sequence-invariant-induction (no silently ignored BMC depth); schemas1..3 keep old BMC and reject strategy field. Distinct inductive_invariants_pass is verifier-bound, never renamed bounded_pass or old UNKNOWN. Legal scheduler/translation/Z3 trusted; theorem only listed invariants/defined transitions, not wire/coverage/compiler/whole protocol.7 checker methods include initial/uncleared-queue SAT obligations, forced UNKNOWN/missing-rule/scope/unsupported rejection and actual v4 ten-stage plus fully rehashed UNKNOWN promotion rejection.146 regression methods pass. First initialization-only trial UNKNOWN/raw script retained in arp-udp-proof-development without unavailable old source reproducibility claim; exact padding removes irrelevant future-event search, not protocol preservation inputs. New frozen-source flow/Linux execution pending commit, old unknown data/guards/oracle unchanged. No new API calls or server changes.


2026-11-04: f14fdac1/tested mergeb3465ea0 exact complete Git tree matches; Linux run41748821541 BOTH new jobs pass:126308497001 native25+7=32 methods/30 fixed native-Z3 cases and126308497801 ten-stage v4flow/verify.97Git bindings/762flow+260native originals in artifacts/arp-udp-v4-linux-f14fdac1 (artifact13284987284 SHAc3fa49f8,13285790868 SHA0d455522). Original-Git read-only audit validates93cases/80literal-contract inputs (83expected rows)/30rules/33gaps/600prefix cutoff,30native fullDiff/30SMT reports/18IPv4 Ethernet frames and66 full-sequence invariant obligations. Initial validity+30preservation+4overlap UNSAT; initial and30rule nonvacuity SAT. No length projection/concrete payload safety restriction/reference callback/assumed poststate. Distinct v4 induction claim covers ONLY listed legal-transition invariants, not wire/coverage/compiler/full protocol. Old depth3 BMC UNKNOWN remains unchanged; modelsemantic hash and generated C byte-identical across strategies (C SHAe2f7f2ea...). No archive code/ELF/solver execution/new Linux claim in audit; CI provenance separately trusted. Local f14 passed flow retained in arp-udp-v4-local-f14fdac1. Afterward generic checker persists query BEFORE solve and refuses nonempty output reuse;8 targeted methods including interrupted-no-passed-report pass,146 broader regression methods had passed before this I/O-only change. Later head must get its own CI; do not extrapolate f14 greens. Next real composed TAP peer and IPv4/UDP/ICMP ingress, then TCP native/timing work; no composed network/complete endpoint proof. Server sole SSH refused, no paid calls (12/83412 exhausted), no main merge/upstream/oracle/hash weakening/user-artifact changes.


2026-11-05: User stopped scheduled polling; leave it stopped. Reviewed open stacked PRs #7–#19 and fetched remote main939ff487 (#1–#6 already merged). Latest-head returned checks on #7–#16 all succeed; recommend staged bottom-up integration with each base retargeted/rechecked, no automatic merge. #17–#19 remain held: d2abad5c composition workflow41749928742 succeeds, but inherited ICMP workflow41749928642 splits passing immutable-release126312207870 and failed direct126312208220. Snapshot and bounded review in artifacts/pr-review-2026-11-05 and docs/pr-integration-review.md; no exhaustive audit or fresh full regression claimed.

New codex/arp-udp-peer prepares one continuous generated-C process for cold app.send→IR ARP→unchanged kernel reply→IR pending UDP Ethernet flush→recv-only independent Linux socket, followed by cached empty/oddNUL/1472 sends. Adapter is only raw TAP transport/public-clock advancement, no host subject stack/packet rewriting/queue/MAC protocol decisions. New local5 adapter checks exercise actual live C plus synthetic mixed PCAP and negative controls; these are NOT Linux evidence. Real isolated Linux workflow pending. Supplementary flows/icmp-echo-inductive.json uses unchanged model/oracle/seeds/exploration with explicit v4 strategy, default10s/query; local4 methods and fresh ten-stage/verify pass,13 obligations (initial2,5preserve+5nonvacuity,1overlap). Only two listed reply-bound/drop-empty invariants; old60s BMC UNKNOWN/report/task remain unchanged. No core/backend/model edits in this milestone. Paid DeepSeek budget remains exhausted12 requests/83412 known tokens; only local child agents were used. Sole server SSH check timed out; no server deployment/global network changes. No automatic main merge, no upstream/oracle/hash changes; both user artifact directories preserved.


2026-11-05 accepted composed-network checkpoint: source5755f715/tested merge224a394a complete trees match. PR20 run42014504643/job127201517338 actual isolated Linux7.0.0-1017-azure succeeds: one generated-C PID2960 cold app.send→ARP request→unchanged kernel reply→IR pending queue flush→Linux recv-only UDP socket; cached empty/oddNUL/1472 follow, four exact deliveries and6captured/6filter/0drop, quiet100.0847ms>=100. Capture stops before C/peer/TAP close. Actual5-input-step fixed Z3 query SAT+reference replay; not five all-input proofs. Supplementary ICMP13 obligations/ten-stage also pass. Original330 files/121 immutable Git bindings in artifacts/linux-arp-udp-peer-5755f715, artifact13407873966 SHA05d5000a; original-Git read-only audit reconstructs peer/runtime and ICMP full flow without executing archive Python/ELF/solver. CI provenance separately trusted. This is FIRST real single-IR composed outbound ARP+IPv4/UDP, still not ingress/TCP/physicalEthernet/full endpoint. No server deployment or paid requests. Related42 local methods passed75.095s; final lifecycle change separately rechecked five methods1.667s.


2026-11-05 finite ingress composition: new model/ipv4-udp-icmp-endpoint.json is ONE63-rule IR0.5 EFSM extending the unchanged30-rule ARP/UDP TX model. Namespaced UDP RX and ICMP Echo guards/actions own all Ethernet bounds, IP/UDP/ICMP lengths/checksums/policy/output; EMPTY/PENDING/RESOLVED receive without changing unrelated pending TX/cache. Independent struct oracle SHA5c05de68 was frozen first and stayed unchanged; model SHA68e3da05 also unchanged across failed/successful native lowering. Ten new methods passed12.554s: nine literal reference/fixed-input Z3/actual C scenarios,30 atomic gaps,17 previous scenarios and native/reference byte faults. No new full-input theorem/ten-stage flow or live ingress peer yet. Canonical input Ethernet frame max(60,14+IPtotal), arbitrary ignored padding, output zero padding; fixedlink/tuple/UDP TTL64, EchoTTL1..255, no TCP/generalhost.

The first native executable SIGSEGV was a real generator resource failure (fire static frame12986128 bytes), not accepted as a model Difference. Original failure and smaller-AST failed trial retain121 files in artifacts/ipv4-endpoint-native-stack-diagnostic. Generic per-rule guard/action helper lowering fixes cumulative stack use without changing IR/ABI/runtime/buildflags/ulimit: local fire96/maxguard482272/maxaction382336/main1038736 bytes. Five new generic fault/atomicity/frame methods and50 old related methods pass; nine frozen native cases pass.119 raw local files in artifacts/ipv4-endpoint-local-helpers, not Linux evidence. New dedicated Linux native workflow retains9endpoint/17legacycompose/13ARP/15fixedZ3TCPdata/101connection cases and stack observations; actual CI pending new source commit. Backend v4 byte semantics remain, changed generator hashes bind new C and old evidence still uses original Git. Upcoming TAP entry profile will explicitly distinguish prephysical-padding frames; no adapter byte rewriting, canonical model/oracle unchanged.


2026-11-05 explicit virtual-TAP ingress profile: model/ipv4-udp-icmp-tap.json derives from unchanged canonical63-rule model. Only30 ingress Ethernet envelopes admit exact14+IPtotal OR canonical max(60,14+IPtotal); partial padding remains gap, no adapter padding/stripping/repair. Official Linuxv6.12 tuntap.rst source is pinned for virtual interface role, not a claim the document mandates padding behavior or matches the runner kernel. Six profile methods pass9.739s:11reference/native/fixedZ3 cases,18native+18reference atomic gaps, exact envelope-only amendment, originalcanonical4unpadded gaps/9cases unchanged.199 original local files in artifacts/ipv4-tap-local-profile; original test harness reason/failure KeyError retained separately from actual protocol failures.

New ports/linux-ipv4-endpoint-peer runs ONE generated-C PID for ARP,4UDP echo roundtrips(empty/odd/MTU included) and3iputils Echo;16selected frames/12continuous inputs are strict acceptance, not yet actual Linux results. Peer socket uses ordinary sendto; model policies remain IR; all original frames including42-byte UDP packets enter unchanged. Linux interface checksum offloads explicitly configured only inside proven newnamespace; no TTL/ID/PMTU policy rewrite. Six adapter methods using real C/synthetic captures and one actual fixed12-input Z3 query pass, plus strong pinned-source checks. New workflow will execute isolated Linux and retain failures/raw capture/runtime hashes; live ingress success is PENDING at this source checkpoint. Paid budget still12/83412 exhausted, automation stopped, no main merge/server deployment.


2026-11-05 TCP wire prerequisite: IR0.6 adds pure bytes_pack32be_mod(int)->4big-endian octets of n mod2^32. Reference arbitraryInt modulo, independent Z3 Int2BV32/Extract/Unit/Concat and C uint32_t unsigned shifts agree on frozen vectors; no protocol callback or uint32 field validation is hidden in packing. Old IR versions/unknown operators reject;0.6 length projection and unextended sequence induction explicitly reject. Same native v4 ABI, new source/model/hash epoch; per-rule helpers preserved, old evidence never rehashed. Eight new methods plus old8wire/7read pass,1024 octet-position and signed64 endpoints actually execute C. Ordinary new word32 ten-stage+verify passes (10literal seeds+1witness), not TCP implementation. New dedicated Linux workflow pending.

Original arbitraryInt monolithic div/mod query UNKNOWN/10s stays in artifacts/word32-arithmetic-diagnostics. Separate exact positions/Int2BV-modulo/weighted-concat obligations are UNSAT and freshcontext reloaded UNSAT with no fixed inputs/prestate assumptions; original7source/query hashes were actually checked. This is an arithmetic representation bridge, not compiler/protocol proof or promotion of old UNKNOWN. Native clock/rational/post-target support still unimplemented. Next TCP raw wire model reuses original tcp-data seq/timer rules with explicit IPv4/TCP bytes, not host stack; candidate validation ongoing, not yet completed.


2026-11-06 user steering: stop using GPT child agents for implementation; use server DeepSeek agents on blxu@192.168.71.78. Server reachable with existing project/key/ledger, no old model controller running. User explicitly lifted original paid-call budget restriction; preserve all12/83412 old entries and use bounded jobs against SAME ledger, operational cap64/no failed-or-uncertain auto retries. First server job tcp-handoff-20261106-0001 PID83162 actually passed7 TCP wire draft tests/11 native-fixedZ3 paths72.971s; two DeepSeek roles consumed8401 reported tokens, ledger14/91813. Draft provenance remains previous local work, not falsely DeepSeek-authored. Suggestions remain unapproved: wrong old-model fixture association and MSS direction misunderstanding require correction. Second server CI repair job ci-paths-20261106-0002 PID84164 launched: exact two approved workflow path associations only, then actual15data fixedZ3+101connection native suites. No provider Python/shell execution, no Git merge, no automation restart; credentials stay private. See docs/server-deepseek-handoff.md.

PR review correction: workflow helper omitted push checks. #7 now merged; #8 has failed receive job124784462166 (quiet observation too short; invalid capture). Do NOT follow earlier incomplete-green recommendation to bulk merge#8–#16; their dependency/base checks must resolve. #17/#19 ICMP formal failures remain. #20 latest a091 job127213432338 passes9endpoint/17compose/13ARP then rejects missing scenarios/tcp-data (0TCP cases); scenarios/data15 andscenarios/connection101 are intended. No merge performed. Server no sudo-n/network-userns at check, only privileged live-network channel blocked; native/reference/Z3 continues. Both user untracked artifact directories preserved.


2026-11-06 actual DeepSeek server CI repair: ci-paths-20261106-0002 PID84164 completed proposal+independent review, exact two workflow path fixes and ALL15data native/fixedZ3+101connection native gates. Originalrun/launch/controller/source/ELF/trace/query/APIusage receipts in artifacts/server-deepseek-ci-20261106, TAR SHA f68dc2b5; local control checked archiveSHA/exact two YAML changes/suitecounts without archive execution. First real CI failure remains artifacts/pr20-missing-scenarios-a0915d79 ZIP SHA80777329 (0TCP cases). Applied only scenarios/tcp-data→scenarios/data andtcp-connection→connection locally; newGitHubCI pending commit, no merge. Shared ledger now16requests/95053 known tokens; no reset. Next server DeepSeek implementer/reviewer job ipv4-compose-20261106-0003 PID85116 started to produce offline singleIR composition builder proposals forTCP+existingARP/UDP/ICMP. Provider Python remains unexecuted pending controller review; no completion claim, no GPT child agents, no scheduling restart.


2026-11-06 continuation on server only: DeepSeek composition job0003 completed code proposal and independent review; reviewer found six blocking defects (unmaintained ARP state, invalid flat state mapping, incomplete raw ingress mapping/bounds, missing queue kind, wrong failure path and Ethernet addresses). Rejected; no provider code executed or integrated. New server job /home/blxu/protocol-flow/candidates/ipv4-compose-20261106-0004 PID85459 uses completed-proposal findings for at most3 implementer/reviewer repair rounds (same ledger, no failed/uncertain API retry, no code execution/main merge). Status/logs remain server-side. CI path repair2c4514a9 is pushed; new GitHub result pending, old red evidence unchanged. Do not say full prototype finished or re-enable scheduling.


2026-11-06 latest server state: whole-composition repair0004 stopped on a provider-completed but truncated8192-token output (invalid_response, counted as paid request19); no automatic identical/uncertain retry and no proposed code executed. Preserve its raw ledger/provider record. Controller decomposed scope into new independent ir-namespace-20261106-0005: pure offline component namespace transform only, <=160source lines, implementer/reviewer max3completed-proposal rounds; other state/queue/Ethernet coupling remains future work. Same server/shared ledger, DeepSeek only. No claim of complete prototype or successful composition.


2026-11-06 server progress correction: bounded jobs stop at failed/review gates;
they are not continuously running between checks. Actual latest pre-change PR20
43c9dec check-runs:28success/1failure (ICMP immutable-release127817430850;
direct ICMP127817430999 and repaired endpoint regression succeeded). No merge.
DeepSeek pure namespace source from ir-namespace-actual-20261106-0007 is now
integrated under protocol_lab/compose, SHAa691671c. Its reviewer invalidJSON/job
failure is retained separately from zero-API controller acceptance: exact1/63/172
rule transforms,32frozen scenarios and3native cases. OriginalTAR SHA02b7c15e
and result in artifacts/server-namespace-20261106. Only a preexisting unaccepted
TCP draft was used in the third gate, not live TCP or completed prototype.
Six namespace/source-gate plus three prior controller tests pass locally; new
small CI pending. Fixed source gate executes precisely its parsed AST, forbids
IO/introspection; it is a restricted capability gate, not a general Python sandbox.
0006 initially lacked fixtures (controller environment error), then rejected a
real arm.delay_ms bug after zero-API fixture correction. Fixture counts now checked
before billing. state-lowering0008 failed three actual code gates (cancel string
misread as dict); new0009 repairs that completed proposal with exact cancel/state
examples, same ledger/DeepSeek only, maximum3bounded rounds and actual gate before
review. No failed/uncertain API retry, GPT child agents, automatic main merge or
scheduler restart. Next integrate accepted state lowering then explicit TCP/ARP
queue/framing composition; privileged server networking remains unavailable.


2026-11-06: server DeepSeek state-lowering-repair0009/PID95698 completed first
round: exact1/63/172rule AST,32frozen scenarios,3actualC and independent advisory
review passed. Accepted source SHA b5f51892 in protocol_lab/compose; raw archive
SHAc7d00f4d in artifacts/server-state-lowering-20261106. Two new local rejection/
state-predicate/cancel/timer-delay tests pass. No whole-stack/compiler proof.
Next server component-union0010/PID96065 started a pure disjoint union builder
proposal, bounded3rounds; it does not implement packet dispatch or queue/framing,
and source remains unexecuted pending external acceptance. Original UNKNOWN/
Differences remain. Namespace milestone d6ba0a92 pushed toPR20; its new CI must
be checked independently. No main merge or scheduler restart.


2026-11-06 PR8 actually repaired: original cc70a74d failed job124784462166 now
has fast-forward backport d5863163 on codex/server-deployment.16 boundary checks
pass and NEW head9CI checks all success incl handshake/loss/receive Linux jobs.
Original invalid ZIP SHAaa24089f retained in the separate PR8 branch, not promoted;
no model/oracle/hash relaxation. PR8 still targets codex/spec-flow-c99, not main;
GitHub main versusPR8 is diverged(14ahead/1behind at check). No bulk/main merge.
PR20 source3d04899b had53/55success, both failures ICMP immutable-release; direct
native/formal passed. Neither old UNKNOWN nor this failure is silently removed.
Server blxu@192.168.71.78 reachable, sudo-n still requires password; privileged
server netns lane blocked, generated/reference/C/Z3 and hosted Linux continue.
DeepSeek0013 pure disjoint union accepted under actual32frozen/3native/7negative
and legal-string counterexample gates, advisory reviewer empty. Source SHAf1a3b780
integrated protocol_lab/compose/disjoint_union.py; rawTAR809261ba includes previous
0011 rejected broad string scanner and actual executedchecker. Two new independent
literal/native and rejection tests pass. This is offline interleaving, NOT TCP/ARP
packet/queue composition or completed prototype. No GPT child agents used.
TCPexchange0014 source failed artificial237line/220gate, completed API unchanged;
root found real ABI/timer/sending/drain defects (never executed). New0015 asks
DeepSeek implementer+reviewer to repair those concrete errors, without a paid API
retry, packet mutation or forced peer policy; no live TCP success yet. Both user
untracked artifact directories remain untouched. Scheduling remains stopped.


2026-11-06 latest server handoff: tcp-peer-exchange-evidence0016 completed
DeepSeek implementation + advisory review(blockingfalse), new source UNEXECUTED.
Original0015 had real scene.steps/steps alias doubleappend;0016 fixes it, tickABI,
integerdeadline checks, receipts/TUNwritecount and explicit pendingTIME-WAIT.
Independent testauthor0017 delivered .py+LIMITATIONS.md and failed onefilegate;
its tests never invoke run_exchange and invented ABI/packet/timer shapes, rejected
rather than calling test-count a success. Completed API retained, no paidretry.
New gateway supports explicit thinking+reasoning_effort while preserving DEFAULT
payload/hash behavior and original max8192tokens/64requests/ledger/no-retry gates.
Official thinking docs: https://api-docs.deepseek.com/guides/thinking_mode/ .
8 deployment/gateway methods pass, including cache separation bythinking mode and
unchanged ledger preservation. Auto-review rejected proposals to raise64->128 and
8192->32768; both limits remain unchanged, explicit user clarification pending.
New server controller tcp-reasoning-bounded-v1/run_tcp_driver_review.py and job
candidates/tcp-peer-reasoning-bounded-20261106-0018 PID104649 launch DeepSeek
independent-test-author/adversarial-reviewer withthinking enabled/low (8192/64),
plus fixed original7TCP wire baseline in parallel. New code proposals NEVER run
automatically. Do not call old stopped0014..17 running or claim liveTCP success.
PR8 d5863163 fresh9checks success, still stackedbasefeaturebranch, no mainmerge.
PR20 acceptedunion head3ae6dd3b pushed; its CI needs own check. Userdirectories
and scheduler stoppedstate preserved. Server sudo-n still unavailable; only that
privileged networking lane blocked, hostedLinux remains available.


2026-11-06 explicit user budget update: user answered the approval question with
“不设置任何上限，随便用”. New jobs use max_calls=None in the SAME original ledger;
no ledger reset, replacement or automatic failed/uncertain retry. Gateway optional
uncapped cumulative mode preserves prior bounded callers/default payload/cache.
Per-response32768 is a current technical setting, not a lifetime spend cap; it can
be adjusted per task. The old proposed8192/64->larger deployment rejections are
historical, not a current permission block after explicit authorization.
Original0018 fixed TCP baseline passed, both reasoningAPI requests exhausted8192
finish_reason=length (one blankfinal); invalid_response preserved, never promoted.
New candidate tcp-peer-acceptance-20261106-0019 PID105373/controller
tcp-reasoning-authorized-v2 runs independent testauthor+adversarial reviewer with
thinking enabled/high and32768 response space, no GPT childagents. This is an
explicitly operator-authorized NEW acceptance task with actualABI/failure context,
not an automatic retry of old request digests. Unchanged prior baseline source
hashes rechecked and passedreceipt reused, not falsely called a fresh test run.
New Python proposals remain unexecuted until controller review and actual tests.
9 gateway/deployment tests pass locally including uncapped original-ledger retention;
old failed-request protection remains active. No mainmerge/scheduler restart or
liveTCP/completeprototype claim. Server sudo/network lane limitation unchanged.
