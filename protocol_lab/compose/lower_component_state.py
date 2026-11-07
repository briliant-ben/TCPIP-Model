"""Offline component control-state lowering for flat-efsm-atomic-ordered-v1 IR.

Pure transform: moves a finite component's control state into an explicit
string variable. No runtime callbacks, no IO, no network, no shell.
"""
import copy
from protocol_lab.ir import validate

_STATE_REQ_ID = "COMPONENT-STATE-DOMAIN"
_VERSIONS = ("0.5", "0.6")
_SEMANTICS = "flat-efsm-atomic-ordered-v1"
_FIXED_BINDING = {
    "source": "docs/component-state-lowering.md",
    "kind": "modeling_choice",
    "strength": "exact control-state representation",
    "interpretation": (
        "Internal control variable represents the original finite "
        "component state under default initialization."
    ),
}


def _map_expr(expr, state_var):
    """Recursively lower expression positions.

    A bare state predicate is exactly {"state": LABEL}. Only op.args are
    recursed; every other node/field is deep-copied unchanged.
    """
    if isinstance(expr, dict) and "op" not in expr and "state" in expr:
        if sorted(expr.keys()) != ["state"]:
            raise ValueError("state predicate must have only the state key")
        label = expr["state"]
        if not isinstance(label, str):
            raise ValueError("state label must be a string")
        return {"op": "eq", "args": [{"var": state_var}, label]}
    out = copy.deepcopy(expr)
    if isinstance(out, dict) and "op" in out and "args" in out:
        args = out["args"]
        if not isinstance(args, list):
            raise ValueError("expression args must be a list")
        out["args"] = [_map_expr(a, state_var) for a in args]
    return out


def _map_action(action, state_var):
    if not isinstance(action, dict):
        raise ValueError("action must be a dict")
    out = copy.deepcopy(action)
    # cancel body may be any JSON value (e.g. a bare string); never inspect it.
    if "cancel" in out:
        return out
    if "set" in out:
        body = out["set"]
        if not isinstance(body, dict):
            raise ValueError("set action body must be a dict")
        if "var" not in body or "value" not in body:
            raise ValueError("set action needs var/value")
        out["set"] = {"var": copy.deepcopy(body["var"]),
                      "value": _map_expr(body["value"], state_var)}
        return out
    if "emit" in out:
        body = out["emit"]
        if not isinstance(body, dict):
            raise ValueError("emit action body must be a dict")
        if "message" not in body:
            raise ValueError("emit action needs message")
        fields = body.get("fields", {})
        if not isinstance(fields, dict):
            raise ValueError("emit fields must be a dict")
        new_fields = {}
        for k, v in fields.items():
            new_fields[k] = _map_expr(v, state_var)
        new_emit = copy.deepcopy(body)
        new_emit["fields"] = new_fields
        out["emit"] = new_emit
        return out
    if "arm" in out:
        body = out["arm"]
        if not isinstance(body, dict):
            raise ValueError("arm action body must be a dict")
        if "timer" not in body:
            raise ValueError("arm action needs timer")
        new_arm = copy.deepcopy(body)
        if "delay_ms" in new_arm:
            new_arm["delay_ms"] = _map_expr(new_arm["delay_ms"], state_var)
        out["arm"] = new_arm
        return out
    raise ValueError("unknown action: %r" % (sorted(out.keys()),))


def _domain_assert(states, state_var):
    parts = [{"op": "eq", "args": [{"var": state_var}, s]} for s in states]
    if len(parts) == 1:
        return parts[0]
    acc = parts[0]
    for p in parts[1:]:
        acc = {"op": "or", "args": [acc, p]}
    return acc


