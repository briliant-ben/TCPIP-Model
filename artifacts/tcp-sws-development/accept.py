"""Seal a finite SWS policy with independently scoped proof/observation evidence."""
from pathlib import Path
import json
import re
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import load, require
from protocol_lab.symbolic import model_hash
HERE = Path(__file__).resolve().parent
model = load(ROOT / 'model/tcp-sws.json'); parent = load(ROOT / 'model/tcp-nagle.json')
report = read(HERE / 'report.json'); fixed = read(HERE / 'verification.json')
require(report['model_semantic_sha256'] == model_hash(model)
    and fixed['status'] == 'valid_sws_fixed_byte_time_evidence'
    and fixed['report_sha256'] == digest(HERE / 'report.json')
    and fixed['checker_sha256'] == digest(HERE / 'verify.py'), 'Fixed evidence stale')
require(len(report['scenarios']) == len(fixed['scenarios']) == 6 and fixed['input_hashes'] == report['input_hashes'], 'Fixed scope changed')
for name, sha in report['input_hashes'].items(): require(digest(ROOT / name) == sha, 'Fixed input changed')
for name, sha in report['artifact_hashes'].items(): require(digest(HERE / name) == sha, 'Fixed artifact changed')
for name, sha in fixed['file_hashes'].items(): require(digest(HERE / name) == sha, 'Fixed verification changed')
require(report['formal']['status'] in ['unknown', 'bounded_pass'] and report['formal']['depth'] == 6,
    'Primary formal failure or scope changed')
component_dir = ROOT / 'artifacts/sws-component-development'
component = read(component_dir / 'result.json'); checked = read(component_dir / 'verification.json')
require(component['status'] == 'conditional_component_preservation_pass'
    and component['property']['id'] == 'SWS-INV'
    and component['model_semantic_sha256'] == model_hash(model)
    and component['parent_semantic_sha256'] == model_hash(parent), 'Wrong conditional claim')
require(checked['status'] == 'valid_conditional_component_preservation'
    and checked['result_sha256'] == digest(component_dir / 'result.json') and checked['queries'] == 248,
    'Conditional verification stale')
for name, sha in component['checker_sources'].items(): require(digest(ROOT / name) == sha, 'Conditional checker changed')
for row in component['queries']: require(digest(component_dir / row['file']) == row['sha256'], 'Conditional query changed')
for row in checked['assertion_equivalence_checks']:
    for law in row['builtin_laws']: require(digest(component_dir / law['file']) == law['sha256'], 'AC law changed')
    if 'file' in row: require(digest(component_dir / row['file']) == row['sha256'], 'Clause equivalence changed')
service_dir = ROOT / 'artifacts/lwip-sws'
index = read(service_dir / 'execution-index.json'); independent = read(service_dir / 'verification.json')
require(independent['status'] == 'valid_independent_sws_observations'
    and independent['index_sha256'] == digest(service_dir / 'execution-index.json')
    and independent['producer_sha256'] == digest(ROOT / 'ports/lwip-sws/tests.py'), 'Independent observations stale')
require(len(independent['scenarios']) == 3, 'Execution coverage changed')
for row in independent['scenarios']:
    out = service_dir / row['id']; result = read(out / 'report.json')
    require(digest(out / 'report.json') == row['report_sha256']
        and result['model_semantic_sha256'] == model_hash(model), 'Execution model differs')
    for name, sha in result['input_hashes'].items(): require(digest(ROOT / name) == sha, 'Execution input changed')
    for name, sha in result['file_hashes'].items(): require(digest(out / name) == sha, 'Execution artifact changed')
    require(digest(out / 'verification.log') == row['log_sha256']
        and digest(out / 'export-verification.log') == row['export_log_sha256'], 'Execution verification changed')
tests = []
for path, count in [(HERE / 'unit-tests.log', 13), (service_dir / 'unit-tests.log', 4)]:
    matched = re.search(r'Ran (\d+) tests in ([0-9.]+)s\s+OK\s*$', path.read_text())
    require(matched is not None and int(matched[1]) == count, 'Incomplete current tests')
    tests.append(dict(file=str(path.relative_to(ROOT)), methods=count, seconds=float(matched[2]), sha256=digest(path)))
# A structural statement about inherited guards, not a whole guard-disjointness proof.
for before, after in zip(parent['transitions'], model['transitions'][:len(parent['transitions'])], strict=True):
    require(before['id'] == after['id'], 'Parent rule order changed')
    expected = after['guard']['args'][0] if before['event'] == 'choice.segment' else after['guard']
    require(before['guard'] == expected, 'Existing guard possibilities expanded')
new_rules = model['transitions'][len(parent['transitions']):]
require(len(new_rules) == 6 and len({(r['from'], r['event']) for r in new_rules}) == 6
    and all(r['event'] not in parent['events'] for r in new_rules), 'New event/state groups are not fresh singletons')
paths = [HERE / n for n in ['accept.py', 'generate.py', 'verify.py', 'report.json', 'verification.json', 'unit-tests.log']]
paths += [component_dir / 'result.json', component_dir / 'verification.json', service_dir / 'execution-index.json',
    service_dir / 'verification.json', service_dir / 'unit-tests.log', ROOT / 'tools/build_sws_model.py', ROOT / 'tests/test_sws.py']
write(HERE / 'acceptance.json', dict(status='finite_sender_sws_policy_verified_with_retained_implementation_differences',
    registered=False, model_semantic_sha256=model_hash(model), rules=len(model['transitions']), invariants=len(model['invariants']),
    tests=tests, fixed_byte_time_scenarios=6, codec='synthetic_only', primary_bmc=report['formal'],
    conditional_sws=dict(queries=248, assertion_correspondence_checks=len(checked['assertion_equivalence_checks']),
        assumed_pre_invariants=component['assumed_pre_invariants'], parent_basis_closure_proved=False),
    inherited_guard_possibilities='unchanged_or_strengthened', new_event_state_groups='six_fresh_singletons',
    independent_C_executions=3, independent_wire_matches=sum(r['wire'] == 'match' for r in index['scenarios']),
    independent_wire_differences=sum(r['wire'] == 'mismatch' for r in index['scenarios']),
    independent_service_matches=sum(r['service'] == 'match' for r in index['scenarios']),
    differences='two_tiny_writes_model221ms_lwip21ms_preserved_not_RFC_bug_claims',
    linux_execution=False, full_tcp_complete=False, universal_refinement=False, kernel_checked_sws_proof=False,
    actual_timer_metadata_equality_state_invariant=False,
    excluded=['dynamic MSS/window scaling/wire PSH', 'lwIP queue/FIN/memory/recovery variations',
        'fairness/liveness', 'universal interpreter/translator/implementation correspondence'],
    trusted_components=component['trusted_components'] + ['public raw-API driver and pinned lwIP/compiler',
        'PCAP parser/normalizer/comparator', 'source/witness/callback projection'],
    integrity_is_not_authenticity=True, input_hashes=report['input_hashes'],
    file_hashes={str(p.relative_to(ROOT)): digest(p) for p in paths}))
print('finite_sender_sws_policy_verified_with_retained_implementation_differences')
