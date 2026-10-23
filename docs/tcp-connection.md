# TCP Connection Profile

`model/tcp-connection.json` 是独立于 `tcp-active-open` 回归基线的连接控制模型。它使用相同的平面 EFSM IR、通用参考解释器和独立 Z3 翻译器；协议规则保存在 JSON 中。

## 范围

覆盖全部 11 个传统连接状态的代表性控制路径：CLOSED、LISTEN、SYN-SENT、SYN-RECEIVED、ESTABLISHED、FIN-WAIT-1、FIN-WAIT-2、CLOSE-WAIT、CLOSING、LAST-ACK、TIME-WAIT。状态齐全不表示所有 TCP 行为已覆盖。

该模型是单连接、零 payload、已通过格式/校验和/连接匹配检查的控制事件模型。没有应用数据队列、窗口管理、拥塞控制、RTT 估计、SACK、TCP-AO 或多连接监听器；LISTEN 表示一个待建立的连接对象，不代表能并发 accept 的完整服务器。

## 开关连接

- 主动 OPEN 发送 SYN，设置发送序列空间并启动重传及用户定时器。
- 被动 OPEN 进入 LISTEN；收到 SYN 后发送 SYN+ACK。
- 同时打开保留 active/passive 来源；支持 RFC 9293 §3.5 Figure 7 的 SYN/SYN+ACK 路径。
- SYN-SENT 中非法 ACK 触发 RST，但不终止当前合法连接尝试；无 SYN 的可接受 ACK 不建立连接。
- ESTABLISHED 的 CLOSE 发 FIN，进入 FIN-WAIT-1；CLOSE-WAIT 的 CLOSE 发 FIN，进入 LAST-ACK。
- 对端 FIN、对本地 FIN 的 ACK、同包 FIN+ACK 和同时关闭采用分别的守卫与状态转换。
- TIME-WAIT 中重复 FIN 被 ACK，并重新启动 2MSL；重复 CLOSE 不生成第二个 FIN。

ACK 与 FIN 事件携带显式 seq/ack。此无数据切片只接受当前期望的序列值或列出的旧控制段；没有把普通整数比较当作完整 TCP 序列比较。一般乱序、窗口外控制段、SYN-RECEIVED 在本地 SYN 尚未确认前的 CLOSE，以及所有未列出事件处理仍报告未覆盖，不能自动认定为实现错误。

## 定时器

| 定时器 | 生命周期 |
|---|---|
| rtx | 有一个待确认控制段时启动；到期重复该段，RTO 加倍；确认后取消 |
| user | 建立连接/关闭操作的配置期限；到期清理控制块并通知应用 |
| time_wait | 进入 TIME-WAIT 时启动 2×MSL；重复 FIN 重启；到期关闭 |

初始 SYN RTO 取 1000ms。发生一次 SYN 重传、握手完成后，模型为后续控制发送采用 3000ms；若此前多次重传使 RTO 已大于此值，则保留较大值。这只覆盖配置中的控制段，不代替完整的 RFC 6298 RTT/Karn/RTO 算法。

用户期限默认 30000ms，MSL 默认 60000ms，均为可配置模型参数，不宣称为全部实现的统一常数。每个状态的定时器义务都有独立不变量。取消/重启后的旧截止时间不会再触发事件；同一时刻的事件顺序遵守现有 IR 契约。

## 重置与应用通知

RST 在 LISTEN/CLOSED 被忽略。SYN-SENT 中匹配 ACK 的 RST+ACK 拒绝连接。SYN-RECEIVED 的有效 RST 根据主动/被动来源进入 CLOSED 或返回 LISTEN。同步状态采用精确 RCV.NXT 的重置路径；窗口内非精确 RST 的 challenge ACK 与节流尚未建模。

`application` 消息输出 connected、peer_eof、reset、refused、aborted、timeout、closed 等通知，作为跨层服务观察。它们是参考模型接口，不是具体操作系统 errno/阻塞 API。每个已建模 ABORT 路径按状态决定是否发送 RST。

## 执行与验收

```bash
.venv/bin/python -m protocol_lab suite --formal --depth 6
```

`artifacts/suite/tcp-connection/` 保存每个场景的轨迹、应用输出、归一化控制包、合成 PCAP、来源映射、DOT 状态图及形式检查产物。报告列出实际访问的状态和未覆盖规则。

当前没有此 profile 的 packetdrill 生命周期适配器、实机抓包接入或总验收通过记录。报告显式标注 `unavailable_for_profile` 与 `protocol_complete: false`。旧 active-open 流程和 `assess` 仍作为已建立的基础验收通道，不能把它的结果自动推广到本模型。
