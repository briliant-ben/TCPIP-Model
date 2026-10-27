# Delayed ACK 开发证据

未注册为九 profile suite 成员。7 个手写输出／时间场景参考执行、完整字节重放及合成 codec 通过；不是 Linux／lwIP 数据执行证据。

原 report/claims 保持原字节：depth=6 BMC unknown、主归纳 unknown，默认 group_size=8 补充生成时通过，但随后独立复查 group-007 在 10000ms 超时。完整失败日志与 pending 元数据保留，不能把生成通过当作本次独立验收通过。

新增 inductive-refinement-singletons 对原主归纳全部 unknown 目标按 group_size=1 完整分组，保留全部上下文与 10000ms 限时，等价、全部组、生成时独立复查、非空完整字节样本及另一次完整 verify 通过。原报告没有用新证据重新哈希。development-verification.json 分别绑定两个结果。

复查独立单项证据：

```sh
.venv/bin/python -m protocol_lab inductive-refine-verify model/tcp-delayed-ack.json --inductive artifacts/tcp-delayed-ack-development/inductive --out artifacts/tcp-delayed-ack-development/inductive-refinement-singletons
```

状态不变量不证明通用字节内容、输出或定时器／首段截止点关系。模型范围和未完成项见 docs/tcp-delayed-ack.md；后续统一 profile 需要显式接入对应分组配置并实际重建。
