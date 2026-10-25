"""Actually compile, audit assumptions and recheck a small IR semantics pilot."""
import argparse
import hashlib
import json
import re
from pathlib import Path
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[2]
IMAGE = 'rocq/rocq-prover:9.2.0@sha256:33926fb3757b2b560c3844157bd64173a26b6d338a256be1ae5eec8df2019025'
THEOREMS = ['checked_concat_length', 'checked_slice_length', 'checked_consume_content',
            'checked_negative_count', 'checked_seq_range', 'checked_seq_compose']


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def closed(output, expected):
    # Empty axiom allowlist; require one explicit closed audit per wrapper.
    return 'Axioms:' not in output and output.count('Closed under the global context') == expected


def check(out, docker=False):
    out = Path(out).resolve()
    out.mkdir(parents=True, exist_ok=True)
    result = {'status': 'not_run', 'kernel_checked_proof': False,
              'scope': 'generic IR value-operation lemmas only; no TCP theorem',
              'theorems': THEOREMS, 'axiom_allowlist': [], 'commands': [],
              'input_hashes': {str(p.relative_to(ROOT)): digest(p) for p in [
                  ROOT/'formal/rocq/IRPrimitives.v', ROOT/'formal/rocq/Check.v',
                  ROOT/'formal/rocq/check.py', ROOT/'docs/semantics.md',
                  ROOT/'protocol_lab/ir.py', ROOT/'protocol_lab/symbolic.py']},
              'image': IMAGE if docker else None,
              'trusted_components': ['Rocq kernel and standard library', 'container/toolchain provenance',
                  'frozen statement review', 'Python orchestration and assumption-output audit'],
              'does_not_prove': ['Python/JSON or Z3 translation equivalence', 'TCP behavior',
                  'buffer ownership in the Python runtime', 'implementation refinement', 'Linux TCP execution']}
    def save():
        (out/'result.json').write_text(json.dumps(result, indent=2)+'\n')
    save()
    tool = 'docker' if docker else 'rocq'
    if not shutil.which(tool):
        result['reason'] = f'{tool} executable unavailable'
        save()
        return 2
    # A fresh workspace prevents a cached .vo from surviving a failed compile.
    with tempfile.TemporaryDirectory(prefix='rocq-', dir=out) as tmp:
        work = Path(tmp)
        work.chmod(0o777)  # image runs as its unprivileged rocq user
        for name in ('IRPrimitives.v', 'Check.v'):
            shutil.copyfile(ROOT/'formal/rocq'/name, work/name)
        prefix = (['docker', 'run', '--rm', '--network', 'none', '--volume', f'{work}:/proof',
                   '--workdir', '/proof', IMAGE] if docker else [])
        def run(name, args, success=True):
            command = prefix + args
            completed = subprocess.run(command, cwd=work, capture_output=True, text=True, timeout=180)
            output = completed.stdout + completed.stderr
            (out/(name+'.log')).write_text(output)
            result['commands'].append({'command': args, 'container_prefix': prefix if docker else [],
                'returncode': completed.returncode, 'log': name+'.log'})
            if success and completed.returncode != 0:
                print(output, flush=True)
                raise RuntimeError(f'{name} failed ({completed.returncode})')
            return completed.returncode, output
        try:
            _, version = run('version', ['rocq', 'compile', '--version'])
            result['checker_version'] = version.strip()
            # Rocq 9.2.0 reports its compiler version as 9.2. The pinned
            # image plus installed package metadata binds the patch release.
            if not re.search(r'version 9\.2(?:\.0)?(?:\s|$)', version):
                raise RuntimeError('Expected Rocq 9.2 compiler')
            if docker:
                _, package_version = run('package-version', ['opam', 'var', 'rocq-runtime:version'])
                result['checker_package_version'] = package_version.strip()
                if package_version.strip() != '9.2.0':
                    raise RuntimeError('Expected locked rocq-runtime 9.2.0 package')
            run('primitives', ['rocq', 'compile', '-Q', '.', 'ProtocolIR', 'IRPrimitives.v'])
            _, audit = run('assumptions', ['rocq', 'compile', '-Q', '.', 'ProtocolIR', 'Check.v'])
            if not closed(audit, len(THEOREMS)):
                raise RuntimeError('Unexpected theorem assumptions or missing audit')
            run('kernel', ['rocq', 'chk', '-Q', '.', 'ProtocolIR', 'ProtocolIR.IRPrimitives', 'ProtocolIR.Check'])
            (work/'FalseProof.v').write_text('Theorem bad : False. Proof. exact I. Qed.\n')
            code, _ = run('reject-false-proof', ['rocq', 'compile', 'FalseProof.v'], success=False)
            if code == 0:
                raise RuntimeError('Invalid proof was accepted')
            (work/'AxiomProbe.v').write_text('Axiom injected : False. Print Assumptions injected.\n')
            _, audit = run('reject-axiom', ['rocq', 'compile', 'AxiomProbe.v'])
            if closed(audit, 1):
                raise RuntimeError('Axiom injection was accepted')
            # Negative probe did compile, but its assumptions must be visible.
            if 'Axioms:' not in audit:
                raise RuntimeError('Axiom audit probe did not expose the injected assumption')
            for name in ('IRPrimitives.v', 'Check.v', 'IRPrimitives.vo', 'Check.vo'):
                shutil.copyfile(work/name, out/name)
            result.update(status='kernel_checked_primitive_lemmas', kernel_checked_proof=True,
                negative_controls={'false_proof': 'rejected_by_compiler', 'axiom_injection': 'rejected_by_audit'})
        except (OSError, RuntimeError, subprocess.TimeoutExpired) as exc:
            result.update(status='failed', reason=str(exc))
    result['artifact_hashes'] = {p.name: digest(p) for p in sorted(out.iterdir())
                                 if p.is_file() and p.name != 'result.json'}
    result['statement_sha256'] = result['input_hashes']['formal/rocq/Check.v']
    save()
    print(result['status'] + ': ' + result.get('reason', 'six audited primitive lemmas'), flush=True)
    return 0 if result['kernel_checked_proof'] else 1


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, default=ROOT/'artifacts/rocq')
    parser.add_argument('--docker', action='store_true')
    options = parser.parse_args()
    raise SystemExit(check(options.out, options.docker))
