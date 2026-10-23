"""A typed, deliberately small EFSM IR. No eval or embedded host code."""
import copy
import json
from pathlib import Path

MOD = 1 << 32


class ModelError(ValueError):
    pass


class Uncovered(ModelError):
    """The model has no applicable rule; this is not a protocol verdict."""


class Conflict(ModelError):
    pass


def require(condition, message):
    if not condition:
        raise ModelError(message)


def value_ok(value, kind):
    return {
        "bool": lambda: type(value) is bool,
        "int": lambda: type(value) is int,
        "seq32": lambda: type(value) is int and 0 <= value < MOD,
        "string": lambda: type(value) is str,
    }.get(kind, lambda: False)()


def infer(expr, model, event=None):
    if type(expr) is bool:
        return "bool"
    if type(expr) is int:
        return "int"
    if type(expr) is str:
        return "string"
    require(type(expr) is dict, f"Invalid expression: {expr!r}")
    if set(expr) == {"seq"}:
        require(value_ok(expr["seq"], "seq32"), "Invalid seq32 literal")
        return "seq32"
    if set(expr) == {"var"}:
        require(expr["var"] in model["variables"], "Unknown variable")
        return model["variables"][expr["var"]]["type"]
    if set(expr) == {"event"}:
        fields = model["events"].get(event, {}).get("fields", {})
        require(expr["event"] in fields, f"Unknown event field: {expr}")
        return fields[expr["event"]]
    if set(expr) == {"state"}:
        require(expr["state"] in model["states"], "Unknown state")
        return "bool"
    if set(expr) == {"timer_active"}:
        require(expr["timer_active"] in model["timers"], "Unknown timer")
        return "bool"
    require(set(expr) == {"op", "args"} and type(expr["args"]) is list,
            "Unsupported expression shape")
    op, args = expr["op"], expr["args"]
    types = [infer(x, model, event) for x in args]
    if op in ("eq", "ne"):
        require(len(types) == 2 and types[0] == types[1], "Equality type mismatch")
        return "bool"
    if op in ("and", "or", "implies", "not"):
        arity = 1 if op == "not" else 2
        require(len(types) == arity and all(t == "bool" for t in types), "Boolean type mismatch")
        return "bool"
    signatures = {
        "add": (["int", "int"], "int"),
        "mul": (["int", "int"], "int"),
        "le": (["int", "int"], "bool"),
        "ge": (["int", "int"], "bool"),
        "seq_add": (["seq32", "int"], "seq32"),
    }
    require(op in signatures, f"Unsupported operator: {op}")
    inputs, output = signatures[op]
    require(types == inputs, f"{op} expects {inputs}, got {types}")
    return output


def evaluate(expr, machine, event=None):
    if type(expr) is not dict:
        return expr
    if "seq" in expr:
        return expr["seq"]
    if "var" in expr:
        return machine.values[expr["var"]]
    if "event" in expr:
        return event["fields"][expr["event"]]
    if "state" in expr:
        return machine.state == expr["state"]
    if "timer_active" in expr:
        return expr["timer_active"] in machine.timers
    args = [evaluate(x, machine, event) for x in expr["args"]]
    return {
        "eq": lambda a, b: a == b,
        "ne": lambda a, b: a != b,
        "and": lambda a, b: a and b,
        "or": lambda a, b: a or b,
        "not": lambda a: not a,
        "implies": lambda a, b: not a or b,
        "add": lambda a, b: a + b,
        "mul": lambda a, b: a * b,
        "le": lambda a, b: a <= b,
        "ge": lambda a, b: a >= b,
        "seq_add": lambda a, b: (a + b) % MOD,
    }[expr["op"]](*args)


def validate(model):
    require(model.get("ir_version") == "0.1", "Unsupported IR version")
    require(model.get("semantics") == "flat-efsm-atomic-ordered-v1", "Unsupported semantics")
    states = model["states"]
    require(len(states) == len(set(states)), "Duplicate states")
    require(model["initial_state"] in states, "Unknown initial state")
    requirements = model["requirements"]
    require(bool(requirements), "Requirements are required")
    for rid, req in requirements.items():
        require(bool(req.get("source")) and bool(req.get("interpretation")), f"Untraceable requirement {rid}")
    for name, var in model["variables"].items():
        require(value_ok(var["initial"], var["type"]), f"Bad initial value: {name}")
    for name, event in model["events"].items():
        require(event["origin"] in ("application", "network", "timer"), f"Bad origin: {name}")
        require(all(t in ("bool", "int", "seq32", "string") for t in event["fields"].values()), "Bad event field type")
    timer_events = []
    for timer in model["timers"].values():
        event = model["events"].get(timer["event"], {})
        require(event.get("origin") == "timer" and event.get("fields") == {}, "Bad timer event")
        timer_events.append(timer["event"])
    require(len(timer_events) == len(set(timer_events)), "Timers must have distinct expiry events")
    ids = set()
    for rule in model["transitions"]:
        require(rule["id"] not in ids, "Duplicate transition ID")
        ids.add(rule["id"])
        require(rule["from"] in states and rule["to"] in states, "Unknown transition state")
        require(rule["event"] in model["events"], "Unknown transition event")
        require(bool(rule["requirements"]) and all(r in requirements for r in rule["requirements"]), "Unknown requirement")
        require(infer(rule["guard"], model, rule["event"]) == "bool", "Non-boolean guard")
        for action in rule["actions"]:
            require(len(action) == 1, "An action must have one operator")
            kind, arg = next(iter(action.items()))
            if kind == "set":
                require(arg["var"] in model["variables"], "Unknown assignment target")
                require(infer(arg["value"], model, rule["event"]) == model["variables"][arg["var"]]["type"], "Assignment type mismatch")
            elif kind == "emit":
                schema = model["messages"].get(arg["message"])
                require(schema is not None, "Unknown message")
                require(set(arg["fields"]) == set(schema["fields"]), "Message fields mismatch")
                for field, expr in arg["fields"].items():
                    require(infer(expr, model, rule["event"]) == schema["fields"][field], f"Message field type mismatch: {field}")
            elif kind == "arm":
                require(arg["timer"] in model["timers"], "Unknown timer")
                require(infer(arg["delay_ms"], model, rule["event"]) == "int", "Bad timer duration type")
            elif kind == "cancel":
                require(arg in model["timers"], "Unknown timer")
            else:
                raise ModelError(f"Unsupported action: {kind}")
    invariant_ids = set()
    for inv in model["invariants"]:
        require(inv["id"] not in invariant_ids, "Duplicate invariant ID")
        invariant_ids.add(inv["id"])
        require(infer(inv["assert"], model) == "bool", "Non-boolean invariant")
        require(bool(inv["requirements"]) and all(r in requirements for r in inv["requirements"]), "Unknown invariant requirement")
    return model


