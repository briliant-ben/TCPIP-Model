# 真实 Linux TCP 接入约定

## 已知边界

初始开发环境没有 packetdrill、Ivy、TUN 或有效网络 capabilities。生成测试脚本不等于执行了测试；合成 PCAP 不能替代实机抓包。`run-packetdrill` 的退出码：0=执行通过，2=未执行或执行失败；详细状态在 JSON 中区分。

脚本语法参考 google/packetdrill 的 `gtests/net/packetdrill/parser.y` 与 `gtests/net/tcp/blocking/blocking-connect.pkt`。出站 SYN `<...>` 忽略 TCP 选项，序列号采用 packetdrill 的每端相对 ISS 表示。当前环境未使用 packetdrill 解析器或真实运行验证，因此兼容性仍是接入验收项。

## 运行配置

推荐准备专用 Linux VM，或为测试创建独立网络命名空间。记录内核版本、packetdrill 提交、命名空间设置、TCP sysctl 和脚本 SHA-256；不要将某次机器的时序自动视为 RFC 的唯一行为。

需要可用的 `/dev/net/tun`、packetdrill 可执行文件、CAP_NET_ADMIN 和 CAP_NET_RAW。runner 做保守探测并设 30 秒超时；实际成功与否仍由工具退出码决定。执行前完成工具安装、路由及网络环境准备。runner 不调用 sudo，也不更改系统配置。

选定测试配置如下：

- IPv4、主动 nonblocking connect，无 SYN payload。
- 初始 SYN RTO 1 秒，脚本默认允许 50 ms 的工具时序容差。
- 只注入基础 SYN+ACK，不协商 TCP 时间戳、窗口扩大和 SACK。
- 出站 SYN 选项与窗口不作为判断对象；ACK 的序列号/确认号必须匹配。

某些新 Linux 内核通过 `net.ipv4.tcp_syn_linear_timeouts` 配置主动 SYN 的线性超时次数。`two-syn-losses` 采用指数退避，运行前需要确认测试命名空间采用对应配置，例如支持该参数的内核中值为 0。这里不会自动修改参数。否则脚本失败可能只是模型配置与实现配置不一致，需要归类，不能直接认定 TCP bug。

## 真实观测归一化

packetdrill 运行成功本身就是对脚本中 socket/packet 期望的检查结果。v0.2 增加独立 PCAP/Difference 入口；实际抓包仍由测试环境采集。

配置 `packet-profile.json` 的本地/对端 IP 和端口，导入：

```bash
.venv/bin/python -m protocol_lab observe /path/to/capture.pcap \
  --profile packet-profile.json --scenario syn-loss --origin external_capture
```

解析器支持经典 PCAP v2.4，大小端、微秒/纳秒时间戳，以及 RAW IPv4、Ethernet（含 VLAN）、Linux cooked v1 链路。当前不支持 PCAPNG、IPv6、Linux cooked v2、分片重组、TCP payload 或此切片之外的 TCP flags。选中连接的格式/长度/IPv4 校验和错误会终止导入；无关连接会计数并过滤。

以上为既有 active-open observe/assess 通道，边界保持不变。新增显式 `tcp-data-v1` Python 归一化/比较投影可处理 ACK payload 和控制 flags，并额外比较窗口和字节内容；它目前只用于数据 profile 的编解码与差异测试，尚未接入数据实机验收。没有为旧通道放宽 payload 或哈希门槛，详见 `docs/tcp-data.md`。

默认严格检查 TCP 校验和。确有发送校验和 offload 的抓包可显式选择 `--checksum-policy record_offload`，但验收会标记 `checksum_review_required`，不会自动放行。解析器不自动去重；应在单一明确观测点采集，避免把真正的重传误删。

真实抓包转为比较器输入前需完成：连接过滤、去除观测点造成的重复包、明确 offload 对校验和的影响、原点时间归一化和双端 ISS 映射。用下式把真实序列空间映射为模型值：

```text
model_seq = (wire_seq - wire_local_iss + model_local_iss) mod 2^32
model_ack = (wire_ack - wire_peer_iss + model_peer_iss) mod 2^32
```

入站包交换 local/peer 角色；未置 ACK 的 SYN 统一以 ack=0 表示。每个包至少包含：

```json
{"direction":"out", "flags":"S", "seq":1000, "ack":0, "time_ms":0}
```

必须保留采集来源、内核与工具版本、原始 PCAP 哈希、归一化器版本以及测试脚本哈希。导入后保留 `observation/capture.pcap` 原件、归一化包、元数据、差异和 evidence manifest。

runner 已记录 run ID、内核/Python 版本、工具二进制哈希、所选 TCP sysctl、命令、退出码和日志哈希。成功的运行记录绑定构建/模型/脚本/预期轨迹。应在完成该次真实运行后导入对应抓包；导入记录会绑定当时成功运行的结果哈希。更换 run ID 或重新运行后，旧观测需要重新导入。

抓包来源由操作者声明，哈希不能证明采集来源。验收器会拒绝把当前构建的合成 PCAP 直接重新标记为 external_capture，也会明确报告该来源仍是 user assertion。手写或重新编码的合成数据必须如实标注，不能用作实机证据。

## 结果归类

- 模型不变量失败：检查模型语义与规范解释，保留反例。
- `Uncovered`：模型范围或规则尚不完整，不对实现作判断。
- packetdrill 失败：先检查环境、配置、脚本语义与容差，再分析实现差异。
- JSON 差异：检查观测归一化，再追溯 packet/event/requirement ID。
- 规范缺口或冲突：必须在确认模型覆盖、假设与规范版本之后人工审查。

本地 `report.json` 是构建时快照，外部证据单独保存。运行 `python3 -m protocol_lab assess --scenario syn-loss` 生成 `acceptance.json`，校验当前代码/规范/模型/场景、构建产物、求解记录、运行记录与观测文件的哈希，并重新执行抓包归一化和差异比较。

指定场景只有在本地快照有效、Z3 安全/重叠检查通过、packetdrill 执行成功、同次运行绑定的外部抓包匹配时才能通过。默认验收全部四个场景。可选某一场景先完成闭环，报告始终列出实际验收范围。缺失结果、合成来源、未确认来源、未绑定执行和 offload 待审为 pending；过期/损坏证据、求解反例或实测失败为 fail。

退出码 0 仅用于所选场景闭环通过，pending/fail 都退出 2。该门槛包含有界状态检查，不声明完整 TCP 合规或无界形式证明。
