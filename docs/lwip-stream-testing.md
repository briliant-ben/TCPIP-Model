# 事件驱动 lwIP 发送、接收、重组及关闭实验

实现入口为 `ports/lwip-stream/run.py`，使用锁定、未修改的 lwIP 2.2.1 C 源码；独立于原握手／SYN-loss 和四字节单段通道。所有模型行为继续来自 tcp-delayed-ack 的 Protocol IR 继承链。该适配器映射刺激并观测实际输出，不实现另一套 Python TCP。

## 范围与输入对应

仅主动打开、总写入至多16字节、对端文本累计至多64字节（含重复）、最多64事件、0..200ms、MSS=4、本地窗口16，支持 app.connect、net.synack、app.send、app.transmit、net.ack、net.data、net.fin_segment 和 app.close。选项、PSH、app.read／接收信用返还、重传／persist／拥塞等不在该实现通道范围；输入环境 drop 和初值覆写均拒绝。其他已有 IR profile 不因此获得实现验证。

应用字节传给 tcp_write（COPY|MORE）；app.transmit 调用 tcp_output。脚本对端注入校验和正确的裸 IPv4 TCP 包，包括数据和携带可选文本的 FIN。app.close 调用公共 tcp_close，不再允许后续 SEND／TRANSMIT，避免持有已关闭 PCB 后继续调用应用 API。对端 ACK 按声明的本地 canonical ISS=1000 平移到实际 netif 捕获 SYN 的 ISS。此平移仅用于输入坐标，与输出 oracle 无关。capture 的出站内容来自实际 lwIP pbuf，不由模型消息编码。

IR app.transmit 是显式调度选择。两个同毫秒的机会允许模型在同刻发送两个 MSS；lwIP 一次 tcp_output 可以发送多个 segment，处理 ACK 后也可自动发送。输入会保留这些机会；归一化不排序、不合并、也不移动任何输出时刻。这里只能评估给定选择的严格投影，不是所有合法实现策略的完整等价关系。

## 正式规范与差异解释

RFC 9293（August 2022）§3.7 与 §3.7.4 定义分段及 Nagle；§3.8.6 与 §3.10.7.4 涉及窗口与 ACK 处理。MSS 是分段长度上限，不要求每段都填满 MSS。规范原文及校验哈希在 spec/sources/manifest.json 和 rfc9293.txt。

初始对端窗口为4时，当前 IR 以4字节发送首段；锁定 lwIP 的 src/core/tcp_out.c:420 在 tcp_write 中使用 `min(pcb->mss, snd_wnd_max / 2)`，实际形成两个2字节段。因此严格包级投影不同。后续 ACK 脚本原样保留；当两侧已发送前沿继续分叉时，同一个后续 ACK 可在一侧成为未来 ACK，不能再把全部下游差异解读为独立 bug。实际回调、包和 Difference 保留，不通过修改上游或 oracle 强行匹配。

sent 回调只报告 lwIP 对应用的通知，不能当作每次部分累计 ACK 的精确 SND.UNA 观测。报告分别记录 written_bytes 和 acknowledged_bytes，未假定两者相等，也不假定执行成功等于整个发送队列已确认。

## 证据验收与运行

各场景分别生成源码／规范输入哈希、编译命令／版本／编译器哈希、原始 PCAP、刺激文件、日志、原始 recv 回调字节／时刻／EOF、IR 轨迹、完整字节固定输入查询、归一化和 Difference。verify 要重新生成 oracle／参考轨迹、复查符号重放、独立求解导出查询与重新生成查询的逻辑等价、重新解析抓包并严格比较0ms投影。原查询字节哈希仍须吻合，不能以文本别名变化为理由重绑旧查询。

