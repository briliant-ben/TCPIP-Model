
## 复现本阶段检查

```sh
.venv/bin/python -m unittest discover -s tests -p 'test_idle_restart*.py' -v
.venv/bin/python -m protocol_lab inductive model/tcp-idle-restart.json --out artifacts/idle-restart-initial-induction
.venv/bin/python -m protocol_lab inductive-refine model/tcp-idle-restart.json --inductive artifacts/idle-restart-initial-induction --out artifacts/idle-restart-initial-refinement --group-size 1
.venv/bin/python -m protocol_lab inductive-refine-verify model/tcp-idle-restart.json --inductive artifacts/idle-restart-initial-induction --out artifacts/idle-restart-initial-refinement
PYTHONPATH=. .venv/bin/python artifacts/tcp-idle-restart-development/acceptance/development-driver.py
PYTHONPATH=. .venv/bin/python artifacts/tcp-idle-restart-development/acceptance/development-verifier.py
```

提交的证据为该版本环境快照。重建使用新的输出目录或先保留原始快照，不能通过放宽SHA验收去迁就旧产物。独立重放脚本使用临时生成配置，三个场景仅用于模型／合成codec检查；主BMC和归纳unknown单列，不宣称完整协议证明。
