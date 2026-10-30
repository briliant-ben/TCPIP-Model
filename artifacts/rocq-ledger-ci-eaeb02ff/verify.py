"""Verify retained CI provenance bindings; does not run a local Rocq kernel."""
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import shutil
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('rocq_audit', ROOT / 'formal/rocq/check.py')
audit = importlib.util.module_from_spec(spec); spec.loader.exec_module(audit)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify(folder):
    provenance = json.loads((folder / 'provenance.json').read_text())
    archive = folder / 'workflow-artifact.zip'
    assert 'sha256:' + sha(archive) == provenance['artifact']['digest'], 'Archive digest differs'
    assert provenance['head_sha'] == provenance['artifact']['workflow_run']['head_sha']
    assert provenance['job_conclusion'] == 'success' and not provenance['artifact']['expired']
    with zipfile.ZipFile(io.BytesIO(archive.read_bytes())) as zipped:
        for member in zipped.infolist():
            path = Path(member.filename)
            assert not path.is_absolute() and '..' not in path.parts
            if not member.is_dir():
                assert (folder / 'download' / path).read_bytes() == zipped.read(member), 'Extracted member differs'
    out = folder / 'download/rocq-ledger'
    result = json.loads((out / 'result.json').read_text())
    assert result['status'] == 'kernel_checked_sent_credit_arithmetic' and result['kernel_checked_proof']
    assert len(result['theorems']) == 5 and len(set(result['theorems'])) == 5
    assert result['axiom_allowlist'] == [] and result['image'] == audit.IMAGE
    assert result['checker_package_version'] == '9.2.0'
    assert result['negative_controls'] == {'false_proof': 'rejected_by_compiler', 'axiom_injection': 'rejected_by_audit'}
    for name, digest in result['input_hashes'].items():
        path = ROOT / name
        assert path.resolve().is_relative_to(ROOT) and sha(path) == digest, 'CI source context changed: ' + name
    for name, digest in result['artifact_hashes'].items():
        path = out / name
        assert path.resolve().is_relative_to(out.resolve()) and sha(path) == digest, 'CI output changed'
    assert audit.closed((out / 'assumptions.log').read_text(), 5)
    assert 'Axioms:' in (out / 'reject-axiom.log').read_text()
    assert any(c['command'][:2] == ['rocq', 'check'] and c['returncode'] == 0 for c in result['commands'])
    assert (out / 'Ledger.v').read_bytes() == (ROOT / 'formal/rocq-ledger/Ledger.v').read_bytes()
    assert (out / 'Check.v').read_bytes() == (ROOT / 'formal/rocq-ledger/Check.v').read_bytes()
    return result


if __name__ == '__main__':
    result = verify(HERE)
    with tempfile.TemporaryDirectory(prefix='rocq-ci-binding-negative-') as tmp:
        copied = Path(tmp) / 'copy'; shutil.copytree(HERE, copied)
        proof = copied / 'download/rocq-ledger/Ledger.vo'
        proof.write_bytes(proof.read_bytes() + b'corrupt')
        try:
            verify(copied)
        except AssertionError:
            pass
        else:
            raise AssertionError('Tampered object was accepted')
    output = dict(status='valid_retained_CI_kernel_evidence', kernel_checked_in_CI=True,
        local_kernel_rerun=False, theorems=result['theorems'], scope=result['scope'],
        does_not_prove=result['does_not_prove'], tampered_object='rejected',
        file_hashes={str(p.relative_to(HERE)): sha(p) for p in sorted(HERE.rglob('*'))
            if p.is_file() and p.name != 'verification.json' and '__pycache__' not in p.parts})
    (HERE / 'verification.json').write_text(json.dumps(output, indent=2) + '\n')
    print(output['status'])
