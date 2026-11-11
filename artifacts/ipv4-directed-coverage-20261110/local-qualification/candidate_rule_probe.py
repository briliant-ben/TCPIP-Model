import hashlib
import json

from protocol_lab.ir import require, validate
from protocol_lab.symbolic import Encoding, model_hash

SCHEMA = 'candidate-rule-probe-v1'


def digest(raw):
    return hashlib.sha256(raw if isinstance(raw, bytes) else raw.encode()).hexdigest()


def render_probe(model, rule_ids):
    """Build SMT queries for preservation of declared invariants by selected rules.

    For each requested rule ID, emit two SMT2 strings:
      - preserve-<index>.smt2: unsat => invariants preserved under arbitrary prestate satisfying all invariants and legal constraints
      - enabled-<index>.smt2: sat => rule enabled under some such prestate (non-vacuity)
    No solver is called. Queries use full symbolic Encoding from IR.

    Returns dict with queries list (each item has rule, role, file, smt2, sha256),
    property_ids, rule_ids, model_semantic_sha256, scope_partial, and other metadata.
    """
    validate(model)
    require(model['ir_version'] == '0.6',
            'candidate_rule_probe supports IR 0.6 atomic-v1 only')
    require(model['semantics'] == 'flat-efsm-atomic-ordered-v1',
            'Only flat atomic ordered semantics supported')
    require(not model['scope'].get('terminal_states', []),
            'Terminal-state contracts not supported')
    require(bool(model.get('invariants', [])), 'Candidate probe requires declared invariants')

    for inv in model['invariants']:
        require('target_cases' not in inv, 'Invariant target_cases unsupported')
        _assert_no_clock_or_event_in_invariant(inv['assert'])

    # reject unsupported invariants: clock/event expressions and rational constants
    # already handled by _assert_no_clock_or_event_in_invariant

    # Validate rule_ids: non-empty, unique list of known rule IDs.
    require(isinstance(rule_ids, list) and len(rule_ids) > 0,
            'rule_ids must be a non-empty list')
    require(len(set(rule_ids)) == len(rule_ids),
            'rule_ids must be unique')
    known_rule_ids = {r['id'] for r in model['transitions']}
    for rid in rule_ids:
        require(rid in known_rule_ids, f'Unknown rule id {rid}')

    queries = []
    for rid in rule_ids:
        index = next(i for i, r in enumerate(model['transitions']) if r['id'] == rid)
        rule = model['transitions'][index]

        enc = Encoding(model, 1, tuple(model['variables']), arbitrary_state=True, fixed_choices=[index])
        z = enc.z
        old, new = enc.frames[0], enc.frames[1]

        # Base constraints: all Encoding assertions (legal timers, typing, etc.)
        base = list(enc.solver.assertions())
        # Add all declared invariants on old state.
        base += [enc.expr(inv['assert'], old) for inv in model['invariants']]

        # Post-state obligations: all invariants on new state + timers not in past.
        post = [enc.expr(inv['assert'], new) for inv in model['invariants']]
        post += [z.Implies(new['active'][n], new['due'][n] >= new['now']) for n in model['timers']]

        # Bad post = violation of any invariant or timer legality or action fault.
        bad = z.Or(z.Not(z.And(*post)), *enc.action_faults)

        # Exact substitution: fix choice index and source/target flat states only,
        # not logical control or prestate variables/contents.
        fixes = [
            (z.Int('choice_0'), z.IntVal(index)),
            (old['state'], z.IntVal(model['states'].index(rule['from']))),
            (new['state'], z.IntVal(model['states'].index(rule['to']))),
        ]

        # Apply fixes to all base constraints and bad.
        base_fixed = [z.simplify(z.substitute(t, *fixes)) for t in base]
        bad_fixed = z.simplify(z.substitute(bad, *fixes))

        # Fresh solver for preservation query (base_fixed + bad_fixed)
        solver = z.Solver()
        solver.add(base_fixed)
        solver.add(bad_fixed)
        smt2_pres = solver.to_smt2()
        fname_pres = f'preserve-{index:04d}.smt2'
        queries.append({
            'rule': rid,
            'role': 'preservation',
            'file': fname_pres,
            'smt2': smt2_pres,
            'sha256': digest(smt2_pres)
        })

        # Fresh solver for non-vacuity query (base_fixed only)
        solver = z.Solver()
        solver.add(base_fixed)
        smt2_en = solver.to_smt2()
        fname_en = f'enabled-{index:04d}.smt2'
        queries.append({
            'rule': rid,
            'role': 'nonvacuity',
            'file': fname_en,
            'smt2': smt2_en,
            'sha256': digest(smt2_en)
        })

    report = {
        'schema': SCHEMA,
        'model_semantic_sha256': model_hash(model),
        'rule_ids': rule_ids,
        'property_ids': [inv['id'] for inv in model['invariants']],
        'scope_partial': model['scope'],
        'queries': queries,
        'solver_executed': False,
        'semantics': 'full_finite_sequence_bv8_int_seq32',
        'byte_encoding': enc.byte_encoding,
        'sequence_encoding': enc.sequence_encoding,
        'solver_preprocess': enc.solver_preprocess,
        'solver_version': enc.z.get_version_string(),
    }
    return report


def _assert_no_clock_or_event_in_invariant(node):
    """Reject clock/event expressions inside invariants only. Guards/actions may contain event fields."""
    if isinstance(node, dict):
        require('clock_ms' not in node and 'event' not in node,
                'clock_ms/event expressions not supported in invariants')
        require(node.get('op') != 'rat', 'Rational constants unsupported in invariants')
        for value in node.values():
            _assert_no_clock_or_event_in_invariant(value)
    elif isinstance(node, list):
        for value in node:
            _assert_no_clock_or_event_in_invariant(value)
