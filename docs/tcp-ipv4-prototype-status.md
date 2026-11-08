# IPv4 有限原型验收状态

2026-11-08：有限原型已具备实际组合运行与 review 材料，见 [成果审阅](ipv4-prototype-review.md)。源码92896425的六项workflow全成功；单个IR生成C PID2802完成ARP/TCP四字节回显与关闭/三UDP往返/三ICMP Echo，25capture/filter、零drops、静默146.049162ms。参考/C实际19条转换与固定输入Z3 SAT/重放通过。完整原件和只读哈希审计在 artifacts/ipv4-prototype-final-9289。

权威当前profile为 model/ipv4-endpoint-virtual-link.json（335规则、58变量、65不变量、61要求）；原canonical/TCP-onlyvirtual模型与58/42字节失败证据保留。所有协议guard/action/queue/timer与来源显式IR，Python只处理原始IO、机械时间和测试刺激。

服务器最终十阶段task bc771c5a实际32例比较及335规则来源绑定通过；八阶段pass，depth1全输入检查UNKNOWN、声明探索10/335覆盖缺口 → assessment unresolved。证据校验一致不提升未知性质。固定路径、合成fixture、实机和证明结论分别保存。

固定单peer/端口、MTU1500及TCP16bytebuffer/SMSS4是当前边界。通用路由/分片/动态绑定/TCP一般乱序拥塞恢复/socket/IPv6/上层不在原型内；TIMEWAIT实时时间到期、完整协议/编译器/规范解释正确性未证明。旧TCP/ICMP UNKNOWN、lwIP2750ms/LinuxTCP Difference保持。后续framework工作等待共同review，PR未自动main合入。
