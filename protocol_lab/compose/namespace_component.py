"""Namespace a protocol-lab IR 0.5/0.6 flat-EFSM atomic-ordered model.

Prefixes every declared identifier with ``prefix + "." + name`` and rewrites
the referencing intents (transition event, requirements, set.var, emit.message,
arm/cancel timer, timer declaration event, and var/timer_active expression
references), including nested variable references inside timer delays.
"""
import copy

from protocol_lab.ir import validate


_TAG_KEYS = ("var", "event", "timer_active", "state")


def _pfx(prefix, name):
    return prefix + "." + name


def _ref(table, name, kind):
    if not isinstance(name, str):
        raise TypeError(kind + " reference must be a string")
    if name not in table:
        raise KeyError(kind + " not declared: " + name)
    return table[name]


def _expr(tables, expr):
    if isinstance(expr, bool):
        return expr
    if isinstance(expr, int):
        return expr
    if isinstance(expr, str):
        return expr
    if isinstance(expr, list):
        return [_expr(tables, e) for e in expr]
    if not isinstance(expr, dict):
        raise TypeError("unsupported expression node")
    tags = [k for k in _TAG_KEYS if k in expr]
    if tags:
        if len(tags) != 1:
            raise TypeError("ambiguous expression node")
        key = tags[0]
        out = dict(expr)
        if key == "var":
            out["var"] = _ref(tables["variables"], expr["var"], "variable")
        elif key == "timer_active":
            out["timer_active"] = _ref(tables["timers"],
                                       expr["timer_active"], "timer")
        # "event" holds a FIELD name; "state" holds a state label.
        return out
    if "op" in expr:
        op = expr["op"]
        if not isinstance(op, str):
            raise TypeError("op name must be a string")
        args = expr.get("args", [])
        if not isinstance(args, list):
            raise TypeError("op args must be a list")
        out = dict(expr)
        out["args"] = [_expr(tables, a) for a in args]
        return out
    if "bytes" in expr and len(expr) == 1:
        if not isinstance(expr["bytes"], list):
            raise TypeError("bytes literal must be a list")
        return dict(expr)
    if "seq" in expr and len(expr) == 1:
        return dict(expr)
    raise TypeError("unsupported expression node")


def _action(tables, action):
    if not isinstance(action, dict):
        raise TypeError("action must be a dict")
    keys = list(action.keys())
    if len(keys) != 1:
        raise RuntimeError("action must have exactly one tag key")
    key = keys[0]
    body = action[key]
    if key == "set":
        if not isinstance(body, dict):
            raise TypeError("set body must be a dict")
        if "var" not in body or "value" not in body:
            raise KeyError("set requires var and value")
        return {"set": {"var": _ref(tables["variables"], body["var"],
                                   "variable"),
                        "value": _expr(tables, body["value"])}}
    if key == "emit":
        if not isinstance(body, dict):
            raise TypeError("emit body must be a dict")
        if "message" not in body:
            raise KeyError("emit requires message")
        fields = body.get("fields", {})
        if not isinstance(fields, dict):
            raise TypeError("emit.fields must be a dict")
        new_fields = {}
        for fname in fields.keys():
            if not isinstance(fname, str):
                raise TypeError("emit field key must be a string")
            new_fields[fname] = _expr(tables, fields[fname])
        return {"emit": {"message": _ref(tables["messages"],
                                         body["message"], "message"),
                         "fields": new_fields}}
    if key == "arm":
        # Rebuild body key-by-key so nested expressions (delay_ms etc.) get
        # their var/timer references renamed, not just the literal case.
        if not isinstance(body, dict):
            raise TypeError("arm body must be a dict")
        if "timer" not in body:
            raise KeyError("arm requires timer")
        new_body = {}
        for k in body.keys():
            if k == "timer":
                new_body["timer"] = _ref(tables["timers"], body["timer"],
                                         "timer")
            else:
                new_body[k] = _expr(tables, body[k])
        return {"arm": new_body}
    if key == "cancel":
        if not isinstance(body, str):
            raise TypeError("cancel must be a timer name string")
        return {"cancel": _ref(tables["timers"], body, "timer")}
    raise RuntimeError("unsupported action kind: " + str(key))


