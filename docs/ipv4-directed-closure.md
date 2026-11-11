# 有限 IPv4：定向关闭路径与选定规则保持检查

2026-11-10 在同一权威 IR 上补充验证，没有修改协议规则、既有 oracle 或生成 C。它是最小原型的后续实验，不是完整 TCP/IP 正确性证明。

## 实际执行

服务器 `.78` 的 0187、0190、0196、0200 四批实际验收了 **24 条默认初态路径、157 个转换**：重新从 IR 生成并编译 C，每条路径比较完整转换、输出与最终快照；24 份固定输入 Z3 查询均 SAT，见证经严格参考重放匹配。输入冻结在 [cases.json](../scenarios/ipv4-rule-coverage/cases.json)，预期快照来自模型，**不是独立 RFC／wire oracle**。

结合先前已验收记录，默认初态实际执行规则由 **71/335 提升到 102/335**，新增31条，包括未完成 ARP 解析时的数据／关闭路径，以及 LISTEN、SYN-SENT、FIN-WAIT、TIME-WAIT 的关闭／终止转换。仍有233条未观察到；这不证明它们不可达。见[逐规则矩阵](../artifacts/ipv4-directed-coverage-20261110/rule-matrix-102.json)和[累计记录](../artifacts/ipv4-directed-coverage-20261110/subset-delivery.json)。

原 flow 自身的探索10/335与这个跨已验收语料的累计102/335是不同统计。没有修改原探索结果，flow 总结论仍为 `unresolved`。

0196 中 DeepSeek 只提交受限 JSON 配方，不能提交可执行 Python：引用原冻结输入前缀、关闭／终止事件、最早实际计时器，或复用同一种子中的原字节并显式调整新路径的逻辑时刻。参考执行器决定全部协议状态。6条命中配方实际 C／Z3 通过，新增 CLOSING／LAST-ACK、缓存过期后终止等6条规则；其余8个目标仍未命中，不能宣称不可达。原字面量场景和 oracle 未改。

0200仅从已完成0198提案中去掉一个不属于请求目标的条目，原提案与拒绝保留；其余11条配方逐项原样选取，不改输入字节／协议／oracle，零额外API。另2条路径实际参考／C／固定Z3通过，补到缓存过期后的 ESTABLISHED／CLOSE-WAIT 关闭。

## 超出默认初态一步的检查

DeepSeek 提供选定规则的保持查询构造器；控制器补充固定目标拒绝条件并独立资格检查。对30条关闭／终止规则，任意满足全部65条声明不变量、类型及计时器约束的前态，通过**精确选定的已定义转换关系**，检查否定的后态不变量、计时器合法性及 action faults。全部使用完整 Seq(BV8)，不固定 `T.control`、缓冲内容或输入字节，不假设后态不变量。

实际结果为 **30 份保持查询 UNSAT，30 份非空性查询 SAT**，每查询保持原10000ms预算。它们只说明这30条已定义转换保持列出的合同；非空性不证明默认初态可达。没有包含其余305条、初态义务、所有 guard 冲突、wire 字节正确性、编译器或整个协议证明。调度／IR 编码／Z3 等可信组件仍需单独说明，不能把该结果覆盖到旧 BMC 的 `UNKNOWN`。

## 全部规则的后续观测

0194另305条规则的610份查询已结束。与先前30条合计：保持查询332UNSAT、3UNKNOWN；非空性161SAT、11UNSAT、163UNKNOWN。3个保持未知目标实际是 `T.D-ACK-FULL-STALE-WINDOW`、`T.D-ACK-PARTIAL-WINDOW`、`T.D-ACK-PARTIAL-STALE-WINDOW`。0201在相同原SMT和10000ms下使用既有精确预处理仍为UNKNOWN，原件不提升。

11个非空性UNSAT全部属于继承的 `T.WIRE-DROP-SHORT-*`。0199在不假设前态不变量、不包含动作／后态关系的更弱guard必要条件上再次得到11UNSAT；当前代码新进程重建查询逐字节一致。这证明它们在当前组合IR/profile的分派条件下被排除；不是已执行覆盖，不证明TCP规范不需要处理短段，也不能通过加强前提让UNSAT变为可满足。它们作为范围限制明确保留，不删除规则来提高覆盖率。

[完整原始包](../artifacts/ipv4-directed-coverage-20261110/formal-originals.tar.gz)有1624文件、SHA256 `0f982a061e50ffb7024dbe6cc0c0a43b51888e9d92e373788a2615dd9d49ddbb`，包含610查询／回执、11证书、旧审核器96KB预检零API拒绝及精简审查、配方拒绝／原样子集和3个保留UNKNOWN诊断。见[观测核对](../artifacts/ipv4-directed-coverage-20261110/formal-observation-audit.json)、[完整状态](../artifacts/ipv4-directed-coverage-20261110/formal-observations.json)、[2条路径审计](../artifacts/ipv4-directed-coverage-20261110/subset-readonly-audit.json)。本次未重跑求解器，未全量重新构造305份保持查询；不把原始回执的哈希一致等同于完整独立证明。

