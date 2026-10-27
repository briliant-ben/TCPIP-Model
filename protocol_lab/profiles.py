"""Multi-model reference flow; unsupported adapters stay explicitly unavailable."""
import json
from pathlib import Path

from .capture import normalize
from .flow import ROOT, digest, read, run_scenario, verify_sources, write
from .ir import load, model_files, require
from .packets import compare, packetdrill, write_pcap
from .symbolic import check, crosscheck_trace, model_hash


def scenario_paths(profile):
    sources = profile["scenarios"]
    require(type(sources) in (str, list), "Invalid scenario source list")
    sources = [sources] if type(sources) is str else sources
    require(bool(sources) and all(type(p) is str for p in sources), "Invalid scenario source list")
    paths = []
    for source in sources:
        directory = (ROOT / source).resolve()
        require(directory.is_relative_to(ROOT), "Scenario source escapes repository")
        paths.extend(sorted(directory.glob("*.json")))
    require(len({p.stem for p in paths}) == len(paths), "Duplicate scenario ID across sources")
    return paths


def profile_inputs(profile, model):
    inputs = {str(p.relative_to(ROOT)): digest(p) for p in model_files(ROOT / profile["model"])}
    paths = sorted((ROOT / "protocol_lab").glob("*.py"))
    paths += scenario_paths(profile)
    paths += [ROOT / "spec/sources/manifest.json", ROOT / "profiles.json", ROOT / "requirements-formal.txt", ROOT / "docs/semantics.md",
              ROOT / "docs/inductive.md", ROOT / "docs/claims.md", ROOT / "formal/README.md"]
    if profile.get("inductive_refinement"):
        paths.append(ROOT / "formal/partition_queries.py")
    if profile.get("wire_projection"):
        paths.append(ROOT / "packet-profile.json")
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
              "net.rst": "R", "net.rstack": "RA", "net.data_ack": "A", "net.data": "A", "net.fin_segment": "FA"}
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
                            "window": fields.get("window", 65535),
                            **({"payload": fields["data"]} if "data" in fields else {}),
                            "dropped_after_egress": False})
        for i, message in enumerate(row["emitted"]):
            if message["message"] in ("application", "application_data"):
                continue
            require(message["message"] in ("tcp", "tcp_data"), "Unimplemented wire adapter")
            pid = f"{row['event_id']}:out:{i}"
            packets.append({**common, "packet_id": pid, "direction": "out", **message["fields"],
                            "dropped_after_egress": pid in drops})
    require(drops <= {p["packet_id"] for p in packets if p["direction"] == "out"}, "Invalid packet drop pointer")
    if "tcp_data" in machine.model["messages"]:
        for packet in packets:
            packet.setdefault("payload", [])
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
        targets = [(rule["to"], "default" if rule.get("target_cases") else "")]
        targets += [(case["to"], f"post case {i+1}") for i, case in enumerate(rule.get("target_cases", []))]
        for target, suffix in targets:
            lines.append(f"  {json.dumps(rule['from'])} -> {json.dumps(target)} [label={json.dumps(label + (chr(10) + suffix if suffix else ""))}];")
    return "\n".join(lines + ["}", ""])


