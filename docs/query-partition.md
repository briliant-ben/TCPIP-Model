# 导出 SMT 查询的精确布尔分组复查

`formal/partition_queries.py` 是开发中的独立辅助检查器，不修改协议 IR，不替代标准归纳后端，不把其原始 unknown 重标为通过。它处理由归纳后端导出的单个带标签查询；不支持增量 push/pop、多个 check-sat、assumptions 或其他未声明命令，遇到这些构造明确拒绝。

给定原查询 `C ∧ A`，保留 C 中的每条断言。仅将 A 的显式 Or，以及 `not(and(...))` 的德摩根展开分为全部析取项；分组覆盖每一个项，不跳过难项。先用独立 SMT 查询检查 A 与完整展开等价，再分别检查 `C ∧ group_i`。只有等价义务及全部分组 unsat 才返回 query_partition_unsat；任何 sat/unknown 均不算通过，也不宣称反例可达。

默认每组至多 16 项，每次求解仍为 10000ms，不扩大输入或步数边界。结果绑定原始完整 SMT 文件、标签、所选断言、全部项的索引覆盖、检查器源码、Z3 版本及每个导出查询的哈希。`--verify` 重新读取原查询，逐项检查组文件恰好保留原上下文及相应析取项，校验覆盖、哈希、版本，再重新求解；不能仅重新计算哈希来删掉约束或把 unknown 改成通过。

在仓库根目录复现当前两个开发义务：

```bash
.venv/bin/python formal/partition_queries.py --verify --out artifacts/tcp-tx-history/query-partitions/pending
.venv/bin/python formal/partition_queries.py --verify --out artifacts/tcp-tx-history/query-partitions/other
```

生成 pending 证据的命令（默认选择断言索引 -4，原文件中的所有其他断言仍完整保留）：

```bash
.venv/bin/python formal/partition_queries.py artifacts/tcp-tx-history/inductive/preservation.smt2 --label 'F-RECEIVE-FIN-WAIT-1-net-fin_segment-PENDING-ACK-DUPLICATE -> FIN-WAIT-1' --group-size 8 --out artifacts/tcp-tx-history/query-partitions/pending
```

当前发送历史模型的 217 个目标检查中，标准后端 215 个 unsat、2 个 unknown；对应两个 unknown 的全部 160／161 个析取项分成 20／11 组后，等价义务与全部组均实际 unsat，另一个进程的 verify 也通过。原归纳报告仍为 unknown。尚未把这种精化接入 suite／claims 的标准验收；不得仅据此把开发模型标为完整验证，更不代表 Rocq 内核证明、通用输出精化或独立协议实现证据。可信组件仍包括 Z3、SMT 解析／序列化和该辅助检查器，原模型到 SMT 的翻译对应仍未证明。

复查稳定性：共享进程全局 Z3 context 的首版曾在单独进程通过后，于聚合复查中出现 unknown；旧检查器及查询保存在 artifacts/diagnostics/query-partition-global-context。当前每条等价／分组查询都将完整公式翻译到新的 Z3 context，再以相同 10000ms 限时求解；不受前序查询的 AST 分配次序影响，不减少断言或改变域。源码变化后须真正重新生成及复查，不能只更新旧结果的检查器哈希。
