"""Separate invariant-induction obligations, not a replacement for BMC.

Length projection is exact only for the syntactically admitted content-insensitive
properties. Satisfying arbitrary prestates are not reachable counterexamples.
"""
import hashlib
import itertools
import json
from pathlib import Path

from .ir import require
from .symbolic import Encoding, model_hash, replay


def digest_text(value):
    return hashlib.sha256(value.encode()).hexdigest()


def assertions(solver):
    # Export a base context; the commands below explicitly check every case.
    return solver.to_smt2().rsplit("(check-sat)", 1)[0]


def prove(model, symbolic_initials=("iss",), out=None):
    initial = Encoding(model, 1, symbolic_initials, byte_encoding="length", sequence_encoding="modular-int")
    z = initial.z
    files = {}
    result = {"backend": "z3-invariant-induction", "model_semantic_sha256": model_hash(model),
              "solver_version": z.get_version_string(), "status": "incomplete",
              "byte_encoding": "exact_length_projection_content_insensitive_subset",
              "sequence_encoding": "modular_integer_full_32bit_domain",
              "symbolic_initials": list(symbolic_initials), "sequence_width": 32,
              "invariants": [i["id"] for i in model["invariants"]],
              "scope": "defined_nonterminal_transitions_and_listed_state_invariants",
              "content_properties": "not_supported_by_length_projection",
              "reachability_of_failed_prestates": "not_claimed", "unbounded_protocol_proof": False,
              "runtime_properties": ["positive_timer_duration", "active_timer_not_in_past"],
              "preservation": [], "overlap": []}

    # These solver obligations validate the length formulas against full Seq(BV8).
    sort = z.SeqSort(z.BitVecSort(8))
    a, b = z.Consts("lemma_a lemma_b", sort)
    offset, count = z.Ints("lemma_offset lemma_count")
    condition = z.Bool("lemma_condition")
    start, size = z.If(offset < 0, 0, offset), z.If(count < 0, 0, count)
    rest = z.If(z.Length(a) > start, z.Length(a)-start, 0)
    length = z.If(size < rest, size, rest)
    lemma_solver = z.Solver()
    lemma_solver.set(timeout=10000)
    lemma_solver.add(z.Or(z.Length(z.Concat(a, b)) != z.Length(a)+z.Length(b),
                         z.Length(z.If(condition, a, b)) != z.If(condition, z.Length(a), z.Length(b)),
                         z.Length(z.SubSeq(a, start, size)) != length))
    files["length-lemmas.smt2"] = lemma_solver.to_smt2()
    result["length_lemmas"] = str(lemma_solver.check())

    initial.solver.add(z.Int("choice_0") == -1)
    initial.solver.add(z.Not(z.And(*[initial.expr(i["assert"], initial.frames[0]) for i in model["invariants"]])))
    files["initial.smt2"] = initial.solver.to_smt2()
    result["initial_query"] = str(initial.solve())
    if result["initial_query"] == "unknown":
        result["initial_reason"] = initial.reason_unknown()
    if result["initial_query"] == "sat":
        result["initial_projection"] = initial.witness(initial.solver.model())["initial"]

    def arbitrary():
        enc = Encoding(model, 1, tuple(model["variables"]), byte_encoding="length",
                       sequence_encoding="modular-int", arbitrary_state=True)
        enc.solver.add(*[enc.expr(i["assert"], enc.frames[0]) for i in model["invariants"]])
        return enc

    step = arbitrary()
    new = step.frames[1]
    post = [step.expr(i["assert"], new) for i in model["invariants"]]
    post += [z.Implies(new["active"][n], new["due"][n] >= new["now"]) for n in model["timers"]]
    step.solver.add(z.Or(z.Not(z.And(*post)), *step.action_faults))
    preservation_script = [assertions(step.solver)]
    for j, rule in enumerate(model["transitions"]):
        case = z.Int("choice_0") == j
        preservation_script += [f"; {rule['id']}\n(push 1)\n(assert {case.sexpr()})\n(check-sat)\n(pop 1)\n"]
        step.solver.push()
        step.solver.add(case)
        answer = step.solve()
        row = {"transition": rule["id"], "query": str(answer)}
        if answer == z.unknown:
            row["reason"] = step.reason_unknown()
        elif answer == z.sat:
            solution = step.solver.model()
            row.update(classification="inductive_obligation_failure_not_reachability_proof",
                       pre_state=model["states"][step.concrete(solution, step.frames[0]["state"])],
                       projection=step.witness(solution),
                       failed_invariants=[i["id"] for i in model["invariants"] if not step.concrete(solution, step.expr(i["assert"], new))])
        result["preservation"].append(row)
        step.solver.pop()
    files["preservation.smt2"] = "".join(preservation_script)

    overlap = arbitrary()
    overlap_script = [assertions(overlap.solver)]
    groups = {}
    for j, rule in enumerate(model["transitions"]):
        groups.setdefault((rule["from"], rule["event"]), []).append(j)
    for (state, event), indices in sorted(groups.items()):
        if len(indices) < 2:
            continue
        case = z.Or(*[z.And(overlap.enabled[0][a][1], overlap.enabled[0][b][1])
                       for a, b in itertools.combinations(indices, 2)])
        overlap_script += [f"; {state} {event}\n(push 1)\n(assert {case.sexpr()})\n(check-sat)\n(pop 1)\n"]
        overlap.solver.push()
        overlap.solver.add(case)
        answer = overlap.solve()
        row = {"state": state, "event": event, "query": str(answer),
               "transitions": [model["transitions"][j]["id"] for j in indices]}
        if answer == z.unknown:
            row["reason"] = overlap.reason_unknown()
        elif answer == z.sat:
            row["classification"] = "overlap_in_invariant_state_not_reachability_proof"
        result["overlap"].append(row)
        overlap.solver.pop()
    files["overlap.smt2"] = "".join(overlap_script)

    answers = [result["length_lemmas"], result["initial_query"]]
    answers += [r["query"] for r in result["preservation"] + result["overlap"]]
    result["status"] = "inductive_obligations_failed" if "sat" in answers else "unknown" if any(a != "unsat" for a in answers) else "inductive_invariants_pass"
    if result["status"] == "inductive_invariants_pass":
        # A concrete full-byte/BV32 path prevents a vacuous replay claim.
        sample = Encoding(model, 1, symbolic_initials)
        sample.solver.add(z.Int("choice_0") != -1)
        files["sample.smt2"] = sample.solver.to_smt2()
        answer = sample.solve()
        result["sample_query"] = str(answer)
        if answer == z.sat:
            result["sample_witness"] = sample.witness(sample.solver.model())
            result["replay"] = replay(model, result["sample_witness"])
            if result["replay"]["status"] != "match":
                result["status"] = "semantic_mismatch"
        else:
            result["status"] = "unknown" if answer == z.unknown else "vacuous"
    result["query_hashes"] = {name: digest_text(value) for name, value in files.items()}
    if out is not None:
        out = Path(out)
        out.mkdir(parents=True, exist_ok=True)
        for name, value in files.items():
            (out / name).write_text(value)
        (out / "result.json").write_text(json.dumps(result, indent=2) + "\n")
    return result


