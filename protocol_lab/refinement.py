"""Supplementary exact-query induction evidence; original results stay unchanged."""
import hashlib
import json
from pathlib import Path
import re

from formal import partition_queries as partitioner
from .ir import CLOCK_SEMANTICS, ModelError, require
from .symbolic import Encoding, model_hash, replay

ROOT = Path(__file__).resolve().parents[1]
BACKEND = 'z3-exact-query-refinement'
PASS = 'refined_inductive_queries_pass'
NOT_NEEDED = 'not_needed_primary_pass'
SOURCES = ('protocol_lab/refinement.py', 'protocol_lab/inductive.py',
           'protocol_lab/ir.py', 'protocol_lab/symbolic.py', 'formal/partition_queries.py')


def read(path):
    return json.loads(Path(path).read_text())


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def write(path, value):
    Path(path).write_text(json.dumps(value, indent=2) + '\n')


def checker_sources():
    return {name: digest(ROOT/name) for name in SOURCES}


def unknown_targets(primary):
    return [{'transition': row['transition'], 'state': target['state']}
            for row in primary['preservation'] for target in row['targets']
            if target['query'] == 'unknown']


def validate_structure(model, primary):
    require(primary['solver_version'] == partitioner.z3.get_version_string(), 'Primary solver version changed')
    require(type(primary['symbolic_initials']) is list and len(primary['symbolic_initials']) == len(set(primary['symbolic_initials'])) and set(primary['symbolic_initials']) <= model['variables'].keys(), 'Invalid primary initial domain')
    require(primary['backend'] == 'z3-invariant-induction', 'Unsupported primary checker')
    require(primary['model_semantic_sha256'] == model_hash(model), 'Refinement model mismatch')
    require(primary['invariants'] == [i['id'] for i in model['invariants']], 'Refinement invariant mismatch')
    require(primary['byte_encoding'] == 'exact_length_projection_content_insensitive_subset'
            and primary['sequence_encoding'] == 'modular_integer_full_32bit_domain'
            and primary['sequence_width'] == 32, 'Unsupported primary refinement semantics')
    require(primary['runtime_properties'] == ['positive_timer_duration', 'active_timer_not_in_past']
            and primary['scope'] == 'defined_nonterminal_transitions_and_listed_state_invariants',
            'Unsupported primary obligation scope')
    expected_clock = 'monotonic_integer_before_next_due' if model['semantics'] == CLOCK_SEMANTICS else 'not_applicable'
    require(primary.get('clock_progress') == expected_clock, 'Missing primary clock coverage')
    require(primary.get('clock_advance_query') in (('sat','unsat','unknown') if expected_clock != 'not_applicable' else ('not_applicable',)), 'Invalid primary clock obligation')
    require(primary['target_coverage'] == 'all_declared_destinations', 'Missing primary target coverage')
    require([r['transition'] for r in primary['preservation']] == [r['id'] for r in model['transitions']],
            'Missing primary rule obligation')
    for rule, row in zip(model['transitions'], primary['preservation']):
        expected = sorted({rule['to'], *[c['to'] for c in rule.get('target_cases', [])]}, key=model['states'].index)
        require([t['state'] for t in row['targets']] == expected, 'Missing primary target obligation')
        answers = [t['query'] for t in row['targets']]
        require(all(a in ('sat', 'unsat', 'unknown') for a in answers), 'Invalid primary query status')
        aggregate = 'sat' if 'sat' in answers else 'unknown' if 'unknown' in answers else 'unsat'
        require(row['query'] == aggregate, 'Primary target status mismatch')
    groups = {}
    for rule in model['transitions']:
        groups.setdefault((rule['from'], rule['event']), []).append(rule['id'])
    groups = {key: ids for key, ids in groups.items() if len(ids) > 1}
    actual = {(r['state'], r['event']): r['transitions'] for r in primary['overlap']}
    require(actual == groups and len(primary['overlap']) == len(groups), 'Missing primary guard obligation')
    return unknown_targets(primary)


