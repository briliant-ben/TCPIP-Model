"""Bind exact model propositions, assumptions and checker trust to evidence.

This is a claim manifest, not a new proof checker or a proof of the translator.
"""
import hashlib
import json
from pathlib import Path

from .ir import CLOCK_SEMANTICS, require
from .symbolic import model_hash


def sha(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def build(model, profile, inputs, scenarios, formal, induction, artifacts, refinement=None):
    refinement = refinement or {"status": "not_run"}
    model_sha = model_hash(model)
    for record in (formal, induction):
        if record["status"] != "not_run":
            require(record["model_semantic_sha256"] == model_sha, "Claim evidence model mismatch")
    scope = {"model_scope": model["scope"], "semantics": model["semantics"], "ir_version": model["ir_version"],
             "environment_requirements": {rid: req for rid, req in model["requirements"].items()
                if req.get("kind", req.get("category")) == "environment_assumption"}}
    checker_code = {name: digest for name, digest in inputs.items() if name.startswith("protocol_lab/") or name == "formal/partition_queries.py"}
    context = {"model_semantic_sha256": model_sha, "assumptions": scope, "input_hashes": inputs}

    def claim(cid, statement, status, checker, version, evidence):
        proposition = {"context": context, "statement": statement}
        return {"id": cid, "statement": statement, "proposition_sha256": sha(proposition),
                "status": status, "checker": checker, "checker_version": version,
                "checker_code_hashes": checker_code, "evidence_hashes": evidence,
                "kernel_checked_proof": False,
                "trusted_components": ["IR parsing and validation", "IR-to-solver translation",
                                       "Z3 solver", "Python checker/evidence integration"]}

    safety_statement = {"kind": "bounded_state_safety_and_guard_overlap", "defined_transitions_only": True,
                        "invariants": [{"id": i["id"], "assert": i["assert"]} for i in model["invariants"]],
                        "runtime_properties": formal.get("runtime_properties", []), "depth": formal.get("depth"),
                        "symbolic_initials": formal.get("symbolic_initials", []),
                        "other_initial_values": "declared_IR_initial_values", "event_domain": "all_typed_values",
                        "sequence_width": 32, "bounded_step_unit": "declared_event_or_clock_advance" if model["semantics"] == CLOCK_SEMANTICS else "declared_event", "time": "unbounded_integer_ms", "clock_progress": formal.get("clock_progress"), "unbounded": False}
    fstatus = formal["status"]
    fs = "verified_bounded" if fstatus == "bounded_pass" else "not_run" if fstatus == "not_run" else "unknown" if fstatus in ("unknown", "vacuous") else "rejected"
    if fstatus != "not_run":
        require(formal.get("backend") == "z3-bmc", "Unsupported claim checker")
        require(type(formal.get("depth")) is int and formal["depth"] >= 1, "Missing bounded claim depth")
        require({"formal/result.json", "formal/model.smt2", "formal/overlap.smt2"} <= artifacts.keys(), "Missing bounded claim evidence")
    if fstatus == "bounded_pass":
        if model["semantics"] == CLOCK_SEMANTICS:
            require(formal.get("clock_progress") == "monotonic_integer_before_next_due"
                    and formal.get("scope") == "defined_transitions_and_clock_progress", "Missing bounded clock progress coverage")
        require(formal.get("safety_query") == "unsat" and formal.get("overlap_query") == "unsat"
                and formal.get("replay", {}).get("status") == "match", "Cannot promote inconclusive solver evidence")
    safety = claim("bounded-state", safety_statement, fs, "z3-bmc", formal.get("solver_version"),
                   {p: h for p, h in artifacts.items() if p.startswith("formal/")})
    safety["solver_result"] = {k: formal[k] for k in ("status", "safety_query", "overlap_query", "reason") if k in formal}

    induction_statement = {"kind": "initial_and_per_rule_invariant_preservation_and_guard_groups",
        "invariants": safety_statement["invariants"], "rules": [r["id"] for r in model["transitions"]],
        "prestate_assumption": "typed_state_and_all_listed_invariants",
        "poststate_invariants_assumed": False, "byte_encoding": induction.get("byte_encoding"),
        "sequence_encoding": induction.get("sequence_encoding"),
        "target_coverage": induction.get("target_coverage"),
        "clock_progress": induction.get("clock_progress"),
        "clock_advance_query": induction.get("clock_advance_query"),
        "symbolic_initials": induction.get("symbolic_initials", []),
        "other_initial_values": "declared_IR_initial_values",
        "transition_targets": [{"id": r["id"], "default": r["to"], "cases": r.get("target_cases", [])}
                               for r in model["transitions"]],
        "content_properties": "not_supported_by_length_projection", "protocol_completeness": False}
    istatus = induction["status"]
    ins = "verified_inductive_state_properties" if istatus == "inductive_invariants_pass" else "not_run" if istatus == "not_run" else "unknown" if istatus in ("unknown", "vacuous") else "rejected"
    if istatus != "not_run":
        require(induction.get("backend") == "z3-invariant-induction", "Unsupported claim checker")
        require({"inductive/result.json", *["inductive/"+p for p in induction["query_hashes"]]} <= artifacts.keys(), "Missing induction claim evidence")
    if istatus == "inductive_invariants_pass":
        expected_clock = "monotonic_integer_before_next_due" if model["semantics"] == CLOCK_SEMANTICS else "not_applicable"
        require(induction.get("clock_progress") == expected_clock
                and induction.get("clock_advance_query") == ("unsat" if expected_clock != "not_applicable" else "not_applicable"),
                "Missing/inconclusive induction clock obligation")
        require(expected_clock == "not_applicable" or "clock-preservation.smt2" in induction["query_hashes"], "Missing clock query evidence")
        require(induction.get("target_coverage") == "all_declared_destinations", "Missing target coverage for induction claim")
        require([r["transition"] for r in induction["preservation"]] == [r["id"] for r in model["transitions"]], "Missing claim rule obligation")
        for rule, row in zip(model["transitions"], induction["preservation"]):
            expected_targets = sorted({rule["to"], *[c["to"] for c in rule.get("target_cases", [])]}, key=model["states"].index)
            require([t["state"] for t in row["targets"]] == expected_targets and all(t["query"] == "unsat" for t in row["targets"]), "Missing/inconclusive claim target obligation")
        require(induction.get("initial_query") == "unsat" and induction.get("length_lemmas") == "unsat"
                and all(r["query"] == "unsat" for r in induction["preservation"] + induction["overlap"])
                and induction.get("replay", {}).get("status") == "match", "Cannot promote inconclusive induction evidence")
    inductive = claim("inductive-state", induction_statement, ins, "z3-invariant-induction", induction.get("solver_version"),
                      {p: h for p, h in artifacts.items() if p.startswith("inductive/")})

    matched = [r["id"] for r in scenarios if r.get("symbolic_replay") == "match"]
    trace_statement = {"kind": "fixed_input_and_rule_choice_replay", "scenario_ids": matched,
                       "universal_event_sequences": False, "compared": ["prestate", "poststate", "timers", "emitted_fields"]}
    trace = claim("fixed-traces", trace_statement, "matched_fixed_inputs" if matched else "not_run",
                  "z3-constrained-trace-and-reference-replay", formal.get("solver_version"),
                  {p: h for p, h in artifacts.items() if "/symbolic/" in p})
    claims = [safety, inductive, trace]
    if profile.get("inductive_refinement"):
        status = refinement["status"]
        refined_status = "not_run"
        if status != "not_run":
            from .refinement import PASS, NOT_NEEDED, validate_summary
            validate_summary(model, induction, refinement)
            require(refinement["primary_result_sha256"] == artifacts.get("inductive/result.json"),
                    "Refinement primary result hash mismatch")
            require(all(inputs.get(name) == value for name, value in refinement["checker_source_hashes"].items()),
                    "Missing refinement checker code bindings")
            required = {"inductive-refinement/result.json", *["inductive-refinement/"+n for n in refinement["artifact_hashes"]]}
            require(required <= artifacts.keys(), "Missing refinement claim evidence")
            refined_status = ("verified_refined_inductive_state_properties" if status == PASS else
                              "not_needed_primary_pass" if status == NOT_NEEDED else
                              "rejected" if status == "refinement_counterexample" else "unknown")
        statement = {**induction_statement,
            "kind": "same_state_induction_with_exact_boolean_query_refinements",
            "primary_status": induction["status"],
            "original_unknown_targets": refinement.get("original_unknown_targets", []),
            "refinement_method": "all_original_assertions_retained_and_exhaustive_disjunct_partition",
            "per_query_timeout_ms": refinement.get("timeout_ms")}
        refined = claim("refined-inductive-state", statement, refined_status,
                        "z3-exact-query-refinement", refinement.get("solver_version"),
                        {p: h for p, h in artifacts.items() if p.startswith(("inductive/", "inductive-refinement/"))})
        refined["trusted_components"].append("exact Boolean partition generation and independent coverage checker")
        claims.append(refined)
    return {"claims_version": "0.1", "profile": profile["id"], **context,
            "claims": claims, "protocol_complete": False,
            "this_manifest_does_not_establish": ["RFC coverage completeness", "IR translator correctness",
                "universal byte-content correctness", "implementation refinement", "liveness/fairness",
                "Linux implementation execution", "Rocq kernel-checked proofs"],
            "integrity_is_not_authenticity_or_semantic_validity": True}


def verify(model, profile, report, out):
    out = Path(out).resolve()
    def record(name, summary):
        if summary["status"] == "not_run":
            return {"status": "not_run"}
        value = json.loads((out / name / "result.json").read_text())
        require(value["status"] == summary["status"], "Claim summary/evidence status mismatch")
        return value
    formal = record("formal", report["formal"])
    induction = record("inductive", report.get("inductive", {"status": "not_run"}))
    refinement = record("inductive-refinement", report.get("inductive_refinement", {"status": "not_run"}))
    expected = build(model, profile, report["input_hashes"], report["scenarios"], formal, induction,
                     {p: h for p, h in report["artifact_hashes"].items() if p != "claims.json"}, refinement=refinement)
    for claim in expected["claims"]:
        for name, digest in claim["evidence_hashes"].items():
            path = (out / name).resolve()
            require(path.is_relative_to(out) and path.is_file()
                    and hashlib.sha256(path.read_bytes()).hexdigest() == digest, "Claim evidence changed")
    actual = json.loads((out / "claims.json").read_text())
    require(actual == expected, "Proof claim manifest mismatch")
    return {"status": "valid_claim_bindings", "protocol_complete": False}
