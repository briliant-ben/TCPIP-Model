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
