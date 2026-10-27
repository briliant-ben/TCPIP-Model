# persist 初始开发验收

14 方法通过，包括 7 个手写字节／输出／时刻契约的完整字节重放。LAST-ACK 用例明确是满足父状态不变量的任意前状态夹具，不宣称正常生命周期可达；另外的 CLOSING 旧缺口有实际参考输入复现。原失败模型和查询保留在 diagnostics/persist-before-closing-states-v1。

193 规则／161 不变量的主归纳 unknown，初值、guard 与纯时钟义务通过，全部未知目标单项补充分组和独立 CLI verify 通过。原查询状态不改名。不代表 BMC、通用字节／输出／时序、解释／翻译／实现精化、活性或 Linux 实机。

```sh
.venv/bin/python -m protocol_lab inductive-refine-verify model/tcp-persist.json --inductive artifacts/persist-initial/inductive --out artifacts/persist-initial/inductive-refinement
```

新模型尚未注册 11 profile，完整开发 pipeline 与独立实现证据仍需继续。原始产物字节保留；源目录迁移只允许同 SHA256 的原查询。
