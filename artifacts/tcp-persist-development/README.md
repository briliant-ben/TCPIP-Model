# persist 开发流水线证据

未注册于统一 11 profile。30 个固定输入（7 新 persist、23 原恢复／SYN／delayed ACK）参考执行、完整字节符号重放和严格 tcp-connection-v1 合成 codec 均通过。不是独立实现或 Linux 实机证据。

主 depth=6 BMC 与主归纳均保留 unknown；原初值／guard／时钟义务和全部未知目标的完整单项补充分组、非空样本及独立复查通过。development-verification.json 记录当前冻结输入、全部 report 文件哈希、源文档、模型、claims 重建和实际独立验证。原查询和时间预算未放宽。

```sh
.venv/bin/python -m protocol_lab inductive-refine-verify model/tcp-persist.json --inductive artifacts/tcp-persist-development/inductive --out artifacts/tcp-persist-development/inductive-refinement
```

193 规则／161 不变量仍只是有限数据 persist 子集。FIN-only、资源策略、拥塞恢复、通用输出／时序、解释／翻译／实现精化与独立数据实现尚未完成。原 CLOSING 漏洞和任意前状态／可达参考复现分别保留，见 artifacts/persist-initial 及 diagnostics/persist-before-closing-states-v1。
