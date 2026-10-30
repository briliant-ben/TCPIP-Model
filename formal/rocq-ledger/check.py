"""Compile/recheck five abstract credit lemmas; never imply an IR/TCP bridge."""
import argparse
import importlib.util
import json
from pathlib import Path
import re
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('primitive_checker_utilities', ROOT / 'formal/rocq/check.py')
base = importlib.util.module_from_spec(spec); spec.loader.exec_module(base)
THEOREMS = ['checked_callback_credit_bound', 'checked_callback_credit_sharp',
            'checked_original_record_mass', 'checked_deferred_ack_credit', 'checked_unsent_budget_transfer']


def check(out, docker=False):
    out = Path(out).resolve(); out.mkdir(parents=True, exist_ok=True)
    sources = [HERE / n for n in ['Ledger.v', 'Check.v', 'check.py', 'README.md']]
    sources += [ROOT / n for n in ['formal/rocq/check.py', 'model/tcp-sent-ledger.json',
        'spec/sources/tcp-sent-ledger.json', 'docs/tcp-sent-ledger.md']]
    result = dict(status='not_run', kernel_checked_proof=False, theorems=THEOREMS,
        scope='five abstract integer sent-credit lemmas only', axiom_allowlist=[], commands=[],
        image=base.IMAGE if docker else None,
        input_hashes={str(p.relative_to(ROOT)): base.digest(p) for p in sources},
        trusted_components=['Rocq kernel and standard library', 'pinned toolchain provenance',
                            'statement review', 'orchestration and assumption-output audit'],
        does_not_prove=['JSON actions satisfy the abstract equations', 'IR interpreter/translator correspondence',
                        'TCP or lwIP behavior', 'implementation refinement', 'Linux TCP execution'])
    def save(): (out / 'result.json').write_text(json.dumps(result, indent=2) + '\n')
    save()
    if not shutil.which('docker' if docker else 'rocq'):
        result['reason'] = 'docker executable unavailable' if docker else 'rocq executable unavailable'
        save(); return 2
    with tempfile.TemporaryDirectory(prefix='ledger-proof-', dir=out) as tmp:
        work = Path(tmp); work.chmod(0o777)
        for name in ['Ledger.v', 'Check.v']: shutil.copyfile(HERE / name, work / name)
        prefix = ['docker', 'run', '--rm', '--network', 'none', '--volume', f'{work}:/proof',
                  '--workdir', '/proof', base.IMAGE] if docker else []
        def run(name, args, required=True):
            process = subprocess.run(prefix + args, cwd=work, capture_output=True, text=True, timeout=180)
            text = process.stdout + process.stderr; (out / (name + '.log')).write_text(text)
            result['commands'].append(dict(command=args, container_prefix=prefix, returncode=process.returncode,
                                           log=name + '.log'))
            if required and process.returncode: raise RuntimeError(name + ' failed: ' + text)
            return process.returncode, text
        try:
            _, version = run('version', ['rocq', 'compile', '--version'])
            result['checker_version'] = version.strip()
            if not re.search(r'version 9\.2(?:\.0)?(?:\s|$)', version): raise RuntimeError('Expected Rocq9.2')
            if docker:
                _, package = run('package-version', ['opam', 'var', 'rocq-runtime:version'])
                result['checker_package_version'] = package.strip()
                if package.strip() != '9.2.0': raise RuntimeError('Expected rocq-runtime9.2.0')
            run('proof-bodies', ['rocq', 'compile', '-Q', '.', 'SentLedger', 'Ledger.v'])
            _, audit = run('assumptions', ['rocq', 'compile', '-Q', '.', 'SentLedger', 'Check.v'])
            if not base.closed(audit, len(THEOREMS)): raise RuntimeError('Unclosed or missing theorem audit')
            run('kernel', ['rocq', 'check', '-Q', '.', 'SentLedger', 'SentLedger.Ledger', 'SentLedger.Check'])
            (work / 'FalseProof.v').write_text('Theorem bad : False. Proof. exact I. Qed.\n')
            code, _ = run('reject-false-proof', ['rocq', 'compile', 'FalseProof.v'], False)
            if code == 0: raise RuntimeError('Invalid proof accepted')
            (work / 'AxiomProbe.v').write_text('Axiom injected : False. Print Assumptions injected.\n')
            _, audit = run('reject-axiom', ['rocq', 'compile', 'AxiomProbe.v'])
            if base.closed(audit, 1) or 'Axioms:' not in audit: raise RuntimeError('Axiom injection audit failed')
            for name in ['Ledger.v', 'Check.v', 'Ledger.vo', 'Check.vo']: shutil.copyfile(work / name, out / name)
            result.update(status='kernel_checked_sent_credit_arithmetic', kernel_checked_proof=True,
                negative_controls={'false_proof': 'rejected_by_compiler', 'axiom_injection': 'rejected_by_audit'})
        except (OSError, RuntimeError, subprocess.TimeoutExpired) as error:
            result.update(status='failed', reason=str(error))
    result['statement_sha256'] = result['input_hashes']['formal/rocq-ledger/Check.v']
    result['artifact_hashes'] = {p.name: base.digest(p) for p in out.iterdir() if p.is_file() and p.name != 'result.json'}
    save(); print(result['status']); return 0 if result['kernel_checked_proof'] else 1


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, default=ROOT / 'artifacts/rocq-ledger')
    parser.add_argument('--docker', action='store_true')
    options = parser.parse_args(); raise SystemExit(check(options.out, options.docker))
