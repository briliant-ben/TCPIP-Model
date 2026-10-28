# 有限 Reno 快速重传／快速恢复开发切片

本模型显式继承 tcp-congestion／persist／连接、ACK/window、FIN、Karn、字节历史。生成器仅生成 JSON AST，执行器和独立形式后端不调用协议 Python 回调。

固定规范 RFC5681 September2009 §2及§3.2、RFC6298 June2011 §3；官方原文沿用仓库源锁。重复ACK必须是被接受的纯ACK，有在途数据、无文本／SYN／FIN、ACK=UNA、窗口等于最近被接受的带ACK线端窗口，而不是缓存SND.WND。无效／future段不更新该知识；合法窗口更新、文本和FIN可以更新，但不增加重复计数。旧ACK不推进UNA时保留计数；首次新UNA、实际拥塞RTO、无在途或连接清理重置。额外范围约束为缓存SND.WND和线端窗口均为正、非persist（零到正的首次窗口恢复ACK不计作本切片的重复ACK）；legacy FIN无窗口字段会使窗口知识失效。

第三重复ACK以FlightSize设阈值max(floor(FlightSize/2),2SMSS)，窗口膨胀为阈值+3SMSS，直接重传UNA处min(SMSS,flight,rwnd)前缀，不推进NXT、不新增RTO重试或退避。更多重复ACK每次膨胀一个SMSS，不重复快速重传。下一推进UNA的ACK退出并降至阈值、清CA信用，不再同时赚取普通SS／CA增长；部分ACK也退出，这是classic Reno而非NewReno。正常新发数据仍由显式app.transmit机会调度。

快速重传使用独立fr_retransmitted原因，不设置父tx_retransmitted（它专指受年龄下界约束的timeout）。原“不提前timeout”不变量完整保留。实际前缀发送时间和重叠RTT样本歧义更新；当前RTO截止点保留，若它比快速发送后的当前RTO年龄下界早，则由父精确字节年龄处理器等待。携带当前累计确认的实际快速输出取消delayed ACK。

尚未注册suite；SMSS4／队列16，连接与定时器语义共享。尚无limited transmit、每重复ACK自动发送新数据、空闲重启、ECN／SACK／NewReno、FIN-only快速恢复或多丢包保证。标量／长度归纳、固定输入匹配与独立实现证据分开；不宣称完整TCP、通用字节／输出顺序／时序、解释／翻译／实现精化证明。父模型与旧unknown和实现差异保留。

恢复进入必须伴随实际非空重传，作为独立不变量检查。原型曾仅检查线端正窗口：旧ACK可改变last wire window但不改变WL缓存，导致缓存窗口0时进入恢复却无重传。可达反例、加强性质的SAT／参考失败／新进程复查和修复前完整快照均保留于 diagnostics/fast-recovery-cached-zero-window-v1；修复不删除预算／年龄约束或放宽输出oracle。

聚合接收规则必须以父模型显式seg_acceptable及ack_is_future判定为准，不能仅凭规则ID推断段被接受。新增被忽略窗口不变不变量，拒收数据／FIN或future ACK不改变最近接受窗口及其有效性。旧型漏计第三重复ACK的可达轨迹、固定输入SAT与独立复查和源码／证据快照保留于 diagnostics/fast-recovery-rejected-segment-window-v1。
