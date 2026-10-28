"""Build reproducible evidence without claiming unrun external checks."""
import copy
import hashlib
import json
import platform
from pathlib import Path
import shutil
import subprocess
import sys
import uuid

from .explore import explore
from .ir import Machine, ModelError, load, require, value_ok
from .packets import compare, normalize_trace, packetdrill, write_pcap

ROOT = Path(__file__).resolve().parents[1]


def read(path):
    return json.loads(Path(path).read_text())


def write(path, value):
    Path(path).write_text(json.dumps(value, indent=2, ensure_ascii=False) + "\n")


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def preflight():
    caps = 0
    status = Path("/proc/self/status")
    if status.exists():
        for line in status.read_text().splitlines():
            if line.startswith("CapEff:"):
                caps = int(line.split()[1], 16)
    return {"platform": sys.platform, "packetdrill": shutil.which("packetdrill"),
            "ivy_check": shutil.which("ivy_check"), "tun": Path("/dev/net/tun").exists(),
            "cap_net_admin": bool(caps & (1 << 12)), "cap_net_raw": bool(caps & (1 << 13))}


def verify_sources():
    sources = read(ROOT / "spec/sources/manifest.json")
    for item in sources:
        path = ROOT / f"spec/sources/rfc{item['rfc']}.txt"
        require(digest(path) == item["sha256"], f"RFC source hash mismatch: {path.name}")
    return sources


class TraceContractMismatch(ModelError):
    """A reference execution violates an independent fixed-input output contract."""
    def __init__(self, scenario, at_ms, expected, observed):
        super().__init__(f"Scenario trace contract mismatch: {scenario} at {at_ms}ms")
        self.scenario = scenario
        self.at_ms = at_ms
        self.expected = copy.deepcopy(expected)
        self.observed = copy.deepcopy(observed)


def run_scenario(model, scenario):
    require(scenario.get("scenario_version") in ("0.1", "0.2"), "Unsupported scenario version")
    machine = Machine(model, scenario.get("initial"))
    for step in scenario["steps"]:
        if "expect_trace" in step:
            require(scenario["scenario_version"] == "0.2", "Trace contracts require scenario 0.2")
            contract = step["expect_trace"]
            require(type(contract) is list, "Bad trace contract list")
            for row in contract:
                require(type(row) is dict and set(row) == {"at_ms", "emitted"}, "Bad trace contract row")
                require(type(row["at_ms"]) is int and row["at_ms"] >= 0, "Bad trace contract time")
                require(type(row["emitted"]) is list, "Bad trace contract emissions")
                for output in row["emitted"]:
                    require(type(output) is dict and set(output) == {"message", "fields"}, "Bad trace contract output")
                    require(type(output["message"]) is str, "Bad trace contract message")
                    schema = model["messages"].get(output["message"])
                    require(schema is not None and type(output["fields"]) is dict
                            and set(output["fields"]) == set(schema["fields"]), "Bad trace contract message fields")
                    require(all(value_ok(output["fields"][key], kind) for key, kind in schema["fields"].items()), "Bad trace contract field type")
        trace_start = len(machine.trace)
        if step.get("tick"):
            machine.tick(step["at_ms"])
        else:
            machine.dispatch(step["event"], step.get("fields", {}), step["at_ms"])
        if "expect_trace" in step:
            observed = [{"at_ms": row["time_ms"], "emitted": row["emitted"]} for row in machine.trace[trace_start:]]
            if observed != step["expect_trace"]:
                raise TraceContractMismatch(scenario["id"], step["at_ms"], step["expect_trace"], observed)
    if "settle_ms" in scenario:
        machine.tick(scenario["settle_ms"])
    expected = scenario["expect"]
    require(machine.state == expected["state"], "Scenario final state mismatch")
    for key, value in expected.get("variables", {}).items():
        require(machine.values.get(key) == value, f"Scenario variable mismatch: {key}")
    require(machine.timers == expected["timers"], "Scenario timer mismatch")
    return machine