def verify(model, out):
    out = Path(out).resolve()
    result = json.loads((out / "result.json").read_text())
    require(result["model_semantic_sha256"] == model_hash(model), "Inductive model is stale")
    require(result["invariants"] == [i["id"] for i in model["invariants"]], "Inductive invariant manifest mismatch")
    require(result["byte_encoding"] == "exact_length_projection_content_insensitive_subset"
            and result["sequence_encoding"] == "modular_integer_full_32bit_domain"
            and result["sequence_width"] == 32, "Inductive encoding mismatch")
    require(result["status"] == "inductive_invariants_pass", "Inductive obligations did not pass")
    require(result["initial_query"] == "unsat" and result["length_lemmas"] == "unsat", "Induction initial/length queries did not pass")
    require([r["transition"] for r in result["preservation"]] == [r["id"] for r in model["transitions"]], "Missing preservation obligation")
    require(all(r["query"] == "unsat" for r in result["preservation"] + result["overlap"]), "Inductive queries did not pass")
    expected_groups = {}
    for r in model["transitions"]:
        expected_groups.setdefault((r["from"], r["event"]), []).append(r["id"])
    expected_groups = {k: v for k, v in expected_groups.items() if len(v) > 1}
    actual_groups = {(r["state"], r["event"]): r["transitions"] for r in result["overlap"]}
    require(actual_groups == expected_groups and len(result["overlap"]) == len(expected_groups), "Missing overlap obligation")
    require(result.get("replay", {}).get("status") == "match", "No concrete induction sample replay")
    require(replay(model, result["sample_witness"])["status"] == "match", "Inductive sample witness no longer replays")
    require(set(result["query_hashes"]) == {"length-lemmas.smt2", "initial.smt2", "preservation.smt2", "overlap.smt2", "sample.smt2"}, "Missing induction query")
    for name, expected in result["query_hashes"].items():
        path = (out / name).resolve()
        require(path.is_relative_to(out) and digest_text(path.read_text()) == expected, "Inductive query changed")
    return {"status": "valid_inductive_artifacts", "protocol_complete": False}
