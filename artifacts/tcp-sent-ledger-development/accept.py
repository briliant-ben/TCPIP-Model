"""Seal explicitly scoped ledger evidence; primary unknown and CI remain visible."""
from pathlib import Path
import json
import re
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import load, require
from protocol_lab.profiles import profile_inputs
from protocol_lab.symbolic import model_hash
HERE = Path(__file__).resolve().parent
model = load(ROOT / 'model/tcp-sent-ledger.json')
profile = read(HERE / 'development-profile.json')
report = read(HERE / 'report.json')
fixed = read(HERE / 'development-verification.json')
require(report['input_hashes'] == profile_inputs(profile, model) == fixed['input_hashes'], 'Fixed inputs stale')
require(fixed['status'] == 'valid_unregistered_sent_ledger_fixed_input_evidence', 'Fixed evidence incomplete')
for name, sha in fixed['file_hashes'].items(): require(digest(HERE / name) == sha, 'Fixed verification artifact changed')
for name, sha in report['artifact_hashes'].items(): require(digest(HERE / name) == sha, 'Fixed artifact changed')
primary_dir = ROOT / 'artifacts/sent-ledger-current-induction'
primary = read(primary_dir / 'result.json')
require(primary['model_semantic_sha256'] == model_hash(model), 'Primary stale')
require(primary['status'] == 'unknown' and primary['initial_query'] == primary['clock_advance_query'] == primary['length_lemmas'] == 'unsat', 'Primary status changed')
require(all(t['query'] in ('unsat', 'unknown') for r in primary['preservation'] for t in r['targets']), 'Primary has SAT')
require(all(r['query'] == 'unsat' for r in primary['overlap']), 'Guard result changed')
for name, sha in primary['query_hashes'].items(): require(digest(primary_dir / name) == sha, 'Primary query changed')
component_dir = ROOT / 'artifacts/sent-ledger-budget-component'
component = read(component_dir / 'result.json'); checked = read(component_dir / 'verification.json')
require(component['model_semantic_sha256'] == model_hash(model), 'Component stale')
require(component['status'] == 'conditional_component_preservation_pass'
    and checked['status'] == 'valid_conditional_component_preservation'
    and checked['result_sha256'] == digest(component_dir / 'result.json'), 'Budget component not verified')
for name, sha in component['checker_sources'].items(): require(digest(ROOT / name) == sha, 'Component checker stale')
for row in component['queries']: require(digest(component_dir / row['file']) == row['sha256'], 'Component query changed')
for row in checked['assertion_equivalence_checks']:
    for law in row['builtin_laws']: require(digest(component_dir / law['file']) == law['sha256'], 'AC law changed')
    if 'file' in row: require(digest(component_dir / row['file']) == row['sha256'], 'Equivalence query changed')
service_dir = ROOT / 'artifacts/lwip-service'
index = read(service_dir / 'execution-index.json'); service = read(service_dir / 'verification.json')
require(service['status'] == 'valid_independent_public_sent_observations'
    and service['index_sha256'] == digest(service_dir / 'execution-index.json'), 'Independent observations unverified')
require(service['producer_sha256'] == digest(ROOT / 'ports/lwip-service/tests.py'), 'Producer stale')
for row in service['scenarios']:
    out = service_dir / row['id']; result = read(out / 'report.json')
    require(digest(out / 'report.json') == row['report_sha256'] and result['model_semantic_sha256'] == model_hash(model), 'Service model binding changed')
    for name, sha in result['input_hashes'].items(): require(digest(ROOT / name) == sha, 'Independent input stale')
    for name, sha in result['file_hashes'].items(): require(digest(out / name) == sha, 'Independent artifact changed')
    require(digest(out / 'verification.log') == row['log_sha256'] and digest(out / 'export-verification.log') == row['export_log_sha256'], 'Independent verification changed')
witness_dir = service_dir / 'segmentation-witnesses'; witnesses = read(witness_dir / 'result.json')
require(witnesses['model_semantic_sha256'] == model_hash(model) and len(witnesses['scenarios']) == 3, 'Alternative witnesses stale')
require(sum(r['wire'] == 'match' for r in witnesses['scenarios']) == 2
    and all(r['service'] == 'match' for r in witnesses['scenarios']), 'Alternative scope changed')
require(witnesses['original_verification_sha256'] == digest(service_dir / 'verification.json'), 'Witness source verification changed')
for name, sha in witnesses['file_hashes'].items(): require(digest(witness_dir / name) == sha, 'Alternative witness changed')
for row in witnesses['scenarios']:
    source = service_dir / row['id']
    require(digest(source / 'difference.json') == row['original_difference_sha256']
        and digest(source / 'receiver-difference.json') == row['original_service_difference_sha256'], 'Original Difference lost')
counts = []
for path, expected in [(HERE / 'unit-tests.log', 11), (service_dir / 'unit-tests.log', 10),
    (component_dir / 'unit-tests.log', 4), (component_dir / 'ac-unit-tests.log', 4)]:
    matched = re.search(r'Ran (\d+) tests in ([0-9.]+)s\s+OK\s*$', path.read_text())
    require(matched is not None and int(matched[1]) == expected, 'Incomplete test log')
    counts.append(dict(file=str(path.relative_to(ROOT)), methods=int(matched[1]), seconds=float(matched[2]), sha256=digest(path)))
unknown = [{'rule': r['transition'], 'state': t['state']} for r in primary['preservation'] for t in r['targets'] if t['query'] == 'unknown']
files = [HERE / n for n in ['accept.py', 'report.json', 'development-verification.json']]
files += [primary_dir / 'result.json', component_dir / 'result.json', component_dir / 'verification.json',
          service_dir / 'execution-index.json', service_dir / 'verification.json', witness_dir / 'result.json']
result = dict(status='finite_sent_ledger_behavior_and_observation_milestone_verified_primary_unknown',
    registered=False, model_semantic_sha256=model_hash(model), rules=len(model['transitions']), invariants=len(model['invariants']),
    tests=counts, fixed_input_full_byte_scenarios=len(fixed['scenarios']), synthetic_codec='synthetic_only',
    primary_bmc=report['formal'], primary_induction='unknown', primary_unknown_targets=unknown,
    budget_component=dict(property=component['property']['id'], queries=checked['queries'],
        assumptions=component['assumed_pre_invariants'], whole_model_proof=False),
    real_execution_scenarios=len(service['scenarios']),
    original_wire_matches=sum(x['wire'] == 'match' for x in index['scenarios']),
    original_wire_mismatches=sum(x['wire'] == 'mismatch' for x in index['scenarios']),
    original_service_matches=sum(x['service'] == 'match' for x in index['scenarios']),
    original_service_mismatches=sum(x['service'] == 'mismatch' for x in index['scenarios']),
    alternative_full_wire_service_witnesses=2, alternative_timed_service_matches=3,
    alternative_LT_wire_difference='preserved', original_candidate_differences='preserved',
    rocq_arithmetic='five_statements_CI_pending_local_compiler_unavailable', kernel_checked_proof=False,
    linux_execution=False, universal_refinement=False, full_tcp_complete=False,
    trusted_components=component['trusted_components'] + ['pinned lwIP/compiler and public API driver',
        'PCAP parser/normalizer/comparator', 'frozen source/witness/service projection mapping'],
    integrity_is_not_authenticity=True,
    input_hashes=report['input_hashes'], file_hashes={str(p.relative_to(ROOT)): digest(p) for p in files})
write(HERE / 'acceptance.json', result)
print(json.dumps({k: result[k] for k in ['status', 'rules', 'invariants', 'real_execution_scenarios', 'budget_component']}))