def run_profile(profile, out, formal=False, depth=6):
    from .profile_config import profile_group_size
    group_size = profile_group_size(profile)
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
    trace_statuses = []
    paths = scenario_paths(profile)
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
        wire_roundtrip = "not_run"
        if profile.get("wire_projection"):
            projection = profile["wire_projection"]
            observed, metadata = normalize(target / "model.synthetic.pcap", read(ROOT / "packet-profile.json"), packets,
                                           origin="synthetic", projection=projection)
            difference = compare(packets, observed, projection=projection)
            write(target / "normalized.synthetic.json", observed)
            write(target / "capture-metadata.json", metadata)
            write(target / "difference.json", {**difference, "evidence_scope": "synthetic_codec_roundtrip_only"})
            require(difference["status"] == "match", "Synthetic codec roundtrip mismatch")
            names += ["normalized.synthetic.json", "capture-metadata.json", "difference.json"]
            wire_roundtrip = "match_synthetic_only"
        adapter = "unavailable_for_profile"
        if profile.get("packetdrill") == "active-open-v1":
            script, _ = packetdrill(packets)
            (target / "test.pkt").write_text(script)
            names.append("test.pkt")
            adapter = "generated_not_executed"
        generated += [target / n for n in names]
        trace_check = {"status": "not_run"}
        if formal and profile.get("symbolic_replay"):
            trace_check = crosscheck_trace(model, machine.trace, target / "symbolic")
            trace_statuses.append(trace_check["status"])
            generated += [target / "symbolic" / n for n in ("path.smt2", "result.json")]
        for row in machine.trace:
            covered.add(row["transition"])
            states.update((row["before"]["state"], row["after"]["state"]))
        scenarios.append({"id": name, "status": "reference_pass", "final_state": machine.state,
                          "events": len(machine.trace), "packets": len(packets), "packetdrill": adapter,
                          "symbolic_replay": trace_check["status"], "wire_roundtrip": wire_roundtrip})
    (out / "state-machine.dot").write_text(graph(model))
    generated.append(out / "state-machine.dot")
    write(out / "expanded-model.json", model)
    generated.append(out / "expanded-model.json")
    formal_result = {"status": "not_run"}
    if formal:
        formal_result = check(model, depth=depth, out=out / "formal")
        generated += [out / "formal" / n for n in ("result.json", "model.smt2", "overlap.smt2")]
    induction = {"status": "not_run"}
    if formal and profile.get("inductive"):
        from .inductive import prove
        induction = prove(model, out=out / "inductive")
        generated += [out / "inductive" / n for n in (*induction["query_hashes"], "result.json")]
    refinement = {"status": "not_run"}
    if formal and profile.get("inductive_refinement"):
        require(profile.get("inductive"), "Refinement requires primary induction")
        from .refinement import refine
        refinement = refine(model, out / "inductive", out / "inductive-refinement", group_size=group_size)
        generated += [out / "inductive-refinement" / n for n in (*refinement["artifact_hashes"], "result.json")]
    result = {"profile": profile["id"], "protocol": model["protocol"], "status": "reference_pass",
              "model_sha256": digest(model_path), "sources": sources, "input_hashes": inputs,
              "scenarios": scenarios, "state_count": len(model["states"]), "transition_count": len(model["transitions"]),
              "visited_states": sorted(states), "unvisited_states": sorted(set(model["states"]) - states),
              "covered_transitions": sorted(covered), "uncovered_transitions": sorted({r["id"] for r in model["transitions"]} - covered),
              "formal": {k: formal_result[k] for k in ("status", "backend", "depth", "reason", "safety_query", "overlap_query") if k in formal_result},
              "inductive": {k: induction[k] for k in ("status", "backend", "byte_encoding", "sequence_encoding") if k in induction},
              "inductive_refinement": {k: refinement[k] for k in ("status", "backend", "primary_status") if k in refinement},
              "real_stack": "not_run", "protocol_complete": False,
              "artifact_hashes": {str(p.relative_to(out)): digest(p) for p in generated}}
    if formal and formal_result["status"] != "bounded_pass":
        result["status"] = "formal_pending" if formal_result["status"] in ("unknown", "vacuous") else "fail"
    if "unknown" in trace_statuses and result["status"] != "fail":
        result["status"] = "formal_pending"
    if any(status not in ("match", "unknown") for status in trace_statuses):
        result["status"] = "fail"
    if induction["status"] not in ("not_run", "inductive_invariants_pass"):
        result["status"] = "formal_pending" if induction["status"] in ("unknown", "vacuous") and result["status"] != "fail" else "fail"
    if refinement["status"] == "refinement_counterexample":
        result["status"] = "fail"
    from .claims import build as build_claims
    write(out / "claims.json", build_claims(model, profile, inputs, scenarios, formal_result, induction, result["artifact_hashes"], refinement=refinement))
    result["artifact_hashes"]["claims.json"] = digest(out / "claims.json")
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
        for scenario in report["scenarios"]:
            if scenario.get("symbolic_replay") == "match":
                trace_result = read(target / scenario["id"] / "symbolic/result.json")
                require(trace_result["model_semantic_sha256"] == model_hash(model), "Trace model mismatch")
                require(trace_result["query"] == "sat" and trace_result["replay"]["status"] == "match", "Trace replay did not match")
        if report["formal"]["status"] == "bounded_pass":
            formal = read(target / "formal/result.json")
            require(formal["model_semantic_sha256"] == model_hash(model), "Formal model mismatch")
            require(formal["safety_query"] == "unsat" and formal["overlap_query"] == "unsat", "Formal queries did not pass")
            require(formal["replay"]["status"] == "match", "Formal witness did not replay")
        if report.get("inductive", {}).get("status") == "inductive_invariants_pass":
            from .inductive import verify
            verify(model, target / "inductive")
        if report.get("inductive_refinement", {}).get("status", "not_run") != "not_run":
            from .refinement import verify as verify_refinement
            verify_refinement(model, target / "inductive", target / "inductive-refinement")
        from .claims import verify as verify_claims
        verify_claims(model, profile, report, target)
        result["profiles"].append({"id": profile["id"], "local_integrity": "pass", "formal": report["formal"],
                                   "inductive": report.get("inductive", {"status": "not_run"}),
                                   "inductive_refinement": report.get("inductive_refinement", {"status": "not_run"}), "real_stack": "not_run"})
    write(out / "verification.json", result)
    return result
