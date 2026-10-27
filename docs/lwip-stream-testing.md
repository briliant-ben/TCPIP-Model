# 事件驱动 lwIP 发送、累计确认和窗口实验

实现入口为 `ports/lwip-stream/run.py`，使用锁定、未修改的 lwIP 2.2.1 C 源码；独立于原握手／SYN-loss 和四字节单段通道。所有模型行为继续来自 tcp-delayed-ack 的 Protocol IR 继承链。该适配器映射刺激并观测实际输出，不实现另一套 Python TCP。

## 范围与输入对应

仅主动打开、总写入至多16字节、最多64事件、0..200ms、MSS=4、本地窗口16，支持 app.connect、net.synack、app.send、app.transmit 和 net.ack。选项、PSH、接收文本、关闭、重传／persist／拥塞等不在该实现通道范围；输入环境 drop 和初值覆写均拒绝。其他已有 IR profile 不因此获得实现验证。

应用字节传给 tcp_write（COPY|MORE）；app.transmit 调用 tcp_output。脚本对端注入校验和正确的裸 IPv4 TCP 包。对端 ACK 按声明的本地 canonical ISS=1000 平移到实际 netif 捕获 SYN 的 ISS。此平移仅用于输入坐标，与输出 oracle 无关。capture 的出站内容来自实际 lwIP pbuf，不由模型消息编码。

IR app.transmit 是显式调度选择。两个同毫秒的机会允许模型在同刻发送两个 MSS；lwIP 一次 tcp_output 可以发送多个 segment，处理 ACK 后也可自动发送。输入会保留这些机会；归一化不排序、不合并、也不移动任何输出时刻。这里只能评估给定选择的严格投影，不是所有合法实现策略的完整等价关系。

## 正式规范与差异解释

RFC 9293（August 2022）§3.7 与 §3.7.4 定义分段及 Nagle；§3.8.6 与 §3.10.7.4 涉及窗口与 ACK 处理。MSS 是分段长度上限，不要求每段都填满 MSS。规范原文及校验哈希在 spec/sources/manifest.json 和 rfc9293.txt。

初始对端窗口为4时，当前 IR 以4字节发送首段；锁定 lwIP 的 src/core/tcp_out.c:420 在 tcp_write 中使用 `min(pcb->mss, snd_wnd_max / 2)`，实际形成两个2字节段。因此严格包级投影不同。后续 ACK 脚本原样保留；当两侧已发送前沿继续分叉时，同一个后续 ACK 可在一侧成为未来 ACK，不能再把全部下游差异解读为独立 bug。实际回调、包和 Difference 保留，不通过修改上游或 oracle 强行匹配。

sent 回调只报告 lwIP 对应用的通知，不能当作每次部分累计 ACK 的精确 SND.UNA 观测。报告分别记录 written_bytes 和 acknowledged_bytes，未假定两者相等，也不假定执行成功等于整个发送队列已确认。

## 证据验收与运行

各场景分别生成源码／规范输入哈希、编译命令／版本／编译器哈希、原始 PCAP、刺激文件、日志、回调、IR 轨迹、完整字节固定输入查询、归一化和 Difference。verify 要重新生成 oracle／参考轨迹、复查符号重放、独立求解导出查询与重新生成查询的逻辑等价、重新解析抓包并严格比较0ms投影。原查询字节哈希仍须吻合，不能以文本别名变化为理由重绑旧查询。

```sh
.venv/bin/python ports/lwip-stream/tests.py
.venv/bin/python ports/lwip-stream/run.py --scenario ports/lwip-stream/scenarios/two-segments-partial-ack.json --out artifacts/lwip-stream/two-segments-partial-ack
.venv/bin/python ports/lwip-stream/run.py --scenario ports/lwip-stream/scenarios/two-segments-partial-ack.json --out artifacts/lwip-stream/two-segments-partial-ack --verify
```

run 的 exit 1 表示执行完成而投影不同，verify 可对有效的差异证据返回0。编译环境、源完整性、输入不支持、模型未覆盖／冲突、形式重放、执行和观测失败分阶段保存，不将失败报告当作实现差异证据。编译二进制不提交，迁移后需重新构建。该通道是真实内存 netif 的 lwIP 观测，不是 Linux，也不是完整 TCP／通用字节、输出、时间或实现精化证明。原 SYN-loss 2750ms 与模型1000ms的差异仍在原通道。
