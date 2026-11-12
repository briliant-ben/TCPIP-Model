"""Verify retained existential witnesses without running archived code or Solver.check.

Use current reference execution for frozen default scenes, exact original SMT
assertion-prefix checks, and substitution of the saved concrete model followed by
Z3 simplification. This does not upgrade the original UNKNOWN receipts.
"""
from pathlib import Path
import hashlib
import json
import re
import sys
import tarfile

import z3

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import run_scenario
from protocol_lab.ir import load
from protocol_lab.symbolic import Encoding

A = ROOT / 'artifacts/ipv4-directed-coverage-20261110'
sha = lambda b: hashlib.sha256(b).hexdigest()
manifest = json.loads((A / 'nonvacuity-observed-0220-manifest.json').read_text())
assert sha((A / 'nonvacuity-observed-0220.tar.gz').read_bytes()) == manifest['sha256']
for path, digest in manifest['source_bindings'].items():
    assert sha((ROOT / path).read_bytes()) == digest
with tarfile.open(A / 'nonvacuity-observed-0220.tar.gz') as archive:
    members = archive.getmembers()
    assert len(members) == len({m.name for m in members}) == manifest['files']
    assert set(manifest['members']) == {m.name for m in members}
    assert all(m.isfile() and not Path(m.name).is_absolute() and '..' not in Path(m.name).parts for m in members)
    files = {m.name: archive.extractfile(m).read() for m in members}
assert all(sha(data) == manifest['members'][name] for name, data in files.items())
assert sha((A / 'formal-originals.tar.gz').read_bytes()) == '0f982a061e50ffb7024dbe6cc0c0a43b51888e9d92e373788a2615dd9d49ddbb'
with tarfile.open(A / 'formal-originals.tar.gz') as archive:
    old = {m.name: archive.extractfile(m).read() for m in archive.getmembers() if m.isfile() and m.name.startswith('ipv4-remaining-rule-preservation-20261110-0194/')}
get = lambda path: json.loads(files[path])
G = 'ipv4-nonvacuity-observed-gate-20261111-0219/'
old_prefix = 'ipv4-remaining-rule-preservation-20261110-0194/'
originals = {r['rule']: r for r in json.loads(old[old_prefix + 'results.json']) if r['role'] == 'nonvacuity' and r['answer'] == 'unknown'}
rows = get(G + 'results.json')
assert len(rows) == 13 and all(r['answer'] == 'sat' for r in rows)
assert len({r['rule'] for r in rows}) == 13
model = load(ROOT / 'model/ipv4-endpoint-virtual-link.json')
mapping = get('source-fixtures/mapping.json')


def commands(text):
    """Split SMT commands while respecting comments, quoted symbols and strings."""
    out, depth, start, i = [], 0, None, 0
    while i < len(text):
        c = text[i]
        if c == ';':
            i = text.find('\n', i)
            if i < 0:
                break
        elif c == '"':
            i += 1
            while i < len(text):
                if text[i] == '"':
                    if i + 1 < len(text) and text[i + 1] == '"':
                        i += 2
                        continue
                    break
                i += 1
            assert i < len(text), 'unterminated SMT string'
        elif c == '|':
            i = text.find('|', i + 1)
            assert i >= 0, 'unterminated SMT symbol'
        elif c == '(':
            if depth == 0:
                start = i
            depth += 1
        elif c == ')':
            depth -= 1
            assert depth >= 0
            if depth == 0:
                out.append(text[start:i + 1])
        i += 1
    assert depth == 0
    return out