def lower_component_state(model, state_var, global_state):
    if not isinstance(model, dict):
        raise TypeError("model must be a dict")
    if not isinstance(state_var, str) or not state_var:
        raise ValueError("state_var must be a nonempty string")
    if not isinstance(global_state, str) or not global_state:
        raise ValueError("global_state must be a nonempty string")
    if model.get("ir_version") not in _VERSIONS:
        raise ValueError("unsupported ir_version: %r" % (model.get("ir_version"),))
    if model.get("semantics") != _SEMANTICS:
        raise ValueError("unsupported semantics: %r" % (model.get("semantics"),))

    scope = model.get("scope", {})
    if not isinstance(scope, dict):
        raise ValueError("scope must be a dict")
    terminal = scope.get("terminal_states", [])
    if not isinstance(terminal, list):
        raise ValueError("terminal_states must be a list")
    if terminal:
        raise ValueError("terminal-state lowering not supported: %r" % (terminal,))

    variables = model.get("variables", {})
    if not isinstance(variables, dict):
        raise ValueError("variables must be a dict")
    if state_var in variables:
        raise ValueError("state variable collides: %r" % (state_var,))

    requirements = model.get("requirements", {})
    if not isinstance(requirements, dict):
        raise ValueError("requirements must be a dict")
    if _STATE_REQ_ID in requirements:
        raise ValueError("requirement id present: %s" % _STATE_REQ_ID)

    invariants = model.get("invariants", [])
    if not isinstance(invariants, list):
        raise ValueError("invariants must be a list")
    for inv in invariants:
        if isinstance(inv, dict) and inv.get("id") == _STATE_REQ_ID:
            raise ValueError("invariant id present: %s" % _STATE_REQ_ID)

    states = model.get("states", [])
    if not isinstance(states, list) or not states:
        raise ValueError("states must be a nonempty list")
    for s in states:
        if not isinstance(s, str):
            raise ValueError("each state label must be a string")
    old_initial = model.get("initial_state")
    if old_initial not in states:
        raise ValueError("initial_state must be one of states")
    if global_state in states:
        raise ValueError("global_state collides with an original state label")

    validate(model)

    new_model = copy.deepcopy(model)

    new_model["states"] = [global_state]
    new_model["initial_state"] = global_state
    new_model["variables"][state_var] = {"type": "string", "initial": old_initial}
    new_model["requirements"][_STATE_REQ_ID] = copy.deepcopy(_FIXED_BINDING)

    new_transitions = []
    for tr in model.get("transitions", []):
        if not isinstance(tr, dict):
            raise ValueError("transition must be a dict")
        for key in ("id", "event", "from", "to", "guard"):
            if key not in tr:
                raise ValueError("transition missing %s" % key)
        src = tr["from"]
        tgt = tr["to"]
        if src not in states:
            raise ValueError("transition from unknown state: %r" % (src,))
        if tgt not in states:
            raise ValueError("transition to unknown state: %r" % (tgt,))
        actions = tr.get("actions", [])
        if not isinstance(actions, list):
            raise ValueError("actions must be a list")
        new_tr = copy.deepcopy(tr)
        new_tr["from"] = global_state
        new_tr["to"] = global_state
        mapped_guard = _map_expr(tr["guard"], state_var)
        new_tr["guard"] = {"op": "and",
                           "args": [{"op": "eq", "args": [{"var": state_var}, src]},
                                    mapped_guard]}
        new_actions = [_map_action(a, state_var) for a in actions]
        new_actions.append({"set": {"var": state_var, "value": copy.deepcopy(tgt)}})
        new_tr["actions"] = new_actions
        new_transitions.append(new_tr)
    new_model["transitions"] = new_transitions

    new_invariants = []
    for inv in invariants:
        if not isinstance(inv, dict):
            raise ValueError("invariant must be a dict")
        for key in ("id", "assert"):
            if key not in inv:
                raise ValueError("invariant missing %s" % key)
        new_inv = copy.deepcopy(inv)
        new_inv["assert"] = _map_expr(inv["assert"], state_var)
        new_invariants.append(new_inv)
    new_invariants.append({
        "id": _STATE_REQ_ID,
        "requirements": [_STATE_REQ_ID],
        "assert": _domain_assert(states, state_var),
    })
    new_model["invariants"] = new_invariants

    validate(new_model)
    return new_model
