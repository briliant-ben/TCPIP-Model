"""Multi-model reference flow; unsupported adapters stay explicitly unavailable."""
import json
from pathlib import Path

from .flow import ROOT, digest, read, run_scenario, verify_sources, write
from .ir import load, require
from .packets import packetdrill, write_pcap
from .symbolic import check, model_hash


def profile_inputs(profile, model):
    inputs = {profile["model"]: digest(ROOT / profile["model"])}
    paths = sorted((ROOT / "protocol_lab").glob("*.py"))
    paths += sorted((ROOT / profile["scenarios"]).glob("*.json"))
    paths += [ROOT / "spec/sources/manifest.json", ROOT / "profiles.json", ROOT / "requirements-formal.txt"]
    inputs.update({str(p.relative_to(ROOT)): digest(p) for p in paths})
    for requirement in model["requirements"].values():
        source = requirement["source"]
        if not source.startswith("https://"):
            path = (ROOT / source).resolve()
            require(path.is_relative_to(ROOT) and path.is_file(), "Missing local interpretation source")
            inputs[str(path.relative_to(ROOT))] = digest(path)
    return inputs


def control_packets(machine, scenario):
    shapes = {"net.syn": "S", "net.synack": "SA", "net.ack": "A", "net.fin": "FA",
              "net.rst": "R", "net.rstack": "RA"}
    packets = []
    drops = set(scenario.get("environment", {}).get("drop_outgoing", []))
    for row in machine.trace:
        common = {"time_ms": row["time_ms"], "event_id": row["event_id"],
                  "transition": row["transition"], "requirements": row["requirements"]}
        name = row["event"]["name"]
        if machine.model["events"][name]["origin"] == "network":
            require(name in shapes, f"No TCP control encoding for event {name}")
            fields = row["event"]["fields"]
            packets.append({**common, "packet_id": row["event_id"] + ":in", "direction": "in",
                            "flags": shapes[name], "seq": fields["seq"], "ack": fields.get("ack", 0),
                            "window": 65535, "dropped_after_egress": False})
        for i, message in enumerate(row["emitted"]):
            if message["message"] == "application":
                continue
            require(message["message"] == "tcp", "Unimplemented wire adapter")
            pid = f"{row['event_id']}:out:{i}"
            packets.append({**common, "packet_id": pid, "direction": "out", **message["fields"],
                            "dropped_after_egress": pid in drops})
    require(drops <= {p["packet_id"] for p in packets if p["direction"] == "out"}, "Invalid packet drop pointer")
    return packets


def graph(model):
    # JSON quoting is valid DOT string escaping, including guards with quotes.
    lines = ["digraph protocol {", "  rankdir=LR;"]
    for state in model["states"]:
        lines.append(f"  {json.dumps(state)};")
    for rule in model["transitions"]:
        label = rule["id"] + "\n" + rule["event"]
        if rule["guard"] is not True:
            label += "\n" + json.dumps(rule["guard"], separators=(",", ":"))
        lines.append(f"  {json.dumps(rule['from'])} -> {json.dumps(rule['to'])} [label={json.dumps(label)}];")
    return "\n".join(lines + ["}", ""])


