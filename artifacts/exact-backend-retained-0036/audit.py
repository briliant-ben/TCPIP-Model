"""Read retained bytes only; never execute archived code, ELF, or SMT."""
import hashlib
import json
from pathlib import Path
import tarfile

ROOT = Path(__file__).parent
EXPECTED = '093fccca2addf2583b66a516e96f3e4adc05685b0dfeb09b58efaeb054283b64'


def audit():
    archive = ROOT / 'original.tar.gz'
    digest = lambda raw: hashlib.sha256(raw).hexdigest()
    assert digest(archive.read_bytes()) == EXPECTED, 'Archive changed'
    with tarfile.open(archive) as z:
        files = {}
        for m in z.getmembers():
            assert not m.issym() and not m.islnk(), 'Unexpected link'
            assert not Path(m.name).is_absolute() and '..' not in Path(m.name).parts
            if m.isfile():
                assert m.name not in files, 'Duplicate entry'
                files[m.name] = z.extractfile(m).read()
    read = lambda n: json.loads(files[n])
    base = 'exact-backend-retained-validation-20261107-0036/'
    result = read(base + 'tests-result.json')
    assert [result[k] for k in ('tests', 'errors', 'failures', 'skips')] == [11, 0, 0, 0]
    assert result['actual_core_bounded_pass'] is True
    assert result['real_pipeline_runs'] == result['positive_verifications'] == 3
    assert len(result['policy_rejections']) == 3
    bindings = 0
    for i in range(3):
        prefix = base + f'actual-flow-{i}/'
        report = read(prefix + 'job/flow.json')
        assert report['assessment'] == 'verified_event_slice'
        assert report['finalized'] and report['execution_status'] == 'completed'
        actual = {n.removeprefix(prefix + 'job/'): digest(b) for n, b in files.items()
                  if n.startswith(prefix + 'job/') and n != prefix + 'job/flow.json'}
        assert actual == report['outputs'], 'Incomplete/changed retained output'
        for name, expected in report['input_hashes'].items():
            assert digest(files[prefix + 'job/' + report['source_snapshot']['files'][name]]) == expected
            if name.startswith('workspace/'):
                assert digest(files[prefix + name]) == expected
            bindings += 1
        formal = report['stages']['formal']['data']
        assert formal == read(prefix + 'job/stages/formal/queries/result.json')
        assert formal['status'] == 'bounded_pass'
        assert formal['solver_preprocess'] == 'exact-v1'
        assert formal['solver_tactics'] == ['propagate-values', 'solve-eqs', 'simplify', 'smt']
        assert formal['solver_preprocess_source'] == 'z3.Then(propagate-values,solve-eqs,simplify,smt).solver()'
        assert formal['safety_query'] == formal['overlap_query'] == 'unsat'
        assert read(prefix + 'readonly-verification.json')['status'] == 'retained_evidence_consistent'
    checks = read(base + 'actual-checks.json')
    core = [r for r in checks if r.get('model_semantic_sha256') ==
            'd52526eebfacc3299c90a217d9b6515f8232f72b71230af14191b543ae28e648']
    assert len(core) == 1
    assert core[0]['status'] == 'bounded_pass' and core[0]['depth'] == 2
    assert core[0]['solver_timeout_ms'] == 60000
    assert core[0]['safety_query'] == core[0]['overlap_query'] == 'unsat'
    return dict(status='retained_bytes_consistent', archive_sha256=EXPECTED,
                files=len(files), source_bindings=bindings, retained_pipeline_jobs=3,
                archived_code_executed=False, fresh_execution=False,
                authenticity_established=False, production_fix_accepted=False)


if __name__ == '__main__':
    print(json.dumps(audit(), indent=2))
