# 有限空闲连接重启

tcp-idle-restart继承tcp-fast-recovery，仍以声明式IR为唯一权威。规范为RFC5681 September2009 §4.1，RW=min(IW,cwnd)，以共享当前RTO判断没有发送数据的间隔严格超过RTO；等于RTO不触发。新数据调度机会之前设置精确RW，保守清累计CA信用，ssthresh不变。guard与action使用同一个有效cwnd，父预算不变量保留。

last-data时间在实际非空tcp_data输出点记录，覆盖新数据、快速／超时重传和零窗口探测；不是应用排队时间或最近接收包时间。SYN、纯ACK、FIN-only、被阻塞的发送尝试和静默时钟不刷新它。连接清理后历史无效；首个数据无此前data历史。所有时间、validity及输出关系为显式IR变量／表达式，没有Python回调或新后端算子。

SMSS4、队列16和已有共享序列空间／定时器边界不变；只在显式app.transmit有待发送文本且本地FIN尚未发送时判断。即使窗口阻塞，调度尝试也可先保守缩窗；它没有发出数据，因而不刷新last-data，后续仍需再次判断。不另设空闲定时器、不自动产生新数据。请求或ACK到来不能掩盖长时间没有发送数据。当前RTO可能因新样本改变，使用发送机会时的值而不是旧固定1000ms。

此开发overlay未注册suite，不是RFC7661窗口验证、完整恢复或完整TCP证明。limited transmit、NewReno/SACK/ECN和一般允许输出关系仍未完成。固定输入字节重放与状态检查仅支持其声明命题；unknown必须保留。没有由此获得Linux或独立实现空闲重启证据，原lwIP2750ms差异及各模块独立证据均不修改。
