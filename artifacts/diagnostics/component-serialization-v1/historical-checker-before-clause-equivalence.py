"""Conditional preservation of one declared IR property over a named parent basis.

This is not whole-model induction: the report lists every assumed invariant and
does not claim preservation of the other child invariants or guard disjointness.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from protocol_lab.ir import CLOCK_SEMANTICS, load, require
from protocol_lab.symbolic import Encoding, model_hash, replay

LIMITS = dict(backend='z3-conditional-component-preservation',
    assumed_parent_invariants_preserved='not_proved_by_this_component_check',
    byte_encoding='exact_length_projection_content_insensitive_subset',
    sequence_encoding='modular_integer_full_32bit_domain', timeout_ms=10000,
    target_coverage='all_declared_destinations',
    runtime_properties=['positive_timer_duration', 'active_timer_not_in_past'],
    does_not_prove=['other child invariants', 'guard disjointness', 'byte contents',
        'whole-model induction', 'unbounded protocol correctness', 'interpreter/translator or implementation refinement'])


def digest(path): return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def exported_assertions(z, assertions):
    # Match the actual SMT artifact representation: negative numeral nodes and
    # zero-arity connectives need not retain their in-memory AST identity through
    # serialization. Preserve the complete assertion vector and its ordering.
    solver = z.Solver(); solver.add(*assertions)
    return list(z.parse_smt2_string(solver.to_smt2()))


def basis(model, parent, property_id):
    child = {i['id']: i for i in model['invariants']}
    require(property_id in child, 'Unknown component property')
    for invariant in parent['invariants']:
        require(invariant['id'] in child and invariant['assert'] == child[invariant['id']]['assert'],
                'Parent basis is not an unchanged subset of child invariants')
    selected = child[property_id]
    assumptions = list(parent['invariants'])
    if property_id not in {i['id'] for i in assumptions}: assumptions.append(selected)
    return selected, assumptions


def queries(model, parent, property_id):
    selected, assumptions = basis(model, parent, property_id)
    initials = tuple(n for n in ['iss'] if n in model['variables'])
    initial = Encoding(model, 1, initials, byte_encoding='length', sequence_encoding='modular-int')
    z = initial.z
    initial.solver.add(z.Int('choice_0') == -1, z.Not(initial.expr(selected['assert'], initial.frames[0])))
    yield 'initial', list(initial.solver.assertions())
    step = Encoding(model, 1, tuple(model['variables']), byte_encoding='length',
                    sequence_encoding='modular-int', arbitrary_state=True)
    step.solver.add(*[step.expr(i['assert'], step.frames[0]) for i in assumptions])
    new = step.frames[1]
    post = [step.expr(selected['assert'], new)]
    post += [z.Implies(new['active'][n], new['due'][n] >= new['now']) for n in model['timers']]
    step.solver.add(z.Or(z.Not(z.And(*post)), *step.action_faults))
    base = list(step.solver.assertions())
    for index, rule in enumerate(model['transitions']):
        source = z.IntVal(model['states'].index(rule['from']))
        targets = sorted({rule['to'], *[c['to'] for c in rule.get('target_cases', [])]}, key=model['states'].index)
        for target in targets:
            destination = z.IntVal(model['states'].index(target))
            fixed = [(z.Int('choice_0'), z.IntVal(index)), (step.frames[0]['state'], source), (new['state'], destination)]
            reduced = [z.simplify(z.substitute(a, *fixed)) for a in base]
            reduced += [symbol == value for symbol, value in fixed]
            yield rule['id'] + ' -> ' + target, reduced
    if model['semantics'] == CLOCK_SEMANTICS:
        fixed = [(z.Int('choice_0'), z.IntVal(-2))]
        yield 'clock_advance', [z.simplify(z.substitute(a, *fixed)) for a in base] + [z.Int('choice_0') == -2]


def sources(model, parent):
    return dict(model_semantic_sha256=model_hash(model), parent_semantic_sha256=model_hash(parent),
        checker_sources={name: digest(ROOT / name) for name in ['formal/component_induction.py',
            'protocol_lab/ir.py', 'protocol_lab/symbolic.py']})


def save(out, data):
    temporary = out / 'result.json.tmp'
    temporary.write_text(json.dumps(data, indent=2) + '\n'); temporary.replace(out / 'result.json')


def prove(model, parent, property_id, out):
    import z3
    out = Path(out); (out / 'queries').mkdir(parents=True, exist_ok=True)
    selected, assumptions = basis(model, parent, property_id)
    before = sources(model, parent)
    result = dict(status='running', **LIMITS, **before,
        property=selected, assumed_pre_invariants=[i['id'] for i in assumptions],
        solver_version=z3.get_version_string(), queries=[])
    save(out, result)
    for index, (label, assertions) in enumerate(queries(model, parent, property_id)):
        solver = z3.Solver(); solver.set(timeout=10000); solver.add(*assertions)
        filename = f'queries/{index:04}.smt2'; (out / filename).write_text(solver.to_smt2())
        answer = solver.check()
        row = dict(label=label, query=str(answer), file=filename, sha256=digest(out / filename))
        if answer == z3.unknown: row['reason'] = solver.reason_unknown()
        if answer == z3.sat:
            witness = f'queries/{index:04}-model.txt'; (out / witness).write_text(solver.model().sexpr() + '\n')
            row.update(classification='arbitrary_prestate_component_failure_not_reachability_proof',
                       witness_file=witness, witness_sha256=digest(out / witness))
        result['queries'].append(row); save(out, result)
    answers = {q['query'] for q in result['queries']}
    result['status'] = ('component_obligation_failure' if 'sat' in answers else
                        'component_unknown' if answers != {'unsat'} else 'conditional_component_preservation_pass')
    if result['status'] == 'conditional_component_preservation_pass':
        sample = Encoding(model, 1, tuple(n for n in ['iss'] if n in model['variables']))
        sample.solver.add(z3.Int('choice_0') >= 0)
        (out / 'sample.smt2').write_text(sample.solver.to_smt2())
        answer = sample.solve(); result['sample_query'] = str(answer)
        if answer == z3.sat:
            result['sample_witness'] = sample.witness(sample.solver.model())
            result['sample_replay'] = replay(model, result['sample_witness'])
            if result['sample_replay']['status'] != 'match': result['status'] = 'semantic_mismatch'
        else: result['status'] = 'component_unknown' if answer == z3.unknown else 'vacuous'
        result['sample_sha256'] = digest(out / 'sample.smt2')
    require(before == sources(model, parent), 'Component checker sources changed')
    save(out, result); return result


def verify(model, parent, property_id, out):
    import z3
    out = Path(out); result = json.loads((out / 'result.json').read_text())
    selected, assumptions = basis(model, parent, property_id)
    require(result['status'] == 'conditional_component_preservation_pass', 'Component obligations not passing')
    require(all(result.get(k) == value for k, value in LIMITS.items()), 'Component proof scope changed')
    require(all(result[k] == value for k, value in sources(model, parent).items()), 'Stale component binding')
    require(result['property'] == selected and result['assumed_pre_invariants'] == [i['id'] for i in assumptions], 'Component claim changed')
    require(result['solver_version'] == z3.get_version_string(), 'Checker version changed')
    count = 0
    for index, (row, (label, expected)) in enumerate(zip(result['queries'], queries(model, parent, property_id), strict=True)):
        require(row['label'] == label and row['query'] == 'unsat', 'Missing component query')
        require(row['file'] == f'queries/{index:04}.smt2', 'Component query identity changed')
        path = out / row['file']; require(path.resolve().is_relative_to(out.resolve()) and digest(path) == row['sha256'], 'Query changed')
        actual = list(z3.parse_smt2_file(str(path)))
        expected = exported_assertions(z3, expected)
        require(len(actual) == len(expected) and all(z3.eq(a, b) for a, b in zip(actual, expected)), 'Exported query differs from reconstructed component semantics')
        solver = z3.Solver(); solver.set(timeout=10000); solver.add(*actual)
        require(solver.check() == z3.unsat, 'Fresh component query did not prove unsat')
        count += 1
    require(result['sample_query'] == 'sat' and result['sample_replay']['status'] == 'match'
            and digest(out / 'sample.smt2') == result['sample_sha256'], 'Missing nonvacuity sample')
    solver = z3.Solver(); solver.set(timeout=10000); solver.add(z3.parse_smt2_file(str(out / 'sample.smt2')))
    sample = Encoding(model, 1, tuple(n for n in ['iss'] if n in model['variables']))
    sample.solver.add(z3.Int('choice_0') >= 0)
    actual = list(solver.assertions()); expected = exported_assertions(z3, sample.solver.assertions())
    require(len(actual) == len(expected) and all(z3.eq(a, b) for a, b in zip(actual, expected)), 'Nonvacuity query changed')
    witness = result['sample_witness']
    require(len(witness['steps']) == 1 and set(witness['initial']) == set(model['variables']), 'Nonvacuity initial scope changed')
    require(all(witness['initial'][name] == variable['initial'] for name, variable in model['variables'].items()
                if name != 'iss'), 'Nonvacuity defaults changed')
    require(solver.check() == z3.sat and replay(model, result['sample_witness'])['status'] == 'match', 'Sample recheck failed')
    require(all(result[k] == value for k, value in sources(model, parent).items()), 'Checker changed during verification')
    return dict(status='valid_conditional_component_preservation', queries=count, whole_model_proof=False)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('model', type=Path); parser.add_argument('--parent', type=Path, required=True)
    parser.add_argument('--property', required=True); parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--verify', action='store_true'); args = parser.parse_args()
    require(args.model.resolve().parent == args.parent.resolve().parent and
        json.loads(args.model.read_text()).get('extends') == args.parent.name, 'Expected the declared immediate parent')
    model, parent = load(args.model), load(args.parent)
    result = verify(model, parent, args.property, args.out) if args.verify else prove(model, parent, args.property, args.out)
    print(json.dumps({'status': result['status'], 'queries': len(result['queries']) if 'queries' in result and type(result['queries']) is list else result.get('queries')}))
    raise SystemExit(0 if result['status'] in ('conditional_component_preservation_pass', 'valid_conditional_component_preservation') else 2)
