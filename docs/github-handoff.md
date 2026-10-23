# GitHub 迁移与复现

仓库：https://github.com/briliant-ben/TCPIP-Model

仓库包含作者工程、RFC 基线与来源哈希、全部模型和场景、参考执行与 Z3 检查代码、测试、文档、现有证据产物，以及保留原许可证的固定版本 lwIP 源码。不依赖原云主机上的 Git 元数据或 Python 虚拟环境。

## 在新 Linux 机器上开始

需要 Git、Python 3.11+、Python venv 和 C99 编译器。以下命令不需要 TUN 或原始套接字权限：

```bash
git clone https://github.com/briliant-ben/TCPIP-Model.git
cd TCPIP-Model
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-formal.txt
.venv/bin/python -m unittest discover -s tests -v
.venv/bin/python -m protocol_lab build
.venv/bin/python -m protocol_lab formal
.venv/bin/python -m protocol_lab suite --formal --depth 6
.venv/bin/python -m protocol_lab suite-verify
```

lwIP 源码已随仓库保存，普通 clone 即可，不需要初始化子模块。上游版本、来源、许可证和构建输入哈希见 `third_party/README.md` 与 `third_party/lwip.lock.json`。

## 真实 lwIP 执行

```bash
.venv/bin/python -m protocol_lab lwip
.venv/bin/python -m protocol_lab lwip-verify
```

当前固定配置下，`lwip` 会因 SYN 丢包场景的时序投影差异返回 1；连接本身成功，差异保存在报告中。`lwip-verify` 检查执行证据完整性，不将时序差异自动视为 RFC 违规。具体边界见 `docs/lwip-testing.md`。

## 证据与重建

`artifacts/` 中提交的 JSON、SMT-LIB、DOT、PCAP 和日志是开发时的证据快照。编译器路径、命令、二进制哈希与日志可能对应原云环境；这些文件不保证在新机器上逐字一致。

Python 虚拟环境、缓存、上游 `.git` 元数据和编译出的 `lwip-harness` 二进制不入库。新机器应重新运行上述构建/执行命令，再校验新生成的证据。缺少二进制时，直接校验旧 lwIP 报告会失败，这是预期行为。

## 后续 Linux TCP 实机验证

独立的 Linux packetdrill 通道还需要 packetdrill、`/dev/net/tun`、CAP_NET_ADMIN 和 CAP_NET_RAW。该通道与 lwIP 内存接口分别验收，不必先完成它才能继续开发模型。

目前整栈尚未完成；已有模型范围与剩余协议见 `docs/stack-scope.md` 和 `profiles.json`。
