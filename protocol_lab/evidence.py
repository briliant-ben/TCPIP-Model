"""Hash-bound evidence records and conservative per-scenario acceptance gates.

Hashes detect stale/mismatched inputs, not forged provenance. External origin is
an explicit operator assertion and is always reported as such.
"""
import json
from pathlib import Path

from .capture import normalize, sha
from .flow import ROOT, digest, read, write
from .ir import ModelError, require
from .packets import compare
from .symbolic import model_hash


def fingerprint():
    paths = [ROOT / "model/tcp.json", ROOT / "model/exploration.json", ROOT / "docs/semantics.md",
             ROOT / "requirements-formal.txt", ROOT / "spec/sources/manifest.json"]
    paths += sorted((ROOT / "scenarios").glob("*.json"))
    paths += sorted((ROOT / "protocol_lab").glob("*.py"))
    return {str(p.relative_to(ROOT)): digest(p) for p in paths}


def ensure_snapshot(artifacts):
    artifacts = Path(artifacts).resolve()
    report = read(artifacts / "report.json")
    require(report.get("flow_status") == "local_slice_pass_external_validation_pending", "No passing local build snapshot")
    require(report.get("input_hashes") == fingerprint(), "Build is stale: rebuild before producing or accepting evidence")
    for rel, expected_hash in report["artifact_hashes"].items():
        path = (artifacts / rel).resolve()
        require(path.is_relative_to(artifacts), "Artifact path escapes build directory")
        require(path.is_file() and digest(path) == expected_hash, f"Build artifact changed: {rel}")
    for item in report["sources"]:
        require(digest(ROOT / f"spec/sources/rfc{item['rfc']}.txt") == item["sha256"], "RFC source changed")
    return report


def binding(artifacts, scenario):
    artifacts = Path(artifacts)
    report = ensure_snapshot(artifacts)
    require(scenario in {s["id"] for s in report["scenarios"]}, "Unknown scenario")
    return {"build_sha256": digest(artifacts / "report.json"), "scenario": scenario,
            "script_sha256": digest(artifacts / scenario / "test.pkt"),
            "expected_sha256": digest(artifacts / scenario / "packets.json"),
            "model_sha256": report["model_sha256"]}


def observe(artifacts, scenario, pcap, profile, origin="unverified", checksum_policy="strict"):
    artifacts = Path(artifacts)
    bind = binding(artifacts, scenario)
    target = artifacts / scenario / "observation"
    target.mkdir(parents=True, exist_ok=True)
    # Invalidate a previous passing record before decoding a replacement input.
    write(target / "evidence.json", {"status": "invalid", "binding": bind, "reason": "normalization incomplete"})
    packets, metadata = normalize(pcap, profile, read(artifacts / scenario / "packets.json"), origin, checksum_policy)
    # Keep a copy: provenance must remain inspectable without the original path.
    capture = target / "capture.pcap"
    data = Path(pcap).read_bytes()
    require(sha(pcap) == metadata["capture_sha256"], "Capture changed while reading")
    capture.write_bytes(data)
    write(target / "packets.json", packets)
    metadata["normalizer_source_sha256"] = digest(ROOT / "protocol_lab/capture.py")
    write(target / "metadata.json", metadata)
    result = compare(read(artifacts / scenario / "packets.json"), packets)
    write(target / "difference.json", result)
    hashes = {n: digest(target / n) for n in ("capture.pcap", "packets.json", "metadata.json", "difference.json")}
    execution = artifacts / scenario / "external-run.json"
    run_hash = None
    if execution.exists():
        run = read(execution)
        if run.get("binding") == bind and run.get("status") == "pass":
            run_hash = digest(execution)
    evidence = {"status": result["status"], "binding": bind, "files": hashes,
                "external_run_sha256": run_hash,
                "origin": origin, "origin_is_user_assertion": True}
    write(target / "evidence.json", evidence)
    return evidence


def check_observation(artifacts, scenario):
    path = Path(artifacts) / scenario / "observation"
    if not (path / "evidence.json").exists():
        return {"status": "not_run"}
    record = read(path / "evidence.json")
    require(record.get("binding") == binding(artifacts, scenario), "Observation has stale build binding")
    require(record.get("status") in ("match", "mismatch"), "Observation evidence is incomplete")
    require(set(record["files"]) == {"capture.pcap", "packets.json", "metadata.json", "difference.json"}, "Incomplete observation file manifest")
    for name, expected_hash in record["files"].items():
        require(digest(path / name) == expected_hash, f"Observation file changed: {name}")
    metadata = read(path / "metadata.json")
    require(record["origin"] == metadata["capture_origin"], "Capture origin metadata mismatch")
    require(metadata["capture_sha256"] == digest(path / "capture.pcap"), "Capture hash mismatch")
    # Recompute the result instead of trusting a saved 'match' string.
    packets, actual_metadata = normalize(path / "capture.pcap", metadata["profile"],
        read(Path(artifacts) / scenario / "packets.json"), record["origin"], metadata["checksum_policy"])
    require(packets == read(path / "packets.json"), "Normalized packet data mismatch")
    require({k: metadata[k] for k in actual_metadata} == actual_metadata, "Capture normalization metadata mismatch")
    require(metadata["normalizer_source_sha256"] == digest(ROOT / "protocol_lab/capture.py"), "Normalizer changed")
    actual = compare(read(Path(artifacts) / scenario / "packets.json"), packets)
    require(actual == read(path / "difference.json"), "Saved difference result mismatch")
    # A local generated PCAP can never establish external provenance via relabeling.
    synthetic_hashes = {digest(Path(artifacts) / s["id"] / "model.synthetic.pcap") for s in ensure_snapshot(artifacts)["scenarios"]}
    if metadata["capture_sha256"] in synthetic_hashes or record["origin"] == "synthetic":
        return {"status": "synthetic_only", "comparison": actual["status"]}
    if record["origin"] != "external_capture":
        return {"status": "unverified_origin", "comparison": actual["status"]}
    execution = Path(artifacts) / scenario / "external-run.json"
    if record.get("external_run_sha256") is None:
        return {"status": "unbound_run", "comparison": actual["status"]}
    require(execution.exists() and digest(execution) == record["external_run_sha256"], "Observation belongs to a different external execution")
    if actual["status"] != "match":
        return {"status": "fail", "comparison": actual["status"]}
    if metadata["checksum_warning_frames"]:
        return {"status": "checksum_review_required", "comparison": actual["status"], "frames": metadata["checksum_warning_frames"]}
    return {"status": "pass" if actual["status"] == "match" else "fail", "origin_is_user_assertion": True}


