# 独立 lwIP 单段数据通道

执行仓库锁定、未修改的 lwIP 2.2.1 C 源码；新目录和编译配置与原 ports/lwip 握手／丢包通道分开。复用其原始 netif 抓包工具，新驱动只调用公共 raw API、构造脚本对端输入并检查 connected/sent 回调；不读取模型输出、修改 PCB 状态或替代 TCP 实现。

有限范围：MSS=4、本地 receive window=16、peer window=8，一次四字节 tcp_write，21ms 显式 tcp_output，30ms 完整 ACK。应用 MORE hint 排除模型尚未声明的 PSH，不更改上游代码。每一条支持的输入／时刻均显式校验，不会静默忽略其他场景事件。其余数据／重组／关闭／恢复不由该单场景验收覆盖。

```sh
.venv/bin/python ports/lwip-data/tests.py
.venv/bin/python ports/lwip-data/run.py
.venv/bin/python ports/lwip-data/run.py --verify
```

模型仍是唯一权威参考：先从 tcp-delayed-ack IR 执行 scenario.json，保存参考轨迹和完整字节符号重放；C 程序只得到公共应用输入的四字节 hex，实际输出来自 lwIP netif pbuf。原始 PCAP 经过独立 checksum／双端 ISS／窗口／字节归一化，以 0ms 时间容差严格比较，输出真实 Difference。配置、驱动、上游锁、编译器、命令、二进制、日志、模型／场景和产物均绑定哈希；verify 重新生成参考输出、独立解码并比较，不因重新计算 manifest 哈希而接受修改的 oracle。

这是虚拟时钟、内存 netif 上的真实 lwIP 实现观测，不是合成模型 PCAP，也不是 Linux TCP/TUN 实机。原普通握手和 SYN-loss 2750ms 差异保持原通道。构建产生的 lwip-harness／dSYM 不提交，跨机器必须重新构建执行，不能放宽哈希适配旧快照。只有输入固定的单段输出投影匹配；不宣称完整协议、实现精化或无界正确性证明。

verify 还会重新执行固定输入符号重放，并独立检查导出的查询与重新生成查询逻辑等价（保留原始查询字节哈希；Z3 内部文本别名不是语义标识）。篡改 oracle、PCAP、执行回调、查询和编译命令后重算哈希，或漏掉必要文件、伪称 Linux，均须被拒绝。哈希绑定只提供完整性，不提供签名或恶意生产者真实性保证。