def _refs(prefix, names):
    if not isinstance(names, list):
        raise TypeError("requirements references must be a list")
    out = []
    for n in names:
        if not isinstance(n, str):
            raise TypeError("requirement reference must be a string")
        out.append(_pfx(prefix, n))
    return out


def namespace_component(model, prefix):
    if not isinstance(prefix, str) or not prefix:
        raise ValueError("prefix must be a non-empty string")
    if not isinstance(model, dict):
        raise TypeError("model must be a dict")
    validate(model)
    src = copy.deepcopy(model)
    out = copy.deepcopy(src)

    tables = {"variables": {}, "events": {}, "timers": {},
              "messages": {}, "requirements": {},
              "transitions": {}, "invariants": {}}

    for category in ("variables", "events", "timers", "messages",
                     "requirements"):
        decls = src.get(category, {})
        if not isinstance(decls, dict):
            raise TypeError(category + " must be a dict")
        new_decls = {}
        for name in decls.keys():
            if not isinstance(name, str):
                raise TypeError(category + " key must be a string")
            new_name = _pfx(prefix, name)
            tables[category][name] = new_name
            new_decls[new_name] = copy.deepcopy(decls[name])
        out[category] = new_decls

    for old_name in tables["timers"]:
        decl = out["timers"][tables["timers"][old_name]]
        if isinstance(decl, dict) and isinstance(decl.get("event"), str):
            decl["event"] = _ref(tables["events"], decl["event"], "event")

    new_transitions = []
    transitions = src.get("transitions", [])
    if not isinstance(transitions, list):
        raise TypeError("transitions must be a list")
    for t in transitions:
        if not isinstance(t, dict):
            raise TypeError("transition must be a dict")
        if "id" not in t:
            raise KeyError("transition missing id")
        old_id = t["id"]
        if not isinstance(old_id, str):
            raise TypeError("transition id must be a string")
        if old_id in tables["transitions"]:
            raise ValueError("duplicate transition id: " + old_id)
        nt = dict(t)
        nt["id"] = _pfx(prefix, old_id)
        tables["transitions"][old_id] = nt["id"]
        if "event" in t:
            nt["event"] = _ref(tables["events"], t["event"], "event")
        if "requirements" in t:
            nt["requirements"] = _refs(prefix, t["requirements"])
        if "guard" in t:
            nt["guard"] = _expr(tables, t["guard"])
        actions = t.get("actions", [])
        if not isinstance(actions, list):
            raise TypeError("transition actions must be a list")
        nt["actions"] = [_action(tables, a) for a in actions]
        new_transitions.append(nt)
    out["transitions"] = new_transitions

    new_invariants = []
    invariants = src.get("invariants", [])
    if not isinstance(invariants, list):
        raise TypeError("invariants must be a list")
    for inv in invariants:
        if not isinstance(inv, dict):
            raise TypeError("invariant must be a dict")
        if "id" not in inv:
            raise KeyError("invariant missing id")
        old_id = inv["id"]
        if not isinstance(old_id, str):
            raise TypeError("invariant id must be a string")
        if old_id in tables["invariants"]:
            raise ValueError("duplicate invariant id: " + old_id)
        ni = dict(inv)
        ni["id"] = _pfx(prefix, old_id)
        tables["invariants"][old_id] = ni["id"]
        if "requirements" in inv:
            ni["requirements"] = _refs(prefix, inv["requirements"])
        if "assert" not in inv:
            raise KeyError("invariant missing assert")
        ni["assert"] = _expr(tables, inv["assert"])
        new_invariants.append(ni)
    out["invariants"] = new_invariants

    validate(out)
    return out, tables
