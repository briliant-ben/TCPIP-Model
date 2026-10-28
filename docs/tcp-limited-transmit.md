# 有限 Limited Transmit

tcp-limited-transmit继承空闲重启、classic Reno及连接／字节／窗口／定时器链。RFC3042 January2001 §2与RFC5681 September2009 §3.2 steps1/2为固定来源，原文及模块锁独立纳入SHA。仍由显式JSON IR执行，没有运行时Python协议回调或新形式算子。

前两个被接受的纯重复ACK各自动发送至多一个SMSS=4的新数据段，条件为尚有数据、正窗口允许、发送后FlightSize<=cwnd+8且本地FIN未发送。cwnd不因LT改变；普通app.transmit仍受原cwnd预算约束，不能借用LT额度。复制父IR的已有在途数据发送动作，包括分段、snd_nxt、字节时间、RTT采样、ACK piggyback取消及缓冲移动；既有RTO截止点保持不变，不因额外新段重启计时。

仅支持无SACK选项的现有事件schema。窗口更新／payload／无效SEQ／future ACK不冒充重复ACK，使用父显式分类。LT在长于当前RTO的无数据发送间隔保守不自动发送，后续app.transmit仍执行空闲缩窗。实际LT输出更新时间历史。现有连接容量仍为发送与重传队列合计16字节。

lt_epoch_bytes和lt_epoch_packets记录当前未推进UNA的重复ACK周期内实际LT输出；UNA推进（含partial ACK）、恢复入口、实际拥塞RTO、persist或清理结束周期。第三dup的损失基数显式为旧FlightSize减实际LT字节，然后用于max(floor(base/2),8)。不是从线上ACK数猜测发送量。当前容量16使两种数值阈值都可能被下限夹到8，因此须检查实际LT输出和基数扣除非空见证，不能把相同最终阈值宣称为数值区分测试；超过该容量的数值区分仍未覆盖。

父CC-INV-DATA-BUDGET继续约束普通显式发送；LT是独立声明的许可，其新字节与队列／cwnd+8约束由LT-INV-SEND另行检查，没有扩大原普通发送预算或修改oracle。LT字节仍在共享队列中赚取后续实际累计确认信用，重复ACK本身不赚信用。此模型未注册suite，不是完整恢复或TCP；自动第四dup后新发、SACK/NewReno、ECN、一般允许输出对应、通用内容／输出／时序与实现精化仍待完成。无独立LT实现或Linux证据，原2750ms差异保持。