def check_external(artifacts, scenario):
    path = Path(artifacts) / scenario / "external-run.json"
    if not path.exists():
        return {"status": "not_run"}
    record = read(path)
    require(record.get("binding") == binding(artifacts, scenario), "Packetdrill evidence has stale/missing build binding")
    require(record.get("status") in ("pass", "fail", "not_run"), "Invalid packetdrill evidence status")
    require(record.get("script_sha256") == digest(Path(artifacts) / scenario / "test.pkt"), "Packetdrill script changed")
    if record["status"] == "pass":
        require(record.get("returncode") == 0 and len(record.get("tool_sha256", "")) == 64 and bool(record.get("kernel")) and bool(record.get("run_id")), "Incomplete external execution provenance")
        log = Path(artifacts) / scenario / "external.log"
        require(log.exists() and digest(log) == record.get("log_sha256"), "Packetdrill log changed/missing")
    return {"status": record["status"], "reason": record.get("reason")}


def check_formal(artifacts):
    path = Path(artifacts) / "formal"
    if not (path / "result.json").exists():
        return {"status": "not_run"}
    record = read(path / "result.json")
    require(record.get("build_sha256") == digest(Path(artifacts) / "report.json"), "Formal evidence has stale/missing build binding")
    require(record.get("model_semantic_sha256") == model_hash(read(ROOT / "model/tcp.json")), "Formal model changed")
    require(record.get("smt2_sha256") == digest(path / "model.smt2"), "Formal query changed")
    require(record.get("overlap_smt2_sha256") == digest(path / "overlap.smt2"), "Formal overlap query changed")
    status = record.get("status")
    require(status in ("bounded_pass", "counterexample", "conflict", "unknown", "vacuous", "semantic_mismatch"), "Invalid formal status")
    if status == "bounded_pass":
        require(record.get("safety_query") == "unsat" and record.get("overlap_query") == "unsat", "Formal query did not pass")
        require(record.get("replay", {}).get("status") == "match" and record["replay"].get("compared_steps", 0) > 0, "No successful cross-semantics replay")
        require(record.get("depth", 0) >= 6 and record.get("symbolic_initials") == ["iss"] and record.get("sequence_width") == 32, "Formal scope is weaker than the acceptance profile")
    return {"status": status, "backend": record["backend"], "depth": record["depth"], "unbounded_proof": False}


def assess(artifacts, scenarios=None):
    artifacts = Path(artifacts)
    result = {"status": "pending", "local_build": "invalid", "formal": {"status": "not_run"}, "scenarios": [], "errors": []}
    try:
        report = ensure_snapshot(artifacts)
        result["local_build"] = "pass"
        names = [s["id"] for s in report["scenarios"]] if scenarios is None else scenarios
        require(bool(names) and len(names) == len(set(names)), "Scenario selection must be nonempty and unique")
        require(set(names) <= {s["id"] for s in report["scenarios"]}, "Unknown scenario selection")
        result["build_sha256"] = digest(artifacts / "report.json")
        try:
            result["formal"] = check_formal(artifacts)
        except (ModelError, KeyError, OSError, ValueError) as exc:
            result["formal"] = {"status": "invalid", "reason": str(exc)}
        for name in names:
            row = {"id": name}
            for kind, checker in (("packetdrill", check_external), ("observation", check_observation)):
                try:
                    row[kind] = checker(artifacts, name)
                except (ModelError, KeyError, OSError, ValueError) as exc:
                    row[kind] = {"status": "invalid", "reason": str(exc)}
            row["status"] = "scenario_closed_loop_pass" if result["formal"]["status"] == "bounded_pass" and all(row[k]["status"] == "pass" for k in ("packetdrill", "observation")) else "pending"
            result["scenarios"].append(row)
        statuses = [result["formal"]["status"]] + [r[k]["status"] for r in result["scenarios"] for k in ("packetdrill", "observation")]
        if any(s in ("invalid", "fail", "counterexample", "conflict", "semantic_mismatch") for s in statuses):
            result["status"] = "fail"
        elif all(r["status"] == "scenario_closed_loop_pass" for r in result["scenarios"]):
            result["status"] = "selected_scenarios_closed_loop_pass"
    except (ModelError, KeyError, OSError, ValueError) as exc:
        result["status"] = "fail"
        result["errors"].append(str(exc))
    result["formal_scope"] = "bounded_state_safety_only; no_unbounded_or_full_TCP_claim"
    write(artifacts / "acceptance.json", result)
    return result