```sh
.venv/bin/python ports/lwip-stream/tests.py
.venv/bin/python ports/lwip-stream/run.py --scenario ports/lwip-stream/scenarios/two-segments-partial-ack.json --out artifacts/lwip-stream/two-segments-partial-ack
.venv/bin/python ports/lwip-stream/run.py --scenario ports/lwip-stream/scenarios/two-segments-partial-ack.json --out artifacts/lwip-stream/two-segments-partial-ack --verify
```

run 的 exit 1 表示执行完成而投影不同，verify 可对有效的差异证据返回0。编译环境、源完整性、输入不支持、模型未覆盖／冲突、形式重放、执行和观测失败分阶段保存，不将失败报告当作实现差异证据。编译二进制不提交，迁移后需重新构建。该通道是真实内存 netif 的 lwIP 观测，不是 Linux，也不是完整 TCP／通用字节、输出、时间或实现精化证明。原 SYN-loss 2750ms 与模型1000ms的差异仍在原通道。


## 接收字节与 EOF 观测关系

C 端 tcp_recv 只复制实际 pbuf 字节、记录时刻／EOF并释放pbuf，不调用 tcp_recved。接收数据仍占用TCP信用，对应 IR 未读 rcv_buf。每一步新增连续缓冲前缀对应原始recv字节；FIN消费对应EOF。该关系不等同模型app.read的消费通知，也不宣称验证完整socket接口。比较忽略回调分块边界；逐字节顺序、交付时刻、EOF相对位置保留，不能排序或把EOF移动到字节之前。

网络 difference.json 与 receiver-difference.json 分别保存。总体比较要求两者都匹配；网络有效差异不能掩盖字节／EOF错误。校验必须重算接收观测关系，重算执行日志哈希不能让旧接收Difference继续被接受。

新增输入覆盖连续两个完整段、乱序补洞、乱序重复、缺口前FIN、FIN携带字节、空主动关闭及发送数据确认后关闭。初次实际观测中，7个新场景的连续字节／EOF／时刻都匹配；只有连续两个完整段同时获得严格网络匹配。乱序补洞及重复补洞的即时ACK在当前捕获末端未出现；FIN／关闭场景的实际通告窗口比模型小1。原包和规则来源保留；不把这两类网络差异误报成字节乱序、EOF丢失或RFC违规。

规范对应RFC9293 §3.6关闭、§3.8.6.3延迟ACK和§3.10.7.4文本／FIN处理。§3.8.6.3引用RFC5681的补洞即时ACK建议；本通道观察至最后事件（至多200ms），既没有跟踪到下一个250ms lwIP定时器刻度，也没有验证500ms延迟上限，不能把缺少同刻ACK提升为永不确认或超时违规。源代码中 tcp_in.c:1631 的 tcp_ack 延迟选择是对应解释线索。

FIN窗口差异是实际wire值；上游tcp_in.c:1550及1587按含FIN的TCP序列长度扣减并更新通告窗口，接收结束路径在538附近另返还FIN信用。此处只是依据固定源码对观测提出解释，不把它当作驱动读取到的内部PCB值；适配器没有读取PCB窗口、修改内核或归一化窗口。模型的未读字节容量策略与实现的通告窗口选择不同，须后续研究一般允许输出关系。

## 查询等价复查的超时与精确提取

新recv测试在同一进程连续重放多个场景时，直接XOR等价求解得到10秒unknown/timeout；新CLI单场景独立复查则通过。原始两查询、原XOR、失败测试、unknown原因及源码快照保存在 diagnostics/receive-multiprocess-recheck-v1。不能把unknown当作不等价反例或通过。

现使用精确布尔等式 XOR(C∧A,C∧B)=C∧XOR(A,B) 提取共同断言。共同前提全部保留，没有共同的子式继续求解；原始查询字节哈希仍绑定。该诊断的136个共同断言及剩余两侧各1种断言经提取后unsat，导出查询另由独立进程复查。新增真值表／增删／否定约束负例，并保留原超时结论。这只是固定输入查询等价的补充编码，不提升TCP主BMC／归纳的unknown或声称证明翻译器。
