# 显式连接打开 PCAP 投影

`tcp-connection-v1` 与旧 active-open/data/fin 投影分别选择。旧投影仍要求初始出站 SYN 和对端 SYN+ACK；不通过删除其条件来接纳新场景。

新投影要求捕获和预期均从该连接的初始纯 SYN 开始，可为任一方向。独立解析器逐方向选取实际捕获的首个 SYN（含 SYN+ACK）的 SEQ 为实际 ISS，预期同方向首个 SYN 提供模型 ISS；ACK 仍按相反方向的独立原点作模 2^32 平移。支持主动、被动、同时打开及仅单方向 SYN 超时。每个需要映射的 SEQ／ACK 方向都必须有实际及模型 SYN 锚点；未需要的对端原点可为 null，不从任意 ACK、参考后态或合成编码器猜出 ISS。

归一化不去重、不排序、不修补错误 ACK，也不将每次重传重新对齐。严格有序比较继续包含 direction、flags、SEQ、ACK、窗口、完整 payload 和时间；IPv4/TCP 格式、分片拒绝、标志和显式 checksum 策略沿用原限制。新投影支持已有 FIN+payload 子集，但不扩展 SYN payload、选项语义或一般复用连接。时间原点仍是首个选中包，并显式加上预期首包的模型时刻；不能由此证明捕获开始前的 listen 等待时间。

SYN／delayed ACK profile 显式选择该投影，以覆盖三种新打开场景。原始失败是适配器未覆盖，不能改称协议不符合或 Linux/lwIP 差异。独立手工原始 PCAP 夹具检查模回绕、被动／同时／部分打开、错误 ACK、重传漂移、缺原点、窗口／字节／顺序与 checksum；场景编码往返仍标为 synthetic-only，不是 Linux 实机证据。
