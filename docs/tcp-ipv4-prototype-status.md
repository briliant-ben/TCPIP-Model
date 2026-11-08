# 最小 IPv4 原型验收记录

当前目标是一个支持范围明确、能从 Protocol IR 生成独立 C 实现的 IPv4 端点原型。当前仍未完成组合网络互通验收，不作为完整或生产可用 TCP/IP 协议栈交付。

已具备：

- 一个335条规则、58个变量的组合 IR，显式拥有 Ethernet/ARP、IPv4、UDP、ICMP Echo、有限 TCP 及共享待发包/定时器策略。
- 固定独立种子的参考执行、生成 C 实际执行及固定输入 Z3 对应检查；既有分开的 Linux peer 证据保留。
- 组合模型现有十阶段 flow。实际15个正负案例的参考/原生比较通过，19个固定 trace 输入步通过字面量合同检查；规范追溯覆盖全部58个声明要求的来源绑定。
- 新组合 TAP 诊断驱动的受限 mock/纯测试：原90项及最终分类修订后92项通过。此项不是实机证据。

尚未通过的门禁：

- 组合模型完整真实 peer 交换：先测量原始 TAP TCP ingress，再验证连续 ARP、UDP、ICMP 和 TCP 收发/关闭。
- flow 总结论仍为 `unresolved`：depth1全输入形式检查是 `UNKNOWN`；深度2的声明探索只覆盖10/335条规则，不能提升为完整覆盖或证明。

`COMPOSED` 是扁平执行状态；组件控制状态保存在显式变量中。初值配置 `{}` 表示采用 IR 默认值，并非没有协议状态。哈希固定的 flow 设计说明是有限探索配置记录；实际覆盖与验收以本记录及原报告为准。

当前模型仍是固定单 peer/端口、MTU和小 TCP 缓冲配置。一般路由、分片重组、通用乱序接收、拥塞控制和完整恢复算法不在当前原型支持范围。生成实现正确性、规范到IR解释正确性和无界协议正确性均未获证明。原TCP/ICMP UNKNOWN、lwIP2750ms及Linux TCP Difference继续保留。

## 本地复现

使用现有 Python3.11+虚拟环境和 C99编译器：

```sh
.venv/bin/python examples/run_native_suite.py model/tcp-ipv4-endpoint.json --scenario-dir scenarios/tcp-ipv4-endpoint --formal-replay --out /tmp/tcp-ipv4-review-native
.venv/bin/python -m protocol_lab.pipeline run flows/tcp-ipv4-endpoint.json --workspace . --out /tmp/tcp-ipv4-review-flow
.venv/bin/python -m protocol_lab.pipeline verify /tmp/tcp-ipv4-review-flow --workspace .
```

输出目录必须是新的。flow返回1且assessment为unresolved表示保留了未决性质，不能称整个流程验证通过。查看每阶段原始报告可区分实现差异、工具失败、覆盖缺口和形式UNKNOWN。

真实网络验证通过独立 namespace 的 GitHub Linux runner 运行。服务器禁止用户 namespace 且没有sudo时，仅阻塞该服务器的特权网络通道；不修改主机网络/SSH。
