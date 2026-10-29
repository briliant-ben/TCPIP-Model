"""Seal finite Nagle behavior and a single conditional property, not full TCP."""
import json
from pathlib import Path
import re
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import load, require
from protocol_lab.symbolic import model_hash
HERE = Path(__file__).resolve().parent
model = load(ROOT / 'model/tcp-nagle.json')
result = read(HERE / 'result.json'); witness = read(HERE / 'verification.json')
require(result['model_semantic_sha256'] == model_hash(model), 'Witness model stale')
require(witness['status'] == 'valid_finite_basic_nagle_observation'
    and witness['result_sha256'] == digest(HERE / 'result.json')
    and witness['checker_sha256'] == digest(HERE / 'verify.py'), 'Observation verification stale')
for name, sha in result['input_hashes'].items(): require(digest(ROOT / name) == sha, 'Observation input changed')
for name, sha in result['file_hashes'].items(): require(digest(HERE / name) == sha, 'Observation artifact changed')
for name, sha in witness['file_hashes'].items(): require(digest(HERE / name) == sha, 'Verification artifact changed')
component_dir = ROOT / 'artifacts/nagle-component-development'
component = read(component_dir / 'result.json'); checked = read(component_dir / 'verification.json')
require(component['status'] == 'conditional_component_preservation_pass'
    and component['property']['id'] == 'NAGLE-INV-NEW-DATA'
    and component['model_semantic_sha256'] == model_hash(model), 'Wrong conditional property')
require(checked['status'] == 'valid_conditional_component_preservation'
    and checked['result_sha256'] == digest(component_dir / 'result.json') and checked['queries'] == 242,
    'Conditional verification changed')
for name, sha in component['checker_sources'].items(): require(digest(ROOT / name) == sha, 'Conditional checker changed')
for row in component['queries']: require(digest(component_dir / row['file']) == row['sha256'], 'Conditional query changed')
for row in checked['assertion_equivalence_checks']:
    for law in row['builtin_laws']: require(digest(component_dir / law['file']) == law['sha256'], 'AC law changed')
    if 'file' in row: require(digest(component_dir / row['file']) == row['sha256'], 'Clause check changed')
log = HERE / 'eight-method-tests.log'
matched = re.search(r'Ran 8 tests in ([0-9.]+)s\s+OK\s*$', log.read_text())
require(matched is not None, 'Current eight-method test run incomplete')
paths = [HERE / n for n in ['accept.py', 'check.py', 'verify.py', 'result.json', 'verification.json', 'eight-method-tests.log']]
paths += [ROOT / n for n in ['tools/build_nagle_model.py', 'tests/test_nagle.py', 'spec/sources/tcp-nagle.json',
    'docs/tcp-nagle.md', 'artifacts/nagle-component-development/result.json',
    'artifacts/nagle-component-development/verification.json']]
write(HERE / 'acceptance.json', dict(status='finite_basic_nagle_behavior_and_conditional_gate_verified',
    registered=False, rules=len(model['transitions']), invariants=len(model['invariants']),
    model_semantic_sha256=model_hash(model), unit_methods=8, unit_seconds=float(matched[1]),
    independent_observation=dict(full_wire='match', timed_callbacks='match', source_input_consumption='exact_once_ordered',
        original_differences='preserved', new_C_execution=False, linux_execution=False),
    conditional_gate=dict(property=component['property']['id'], queries=checked['queries'],
        assertion_equivalence_checks=len(checked['assertion_equivalence_checks']),
        assumed_pre_invariants=component['assumed_pre_invariants'], parent_basis_closure_proved=False),
    full_model_bmc='not_run_for_this_overlay', full_model_induction='not_run_for_this_overlay',
    parent_full_induction='unknown_preserved', whole_model_proof=False, kernel_checked_nagle_proof=False,
    full_tcp_complete=False, universal_refinement=False,
    excluded=['complete sender SWS and timeout', 'lwIP queue/FIN/memory/recovery variations',
        'dynamic MSS', 'general byte/time/IR/interpreter/translator/implementation correspondence'],
    trusted_components=component['trusted_components'] + ['generic scheduling witness replay',
        'PCAP parser/normalizer/comparator', 'public callback/source mapping'],
    input_hashes=result['input_hashes'],
    file_hashes={str(p.relative_to(ROOT)): digest(p) for p in paths}))
print('finite_basic_nagle_behavior_and_conditional_gate_verified')
