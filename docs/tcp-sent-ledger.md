# 有限完整分段确认信用账本

本overlay继承tcp-output-schedule，不改变TCP字节ACK、发送／重传队列、序列空间或timer。增加16槽循环账本，每槽显式int长度1..4和seq32排他末端。仅实际非空tcp_data在该规则入口SND.NXT处的新发建立记录；SYN、FIN及旧范围重传不新计。每个原子规则至多一个新数据段，超出由不变量拒绝。循环head／tail和ACK释放均为JSON IR表达式，不依赖Python运行时回调、排序或隐藏队列。

模型的queue16不是生命周期写入上界：头段已有3字节被ACK后，再填满16字节未确认队列，一次累计ACK可释放19字节完整记录信用。cb_step_bytes上界因此为19；独立C通道总写入16的实验限制保持。原型16上界的可达拒绝、9方法历史通过、边界测试失败及终止过时归纳的记录归档sent-ledger-credit-bound-v1。累计callback信用加当前partial前缀不得超过TCP累计ACK信用，累计首次发出不得超过累计接受写入，避免任意归纳前态丢失既有信用关系。

CB-INV-UNSENT-BUDGET进一步要求“累计首次发出＋当前待发 <= 累计接受写入”。仅约束已发出<=写入不足以支持归纳：原型可允许已发14／待发16／仅写入16的任意前态，随后发送3触发已发17>写入16。11个发送／persist的SAT投影均违反更强的发送库存关系，未建立协议可达性；旧主报告、9固定轨迹验收和8真实捕获验收归档sent-ledger-induction-budget-v1。此次只增加状态约束，不更改协议动作、guard、缓冲、时钟、上游或旧oracle；新的证明和证据必须重新绑定此模型版本。

在父模型已经接受新的data ACK信用后，覆盖完整原始段末端的记录才释放。cb_step_bytes是该原子输入的显式IR服务观察量；cb_acked_total累计完整记录信用。部分ACK仍立即推进父snd_una及svc_acked_bytes，却不提前释放完整段信用。重复／旧／未来ACK不伪造信用，重传不重复建账。cb_live_total减实际rtx字节数是已ACK但尚未释放的头段前缀，范围0..3；完整记录质量守恒包括原始段的被放弃信用，和父模型仅剩未确认字节的放弃量分别保留。

该服务策略来自固定lwIP2.2.1公开tcp_sent API和tcp_free_acked_segments实现：完整原始段释放后累加recv_acked，再调用sent回调。它是实现特定的可选观察模型，不是RFC要求所有TCP API使用同样回调粒度。RFC9293 August2022 §§3.4、3.10.7.4的字节／累计ACK语义继续由父链负责；源码版本、相关主文件SHA和解释绑定spec/sources/tcp-sent-ledger.json。C适配器只记录公共回调时间与字节数，不读取或改写内部PCB，不改变上游。

首个window4实验实际发送2+2而候选为单4，因而ACK1003在实际侧完整释放2字节、候选侧尚不释放。这是分段候选差异，不能称实际partial-ACK回调错误。tcp_out.c的mss_local取min(pcb.mss,snd_wnd_max/2)是解释线索；window8实验另行观测真正4字节原始段的部分ACK。原window4候选、手写契约和严格Difference保留，首轮来源快照归档sent-ledger-window4-hypothesis-v1；不把新增窗口实验或替代见证当作原候选通过。

使用同一源输入／显式调度见证，独立比较完整严格线端和带时刻服务事件。服务匹配不抹去RTO或分段网络差异，也不把TCP字节ACK直接等同完整段回调。支持范围仍为SMSS4／队列16及父连接链，不覆盖所有Nagle/SWS、实现段拆分／合并／重分段策略、65535以上回调拆分、通用socket或实现精化。固定输入全字节查询、长度／标量归纳、真实内存netif观察和Linux证据分别标注，unknown保持unknown。
