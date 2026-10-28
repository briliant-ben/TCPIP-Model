# Anthropic / Theorem 形式验证研究：项目适用性初评

调研日期：2026-10-25。此文是方向评估，未安装或运行外部证明流水线，未独立复验发布的 Rocq 证明，也未把研究结果作为本项目通过证据。未改变 Protocol IR 的权威地位或当前执行路线。

## 核实的结果与边界

Anthropic 2026-10-22 的文章报告 123 个库、239 个 OSS-Fuzz 入口、约 1.8 亿行 Rocq 证明。证明目标绑定特定编译产物和性质，主实验采用静态、单线程 RISC-V Linux 二进制，带输入大小和内存/操作系统语义假设。不能由此推出全部库/API/平台正确。

附录把错误自由与 ASan/普通二进制的观测行为对应分开表述；公开发布的 statements 又区分 halts、agreement、内存预算及允许的系统调用失败。行为等价本身不保证终止，具体命题和前提必须逐项读取。公开仓库当前 README 列出 25 个库、60 个入口，是文章所述结果的公开子集，不是全部 239 个入口的本地复现。

核心机制是模型提出证明、独立检查器验收：公开 checker 固定二进制哈希和 statement，编译 Rocq proof term，再审计 Print Assumptions；证明不能自行修改被证明的命题。CI 的检查工具和常规 statement 来自 PR 的 base branch。它还明确限制未批准公理/Admitted。基础 ISA/OS 语义与实际部署的对应关系仍属于可信边界。

LPS 的 SCOPE 明确列出线程、信号、地址空间、文件、网络和内存预算等限制，并指出语义内部一致不等于与真实 Linux 一致。因而其 Linux 进程模型不是 Linux TCP 内核或网络环境已经正确的证明。

## 对本项目的判断

保持 RFC → Protocol IR → 参考执行/形式后端 → 独立实现 → PCAP/Difference/追溯的主线。补充可由较小可信检查器验收的证明产物，以及 IR 与执行/实现之间的对应关系；无需把项目改成二进制安全扫描或生产网络栈。

本项目已有 Z3 BMC、长度/标量状态归纳、完整字节固定输入重放和证据哈希。这些分别回答不同问题。当前提交基线为 44262ba；ACK/window 组合改动尚在工作区，不能把针对性测试当作新的全量已提交验收。

最重要的现有缺口：

1. **命题/规范。** 无崩溃不等于 TCP 正确；同长度错误字节、提前 ACK、错误重传期限可以保持内存/长度状态安全。需要独立明确的内容、输出、时序和服务契约，逐项关联 RFC 与 profile 选择。
2. **解释/翻译。** Z3 unsat 和独立重放不等于已证明 Python 解释器或 IR→SMT 翻译正确。应形式化小而通用的 IR AST/操作语义，并列明 JSON 解析、翻译、求解器等剩余可信组件。
3. **实现。** 模型不变量通过不能自动转为 lwIP/Linux 满足 IR；实机轨迹匹配也不是所有实现执行的精化证明。独立实现测试继续保留，并逐步增加实现到模型的观测/服务对应。
4. **检查器。** 哈希证明内容绑定，不证明命题成立。后续 proof manifest 应记录定理、前提、checker/语义版本、输入和步数界、未覆盖项、模型/产物哈希及检查日志；检查器与命题的修改需要独立审查，不能靠同时改 oracle 和目标来通过。

## 建议的增量顺序

- 保留 Z3 的快速反例、BMC 与归纳路径及其真实 unknown 结果。
- 先试验一个小型 Rocq 证书后端：从 seq32 运算、字节切片/拼接/值语义、一步原子执行和定时器顺序中选小范围，给出精确命题并机器检查。协议规则仍由 IR 提供；验证语义/翻译关系，不维护第二套手写 TCP 规范。
- 接着验证一项实际内容/输出性质，例如重组后的连续前缀与首次接受的字节逐字节一致，或非法 ACK 不删除发送队列。状态长度证书不替代这些性质。
- 再选择一个现有或自然可拆出的纯 C 入口作实现层试点，给 fuzz/property harness 加明确断言，探索 RISC-V 二进制证明。Python 平台不为使用该工具而整体重写；也不把 RISC-V 产物的结论自动推广到当前 macOS/ARM 编译产物。
- 保留 PCAP、Linux/lwIP 观测、配置差异和故障变体，用它们检查形式语义与真实环境之间的关系。现有 2750ms 重传差异仍按配置/时钟问题分析，不因另一层证明通过而消失。

这是“增加证明层和精化层”，而不是更换项目目标。尚未决定采用 Rocq 为必须依赖，未提交 OSS Verify 报名，未联系外部维护者。

## 一手来源

- [Anthropic 原文](https://www.anthropic.com/research/formal-verification)
- [技术附录](https://www-cdn.anthropic.com/files/4zrzovbb/website/6867eadf760258fa8b42a504600cd3c036d16358.pdf)
- [公开证明及覆盖范围](https://github.com/theorem-labs/oss-verify-proofs)
- [具体命题与预算/失败假设](https://github.com/theorem-labs/oss-verify-proofs/blob/main/docs/statements.md)
- [检查流程、命题固定及公理审计](https://github.com/theorem-labs/oss-verify-proofs/blob/main/docs/checking.md)
- [LPS 范围与未检查假设](https://github.com/theorem-labs/rocq-linux-process-semantics/blob/main/SCOPE.md)
- [OSS Verify 接入条件](https://github.com/theorem-labs/oss-verify)

网页与 main 分支可能变更；这些链接用于本次技术评估，不是本项目已锁定或已验收的第三方依赖。
