# persist 初版遗漏待发送 FIN 的关闭状态

初版仅允许 ESTABLISHED/CLOSE-WAIT/FIN-WAIT-1。独立归纳发现接收 FIN 后可进入 CLOSING，且 FIN 尚未发送、数据队列仍待探测；参考复现也确认 local close 后 peer FIN 会被新所有权不变量拒绝。原完整查询、模型、范围和可达参考轨迹保留。归纳任意前状态本身不是可达证明；另外保存的参考调用才是可达复现。

应在同一显式所有权语义下覆盖父模型支持的 pending-FIN CLOSING/LAST-ACK，继续禁止 fin_sent 的 FIN-only persist，不删安全义务或回退比较器。不是 RFC 或外部实现缺陷证据。
