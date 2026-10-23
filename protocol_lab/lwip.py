"""Compile and observe the pinned, unmodified lwIP C implementation without TUN."""
import json
from pathlib import Path
import shutil
import subprocess

from .capture import normalize
from .evidence import binding
from .flow import ROOT, digest, read, write
from .ir import require
from .packets import compare


def sources():
    manifest = read(ROOT / "third_party/lwip.lock.json")
    base = ROOT / manifest["source_directory"]
    require(base.is_relative_to(ROOT), "Invalid vendor source directory")
    for rel, expected in manifest["files"].items():
        path = (base / rel).resolve()
        require(path.is_relative_to(base.resolve()), "Vendor path escapes source directory")
        require(path.is_file() and digest(path) == expected, f"Pinned lwIP source missing/changed: {rel}")
    return manifest, base


def build_lwip(out):
    out = Path(out)
    out.mkdir(parents=True, exist_ok=True)
    record = {"status": "incomplete"}
    write(out / "build.json", record)
    manifest, base = sources()
    cc = shutil.which("cc")
    require(cc is not None, "C compiler is required for the lwIP adapter")
    port = ROOT / "ports/lwip"
    source_files = [base / rel for rel in manifest["files"] if rel.endswith(".c")]
    binary = (out / "lwip-harness").resolve()
    command = [cc, "-std=c99", "-O1", "-g", "-I"+str(port), "-I"+str(base / "src/include"),
               str(port / "harness.c"), *[str(p) for p in source_files], "-o", str(binary)]
    run = subprocess.run(command, capture_output=True, text=True, timeout=60)
    (out / "build.log").write_text(run.stdout + run.stderr)
    record = {"status": "pass" if run.returncode == 0 else "fail", "returncode": run.returncode,
              "command": command, "compiler_sha256": digest(cc), "commit": manifest["commit"],
              "vendor_manifest_sha256": digest(ROOT / "third_party/lwip.lock.json"),
              "port_hashes": {str(p.relative_to(ROOT)): digest(p) for p in sorted(port.rglob("*")) if p.is_file()},
              "log_sha256": digest(out / "build.log")}
    if run.returncode == 0:
        record["binary_sha256"] = digest(binary)
    write(out / "build.json", record)
    require(run.returncode == 0, f"lwIP compilation failed; see {out / 'build.log'}")
    return binary, record


def run_lwip(artifacts):
    artifacts = Path(artifacts).resolve()
    # Verify current model/scenario/adapter sources before producing implementation evidence.
    bindings = {name: binding(artifacts, name) for name in ("handshake", "syn-loss")}
    out = artifacts / "lwip"
    out.mkdir(parents=True, exist_ok=True)
    write(out / "report.json", {"status": "incomplete"})
    binary, built = build_lwip(out / "bin")
    result = {"status": "executed", "implementation": "lwIP", "upstream_commit": built["commit"],
              "network_interface": "in_memory_ipv4", "clock": "virtual_ms", "host_tcp_stack": False,
              "scope": "single_active_connection_no_payload", "full_stack_validated": False,
              "build_record_sha256": digest(out / "bin/build.json"), "scenarios": []}
    for name in ("handshake", "syn-loss"):
        target = out / name
        target.mkdir(exist_ok=True)
        command = [str(binary), name, str(target / "capture.pcap")]
        executed = subprocess.run(command, capture_output=True, text=True, timeout=10)
        (target / "execution.log").write_text(executed.stdout + executed.stderr)
        require(executed.returncode == 0, f"lwIP execution failed; see {target / 'execution.log'}")
        summary = json.loads(executed.stdout)
        require(summary.get("connected") == 1, "lwIP callback did not confirm connection")
        expected = read(artifacts / name / "packets.json")
        packets, metadata = normalize(target / "capture.pcap", read(ROOT / "packet-profile.json"), expected,
                                      origin="external_capture", checksum_policy="strict")
        metadata.update(producer="lwip_memory_netif", clock="virtual_ms", binary_sha256=digest(binary))
        write(target / "packets.json", packets)
        write(target / "metadata.json", metadata)
        difference = compare(expected, packets)
        write(target / "difference.json", difference)
        record = {"scenario": name, "binding": bindings[name], "execution": "pass", "returncode": executed.returncode,
                  "command": command, "summary": summary, "comparison": difference["status"],
                  "binary_sha256": digest(binary), "files": {n: digest(target / n) for n in
                      ("capture.pcap", "packets.json", "metadata.json", "difference.json", "execution.log")},
                  "interpretation": "A mismatch is a profile/observation difference requiring analysis, not an automatic RFC-conformance verdict."}
        write(target / "execution.json", record)
        result["scenarios"].append(record)
    result["status"] = "executed_with_differences" if any(r["comparison"] != "match" for r in result["scenarios"]) else "execution_and_projection_pass"
    write(out / "report.json", result)
    return result


def verify_lwip(artifacts):
    artifacts = Path(artifacts).resolve()
    out = artifacts / "lwip"
    manifest, base = sources()
    report = read(out / "report.json")
    require(report["status"] in ("executed_with_differences", "execution_and_projection_pass"), "lwIP run is incomplete")
    built = read(out / "bin/build.json")
    require(digest(out / "bin/build.json") == report["build_record_sha256"], "lwIP build record changed")
    require(built["status"] == "pass" and built["commit"] == manifest["commit"], "lwIP vendor revision mismatch")
    require(built["vendor_manifest_sha256"] == digest(ROOT / "third_party/lwip.lock.json"), "Vendor source manifest changed")
    actual_port = {str(p.relative_to(ROOT)): digest(p) for p in sorted((ROOT / "ports/lwip").rglob("*")) if p.is_file()}
    require(built["port_hashes"] == actual_port, "lwIP port changed")
    require(built["binary_sha256"] == digest(out / "bin/lwip-harness"), "lwIP binary changed")
    require(built["log_sha256"] == digest(out / "bin/build.log"), "lwIP compiler log changed")
    require({r["scenario"] for r in report["scenarios"]} == {"handshake", "syn-loss"}, "lwIP scenario set mismatch")
    for record in report["scenarios"]:
        name = record["scenario"]
        target = out / name
        require(read(target / "execution.json") == record, "lwIP execution record changed")
        require(record["binding"] == binding(artifacts, name), "lwIP model binding is stale")
        require(record["binary_sha256"] == built["binary_sha256"] and record["returncode"] == 0, "lwIP process did not pass")
        require(set(record["files"]) == {"capture.pcap", "packets.json", "metadata.json", "difference.json", "execution.log"}, "lwIP evidence file manifest mismatch")
        for filename, expected_hash in record["files"].items():
            require(digest(target / filename) == expected_hash, "lwIP observed evidence changed")
        packets, metadata = normalize(target / "capture.pcap", read(ROOT / "packet-profile.json"),
                                     read(artifacts / name / "packets.json"), "external_capture")
        require(packets == read(target / "packets.json"), "lwIP normalization mismatch")
        difference = compare(read(artifacts / name / "packets.json"), packets)
        require(difference == read(target / "difference.json") and difference["status"] == record["comparison"], "lwIP difference mismatch")
    result = {"status": "valid_execution_evidence", "comparison_status": report["status"], "full_stack_validated": False}
    write(out / "verification.json", result)
    return result