def run_profile(profile, out, formal=False, depth=6):
    out = Path(out)
    out.mkdir(parents=True, exist_ok=True)
    write(out / "report.json", {"status": "incomplete"})
    model_path = ROOT / profile["model"]
    model = load(model_path)
    inputs = profile_inputs(profile, model)
    sources = verify_sources()
    states, covered = {model["initial_state"]}, set()
    generated = []
    scenarios = []
    paths = sorted((ROOT / profile["scenarios"]).glob("*.json"))
    require(bool(paths), "Profile has no scenarios")
    for path in paths:
        scenario = read(path)
        name = scenario["id"]
        require(name == path.stem, "Scenario id must match filename")
        inputs[str(path.relative_to(ROOT))] = digest(path)
        machine = run_scenario(model, scenario)
        packets = control_packets(machine, scenario)
        target = out / name
        target.mkdir(exist_ok=True)
        write(target / "trace.json", machine.trace)
        write(target / "packets.json", packets)
        write(target / "scenario.json", scenario)
        write(target / "packet-map.json", {"capture_origin": "synthetic_model", "frames": [
            {"frame": i+1, "packet_id": p["packet_id"], "event_id": p["event_id"], "requirements": p["requirements"]}
            for i, p in enumerate(packets)]})
        write_pcap(target / "model.synthetic.pcap", packets)
        names = ["trace.json", "packets.json", "scenario.json", "packet-map.json", "model.synthetic.pcap"]
        adapter = "unavailable_for_profile"
        if profile.get("packetdrill") == "active-open-v1":
            script, _ = packetdrill(packets)
            (target / "test.pkt").write_text(script)
            names.append("test.pkt")
            adapter = "generated_not_executed"
        generated += [target / n for n in names]
        for row in machine.trace:
            covered.add(row["transition"])
            states.update((row["before"]["state"], row["after"]["state"]))
        scenarios.append({"id": name, "status": "reference_pass", "final_state": machine.state,
                          "events": len(machine.trace), "packets": len(packets), "packetdrill": adapter})
    (out / "state-machine.dot").write_text(graph(model))
    generated.append(out / "state-machine.dot")
    formal_result = {"status": "not_run"}
    if formal:
        formal_result = check(model, depth=depth, out=out / "formal")
        generated += [out / "formal" / n for n in ("result.json", "model.smt2", "overlap.smt2")]
    result = {"profile": profile["id"], "protocol": model["protocol"], "status": "reference_pass",
              "model_sha256": digest(model_path), "sources": sources, "input_hashes": inputs,
              "scenarios": scenarios, "state_count": len(model["states"]), "transition_count": len(model["transitions"]),
              "visited_states": sorted(states), "unvisited_states": sorted(set(model["states"]) - states),
              "covered_transitions": sorted(covered), "uncovered_transitions": sorted({r["id"] for r in model["transitions"]} - covered),
              "formal": {k: formal_result[k] for k in ("status", "backend", "depth") if k in formal_result},
              "real_stack": "not_run", "protocol_complete": False,
              "artifact_hashes": {str(p.relative_to(out)): digest(p) for p in generated}}
    if formal and formal_result["status"] != "bounded_pass":
        result["status"] = "formal_pending" if formal_result["status"] in ("unknown", "vacuous") else "fail"
    write(out / "report.json", result)
    return result


def run_suite(out, formal=False, depth=6):
    out = Path(out)
    out.mkdir(parents=True, exist_ok=True)
    result = {"status": "incomplete", "implemented_profiles": [], "pending_modules": [], "full_stack_complete": False}
    write(out / "report.json", result)
    suite = read(ROOT / "profiles.json")
    for profile in suite["profiles"]:
        result["implemented_profiles"].append(run_profile(profile, out / profile["id"], formal, depth))
    result["pending_modules"] = suite["pending_modules"]
    result["profile_report_hashes"] = {p["profile"]: digest(out / p["profile"] / "report.json") for p in result["implemented_profiles"]}
    statuses = {p["status"] for p in result["implemented_profiles"]}
    result["status"] = "fail" if "fail" in statuses else "formal_pending_stack_incomplete" if "formal_pending" in statuses else "local_profiles_pass_stack_incomplete"
    write(out / "report.json", result)
    return result


def verify_suite(out):
    out = Path(out).resolve()
    suite = read(ROOT / "profiles.json")
    result = {"status": "valid_local_artifacts_stack_incomplete", "full_stack_complete": False, "profiles": []}
    top = read(out / "report.json")
    require(top.get("status") in ("local_profiles_pass_stack_incomplete", "formal_pending_stack_incomplete"), "Suite build is not passing/pending")
    require(top.get("pending_modules") == suite["pending_modules"], "Stack scope changed")
    require(set(top.get("profile_report_hashes", {})) == {p["id"] for p in suite["profiles"]}, "Profile manifest mismatch")
    for profile in suite["profiles"]:
        target = out / profile["id"]
        require(digest(target / "report.json") == top["profile_report_hashes"][profile["id"]], "Profile report changed")
        report = read(target / "report.json")
        model = load(ROOT / profile["model"])
        require(report["input_hashes"] == profile_inputs(profile, model), "Profile inputs are stale")
        verify_sources()
        for rel, expected_hash in report["artifact_hashes"].items():
            path = (target / rel).resolve()
            require(path.is_relative_to(target), "Profile artifact path escapes directory")
            require(digest(path) == expected_hash, f"Profile artifact changed: {rel}")
        if report["formal"]["status"] == "bounded_pass":
            formal = read(target / "formal/result.json")
            require(formal["model_semantic_sha256"] == model_hash(model), "Formal model mismatch")
            require(formal["safety_query"] == "unsat" and formal["overlap_query"] == "unsat", "Formal queries did not pass")
            require(formal["replay"]["status"] == "match", "Formal witness did not replay")
        result["profiles"].append({"id": profile["id"], "local_integrity": "pass", "formal": report["formal"], "real_stack": "not_run"})
    write(out / "verification.json", result)
    return result