def build(out):
    out = Path(out)
    out.mkdir(parents=True, exist_ok=True)
    summary_path = out / "report.json"
    if summary_path.exists():
        summary_path.unlink()
    model_path = ROOT / "model/tcp.json"
    model = load(model_path)
    sources = verify_sources()
    report = {"flow_version": "0.2", "model_sha256": digest(model_path), "sources": sources,
              "stages": {"source_integrity": "pass", "ir_validation": "pass"},
              "formal": {"status": "not_run", "backend": "z3-bmc", "reason": "Run the formal command; results are assessed separately. Ivy translation is not implemented."},
              "real_stack": {"status": "not_run", "reason": "Run packetdrill explicitly on a prepared Linux test host."},
              "observation_difference": {"status": "not_run", "reason": "No independently observed implementation trace supplied."},
              "preflight": preflight(), "scenarios": []}
    checks = explore(model, read(ROOT / "model/exploration.json"))
    write(out / "bounded-check.json", checks)
    report["stages"]["bounded_safety"] = checks["status"]
    report["stages"]["model_coverage"] = "gaps_found" if checks["uncovered"] else "no_gaps_in_sampled_domains"
    require(checks["status"] != "fail", "Bounded check failed; see bounded-check.json")
    for path in sorted((ROOT / "scenarios").glob("*.json")):
        scenario = read(path)
        name = scenario["id"]
        require(name == path.stem, "Scenario id must equal filename stem")
        machine = run_scenario(model, scenario)
        packets = normalize_trace(machine, scenario)
        target = out / name
        target.mkdir(exist_ok=True)
        write(target / "trace.json", machine.trace)
        write(target / "packets.json", packets)
        write(target / "scenario.json", scenario)
        write_pcap(target / "model.synthetic.pcap", packets)
        script, mapping = packetdrill(packets)
        (target / "test.pkt").write_text(script)
        write(target / "packet-map.json", {"capture_origin": "synthetic_model", "capture_point": "local_endpoint_egress_and_ingress",
              "packets": [{"pcap_frame": i+1, "packet_id": p["packet_id"], "event_id": p["event_id"],
                           "requirements": p["requirements"], "dropped_after_egress": p["dropped_after_egress"]} for i, p in enumerate(packets)],
              "packetdrill_lines": mapping})
        report["scenarios"].append({"id": name, "sha256": digest(path), "status": "reference_pass",
                                    "transitions": [r["transition"] for r in machine.trace],
                                    "packet_count": len(packets), "pcap_origin": "synthetic_model",
                                    "packetdrill": "generated_not_executed"})
    report["stages"]["reference_execution"] = "pass"
    report["stages"]["packet_artifacts"] = "generated"
    report["flow_status"] = "local_slice_pass_external_validation_pending"
    # Pin runtime, domain config and adapter sources as well as model/scenarios.
    inputs = [ROOT / "model/exploration.json"] + sorted((ROOT / "protocol_lab").glob("*.py"))
    report["implementation_hashes"] = {str(p.relative_to(ROOT)): digest(p) for p in inputs}
    # External results must never become local build inputs on the next rebuild.
    generated = [out / "bounded-check.json"]
    for scenario in report["scenarios"]:
        generated += [out / scenario["id"] / n for n in ("trace.json", "packets.json", "scenario.json", "model.synthetic.pcap", "test.pkt", "packet-map.json")]
    report["artifact_hashes"] = {str(p.relative_to(out)): digest(p) for p in generated}
    from .evidence import fingerprint
    report["input_hashes"] = fingerprint()
    write(summary_path, report)
    return report


def run_packetdrill(script, out):
    """Run only when explicitly requested; never silently mark a skip as success."""
    out = Path(out)
    out.mkdir(parents=True, exist_ok=True)
    env = preflight()
    script = Path(script).resolve()
    require(script.is_file(), f"Missing packetdrill script: {script}")
    ready = env["platform"] == "linux" and env["packetdrill"] and env["tun"] and env["cap_net_admin"] and env["cap_net_raw"]
    result = {"status": "not_run", "preflight": env, "script": str(script), "script_sha256": digest(script),
              "run_id": uuid.uuid4().hex,
              "kernel": platform.release(), "python": platform.python_version(),
              "reason": "Requires Linux, packetdrill, /dev/net/tun, CAP_NET_ADMIN and CAP_NET_RAW."}
    result["tcp_profile"] = {}
    for name in ("tcp_syn_retries", "tcp_syn_linear_timeouts", "tcp_timestamps", "tcp_ecn"):
        setting = Path("/proc/sys/net/ipv4") / name
        if setting.exists():
            result["tcp_profile"][name] = setting.read_text().strip()
    if (script.parent.parent / "report.json").exists():
        from .evidence import binding
        result["binding"] = binding(script.parent.parent, script.parent.name)
    write(out / "external-run.json", result)
    if ready:
        result["tool_sha256"] = digest(env["packetdrill"])
        cmd = [env["packetdrill"], "--tolerance_usecs=50000", str(script)]
        result["command"] = cmd
        try:
            run = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
            (out / "external.log").write_text(run.stdout + run.stderr)
            result["log_sha256"] = digest(out / "external.log")
            result.update(status="pass" if run.returncode == 0 else "fail", returncode=run.returncode, reason=None)
        except subprocess.TimeoutExpired:
            result.update(status="fail", reason="packetdrill timeout after 30 seconds")
        except OSError as exc:
            result.update(status="fail", reason=str(exc))
    write(out / "external-run.json", result)
    return result
