"""Verify all formal/lib/** Protocol IR modules using Formal-Spec-Agent lean-timed-check."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def discover_modules():
    mods = []
    lib_dir = ROOT / 'formal/lib'
    if not lib_dir.is_dir():
        return mods
    for manifest in sorted(lib_dir.glob('*/*/manifest.json')):
        group = manifest.parts[-3]
        name = manifest.parts[-2]
        model = ROOT / 'model' / group / f'{name}.json'
        mods.append((f'{group}/{name}', model, manifest))
    return mods


def update_manifests(mods):
    for label, model, manifest in mods:
        proof_file = manifest.parent / 'TimedProof.lean'
        mdata = {
            'schema': 'fsa-lean-timed-proof-manifest-v1',
            'model': {
                model.name: hashlib.sha256(model.read_bytes()).hexdigest(),
            },
            'modules': [
                {
                    'module': 'TimedProof',
                    'sha256': hashlib.sha256(proof_file.read_bytes()).hexdigest(),
                }
            ],
        }
        # Note: lean_timed_check looks for model in model.parent! Copy/pin relative paths if needed.
        manifest.write_text(json.dumps(mdata, indent=2) + '\n', encoding='utf-8')
        print(f'Updated manifest {label}')


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--framework', type=Path, required=True)
    p.add_argument('--lean', default='lean')
    p.add_argument('--out', type=Path, default=Path('/tmp/tcpip-formal-lib-check'))
    p.add_argument('--filter', default='')
    p.add_argument('--update-manifests', action='store_true')
    args = p.parse_args()

    mods = discover_modules()
    if args.filter:
        mods = [m for m in mods if args.filter in m[0]]
    if not mods:
        raise SystemExit('No formal/lib modules matched')

    if args.update_manifests:
        update_manifests(mods)

    fw = args.framework.resolve()
    lean = str(Path(args.lean).resolve()) if '/' in args.lean else args.lean
    out_root = args.out.resolve()
    if out_root.exists():
        shutil.rmtree(out_root)
    out_root.mkdir(parents=True)

    env = dict(os.environ, PYTHONPATH=str(fw), PYTHONDONTWRITEBYTECODE='1')
    results = []
    for label, model, manifest in mods:
        mod_out = out_root / label.replace('/', '_')
        msha = hashlib.sha256(manifest.read_bytes()).hexdigest()
        cmd = [
            sys.executable, '-S', '-m', 'formal_spec_agent', 'lean-timed-check',
            str(model), '--proof-manifest', str(manifest), '--proof-sha256', msha,
            '--out', str(mod_out), '--lean', lean,
        ]
        res = subprocess.run(cmd, cwd=fw, env=env, capture_output=True, text=True)
        if res.returncode != 0:
            print(f'FAIL {label}:\n{res.stdout}\n{res.stderr}', file=sys.stderr)
            raise SystemExit(res.returncode or 1)
        rjson = json.loads((mod_out / 'result.json').read_text())
        assert rjson['status'] == 'checked_timed_dispatch_contract', rjson
        assert rjson['axioms'] == {
            'initial': ['propext', 'Classical.choice', 'Quot.sound'],
            'timers': ['propext', 'Classical.choice', 'Quot.sound'],
            'preservation': ['propext', 'Classical.choice', 'Quot.sound'],
            'advance': ['propext', 'Classical.choice', 'Quot.sound'],
            'dispatch': ['propext', 'Classical.choice', 'Quot.sound'],
        } or set().union(*rjson['axioms'].values()).issubset({'propext', 'Classical.choice', 'Quot.sound', 'Lean.ofReduceBool', 'Lean.trustCompiler'})
        # Enforce zero sorry / custom axioms:
        for thm, ax in rjson['axioms'].items():
            bad = [a for a in ax if a not in ('propext', 'Classical.choice', 'Quot.sound')]
            if bad:
                raise SystemExit(f'Forbidden axioms in {label}.{thm}: {bad}')
        results.append({'module': label, 'raw_firings': rjson['raw_firings'], 'conflicts': rjson['conflict_groups']})
        print(f'LEAN OK: {label} (raw={rjson["raw_firings"]}, conflicts={rjson["conflict_groups"]})', flush=True)

    print(json.dumps({'status': 'pass', 'checked': results}, indent=2))


if __name__ == '__main__':
    main()
