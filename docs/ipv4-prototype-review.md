最新入口：[2026-11-12有限原型交付](ipv4-prototype-delivery.md)。下文为早期实际互通里程碑，不是当前PR／收尾状态。

# IPv4 有限原型：成果审阅入口

2026-11-10 后续进展：[定向收尾与原始证据](ipv4-directed-closure.md)实际新增24条默认路径／157转换，累计执行102/335；30条选定已定义转换保持全部声明不变量（30UNSAT＋30非空性SAT）。原任务／网络结果按各自源码保留，flow仍unresolved，以下为原互通里程碑记录。

本轮新增成果在 [PR23](https://github.com/briliant-ben/TCPIP-Model/pull/23) 审阅；PR22 已由仓库所有者先前合入，其范围止于旧源码9c7fb915。本轮交付是固定单 peer 的 IPv4 端点原型。一个 Protocol IR 显式拥有 ARP、IPv4、有限 TCP、UDP、ICMP Echo 和共享待发包／计时器；从 IR 生成的独立 C 程序已完成同进程 Linux 互通。Python 适配器负责原始链路 IO、机械计时和测试刺激。

先看[实际运行可视化](../artifacts/ipv4-prototype-final-9289/review.html)：19 个实际转换可展开查看 IR guard、action、规范来源；25 个原始抓包记录可展开查看字节。页面分别显示 C 逻辑时刻与 PCAP 实测时刻。

## 本轮已验收

功能源码头 `92896425dadf2ee6a8aa06f7740a0fc8a3c3a18f` 的六项 workflow 全部成功。[组合 Linux 验收](https://github.com/briliant-ben/TCPIP-Model/actions/runs/42452725172) 在隔离 namespace 中执行：

| 模块 | 同一个生成 C 进程中的实际观察 |
|---|---|
| ARP | 冷启动查询、独立 Linux 回复、缓存供后续发送使用 |
| TCP | 主动连接、`0080ff07` 四字节双向传输、主动关闭至等待中的 TIME-WAIT |
| UDP | 空数据、5 字节含 NUL 数据、1472 字节数据，三次精确往返 |
| ICMP Echo | 0／5／1472 字节三次 Echo，iputils 各 1 发 1 收、零丢失 |

C 只启动一次，PID2802；25 captured／25 filter／0 drops，实际停止请求前静默146.049162ms。TCP socket、UDP socket、ping 与 C 均保持到独立抓包结束后才释放。原始字节未填补或改写。独立观察器核对 MAC／IP／TCP／UDP／ICMP 校验和、UDP 内容／端口及完整 Echo 回复字节。

实际19条转换的参考/C比较、独立 Z3 固定输入 SAT＋见证重放均通过。另有94项相关回归、新 profile 两项构造器检查，以及28条参考/C正负路径、7条固定输入 Z3 检查。详细来源与检查范围见[只读审计](../artifacts/ipv4-prototype-final-9289/readonly-audit.json)，[原始网络 ZIP](../artifacts/ipv4-prototype-final-9289/linux-peer-original.zip)及[原始 flow TAR](../artifacts/ipv4-prototype-final-9289/flow-original.tar.gz)。归档 Python／ELF／求解器未在只读审计中执行；CI provenance 是单独的可信前提。

## 模型与流程

权威模型为 [ipv4-endpoint-virtual-link.json](../model/ipv4-endpoint-virtual-link.json)：335条规则、58变量、65不变量、61个规范／范围要求。扁平执行状态为 `COMPOSED`，控制状态由显式 `L.control`、`T.control` 保存。审阅入口是两个纯离线构造器：[TCP 输入边界](../tools/tcp_ipv4_virtual_link.py)、[复用既有 UDP/ICMP TAP guards](../tools/ipv4_endpoint_virtual_link.py)。运行时使用完整 JSON。

旧 canonical 模型、TCP-only virtual 模型与失败证据均保留。新增 profile 明示接收“精确 IPv4 范围或规范填充”；发送仍有最小 Ethernet padding。原58字节 TCP 与42字节 UDP入口失败没有被追认通过。该假设的规范解释见[完整虚拟链路范围](ipv4-endpoint-virtual-link.md)。

[最终十阶段 task](../flows/ipv4-endpoint-virtual-link.json) 已在服务器实际运行、保存全部源快照并完成调用方 task 哈希验收：32例（21固定字面量、10模型导出、1域外负例）参考/C比较通过，335条规则来源绑定通过。IR文件和生成C源码分别与实机通道一致：

- IR SHA256：`7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5`
- C SHA256：`19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b`

flow 总结论仍为 **unresolved**：八阶段通过，全输入 depth1 形式检查 UNKNOWN，声明探索覆盖10/335。保留证据校验一致与协议性质已证明是分别记录的结论。`run`／`verify` 在该未决结论下均返回1；返回2才表示 intake／证据被拒绝。旧控制器误把 verify 的1当失败，其原记录保留，后续只重新检查证据，没有重跑形式查询。

## 本地复现

需要 Python3.11+、已装 `requirements-formal.txt` 的虚拟环境及 C99 编译器。输出目录必须全新：

```sh
.venv/bin/python -m protocol_lab.pipeline run flows/ipv4-endpoint-virtual-link.json --workspace . --out /tmp/ipv4-review-fresh --task-sha256 bc771c5a6647af18a3ff6cddb50a36a51438a04b44f737621f2e7b4bba5b0d3f > /tmp/ipv4-review.log
.venv/bin/python -m protocol_lab.pipeline verify /tmp/ipv4-review-fresh --workspace . --task-sha256 bc771c5a6647af18a3ff6cddb50a36a51438a04b44f737621f2e7b4bba5b0d3f
```

在本轮配置中看到返回1和 `unresolved` 是上述未决结果。查看 `/tmp/ipv4-review-fresh/flow.json` 和各 stage 报告。

随后可直接运行刚生成的 C 二进制，输入一次初始化和连接事件，观察其生成的 ARP 输出：

```sh
printf 'B\nD 0 T.app.connect\n' | /tmp/ipv4-review-fresh/stages/build/build/protocol-native
```

完整实时复现入口为 [Linux workflow](../.github/workflows/linux-tcp-ipv4-probe.yml)，需要独立 Linux namespace、TAP 与所需网络权限。服务器 `.78` 缺少 sudo／可用 user namespace，仅阻塞该服务器的特权网络通道；本轮网络证据来自隔离 GitHub Linux。服务器上的新 flow 使用真实 Linux 生成 C 执行，但该离线路径没有被算作网络抓包。

## 一起 review 的重点

1. 当前固定端点 `.1:40000 ↔ .2:8080`、单 peer／MTU1500、TCP16字节缓冲／SMSS4的范围，是否符合下一阶段实验基线。
2. 规范解释、虚拟链路边界和独立 oracle 的来源；源码／模型／C／ELF／抓包／轨迹／SMT 的哈希连接。
3. 固定路径对应检查、全输入 UNKNOWN、覆盖缺口与可信组件的区别。

一般动态绑定／路由、分片重组、TCP通用乱序／拥塞／恢复、完整 socket 服务、IPv6及上层应用未纳入本原型。TIME-WAIT实时时间到期、完整协议／编译器／英文规范到IR解释的正确性均未获证明。旧TCP/ICMP UNKNOWN、lwIP2750ms和 Linux TCP Difference继续保留。后续 agent 框架完善留在这次 review 之后；本轮没有自动合入 main。

## 服务器发布

`.78` 新发布位于 `/home/blxu/protocol-flow/releases/ipv4-prototype-963a57f8`：122个选定 Git963a57f8 的只读源码／IR／规范文件，以及在服务器重新生成编译的 C 程序。生成C哈希与上面的实机、flow通道一致；初始化／连接事件输出匹配冻结ARP字面量；保留flow校验仍为一致的 unresolved。旧发布未覆盖，没有新增API调用或网络执行。[部署原始回执](../artifacts/ipv4-server-release-963a)记录了全部源绑定。

可直接查看服务器 C 程序输出：

```sh
printf 'B\nD 0 T.app.connect\n' | ssh blxu@192.168.71.78 /home/blxu/protocol-flow/releases/ipv4-prototype-963a57f8/build/protocol-native
```

这是独立 C 的启动／ARP输出检查；真实链路IO使用已验收适配器。本次部署启动检查没有计作新的抓包互通证据。
