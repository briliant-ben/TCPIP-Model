# 固定版本的通用框架客户端

通用框架现位于 [Formal-Spec-Agent](https://github.com/briliant-ben/Formal-Spec-Agent)。
此仓库继续保存 TCP/IP 模型、C复现输入、规范与oracle、仿真测试、网络适配器和原始证据。
`framework` 是单向Git子模块；`framework.lock.json` 同时固定提交和全部执行源文件摘要。
不存在反向子模块或另一份持续演进的通用语义实现。

## 新执行

```sh
git submodule update --init --recursive
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-formal.txt

# 摘要应由验收控制器批准；本地计算只表示绑定当前版本
TASK_SHA=$(shasum -a 256 flows/tcp-active-open.json | cut -d ' ' -f 1)
.venv/bin/python tools/run_framework_candidate.py run flows/tcp-active-open.json \
  --workspace . --out /tmp/tcp-framework-run-001 --task-sha256 "$TASK_SHA"
.venv/bin/python tools/run_framework_candidate.py verify /tmp/tcp-framework-run-001 \
  --workspace . --task-sha256 "$TASK_SHA"
```

输出目录必须全新，不能位于框架工具目录内。客户端先核对子模块提交与完整源文件集合，
再在独立进程中从框架目录启动；它不会在当前TCP/Python进程中混合导入同名包。
缺少子模块、提交不符或改动源码会明确拒绝，不会静默回退到旧执行器。

`flows/udp-header.json`、`flows/ipv4-prototype-closeout.json` 等普通IR事件／原始字节任务
同样使用此入口；各自范围和失败／UNKNOWN约定保持不变。新的框架运行拥有新的工具哈希，
**不能当成旧证据重新验收通过**。旧的专用TCP `wire` codec仍由基准仓库复现，通用框架
对该旧扩展明确拒绝；IR自己构造原始bytes的完整原型无需那个codec。

## 历史证据与维护边界

原 `protocol_lab` 保留为**冻结历史兼容快照**。清单为
`docs/frozen-legacy-framework.json`；迁移回归检查其摘要未改。
既有原型交付、旧CI／solver结果和端口工具继续使用相应原Git/source epoch复现。
不删除它、改哈希或拿新框架冒充旧checker，也不在这里继续添加通用IR／后端功能。

通用特性只在Formal-Spec-Agent中修改并验证；本仓库通过明确的子模块pin＋lock更新接入，
随后产生新的测试／证据版本。协议模型与网络peer适配器仍在本仓库开发。现有PR不自动合入main。

## 已实际核对

新框架独立运行外部TCP主动打开和UDP描述子两个十阶段任务、保留校验均通过，
没有复制其协议模型。客户端四项测试还检查了版本／源码拒绝、旧快照冻结，以及完整
335规则IPv4 IR的新生成C哈希仍为 `19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b`，
并实际编译、执行一条冻结原型场景，参考／C对比通过。

这是迁移资格检查，不是新网络抓包、完整编译器等价或全TCP证明。原
`unresolved`、覆盖缺口、lwIP2750ms和LinuxTCP Difference均未改变。