def validate_summary(model, primary, result):
    expected = validate_structure(model, primary)
    require(result['backend'] == BACKEND and result['model_semantic_sha256'] == model_hash(model),
            'Refinement checker/model mismatch')
    require(result['primary_status'] == primary['status']
            and result['primary_query_hashes'] == primary['query_hashes'], 'Refinement primary binding mismatch')
    require(result['original_unknown_targets'] == expected, 'Refinement unknown target coverage mismatch')
    require(result['status'] in (PASS, NOT_NEEDED, 'refinement_unknown', 'refinement_counterexample',
                                'refinement_unavailable'), 'Unsupported refinement result status')
    if result['status'] == NOT_NEEDED:
        require(primary['status'] == 'inductive_invariants_pass' and not result['partitions'],
                'Primary induction is not passing')
    if result['status'] == PASS:
        require(primary['status'] == 'unknown' and bool(expected), 'No unknown primary preservation to refine')
        require(primary['initial_query'] == 'unsat' and primary['length_lemmas'] == 'unsat'
                and primary['clock_advance_query'] in ('unsat','not_applicable')
                and all(r['query'] == 'unsat' for r in primary['overlap']),
                'Cannot omit unresolved initial/guard obligations')
        require(all(t['query'] in ('unsat', 'unknown') for r in primary['preservation'] for t in r['targets']),
                'Cannot refine a satisfiable preservation obligation')
        require([p['target'] for p in result['partitions']] == expected, 'Missing refined target obligation')
        for index, part in enumerate(result['partitions']):
            require(part['directory'] == f'partitions/target-{index:03}'
                    and part['label'] == part['target']['transition']+' -> '+part['target']['state'],
                    'Refinement label/path mismatch')
            require(part['status'] == 'query_partition_unsat'
                    and part['verification']['status'] == 'valid_exact_partition_queries',
                    'Cannot promote inconclusive refinement evidence')
        require(result.get('sample_query') == 'sat' and result.get('replay', {}).get('status') == 'match',
                'Missing nonempty full-byte refinement replay')
        witness = result.get('sample_witness', {})
        require(type(witness.get('steps')) is list and len(witness['steps']) == 1
                and model['initial_state'] not in model.get('scope', {}).get('terminal_states', []),
                'Missing nonempty full-byte refinement witness')
        require(set(witness.get('initial', {})) == set(model['variables'])
                and all(witness['initial'][name] == spec['initial'] for name, spec in model['variables'].items()
                        if name not in primary['symbolic_initials']), 'Refinement sample initial domain changed')
        step = witness['steps'][0]
        rules = {r['id']: r for r in model['transitions']}
        require(step.get('transition') in rules and rules[step['transition']]['from'] == model['initial_state']
                and rules[step['transition']]['event'] == step.get('event'), 'Refinement sample transition mismatch')

    return expected


def _primary(model, directory):
    directory = Path(directory)
    primary = read(directory/'result.json')
    validate_structure(model, primary)
    files = {'length-lemmas.smt2', 'initial.smt2', 'preservation.smt2', 'overlap.smt2'}
    if primary['clock_progress'] != 'not_applicable':files.add('clock-preservation.smt2')
    if 'sample_query' in primary:
        files.add('sample.smt2')
    require(set(primary['query_hashes']) == files, 'Missing primary query evidence')
    for name, expected in primary['query_hashes'].items():
        require(digest(directory/name) == expected, 'Primary query changed')
    labels = re.findall(r'^; (.+ -> .+)\n\(reset\)\n', (directory/'preservation.smt2').read_text(), re.M)
    expected = [r['transition']+' -> '+t['state'] for r in primary['preservation'] for t in r['targets']]
    require(labels == expected, 'Primary query label coverage mismatch')
    return primary


