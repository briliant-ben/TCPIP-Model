# Historical presentation copy

Use the current English guide at `docs/ipv4-prototype-delivery.md`.

# 最小 IPv4 TCP/IP 原型交付

2026-11-12，按此前固定的[有限原型验收合同](../ipv4-prototype-acceptance.md)，最小可运行原型已交付。入口为[机器可读汇总](../../artifacts/ipv4-prototype-delivery-20261112/summary.json)。协议模型、C生成、测试和证据都保留在本仓库；后续通用 Agent 框架属于独立的 `Formal-Spec-Agent` 仓库，本次未开始拆分。

## 能做什么

唯一权威 IR 是 `model/ipv4-endpoint-virtual-link.json`。规范来源、协议状态、缓冲、计时器、guard、action 和字节布局均显式存在于 IR；生成器输出独立 C99 程序，Linux 协议栈只作为独立测试对端。

同一个生成 C 进程已完成 ARP 解析、TCP 建连／四字节双向传输／主动关闭至 TIME-WAIT、UDP 三种长度往返、ICMP Echo 三种长度往返。25包独立抓包、零丢包，原始字节、校验和、进程生命周期、19步参考／C／固定输入 Z3 对应检查通过。这是此前保留的隔离 Linux 虚拟 Ethernet 观测，本轮没有重测网络或物理网卡。

完整流程已打通：规范绑定 → IR → 参考执行／独立 Z3 → 测试生成 → IR生成独立C → peer／PCAP／轨迹 → Difference／规范追溯。见[实际19步与25包可视化](../../artifacts/ipv4-prototype-final-9289/review.html)。

## 本次收尾核对

- 用原 Git `bcf0ce25` 中与保留输入逐文件匹配的形式／流程检查器，重新验收原77例交付证据：初始化一步563项否定查询UNSAT、1个SAT见证严格重放；有限交付仍通过。当前工具拒绝旧源码集合时，使用原Git版本核对，未修改旧哈希／结果，也未执行归档Python／ELF或重新求解旧SMT。当前汇总工具单独绑定版本。
- 当前源码重新从 IR 生成并编译 C，冻结24条默认初态补充路径完整比较通过，77.180秒。累计默认执行102/335条规则；模型／C／oracle未变。
- 原332条直接UNSAT保持观测加3条ACK分解／已证引理证书，覆盖335条**已定义规则的声明保持义务**，包含被当前条件排除的真空分支。这不证明调度器、可达性、wire或编译器正确。
- 原非空性161SAT／11UNSAT／163UNKNOWN保留；另外13份新SAT见证已通过当前参考场景重放、原全部断言精确保留和具体赋值化简核对。新增证据后有174条具SAT证书，另150条仍缺SAT证书；11条短段规则在当前组合域被排除。
- DeepSeek参与方案、具体证明定位和独立审查。最终审查无blocking；关于mapping未绑定的意见由全成员清单哈希和来源场景双哈希检查排除；关于自定义SMT拆分的意见另加Z3逐项重解析／原AST顺序精确相等检查。源审查不是执行证明，原意见及处理保留。

## 怎么运行与复核

Python3.11+、C99编译器，以及已安装 `requirements-formal.txt` 的 `.venv`。在仓库根目录运行：

```sh
# 新生成、编译并实际运行独立C，比较冻结24条路径
.venv/bin/python -m unittest discover -s tests -p test_ipv4_rule_coverage.py -v

# 补充证书／见证只读复核；不调用DeepSeek，不执行归档代码或Solver.check
.venv/bin/python tools/verify_ipv4_ack_certificates.py
.venv/bin/python tools/verify_ipv4_nonvacuity_witnesses.py

# 检查当前IR/C和交付汇总绑定，不改变通用flow结论
.venv/bin/python tools/ipv4_prototype_summary.py
```

新的完整离线执行使用 `flows/ipv4-prototype-closeout.json`，按照[十阶段入口](../spec-flow.md)指定全新输出目录和task哈希。它实际生成／编译C并保存轨迹与证据；**通用flow的完整探索结论仍允许返回1和 `unresolved`**，须分别检查阶段状态、有限交付合同和证据一致性，不能把它改成全协议证明。实际网络复现另需隔离Linux namespace、TAP与所需权限，见[组合peer入口](../../ports/linux-tcp-ipv4-peer/README.md)。服务器 `.78` 无sudo只影响其特权网络通道；不会修改服务器现有网络。

## 明确没有完成的范围

固定单peer／端口、IPv4 MTU1500、TCP16字节缓冲与SMSS4。动态路由、分片重组、一般TCP拥塞／恢复／options、socket、IPv6和上层协议不在本次原型内。TIME-WAIT实时到期未测，逻辑到期测试不能代替实测。

通用flow的声明探索仍10/335、总评 `unresolved`；累计233条未执行规则不等于不可达。150条缺SAT证书也是验证缺口，不当作协议功能被证明不存在。旧TCP／ICMP UNKNOWN、lwIP2750ms重传和LinuxTCP Difference全部保留。

这些限制已在原交付合同中明确；不会为了宣布“最小原型完成”而缩小现有模型、删规则、放宽oracle或篡改flow结论。**有限可运行原型交付通过**与**通用完整验证未完成**是两个分别记录的结论。
