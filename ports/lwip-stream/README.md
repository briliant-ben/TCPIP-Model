# lwIP 事件驱动发送／接收／关闭验证

范围：锁定且未修改的 lwIP 2.2.1，内存 IPv4 netif，主动打开，MSS=4、本地窗口16，总写入0..16字节、对端累计文本至多64字节、3..64事件、0..200ms。公共 raw API 写入 MORE 数据／调用 tcp_output；网络端注入 SYN+ACK／ACK／DATA／FIN，支持公共接收回调与 CLOSE。无 PSH、选项、app.read／接收信用返还、丢包／定时器恢复或 Linux 证明。本目录与原 lwip-data 单场景通道独立，原证据不重绑。

scenario 直接映射为有界文本输入：CONNECT、SEND hex、TRANSMIT、SYNACK seq ack window、ACK seq ack window、DATA/FIN seq ack window hex、CLOSE。所有事件、字段、类型、时间和上限显式校验，C 端也拒绝未知命令／尾随字段。canonical 本地 ISS=1000 映射到抓取实际 SYN 的 ISS；只变换对端输入 ACK 坐标，不读取 IR 输出、不改 PCB。输出完全来自实际 lwIP netif pbuf，脚本输入包另标 in；没有合成局部输出。

参考由 tcp-delayed-ack IR 计算，固定输入完整字节符号重放、原始 PCAP 独立 checksum／ISS 归一化、0ms 容差严格 Difference、输入／查询／编译／二进制／产物哈希绑定、重新生成参考及查询逻辑等价复查均必须通过验收。执行成功与 Difference 分开，差异不自动视作 RFC bug，也不更改 oracle。

```sh
.venv/bin/python ports/lwip-stream/run.py
.venv/bin/python ports/lwip-stream/run.py --verify
```

每个其他输入使用 --scenario ports/lwip-stream/scenarios/NAME.json --out artifacts/lwip-stream/NAME；验证时传相同参数及 --verify。sent 回调只表示 lwIP 公共应用通知，部分 ACK 在 lwIP 按完整内部 segment 释放时才通知，不能把它等同模型 SND.UNA 的每字节推进。

规范：RFC 9293（August 2022）§3.7 分段、§3.7.4 Nagle、§3.8.6 窗口管理、§3.10.7.4 ACK／窗口处理。模型的 app.transmit 为声明式发送调度事件；lwIP 也可在处理 ACK 时自动发送。把同一毫秒的显式发送机会列入模型输入，不抹去包顺序／时刻差异。不同发送策略合法性需单独分析，不能以某个唯一分段计划充当所有 TCP 实现的完整符合性 oracle。此处验证限定选择与输入下的严格投影。

初次六场景实际执行：部分／重复 ACK、零窗口恢复、旧 ACK 不重新开放窗口、future ACK、不可接受接收 SEQ 五场景投影匹配；初始 peer window=4 场景保留 mismatch。上游 src/core/tcp_out.c:420 将 tcp_write 的分段上限设为 min(pcb->mss, snd_wnd_max/2)，所以实际先发两个2字节段，模型先发一个4字节段，继而出现额外包与脚本后续ACK分叉。这是当前固定分段选择与实现策略的差异，不把 advertised MSS=4 误当每包必须4字节，也不直接认定 RFC 违规。严格 Difference、实际未完全 ACK 的回调和原始抓包保留，不篡改输入去追随输出。

run 返回1表示执行完成但投影不同；verify 返回0可以验收这样的有效差异证据。编译／源完整性、未支持输入、模型未覆盖／规则冲突、形式重放、执行及观测无效分别记录失败阶段，不把这些失败报告当作实现 Difference 证据。Hash 完整性不提供签名／生产者真实性。

接收／关闭扩展须独立重建验收：新增 DATA/FIN（携带0..16字节）和 CLOSE。总对端文本（含重复输入）至多64字节，应用接收缓存16字节，不调用 tcp_recved，不支持 app.read。C recv 回调保存原始字节／时刻／EOF；独立 receiver-difference 将其对应到 IR 每步新增连续 rcv_buf 前缀及 FIN 消费，忽略回调分块边界但保留字节顺序、时刻和EOF。网络Difference与接收交付Difference分别保存，任一不匹配均为总体差异。既有六场景须按新源码全部重新生成和验收，不能只重算旧哈希。新增范围不包含丢包／重传、persist、拥塞或Linux；旧单段通道保持独立。

查询等价使用精确共享前提提取 XOR(C∧A,C∧B)=C∧XOR(A,B)，共同约束全部保留；未匹配子式继续参与求解，sat／unknown均拒绝。初次直接XOR在连续多场景进程中超时，原查询／unknown和精确提取复查证据保存在 diagnostics/receive-multiprocess-recheck-v1。
