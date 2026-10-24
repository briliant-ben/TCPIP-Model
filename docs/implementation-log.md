# 持续实施记录

## 2026-10-24：本地基线恢复

当前仓库 HEAD 为 `bb921b5`，克隆时工作区干净，仓库和父目录未发现 AGENTS.md。未回退或覆盖已有改动。

环境：macOS arm64 / Darwin 27.0.0、Python 3.12.14、Apple clang 21.0.0、Z3 4.15.4.0。系统 Python 3.9 不满足要求，虚拟环境由本地新版 Python 创建；依赖按 requirements-formal.txt 固定安装。虚拟环境、编译二进制和 macOS 调试符号均不入库。

验证：78 项 unittest 通过；build、formal（深度 6）、suite --formal --depth 6、suite-verify 通过。lwIP 实际 C 执行两次连接均成功；handshake 投影匹配，syn-loss 重传为 2750ms，仍与模型 1000ms 配置不同；lwip 返回 1，lwip-verify 为 valid_execution_evidence。未改动上游或 oracle。

Linux 通道：本机有 tcpdump，但没有 packetdrill、Linux /dev/net/tun、ip 网络命名空间或 Linux capabilities。没有 Linux 实机证据；未更改宿主网络。仅该通道受阻，继续模型开发。

## 实施里程碑

1. 基线恢复（已完成）：重建全部本地证据，保留实现差异。
2. IR 数据基础：版本化字节串、长度、拼接、切片及序列空间谓词；参考与独立 Z3 后端同步，覆盖边界、回绕和故障变体。
3. TCP 有限数据切片：显式缓冲、分段、累计 ACK、窗口与重传，固定支持范围和场景；不得标为完整 TCP。
4. 连接组合与恢复：保持唯一序列号/定时器语义，逐步加入乱序、RTT/RTO、delayed ACK、persist、拥塞与恢复，以及独立实现验证。
5. 后续协议：按用户给定顺序推进 UDP、IPv4、ICMP、ARP、IPv6/NDP、socket 与组合，分别固定规范、假设和验收条件。

每个完成的里程碑提交文档、代码、测试与当前证据。形式结果始终有步数边界；场景和规则覆盖不等于规范完整性。

## 2026-10-24：IR 数据基础

新增 opt-in IR 0.2；bytes 的 JSON 八位组表示、截断切片、长度与拼接，整数 sub/min，32 位前向距离及半空间比较在参考解释器与独立 Z3 后端同步实现。语义与条款链接见 semantics.md；RFC 9293 §3.4 为 TCP 规范依据，RFC 1982 §3.2 仅是通用串行数比较参考。没有把任意回调引入 IR。

字节列表在初值、事件、状态、输出和轨迹间采用复制的值语义；失败事务回滚。新操作在旧版模型中明确拒绝，未知后端操作报错。Z3 资源异常转为带原因的 unknown，保持不确定结果不能通过的门槛。

11 项新增测试通过：包括字节容量 BMC 深度 3、全 BV32 对的半空间谓词查询、具体字节/回绕见证重放、边界与错误类型、错误序列推进故障反例。已知限制：混合字节长度与序列关系的通用 BMC 可能超时；该性质未宣布通过。
