"""Pure offline disjoint union of pre-lowered, pre-namespaced atomic components.

Only a validated disjoint union of already-flattened atomic-v1 IR components.
Adds no packet dispatch, framing, queues, or runtime Python callbacks. Event
alphabets are expected disjoint, so this represents interleaving, not routing.
"""
import copy

from protocol_lab.ir import validate

_ALLOWED = (
    "ir_version",
    "semantics",
    "protocol",
    "scope",
    "states",
    "initial_state",
    "variables",
    "events",
    "timers",
    "messages",
    "requirements",
    "transitions",
    "invariants",
)
_DICT_FIELDS = ("variables", "events", "timers", "messages", "requirements")
_LIST_FIELDS = ("transitions", "invariants")
_SEMANTICS = "flat-efsm-atomic-ordered-v1"


def _check_type_decl(value, path):
    """Reject forbidden type declarations in a schema type position.

    Only *type position* values are inspected here (e.g. variables[*].type,
    field type declarations). Ordinary literal strings/metadata elsewhere are
    never scanned for forbidden words.
    """
    if isinstance(value, str):
        if value in ("clock", "post", "rational"):
            raise ValueError("forbidden type declaration %r at %s" % (value, path))
        if "rational" in value:
            raise ValueError("forbidden rational type %r at %s" % (value, path))
    elif isinstance(value, dict):
        for k, v in value.items():
            _check_type_decl(v, path + "." + str(k))
    elif isinstance(value, list):
        for i, item in enumerate(value):
            _check_type_decl(item, path + "[%d]" % i)


def _scan_type_positions(container, path):
    """Walk structural declarations and validate only actual type positions."""
    if isinstance(container, dict):
        # variables[*].type is the canonical type position.
        if "type" in container:
            _check_type_decl(container["type"], path + ".type")
        # event/message field type declarations: fields{name: {type: ...}}.
        if "fields" in container and isinstance(container["fields"], dict):
            for fname, fdecl in container["fields"].items():
                if isinstance(fdecl, dict) and "type" in fdecl:
                    _check_type_decl(
                        fdecl["type"], path + ".fields." + str(fname) + ".type")
        for k, v in container.items():
            if k in ("type",):
                continue
            _scan_type_positions(v, path + "." + str(k))
    elif isinstance(container, list):
        for i, item in enumerate(container):
            _scan_type_positions(item, path + "[%d]" % i)


def _check_component(c):
    if not isinstance(c, dict):
        raise ValueError("component must be a dict")
    extra = set(c) - set(_ALLOWED)
    if extra:
        raise ValueError(
            "unsupported top-level fields (unresolved extensions must be "
            "resolved/lowered before merge, never silently discarded): %r"
            % sorted(extra))
    for key in _ALLOWED:
        if key not in c:
            raise ValueError("missing component field: %s" % key)
    if not isinstance(c["ir_version"], str) or c["ir_version"] not in ("0.5", "0.6"):
        raise ValueError("unsupported ir_version: %r" % (c["ir_version"],))
    if c["semantics"] != _SEMANTICS:
        raise ValueError("unsupported semantics: %r" % (c["semantics"],))
    if not isinstance(c["protocol"], str) or c["protocol"] == "":
        raise ValueError("protocol must be a nonempty string")

    scope = c["scope"]
    if not isinstance(scope, dict):
        raise ValueError("scope must be a dict")
    if scope.get("terminal_states"):
        raise ValueError("terminal_states must be empty")

    states = c["states"]
    if not isinstance(states, list):
        raise ValueError("states must be a list")
    if len(states) != 1:
        raise ValueError("states must be a singleton list")
    if c["initial_state"] != states[0]:
        raise ValueError("initial_state must equal the singleton state")

    for key in _DICT_FIELDS:
        if not isinstance(c[key], dict):
            raise ValueError("%s must be a dict" % key)
        _scan_type_positions(c[key], key)
    for key in _LIST_FIELDS:
        if not isinstance(c[key], list):
            raise ValueError("%s must be a list" % key)
        _scan_type_positions(c[key], key)

    validate(c)


def _reject_duplicate_ids(items, label):
    seen = set()
    for item in items:
        if not isinstance(item, dict):
            raise ValueError("%s entry must be a dict" % label)
        if "id" not in item:
            raise ValueError("%s entry missing id" % label)
        ident = item["id"]
        if ident in seen:
            raise ValueError("duplicate %s id: %r" % (label, ident))
        seen.add(ident)


def merge_disjoint_components(components, protocol):
    """Return a validated disjoint union of pre-lowered atomic components.

    All inputs must be flat-efsm-atomic-ordered-v1 IR0.5/IR0.6 components
    sharing exactly the same nonempty singleton states/initial_state, with no
    terminal states and disjoint namespaced keys. Inputs are not mutated.
    """
    if not isinstance(components, list) or not components:
        raise ValueError("components must be a nonempty list")
    if not isinstance(protocol, str) or protocol == "":
        raise ValueError("protocol must be a nonempty string")

    for c in components:
        _check_component(c)

    first = components[0]
    states = first["states"]
    initial_state = first["initial_state"]
    for c in components[1:]:
        if c["states"] != states or c["initial_state"] != initial_state:
            raise ValueError("states/initial_state mismatch across components")

    ver = "0.5"
    for c in components:
        if c["ir_version"] == "0.6":
            ver = "0.6"
            break

    out = {
        "ir_version": ver,
        "semantics": _SEMANTICS,
        "protocol": protocol,
        "states": copy.deepcopy(states),
        "initial_state": copy.deepcopy(initial_state),
    }

    for key in _DICT_FIELDS:
        merged = {}
        for c in components:
            for k, v in c[key].items():
                if k in merged:
                    raise ValueError("duplicate %s key: %r" % (key, k))
                merged[k] = copy.deepcopy(v)
        out[key] = merged

    for key in _LIST_FIELDS:
        merged_list = []
        for c in components:
            for item in c[key]:
                merged_list.append(copy.deepcopy(item))
        _reject_duplicate_ids(merged_list, key)
        out[key] = merged_list

    out["scope"] = {
        "terminal_states": [],
        "component_scopes": [copy.deepcopy(c.get("scope", {})) for c in components],
    }

    validate(out)
    return out
