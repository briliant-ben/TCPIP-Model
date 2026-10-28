# 有限拥塞窗口／慢启动／拥塞避免／数据 RTO 开发模型

model/tcp-congestion.json 声明式继承 persist、delayed ACK、连接与字节历史，共用 snd_una/snd_nxt、rtx_buf、窗口和定时器。tools/build_congestion_model.py 仅生成显式 JSON AST；执行器不调用它，没有协议 Python 回调。

规范固定 RFC5681 September2009 §§2、3.1，原文与独立模块来源锁在 spec/sources/rfc5681.txt、tcp-congestion.json。保守 IW=SMSS=4，允许配置4..16（最多4SMSS），实验默认初始阈值16；它不是协议的最大通告窗口（父模型窗口仍允许0..65535），不同初始阈值至少8需显式路径假设。SYN/SYNACK、FIN控制不赚取数据拥塞信用。新数据每次最多min(MSS,排队字节,rwnd-flight,cwnd-flight)，拥塞耗尽时由显式blocked规则接收输入。

慢启动每个确认新数据的ACK增加min(N,SMSS)；cwnd>=ssthresh进入累计确认字节拥塞避免，累计达到旧cwnd时增加一个SMSS并保守清零信用。old/duplicate/future/无效SEQ ACK、控制ACK不增长；persist／零窗口探测期间不增长。没有每RTT增长上限的通用时序证明，字节计数策略与各固定输入须独立检查，不宣布完整拥塞正确性。

只有实际发出重传的正窗口数据RTO触发拥塞丢失：cwnd降为4，首次超时的最老数据字节令阈值为max(floor(FlightSize/2),8)。16个显式逐字节超时标记随实际数据ACK移动、随共享队列清理；重复RTO不重复调整同一字节的阈值。计数记录每次首次更新，便于测试有限容量下数值相同但决策不同的情况。floor半数只使用既有精确有理／ceil语义，无新增后端算子。窗口为零的探测、独立persist、过早timer等待不是拥塞丢失。

此模型暂未注册suite。尚不包含快速重传／快速恢复、limited transmit、长空闲重启、ECN、SACK／NewReno、多连接公平性或FIN-only拥塞响应。FIN/SYN仍采用父连接语义，不另建序列空间或定时器。没有独立实现拥塞证据、无界／通用输出时序或解释／翻译／实现精化证明；父profile和已有unknown保留。
