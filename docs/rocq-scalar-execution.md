# 源 IR 到 Rocq 标量执行语义试点

源模型是 `model/seq32-contract.json`。`formal/rocq-scalar/compile.py` 生成
`Compiled.v` 数据构造子，另一个逆向解析器恢复原始 JSON 表达式、赋值顺序、
初值、事件序列域和不变量；`Semantics.v` 定义该片段的求值及有序状态更新。
`Proofs.v` 的命题直接引用生成程序和生成性质。

已接纳的片段：IR0.2、flat ordered-v1、单非终止状态、单 application 事件、
无条件自环、int/seq32 变量、有序 set 和 eq 不变量；表达式含整数、变量、
事件字段及 add/sub/seq_add/seq_distance。定时器、消息、条件控制、其他类型／
表达式、额外语义字段均拒绝。证明体针对当前标量契约布局，不是通用证明生成器。

## 实际命题与证据

[CI41033653538](https://github.com/briliant-ben/TCPIP-Model/actions/runs/41033653538)
在源码e08d3fdb及digest固定Rocq9.2.0镜像运行成功：

1. 生成初始环境满足生成的两条相等性质。
2. 对任意初始数据环境及符合声明seq32域的事件输入，执行生成的7条有序赋值
   后满足生成的两条相等性质。offset是无界Z，不附加seq32范围限制。

两次空公理审计、三模块独立 `rocq check` 通过。错误逆位移和错误赋值顺序的源IR
变体必须先成功编译生成数据模块，继而在执行证明的 `change` 检查中被拒绝；
两个源错误同时有合法参考输入导致不变量失败。公理注入由审计拒绝。

`artifacts/rocq-scalar-ci-e08d3fdb/` 保留官方API来源／原ZIP、完整job日志、源码与
.vo对象、正反编译／kernel日志及独立离线绑定验收。6个临时副本检查拒绝对象损坏、
重哈希错误字段、把offset额外收窄为seq32、削弱命题、替换错误源变体和扩大证明范围。
对象损坏检查是哈希完整性门，不能替代对重哈希对象的真实kernel检查或原ZIP来源。
原件未改，本地没有重新运行kernel。

在命名源码检查点：

```sh
.venv/bin/python formal/rocq-scalar/verify.py --out artifacts/rocq-scalar-ci-e08d3fdb/download
.venv/bin/python artifacts/rocq-scalar-ci-e08d3fdb/faults.py
.venv/bin/python artifacts/rocq-scalar-ci-e08d3fdb/accept.py
```

新执行使用 `formal/rocq-scalar/check.py --docker --out artifacts/new-name`，不得覆盖
旧证据。源变更有意使检查点绑定失效，应使用对应源码而不是放宽哈希。

## 边界与保留历史

kernel检查的是形式片段语义中**实际生成程序**的定理。JSON与构造子的一致性由
可信Python逆向解析器检查，形式语义定义、源类型验证及编排／来源仍属于可信基。
这不是对JSON解析器／编译器、Python解释器或Z3翻译器的普遍kernel证明，也不是
TCP状态机、字节、网络输出顺序、时间、活性、实现或Linux协议执行证明。原标量
模型对完整kernel／通用解释器对应证明的排除没有被重写成已完成。

第一次CI在证明整体谓词的 `vm_compute` 展开处未能于180s完成；第二次初态审计
通过但step证明的列表引理应用失败。原ZIP、部分对象、源码和诊断分别保留在
`artifacts/diagnostics/rocq-scalar-first-ci`、`rocq-scalar-second-ci`。三个版本的源IR、
生成程序和定理陈述相同；修正仅涉及证明体及失败日志保存，没有提高上限、增加公理、
收窄输入或修改原不变量。

7项结构方法和此前31项相关方法合计38项专项通过。新7方法不在71a3e1a8正在运行
的442项冻结回归内；当前449项完整发现尚未全部运行。TCP的69个相关ACK未知分支、
一般SSA／环形赋值、字节／时序／实现关系和全部后续协议仍需继续。