checks = []
for i, row in enumerate(rows):
    d = G + str(i).zfill(3) + '/'
    witness = get(d + 'observed.json')
    source = mapping[witness['source_reference']]
    ref_bytes, scene_bytes = files[source + '-reference.json'], files[source + '-scenario.json']
    assert sha(ref_bytes) == witness['source_sha256'] and sha(scene_bytes) == witness['source_scene_sha256']
    scene = json.loads(scene_bytes)
    assert scene.get('initial', {}) == {}
    reference = run_scenario(model, scene)
    saved = json.loads(ref_bytes)
    assert reference.trace == saved['trace'] and reference.snapshot() == saved['snapshot']
    tr = reference.trace[witness['trace_index']]
    assert tr == witness['trace'] and tr['transition'] == row['rule']
    assert witness['previous_ms'] == (reference.trace[witness['trace_index'] - 1]['time_ms'] if witness['trace_index'] else 0)
    original = files[d + 'original.smt2']
    receipt = originals[row['rule']]
    assert original == old[old_prefix + receipt['file']]
    assert sha(original) == row['original_sha256'] == receipt['sha256']
    query = files[d + 'observed-witness.smt2']
    assert sha(query) == row['query_sha256']
    before = list(z3.parse_smt2_string(original.decode()))
    after = list(z3.parse_smt2_string(query.decode()))
    assert len(after) > len(before) and all(a.eq(b) for a, b in zip(before, after))
    index = next(k for k, r in enumerate(model['transitions']) if r['id'] == row['rule'])
    enc = Encoding(model, 1, tuple(model['variables']), arbitrary_state=True, fixed_choices=[index])
    expected = []
    for frame, snap, now in [(enc.frames[0], tr['before'], witness['previous_ms']), (enc.frames[1], tr['after'], tr['time_ms'])]:
        expected += [frame['state'] == z3.IntVal(model['states'].index(snap['state'])), frame['now'] == z3.IntVal(now)]
        for name, spec in model['variables'].items():
            expected.append(frame['values'][name] == enc.literal(snap['variables'][name], spec['type']))
        for name in model['timers']:
            active = name in snap['timers']
            expected.append(frame['active'][name] == z3.BoolVal(active))
            if active:
                expected.append(frame['due'][name] == z3.IntVal(snap['timers'][name]))
    event = tr['event']
    schema = model['events'][event['name']]['fields']
    assert set(event['fields']) == set(schema)
    expected += [enc.events[0][event['name']][name] == enc.literal(value, schema[name]) for name, value in event['fields'].items()]
    expected.append(z3.Int('choice_0') == z3.IntVal(index))
    assert len(after) == len(before) + len(expected)
    mismatches = [dict(index=k, actual=a.sexpr(), expected=b.sexpr()) for k, (a, b) in enumerate(zip(after[len(before):], expected)) if not a.eq(b)]
    if mismatches:
        (A / 'nonvacuity-binding-audit-failure.json').write_text(json.dumps(dict(rule=row['rule'], mismatches=mismatches), indent=2) + '\n')
    assert not mismatches
    # Decode saved constant definitions, then instantiate every ORIGINAL assertion.
    assignment = files[d + 'assignment.sexpr']
    assert sha(assignment) == row['assignment_sha256']
    defs = commands(assignment.decode())
    names = []
    for definition in defs:
        match = re.match(r'\(define-fun\s+(\|[^|]+\||[^\s()]+)\s+\(\)', definition)
        assert match, 'nonconstant saved model requires an explicitly supported evaluator'
        names.append(match.group(1))
    assert len(names) == len(set(names))
    declarations, assertions, original_declarations = [], [], []
    for command in commands(original.decode()):
        if command.startswith('(assert'):
            assertions.append(command)
        elif command.startswith('(declare-fun'):
            original_declarations.append(command)
            match = re.match(r'\(declare-fun\s+(\|[^|]+\||[^\s()]+)\s+\(\)', command)
            if not match or match.group(1) not in names:
                declarations.append(command)
        elif command.startswith('(define-'):
            original_declarations.append(command)
            declarations.append(command)
    # Independently parse the split commands with Z3 before any substitution:
    # require exact equality/order with the entire original parser result.
    reparsed = z3.parse_smt2_string('\n'.join(original_declarations + assertions))
    assert len(reparsed) == len(before) and all(a.eq(b) for a, b in zip(reparsed, before))
    concrete = z3.parse_smt2_string('\n'.join(declarations + defs + assertions))
    assert len(concrete) == len(before)
    assert all(z3.is_true(z3.simplify(term)) for term in concrete), 'saved assignment does not simplify all original assertions to true'
    checks.append(dict(rule=row['rule'],original_assertions=len(before),all_original_assertions_true_by_concrete_substitution=True,exact_observed_bindings=True,current_reference_scene_match=True))
review = get('ipv4-nonvacuity-observed-review-20261111-0220/response.json')
assert review['blocking'] == []
report = dict(status='pass',archive_sha256=manifest['sha256'],member_count=len(files),checks=checks,solver_check_called=False,archived_code_executed=False,old_unknown_records_unchanged=True,new_separate_SAT_witnesses=13,remaining_without_SAT_certificate=150,whole_flow='unresolved',new_native_or_network_execution=False,independent_review=review)
(A / 'nonvacuity-witness-readonly-audit.json').write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps(dict(status='pass',new_separate_SAT_witnesses=13,solver_check_called=False)))