def refine(model, primary_dir, out, group_size=8):
    primary_dir, out = Path(primary_dir), Path(out)
    out.mkdir(parents=True, exist_ok=True)
    write(out/'result.json', {'status': 'incomplete', 'backend': BACKEND})
    require(type(group_size) is int and group_size >= 1, 'Positive refinement group size required')
    primary = _primary(model, primary_dir)
    sources = checker_sources()
    result = {'backend': BACKEND, 'status': 'refinement_unavailable',
              'model_semantic_sha256': model_hash(model), 'primary_status': primary['status'],
              'primary_result_sha256': digest(primary_dir/'result.json'),
              'primary_query_hashes': primary['query_hashes'], 'checker_source_hashes': sources,
              'solver_version': primary['solver_version'], 'group_size': group_size, 'timeout_ms': 10000,
              'original_unknown_targets': unknown_targets(primary), 'partitions': [],
              'scope': 'same declared state-induction obligations; original unknown results retained',
              'unbounded_protocol_proof': False, 'kernel_checked_proof': False,
              'artifact_hashes': {}}
    generated = []
    if primary['status'] == 'inductive_invariants_pass':
        from .inductive import verify as verify_primary
        verify_primary(model, primary_dir)
        result['status'] = NOT_NEEDED
    elif (primary['status'] == 'unknown' and result['original_unknown_targets']
          and primary['initial_query'] == 'unsat' and primary['length_lemmas'] == 'unsat'
                and primary['clock_advance_query'] in ('unsat','not_applicable')
          and all(r['query'] == 'unsat' for r in primary['overlap'])
          and all(t['query'] in ('unsat', 'unknown') for r in primary['preservation'] for t in r['targets'])):
        outcomes = []
        for index, target in enumerate(result['original_unknown_targets']):
            name = f'partitions/target-{index:03}'
            label = target['transition']+' -> '+target['state']
            part = partitioner.partition(primary_dir/'preservation.smt2', label, out/name,
                                         group_size=group_size, timeout_ms=10000)
            verification = {'status': 'not_run_inconclusive_partition'}
            if part['status'] == 'query_partition_unsat':
                try:
                    verification = partitioner.verify(out/name, source_path=primary_dir/'preservation.smt2')
                except partitioner.PartitionInconclusive as error:
                    verification = {'status': 'unknown', 'reason': str(error)}
            write(out/name/'verification.json', verification)
            result['partitions'].append({'target': target, 'directory': name, 'label': label,
                                         'status': part['status'], 'verification': verification})
            generated += [f'{name}/{p}' for p in (*part['query_hashes'], 'result.json', 'verification.json')]
            outcomes.append('sat' if part['status'] == 'satisfiable_query_not_reachability_proof'
                            else 'unsat' if verification['status'] == 'valid_exact_partition_queries' else 'unknown')
        result['status'] = ('refinement_counterexample' if 'sat' in outcomes else
                            'refinement_unknown' if 'unknown' in outcomes else PASS)
        if result['status'] == PASS:
            sample = Encoding(model, 1, tuple(primary['symbolic_initials']))
            sample.solver.add(sample.z.Int('choice_0') >= 0)
            (out/'sample.smt2').write_text(sample.solver.to_smt2())
            generated.append('sample.smt2')
            answer = sample.solve()
            result['sample_query'] = str(answer)
            if answer == sample.z.sat:
                result['sample_witness'] = sample.witness(sample.solver.model())
                result['replay'] = replay(model, result['sample_witness'])
                require(result['replay']['status'] == 'match', 'Refinement full-byte sample mismatch')
            else:
                result['status'] = 'refinement_unknown'
                result['sample_reason'] = sample.reason_unknown() if answer == sample.z.unknown else 'empty sample domain'
    else:
        result['reason'] = 'Only unknown preservation targets with passing initial/length/guard obligations can be refined'
    require(checker_sources() == sources, 'Refinement checker changed during execution')
    require(digest(primary_dir/'result.json') == result['primary_result_sha256'], 'Primary result changed during refinement')
    result['artifact_hashes'] = {name: digest(out/name) for name in generated}
    validate_summary(model, primary, result)
    write(out/'result.json', result)
    return result


def verify(model, primary_dir, out):
    primary_dir, out = Path(primary_dir), Path(out).resolve()
    primary = _primary(model, primary_dir)
    result = read(out/'result.json')
    validate_summary(model, primary, result)
    require(result['primary_result_sha256'] == digest(primary_dir/'result.json'), 'Refinement primary result changed')
    require(result['checker_source_hashes'] == checker_sources(), 'Refinement checker sources changed')
    require(result['timeout_ms'] == 10000 and result['solver_version'] == partitioner.z3.get_version_string(),
            'Refinement execution configuration changed')
    for name, expected in result['artifact_hashes'].items():
        path = (out/name).resolve()
        require(path.is_relative_to(out) and path.is_file() and digest(path) == expected,
                'Refinement artifact changed or escaped output')
    if result['status'] == NOT_NEEDED:
        from .inductive import verify as verify_primary
        verify_primary(model, primary_dir)
        require(result['artifact_hashes'] == {}, 'Unexpected unnecessary refinement artifacts')
    elif result['status'] == PASS:
        expected_files = {'sample.smt2'}
        for part in result['partitions']:
            directory = out/part['directory']
            record = read(directory/'result.json')
            require(record['label'] == part['label']
                    and record['source_sha256'] == primary['query_hashes']['preservation.smt2']
                    and record['group_size'] == result['group_size'] and record['timeout_ms'] == result['timeout_ms'],
                    'Refined query source/label/configuration mismatch')
            expected_files.update(f"{part['directory']}/{p}" for p in (*record['query_hashes'], 'result.json', 'verification.json'))
            checked = partitioner.verify(directory, source_path=primary_dir/'preservation.smt2')
            require(checked == part['verification'] == read(directory/'verification.json'), 'Refinement verification summary mismatch')
        require(set(result['artifact_hashes']) == expected_files, 'Missing refinement evidence file')
        require(replay(model, result['sample_witness'])['status'] == 'match', 'Refinement sample no longer replays')
    return {'status': 'valid_refined_induction_evidence' if result['status'] in (PASS, NOT_NEEDED)
            else 'valid_pending_refinement_bindings', 'protocol_complete': False,
            'primary_status': primary['status'], 'refinement_status': result['status']}
