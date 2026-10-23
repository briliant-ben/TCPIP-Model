# lwIP 实现执行适配器

此适配器执行固定版本的上游 lwIP C 代码，使用内存 IPv4 netif 和虚拟毫秒时钟。它无需 TUN 或网络权限，不使用宿主 Linux TCP；它也不把参考模型产生的包冒充真实实现的输出。

```bash
.venv/bin/python -m protocol_lab build
.venv/bin/python -m protocol_lab lwip
.venv/bin/python -m protocol_lab lwip-verify
```

`lwip` 在产生投影差异时退出 1，执行失败时失败，不会把差异吞掉。`lwip-verify` 校验的是执行证据的完整性，校验成功不意味着所有比较都匹配。报告路径为 `artifacts/lwip/report.json`。

## 当前场景

- `handshake`：lwIP 主动连接；脚本对端在 10ms 注入合法 SYN+ACK；检查 lwIP connected 回调和实际输出 ACK。
- `syn-loss`：对初次 SYN 不提供响应，由 lwIP 自己决定重传时刻；观察到重传后再等待 10ms 注入 SYN+ACK。

C 驱动仅构造测试对端输入。输出报文通过 lwIP netif 回调抓取，SYN 序列号来自实际实现，不读取预期 JSON。Python 解析独立 PCAP 后执行双端 ISS 映射和校验和检查，再与现有 active-open 模型投影比较。

当前固定源和配置下，普通握手投影匹配。丢包场景连接成功，实际首个 SYN 重传出现在 2750ms，而模型配置为 1000ms，差异原样保存。lwIP 的默认初始 RTO 和慢定时器相位与模型配置不同；这里尚未建立带时钟量化容差的精化关系，不能仅据此认定 RFC bug。也没有改动上游状态变量或放宽容差来强行通过。

## 证据

保存源文件锁定清单、编译命令/日志/二进制哈希、C 驱动与配置哈希、执行命令/日志、PCAP、归一化包、元数据、差异和当前模型构建绑定。`lwip-verify` 重新校验源、二进制与观测文件，重新归一化和比较。

上游源码未改动。当前 NO_SYS 编译配置启用 IPv4/TCP/UDP/ICMP/ARP，但这里只测试两个 TCP 控制场景；IPv6、完整 socket API、数据传输和整个协议栈的组合性质均未因此获得验证。此通道与 Linux packetdrill 证据分别存储，不自动改写 Linux 的 `not_run`。