DeepSeek0197审查结构不符合要求，并混淆保持／非空性的未知目标。计数经原件核对正确；其增加超时、重跑已完成30条、加强前提修复非空性的建议未采纳。

## 审查与原件

[原始 TAR](../artifacts/ipv4-directed-coverage-20261110/originals.tar.gz)包含303个原文件，SHA256 `4db41c595e20eacd2f8d55971b0d942585537613c661a153cb3466b35f98aafe`。[只读审计](../artifacts/ipv4-directed-coverage-20261110/fresh-readonly-audit.json)核对所有成员、当前源码／IR／C、原 ELF／输入／stdout／快照、固定查询及见证。当前受审源码在独立新进程重建的60份保持／非空性查询与原件逐字节一致；没有重跑求解器或执行归档 Python／ELF。服务器执行回执的真实性是另一个信任前提，本轮没有新网络抓包。

[0196原始 TAR](../artifacts/ipv4-directed-coverage-20261110/recipe-originals.tar.gz)另保留77个原文件，SHA256 `3611d6268d142b72b869a19d7f25b331f6ca6970da8214bc297c63f8f6bed823`。[配方只读审计](../artifacts/ipv4-directed-coverage-20261110/recipe-readonly-audit.json)从冻结种子逐步重建6条输入路径，核对原字段、实际 IR 最早计时器、C原始输出及6份SAT见证。两个原始包和首次94规则交付记录均未覆盖。

生成 C 仍为 `19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b`；IR 仍为文件哈希 `7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5`。既有规范版本、条款和范围没有改变。

DeepSeek 最初的收集器源码没有通过审查：先复制解释器，后又有规则误计、跳过路径、未完成实现等问题，均未用于计数。控制器最终使用真实 `Machine` 的有限前缀收集器。原始 DeepSeek 测试中的导入／语法错误也保留；控制器独立正反例资格检查通过，不能把模型自评或坏测试当验收。

独立 DeepSeek 审查最初提出两项 blocking，在提供完整比较器和负例证据后撤回：保持查询应是“前提且否定后态性质”，不能把后态性质作为前提；实际 `codegen.execute.run` 已比较 C／参考转换和快照。其他意见仍保留：精确转换关系本来就是本次“已定义转换”命题的一部分；原文件／输入与查询绑定由只读审计补核，后续运行器在每次求解前后重查。没有按审查建议去假设结论或缩小输入域。

首个审计在混合进程重建报告时未能完全比较相等，原重建输出未保存，原因未确定；改用独立新进程后60份查询逐字节相同，不放宽哈希。第二个审计在所有源码／重放／查询检查通过后，被严格覆盖记录 API 拒绝额外 `target_rules` 元数据；最终只向统计器投递其规定的五个字段，目标命中检查和原记录均保留。这两次审计失败原件均在证据目录。

## 复现与后续

运行冻结24条路径对当前 IR／新生成 C 的回归：

```sh
.venv/bin/python -m unittest discover -s tests -p test_ipv4_rule_coverage.py -v
```

专用 CI 为 `Finite IPv4 directed rule paths`。24条服务器固定输入 SMT／结果在三个 TAR；此单元测试不声称重跑它们。

原0194／0195／0197／0198／0199／0200／0201均已终态，不重启。0202和0204在模型调用前分别被布尔简化器资格断言／上下文大小预检拒绝，零API；原失败保留在服务器。新0206采用实际布尔覆盖检查和紧凑原IR表达式候选交给DeepSeek选择，对3个ACK未知目标研究穷尽分解：0..16每个值加完整补集，共54叶，每叶10000ms。所有原字节／不变量／guard／转换关系保留；补集不能省略，原UNKNOWN不更名，只有完整全部叶UNSAT才能形成新的分解结论。额外叶预算与原单查询分开记录，不是假设输入落在0..16。0206已完成54叶，32UNSAT、22UNKNOWN、无SAT；其中完整ACK旧窗口规则的18叶全部UNSAT，两条partialACK仍未决。该新分解结果尚需单独原件／完整公式／补集审计，没有改写原UNKNOWN。后续0207仅针对两条partialACK，以完整原IR表达式摘要供DeepSeek选ACK距离，36叶继续保留补集与原公式，每叶10000ms。未验收的新结果不计入本次交付。

旧 TCP／ICMP `UNKNOWN`、lwIP2750ms及 Linux TCP Difference 保留。固定端点／MTU1500／TCP16字节缓冲与 SMSS4 等范围不变；服务器没有新增特权网络操作，没有自动合入 main，也没有重开定时任务。
