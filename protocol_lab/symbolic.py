"""Independent bounded symbolic semantics for IR 0.1 (Z3 optional).

No call to runtime evaluate/dispatch is used to construct the transition system.
The runtime is invoked only afterwards to cross-check solver witnesses.
"""
import hashlib
import json
from pathlib import Path

from .ir import MOD, Machine, ModelError, infer, require, validate


def model_hash(model):
    return hashlib.sha256(json.dumps(model, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def replay(model, witness):
    try:
        machine = Machine(model, witness["initial"])
    except ModelError as exc:
        return {"status": "runtime_rejected", "step": "initial", "error": str(exc)}
    compared = 0
    for step in witness["steps"]:
        try:
            if step["origin"] == "timer":
                machine.tick(step["at_ms"])
            else:
                machine.dispatch(step["event"], step["fields"], step["at_ms"])
        except ModelError as exc:
            return {"status": "runtime_rejected", "step": compared, "error": str(exc)}
        row = machine.trace[-1]
        if machine.snapshot() != step["after"] or row["emitted"] != step["emitted"]:
            return {"status": "semantic_mismatch", "step": compared,
                    "runtime": machine.snapshot(), "symbolic": step["after"]}
        compared += 1
    return {"status": "match", "compared_steps": compared}


def encode_trace(model, trace, **encoding_options):
    """Constrain inputs/rule choices, without assuming poststates or invariants."""
    require(bool(trace), "Cannot cross-check an empty trace")
    # Initial overrides are concrete inputs, not assumed safety properties.
    initial = trace[0]["before"]["variables"]
    overrides = [n for n, v in model["variables"].items() if initial[n] != v["initial"]]
    enc = Encoding(model, len(trace), overrides, **encoding_options)
    z = enc.z
    for name, value in initial.items():
        enc.solver.add(enc.frames[0]["values"][name] == enc.literal(value, model["variables"][name]["type"]))
    for i, row in enumerate(trace):
        indices = [j for j, r in enumerate(model["transitions"]) if r["id"] == row["transition"]]
        require(len(indices) == 1, "Trace references unknown transition")
        require(model["transitions"][indices[0]]["event"] == row["event"]["name"], "Trace event/transition mismatch")
        enc.solver.add(z.Int(f"choice_{i}") == indices[0], enc.frames[i+1]["now"] == row["time_ms"])
        schema = model["events"][row["event"]["name"]]["fields"]
        require(set(row["event"]["fields"]) == set(schema), "Trace event fields mismatch")
        for name, value in row["event"]["fields"].items():
            enc.solver.add(enc.events[i][row["event"]["name"]][name] == enc.literal(value, schema[name]))
    return enc


def crosscheck_trace(model, trace, out=None):
    enc = encode_trace(model, trace)
    query = enc.solver.to_smt2()
    answer = enc.solve()
    result = {"backend": "z3-constrained-trace", "scope": "fixed_inputs_and_rule_choices",
              "all_input_safety": "not_claimed", "steps": len(trace), "query": str(answer),
              "model_semantic_sha256": model_hash(model), "solver_version": enc.z.get_version_string(),
              "smt2_sha256": hashlib.sha256(query.encode()).hexdigest()}
    if answer == enc.z.sat:
        result["witness"] = enc.witness(enc.solver.model())
        result["replay"] = replay(model, result["witness"])
        result["status"] = result["replay"]["status"]
        # Verify the supplied reference trace as well, not only a new replay.
        before = {"state": model["initial_state"], "variables": result["witness"]["initial"], "timers": {}}
        for row, step in zip(trace, result["witness"]["steps"]):
            if (row["before"] != before or row["after"] != step["after"] or row["emitted"] != step["emitted"]
                    or row["event"] != {"name": step["event"], "fields": step["fields"]}
                    or row["time_ms"] != step["at_ms"]):
                result["status"] = "semantic_mismatch"
            before = step["after"]
    elif answer == enc.z.unknown:
        result.update(status="unknown", reason=enc.reason_unknown())
    else:
        result["status"] = "symbolic_rejected_trace"
    if out is not None:
        out = Path(out)
        out.mkdir(parents=True, exist_ok=True)
        (out / "path.smt2").write_text(query)
        (out / "result.json").write_text(json.dumps(result, indent=2) + "\n")
    return result


class Encoding:
    def solve(self):
        """Solver resource failures are inconclusive, never a passing result."""
        self.solver_error = None
        try:
            return self.solver.check()
        except self.z.Z3Exception as exc:
            self.solver_error = str(exc)
            return self.z.unknown

    def reason_unknown(self):
        return self.solver_error or self.solver.reason_unknown()

    def __init__(self, model, depth, symbolic_initials, byte_encoding="sequence", sequence_encoding="bitvector", arbitrary_state=False):
        try:
            import z3
        except ImportError as exc:
            raise ModelError("Z3 is missing: install requirements-formal.txt in .venv") from exc
        self.z = z3
        self.model = validate(model)
        require(byte_encoding in ("sequence", "length"), "Unsupported symbolic byte encoding")
        self.byte_encoding = byte_encoding
        require(sequence_encoding in ("bitvector", "modular-int"), "Unsupported sequence encoding")
        self.sequence_encoding = sequence_encoding
        if byte_encoding == "length":
            self.validate_length_projection()
        self.depth = depth
        self.initials = symbolic_initials
        require(type(depth) is int and 1 <= depth <= 30, "Symbolic depth must be 1..30")
        require(all(n in model["variables"] for n in symbolic_initials), "Unknown symbolic initial variable")
        self.byte_sort = z3.SeqSort(z3.BitVecSort(8)) if byte_encoding == "sequence" else z3.IntSort()
        self.sorts = {"bool": z3.BoolSort(), "int": z3.IntSort(),
                      "seq32": z3.BitVecSort(32) if sequence_encoding == "bitvector" else z3.IntSort(),
                      "string": z3.StringSort(), "bytes": self.byte_sort}
        self.frames = []
        self.events, self.branches, self.conflicts, self.action_faults, self.enabled = [], [], [], [], []
        self.solver = z3.Solver()
        self.solver.set(timeout=10000)
        for i in range(depth + 1):
            self.frames.append({"state": z3.Int(f"state_{i}"), "now": z3.Int(f"now_{i}"),
                "values": {n: z3.Const(f"v_{i}_{n}", self.sorts[v["type"]]) for n, v in model["variables"].items()},
                "active": {n: z3.Bool(f"active_{i}_{n}") for n in model["timers"]},
                "due": {n: z3.Int(f"due_{i}_{n}") for n in model["timers"]}})
        first = self.frames[0]
        if byte_encoding == "length":
            for frame in self.frames:
                self.solver.add(*[frame["values"][n] >= 0 for n, v in model["variables"].items() if v["type"] == "bytes"])
        if sequence_encoding == "modular-int":
            for frame in self.frames:
                for n, v in model["variables"].items():
                    if v["type"] == "seq32":
                        self.solver.add(frame["values"][n] >= 0, frame["values"][n] < MOD)
        if arbitrary_state:
            self.solver.add(first["state"] >= 0, first["state"] < len(model["states"]), first["now"] >= 0)
        else:
            self.solver.add(first["state"] == model["states"].index(model["initial_state"]), first["now"] == 0)
        for n, var in model["variables"].items():
            if n not in symbolic_initials:
                self.solver.add(first["values"][n] == self.literal(var["initial"], var["type"]))
        for n in model["timers"]:
            if arbitrary_state:
                self.solver.add(z3.Implies(first["active"][n], first["due"][n] >= first["now"]))
            else:
                self.solver.add(z3.Not(first["active"][n]), first["due"][n] == 0)
        for i in range(depth):
            self.encode_step(i)

    def validate_length_projection(self):
        """Reject every content observation; do not approximate bytes equality."""
        def visit(expr, event=None):
            if type(expr) is not dict or "op" not in expr:
                return
            if expr["op"] in ("eq", "ne"):
                require(infer(expr["args"][0], self.model, event) != "bytes",
                        "Length projection does not support byte-content equality")
            for arg in expr["args"]:
                visit(arg, event)
        for rule in self.model["transitions"]:
            visit(rule["guard"], rule["event"])
            for action in rule["actions"]:
                kind, arg = next(iter(action.items()))
                if kind == "set":
                    visit(arg["value"], rule["event"])
                elif kind == "arm":
                    visit(arg["delay_ms"], rule["event"])
                elif kind == "emit":
                    for expr in arg["fields"].values():
                        visit(expr, rule["event"])
        for inv in self.model["invariants"]:
            visit(inv["assert"])

    def literal(self, value, kind=None):
        z = self.z
        if kind == "seq32":
            return z.BitVecVal(value, 32) if self.sequence_encoding == "bitvector" else z.IntVal(value)
        if kind == "bytes":
            if self.byte_encoding == "length":
                return z.IntVal(len(value))
            units = [z.Unit(z.BitVecVal(v, 8)) for v in value]
            return z.Concat(*units) if len(units) > 1 else units[0] if units else z.Empty(self.byte_sort)
        if type(value) is bool:
            return z.BoolVal(value)
        if type(value) is int:
            return z.IntVal(value)
        return z.StringVal(value)

    def expr(self, value, frame, fields=None):
        z = self.z
        if type(value) is not dict:
            return self.literal(value)
        if "seq" in value:
            return self.literal(value["seq"], "seq32")
        if "bytes" in value:
            return self.literal(value["bytes"], "bytes")
        if "var" in value:
            return frame["values"][value["var"]]
        if "event" in value:
            return fields[value["event"]]
        if "state" in value:
            return frame["state"] == self.model["states"].index(value["state"])
        if "timer_active" in value:
            return frame["active"][value["timer_active"]]
        args = [self.expr(v, frame, fields) for v in value["args"]]
        operators = {"eq": lambda a, b: a == b, "ne": lambda a, b: a != b,
                "and": z.And, "or": z.Or, "not": z.Not, "implies": z.Implies,
                "add": lambda a, b: a+b, "mul": lambda a, b: a*b,
                "le": lambda a, b: a <= b, "ge": lambda a, b: a >= b,
                "seq_add": lambda a, b: a + z.Int2BV(b, 32),
                "sub": lambda a, b: a - b,
                "min": lambda a, b: z.If(a <= b, a, b),
                "bytes_len": z.Length,
                "bytes_concat": z.Concat,
                "bytes_slice": lambda a, offset, count: z.SubSeq(a, z.If(offset < 0, 0, offset), z.If(count < 0, 0, count)),
                "seq_distance": lambda a, b: z.BV2Int(b - a, is_signed=False),
                "seq_comparable": lambda a, b: b - a != z.BitVecVal(1 << 31, 32),
                "seq_lt": lambda a, b: z.And(a != b, z.ULT(b - a, z.BitVecVal(1 << 31, 32))),
                "seq_le": lambda a, b: z.ULT(b - a, z.BitVecVal(1 << 31, 32))}
        if self.byte_encoding == "length":
            def slice_length(length, offset, count):
                start = z.If(offset < 0, 0, offset)
                size = z.If(count < 0, 0, count)
                remaining = z.If(length > start, length - start, 0)
                return z.If(size < remaining, size, remaining)
            operators.update(bytes_len=lambda a: a, bytes_concat=lambda a, b: a+b,
                             bytes_slice=slice_length)
        if self.sequence_encoding == "modular-int":
            operators.update(seq_add=lambda a, b: (a+b) % MOD,
                             seq_distance=lambda a, b: (b-a) % MOD,
                             seq_comparable=lambda a, b: (b-a) % MOD != MOD//2,
                             seq_lt=lambda a, b: z.And((b-a) % MOD > 0, (b-a) % MOD < MOD//2),
                             seq_le=lambda a, b: (b-a) % MOD < MOD//2)
        require(value["op"] in operators, f"Unsupported symbolic operator: {value['op']}")
        return operators[value["op"]](*args)

    def encode_step(self, index):
        z, m = self.z, self.model
        old, new = self.frames[index:index+2]
        fields = {name: {n: z.Const(f"input_{index}_{name}_{n}", self.sorts[kind]) for n, kind in spec["fields"].items()}
                  for name, spec in m["events"].items()}
        self.events.append(fields)
        if self.byte_encoding == "length":
            self.solver.add(*[fields[name][n] >= 0 for name, spec in m["events"].items()
                              for n, kind in spec["fields"].items() if kind == "bytes"])
        if self.sequence_encoding == "modular-int":
            for name, spec in m["events"].items():
                for n, kind in spec["fields"].items():
                    if kind == "seq32":
                        self.solver.add(fields[name][n] >= 0, fields[name][n] < MOD)
        choice = z.Int(f"choice_{index}")
        branches, enabled = [], []
        not_terminal = z.And(*[old["state"] != m["states"].index(s) for s in m["scope"]["terminal_states"]])
        for j, rule in enumerate(m["transitions"]):
            name = rule["event"]
            origin = m["events"][name]["origin"]
            conditions = [not_terminal, old["state"] == m["states"].index(rule["from"]),
                          new["now"] >= old["now"], self.expr(rule["guard"], old, fields[name])]
            expiring = None
            if origin == "timer":
                matches = [n for n, spec in m["timers"].items() if spec["event"] == name]
                require(len(matches) == 1, "Symbolic timer event must map to exactly one timer")
                expiring = matches[0]
                conditions += [old["active"][expiring], new["now"] == old["due"][expiring]]
                for other in m["timers"]:
                    if other != expiring:
                        priority = old["due"][expiring] < old["due"][other] if other < expiring else old["due"][expiring] <= old["due"][other]
                        conditions.append(z.Implies(old["active"][other], priority))
            else:
                conditions += [z.Implies(old["active"][n], new["now"] < old["due"][n]) for n in m["timers"]]
            enabled.append((name, z.And(*conditions)))
            work = {"state": old["state"], "now": new["now"], "values": dict(old["values"]),
                    "active": dict(old["active"]), "due": dict(old["due"])}
            if expiring:
                work["active"][expiring] = z.BoolVal(False)
            emitted = []
            for action in rule["actions"]:
                kind, arg = next(iter(action.items()))
                if kind == "set":
                    work["values"][arg["var"]] = self.expr(arg["value"], work, fields[name])
                elif kind == "cancel":
                    work["active"][arg] = z.BoolVal(False)
                elif kind == "arm":
                    delay = self.expr(arg["delay_ms"], work, fields[name])
                    self.action_faults.append(z.And(*conditions, choice == j, delay <= 0))
                    work["active"][arg["timer"]] = z.BoolVal(True)
                    work["due"][arg["timer"]] = new["now"] + delay
                elif kind == "emit":
                    emitted.append({"message": arg["message"], "fields": {n: self.expr(v, work, fields[name]) for n, v in arg["fields"].items()}})
                else:
                    raise ModelError(f"Unsupported symbolic action: {kind}")
            conditions += [choice == j, new["state"] == m["states"].index(rule["to"])]
            for group in ("values", "active", "due"):
                conditions += [new[group][n] == work[group][n] for n in work[group]]
            branches.append(z.And(*conditions))
            self.branches.append((index, j, emitted))
        # Suffix padding covers every prefix <= depth, including dead-end states.
        unchanged = [new["state"] == old["state"], new["now"] == old["now"]]
        for group in ("values", "active", "due"):
            unchanged += [new[group][n] == old[group][n] for n in old[group]]
        branches.append(z.And(choice == -1, *unchanged))
        self.solver.add(z.Or(*branches))
        if index:
            self.solver.add(z.Implies(z.Int(f"choice_{index-1}") == -1, choice == -1))
        self.conflicts.append(z.Or(*[z.And(a, b) for i, (ea, a) in enumerate(enabled)
                                       for eb, b in enabled[i+1:] if ea == eb]))
        self.enabled.append(enabled)

    def concrete(self, solution, value):
        result = solution.eval(value, model_completion=True)
        if self.z.is_bool(result):
            return self.z.is_true(result)
        if self.z.is_string_value(result):
            return result.as_string()
        if self.byte_encoding == "sequence" and result.sort() == self.byte_sort:
            length = solution.eval(self.z.Length(value), model_completion=True).as_long()
            return [solution.eval(value[i], model_completion=True).as_long() for i in range(length)]
        return result.as_long()

    def witness(self, solution):
        m = self.model
        def typed(value, kind):
            if self.byte_encoding == "length" and kind == "bytes":
                return {"byte_length": self.concrete(solution, value)}
            return self.concrete(solution, value)
        initial = {n: typed(v, m["variables"][n]["type"]) for n, v in self.frames[0]["values"].items()}
        steps = []
        for i in range(self.depth):
            choice = self.concrete(solution, self.z.Int(f"choice_{i}"))
            if choice == -1:
                break
            rule = m["transitions"][choice]
            frame = self.frames[i+1]
            emitted = next(e for index, j, e in self.branches if index == i and j == choice)
            steps.append({"at_ms": self.concrete(solution, frame["now"]), "event": rule["event"],
                          "origin": m["events"][rule["event"]]["origin"], "transition": rule["id"],
                          "fields": {n: typed(v, m["events"][rule["event"]]["fields"][n]) for n, v in self.events[i][rule["event"]].items()},
                          "after": {"state": m["states"][self.concrete(solution, frame["state"])],
                                    "variables": {n: typed(v, m["variables"][n]["type"]) for n, v in frame["values"].items()},
                                    "timers": {n: self.concrete(solution, frame["due"][n]) for n, active in frame["active"].items() if self.concrete(solution, active)}},
                          "emitted": [{"message": e["message"], "fields": {n: typed(v, m["messages"][e["message"]]["fields"][n]) for n, v in e["fields"].items()}} for e in emitted]})
        return {"initial": initial, "steps": steps}


def check(model, depth=6, symbolic_initials=("iss",), out=None):
    enc = Encoding(model, depth, symbolic_initials)
    z = enc.z
    invariants = [enc.expr(inv["assert"], frame) for frame in enc.frames for inv in model["invariants"]]
    # Save an executable SMT-LIB query, including the exact property being queried.
    enc.solver.push()
    enc.solver.add(z.Or(z.Not(z.And(*invariants)), *enc.action_faults))
    smt = enc.solver.to_smt2()
    answer = enc.solve()
    report = {"backend": "z3-bmc", "solver_version": z.get_version_string(), "depth": depth,
              "model_semantic_sha256": model_hash(model), "symbolic_initials": list(symbolic_initials),
              "sequence_width": 32, "event_fields": "all_typed_values", "time": "unbounded_integer_ms",
              "scope": "defined_transitions_only", "liveness": "not_checked", "unbounded_proof": False,
              "invariants": [i["id"] for i in model["invariants"]], "safety_query": str(answer)}
    report["runtime_properties"] = ["positive_timer_duration"]
    if model["ir_version"] == "0.2":
        report["byte_semantics"] = "finite_sequence_bv8_truncating_slice"
        report["sequence_order"] = "strict_half_space_partial_order"
    if answer == z.sat:
        report["counterexample"] = enc.witness(enc.solver.model())
        report["replay"] = replay(model, report["counterexample"])
        report["status"] = "counterexample"
    elif answer == z.unsat:
        report["status"] = "bounded_pass"
    else:
        report.update(status="unknown", reason=enc.reason_unknown())
    enc.solver.pop()
    enc.solver.push()
    enc.solver.add(z.Or(*enc.conflicts))
    overlap_smt = enc.solver.to_smt2()
    conflict = enc.solve()
    report["overlap_query"] = str(conflict)
    if conflict == z.sat:
        report["status"] = "conflict"
    elif conflict == z.unknown and report["status"] == "bounded_pass":
        report.update(status="unknown", reason=enc.reason_unknown())
    enc.solver.pop()
    # A satisfying path is cross-checked against independent runtime semantics.
    if report["status"] == "bounded_pass":
        enc.solver.add(z.Int("choice_0") != -1)
        answer = enc.solve()
        if answer == z.sat:
            report["sample_witness"] = enc.witness(enc.solver.model())
            report["replay"] = replay(model, report["sample_witness"])
            if report["replay"]["status"] != "match":
                report["status"] = "semantic_mismatch"
        else:
            report["status"] = "unknown" if answer == z.unknown else "vacuous"
            if answer == z.unknown:
                report["reason"] = enc.reason_unknown()
    if out is not None:
        out = Path(out)
        out.mkdir(parents=True, exist_ok=True)
        (out / "model.smt2").write_text(smt)
        (out / "overlap.smt2").write_text(overlap_smt)
        report["smt2_sha256"] = hashlib.sha256(smt.encode()).hexdigest()
        report["overlap_smt2_sha256"] = hashlib.sha256(overlap_smt.encode()).hexdigest()
        (out / "result.json").write_text(json.dumps(report, indent=2) + "\n")
    return report