def load(path):
    return validate(json.loads(Path(path).read_text()))


class Machine:
    def __init__(self, model, initial=None):
        self.model = validate(copy.deepcopy(model))
        self.state = model["initial_state"]
        self.values = {k: v["initial"] for k, v in model["variables"].items()}
        for key, value in (initial or {}).items():
            require(key in model["variables"], f"Unknown initial variable {key}")
            require(value_ok(value, model["variables"][key]["type"]), f"Bad initial variable {key}")
            self.values[key] = value
        self.timers = {}
        self.now_ms = 0
        self.trace = []
        self.check_invariants()

    def snapshot(self):
        return {"state": self.state, "variables": self.values.copy(), "timers": self.timers.copy()}

    def check_invariants(self):
        for key, var in self.model["variables"].items():
            require(value_ok(self.values[key], var["type"]), f"Variable type violation: {key}")
        for inv in self.model["invariants"]:
            require(evaluate(inv["assert"], self), f"Invariant failed: {inv['id']}")

    def _fire(self, name, fields, timer=None):
        event = {"name": name, "fields": fields}
        schema = self.model["events"].get(name)
        require(schema is not None, f"Unknown event {name}")
        require(set(fields) == set(schema["fields"]), f"Event field mismatch: {name}")
        for key, kind in schema["fields"].items():
            require(value_ok(fields[key], kind), f"Bad event value: {key}")
        matches = [r for r in self.model["transitions"] if r["from"] == self.state and r["event"] == name and evaluate(r["guard"], self, event)]
        if not matches:
            raise Uncovered(f"No transition: state={self.state}, event={event}")
        if len(matches) > 1:
            raise Conflict(f"Overlapping rules: {[r['id'] for r in matches]}")
        rule = matches[0]
        before = self.snapshot()
        if timer:
            del self.timers[timer]
        emitted = []
        for action in rule["actions"]:
            kind, arg = next(iter(action.items()))
            if kind == "set":
                self.values[arg["var"]] = evaluate(arg["value"], self, event)
            elif kind == "emit":
                emitted.append({"message": arg["message"], "fields": {k: evaluate(v, self, event) for k, v in arg["fields"].items()}})
            elif kind == "cancel":
                self.timers.pop(arg, None)
            elif kind == "arm":
                delay = evaluate(arg["delay_ms"], self, event)
                require(type(delay) is int and delay > 0, "Timer duration must be positive")
                self.timers[arg["timer"]] = self.now_ms + delay
        self.state = rule["to"]
        record = {"event_id": f"e{len(self.trace)+1:04d}", "time_ms": self.now_ms,
                  "event": event, "transition": rule["id"], "requirements": rule["requirements"],
                  "before": before, "after": self.snapshot(), "emitted": emitted}
        self.trace.append(record)
        self.check_invariants()

    def advance(self, time_ms):
        require(type(time_ms) is int and time_ms >= self.now_ms, "Time must be monotonic integer milliseconds")
        while self.timers and min(self.timers.values()) <= time_ms:
            timer = min(self.timers, key=lambda x: (self.timers[x], x))
            self.now_ms = self.timers[timer]
            self._fire(self.model["timers"][timer]["event"], {}, timer)
        self.now_ms = time_ms

    def dispatch(self, name, fields=None, time_ms=None):
        # Commit a complete operation only after guards, actions and invariants pass.
        # Failed operations leave the caller's machine untouched.
        candidate = copy.deepcopy(self)
        require(name in self.model["events"], f"Unknown event {name}")
        require(self.model["events"][name]["origin"] != "timer", "Timer events cannot be injected")
        candidate.advance(self.now_ms if time_ms is None else time_ms)
        candidate._fire(name, fields or {})
        self.__dict__.update(candidate.__dict__)

    def tick(self, time_ms):
        candidate = copy.deepcopy(self)
        candidate.advance(time_ms)
        self.__dict__.update(candidate.__dict__)
