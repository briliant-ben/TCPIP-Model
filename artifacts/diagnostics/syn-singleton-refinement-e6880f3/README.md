# SYN 单项分组补充证据

对应 e6880f3 源码与模型。主归纳及原 group_size=8 补充 unknown 保存在同级 syn-clock-progress-e6880f3；不修改原结果。

本目录使用已有 refinement API 的 group_size=1，单查询仍为 10000ms，完整覆盖三个原未知目标的 166/166/167 个析取项。全部上下文断言保留；等价、所有组、生成时独立复查、非空完整字节声明规则样本及独立完整 verify 均通过。搬迁后 CLI 再次实际验证，日志保留。

复查命令（当前绑定源码及 Z3 版本须一致）：

```sh
.venv/bin/python -m protocol_lab inductive-refine-verify model/tcp-syn-history.json --inductive artifacts/diagnostics/syn-clock-progress-e6880f3/inductive --out artifacts/diagnostics/syn-singleton-refinement-e6880f3
```

只有补充状态归纳命题通过；原主归纳/BMC unknown 不升级。不是字节内容、通用输出/时间、解释/翻译精化、Rocq、完整 TCP 或 Linux 实机证明。SYN 尚未注册标准 suite。
