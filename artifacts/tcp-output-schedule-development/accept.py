"""Seal bounded schedule evidence; preserve all primary/canonical unknowns/failures."""
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import digest, read, write
from protocol_lab.ir import load, require
from protocol_lab.profiles import profile_inputs
from protocol_lab.symbolic import model_hash

HERE = Path(__file__).resolve().parent
model = load(ROOT / 'model/tcp-output-schedule.json')
profile = read(HERE / 'development-profile.json')
report = read(HERE / 'report.json')
verification = read(HERE / 'development-verification.json')
require(report['input_hashes'] == profile_inputs(profile, model), 'Stale development inputs')
require(verification['report_sha256'] == digest(HERE / 'report.json'), 'Stale verification')
require(verification['status'] == 'valid_unregistered_development_evidence_formal_pending', 'Unexpected evidence status')
for name, sha in report['artifact_hashes'].items():
    require(digest(HERE / name) == sha, 'Changed profile artifact: ' + name)
primary_dir = ROOT / 'artifacts/output-schedule-current-induction'
refinement_dir = ROOT / 'artifacts/output-schedule-current-refinement'
primary = read(primary_dir / 'result.json')
refinement = read(refinement_dir / 'result.json')
require(primary['status'] == 'unknown', 'Primary status changed')
require(refinement['status'] == 'refined_inductive_queries_pass', 'Refinement not passing')
require('valid_refined_induction_evidence' in (refinement_dir / 'verification.log').read_text(), 'Missing independent verification')
require(refinement['primary_result_sha256'] == digest(primary_dir / 'result.json'), 'Stale primary binding')
require(primary['model_semantic_sha256'] == refinement['model_semantic_sha256'] == model_hash(model), 'Model mismatch')
for name, sha in primary['query_hashes'].items():
    require(digest(primary_dir / name) == sha, 'Changed primary query: ' + name)
for name, sha in refinement['checker_source_hashes'].items():
    require(digest(ROOT / name) == sha, 'Changed proof checker: ' + name)
for name, sha in refinement['artifact_hashes'].items():
    require(digest(refinement_dir / name) == sha, 'Changed refinement artifact: ' + name)
wire_dir = ROOT / 'artifacts/output-schedule-alignment'
wire = read(wire_dir / 'result.json')
require(wire['status'] == 'matched_finite_wire_service_projection_witness_canonical_final_mismatch', 'Wrong wire scope')
require(wire['canonical_final']['status'] == 'mismatch' and wire['original_comparison'] == 'mismatch_preserved', 'Canonical failure lost')
for name, sha in {**wire['bound_original_inputs'], **wire['input_hashes']}.items():
    require(digest(ROOT / name) == sha, 'Changed wire input: ' + name)
for name, sha in wire['file_hashes'].items():
    require(digest(wire_dir / name) == sha, 'Changed wire artifact: ' + name)
log = (HERE / 'unit-tests.log').read_text()
match = re.search(r'Ran (\d+) tests in ([0-9.]+)s\s+OK\s*$', log)
require(match is not None and int(match[1]) == 12, 'Incomplete final unit run')
unknown = refinement['original_unknown_targets']
groups = sum(p['verification']['disjuncts'] for p in refinement['partitions'])
checks = sum(p['verification']['checks'] for p in refinement['partitions'])
files = [HERE / n for n in ['accept.py', 'generate.py', 'verify.py', 'unit-tests.log',
    'report.json', 'development-verification.json']]
files += [primary_dir / 'result.json', refinement_dir / 'result.json',
          refinement_dir / 'verification.log', wire_dir / 'result.json']
files += [ROOT / p for p in ['tests/test_output_schedule.py', 'tools/replay_schedule.py',
    'tools/build_output_schedule_model.py', 'spec/sources/tcp-output-schedule.json']]
result = dict(status='finite_output_schedule_and_service_observation_milestone_verified',
    registered=False, model_semantic_sha256=model_hash(model), rules=len(model['transitions']),
    invariants=len(model['invariants']), test_methods=int(match[1]), test_seconds=float(match[2]),
    parent_stimuli=22, fixed_input_scenarios=2, synthetic_codec_scope='synthetic_only',
    primary_bmc=report['formal'], primary_induction=primary['status'],
    primary_unknown_targets=unknown, supplementary_groups=groups, supplementary_checks=checks,
    wire_service_projection='one_fixed_seven_input_nine_frame_witness',
    canonical_final='mismatch_preserved', new_independent_execution=False,
    linux_execution=False, kernel_checked_proof=False, universal_refinement=False,
    complete_tcp=False, input_hashes=report['input_hashes'],
    file_hashes={str(p.relative_to(ROOT)): digest(p) for p in files})
write(HERE / 'acceptance.json', result)
print({k: result[k] for k in ['status', 'test_methods', 'supplementary_groups', 'supplementary_checks']})
