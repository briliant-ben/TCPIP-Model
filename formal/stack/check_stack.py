"""Run and audit pinned Lean 4.35.0 timed proofs across all 10 stack IR modules."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import json
import os
from pathlib import Path
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
ALLOWED_AXIOMS = {'propext', 'Classical.choice', 'Quot.sound'}
CLAIMS = ('initial', 'timers', 'preservation', 'advance', 'dispatch')


def _check_one(framework: Path, lean_bin: str, out_root: Path, entry: dict):
    slug = entry['id'].replace('/', '_')
    bundle = out_root / slug
    model_path = ROOT / entry['model']
    manifest_path = ROOT / entry['manifest']
    manifest_sha = entry['proof_manifest_sha256']

    for lean_src in manifest_path.parent.glob('*.lean'):
        txt = lean_src.read_text(encoding='utf-8')
        if re.search(r'\bsorry\b', txt) or re.search(r'^\s*axiom\b', txt, re.MULTILINE):
            raise ValueError(f'Forbidden sorry/axiom token in {lean_src}')

    command = [
        sys.executable, '-S', '-m', 'formal_spec_agent', 'lean-timed-check',
        str(model_path),
        '--proof-manifest', str(manifest_path),
        '--proof-sha256', manifest_sha,
        '--out', str(bundle),
        '--lean', lean_bin,
    ]
    env = dict(os.environ, PYTHONPATH=str(framework), PYTHONDONTWRITEBYTECODE='1')
    proc = subprocess.run(command, cwd=framework, env=env, capture_output=True, text=True, check=False)
    if proc.returncode != 0:
        raise ValueError(
            f"{entry['id']} lean-timed-check failed (rc={proc.returncode}):\n"
            f"{proc.stdout}\n{proc.stderr}"
        )
    return entry, bundle, model_path, manifest_path, manifest_sha


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--framework', type=Path, required=True)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--lean', default='lean')
    parser.add_argument('--jobs', type=int, default=min(4, os.cpu_count() or 2))
    args = parser.parse_args()

    pin = json.loads((ROOT / 'formal/stack/framework.json').read_text(encoding='utf-8'))
    framework = args.framework.resolve()
    out_root = args.out.resolve()

    try:
        head = subprocess.check_output(
            ['git', '-C', str(framework), 'rev-parse', 'HEAD'], text=True
        ).strip()
        if head != pin['commit']:
            raise ValueError(
                f"Framework HEAD {head} differs from formal/stack/framework.json ({pin['commit']})"
            )
        dirty = subprocess.check_output(
            ['git', '-C', str(framework), 'status', '--porcelain', '--untracked-files=all',
             '--', 'formal_spec_agent', 'protocol_lab'],
            text=True,
        )
        if dirty:
            raise ValueError('Use clean source files from the pinned framework commit')

        if out_root.exists():
            raise ValueError(f'Output directory already exists: {out_root}')
        out_root.mkdir(parents=True)

        lean_bin = str(Path(args.lean).resolve()) if '/' in args.lean else args.lean
        modules = pin['modules']
        if len(modules) != 10:
            raise ValueError(f'Expected 10 stack modules, got {len(modules)}')

        sys.path.insert(0, str(framework))
        from formal_spec_agent import lean_timed_check as ltc

        with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
            futures = [pool.submit(_check_one, framework, lean_bin, out_root, m) for m in modules]
            results = [f.result() for f in futures]

        summary = []
        for entry, bundle, model_path, manifest_path, manifest_sha in results:
            report = ltc.inspect(bundle, model_path, manifest_path, manifest_sha, require_pass=True)
            if report.get('status') != 'checked_timed_dispatch_contract':
                raise ValueError(f"{entry['id']}: unexpected status {report.get('status')}")
            axioms = report.get('axioms', {})
            for claim in CLAIMS:
                used = set(axioms.get(claim, ()))
                extra = used - ALLOWED_AXIOMS
                if extra:
                    raise ValueError(f"{entry['id']} claim {claim} used non-standard axioms: {sorted(extra)}")
            summary.append({
                'id': entry['id'],
                'status': report['status'],
                'raw_firings': report['raw_firings'],
                'conflict_groups': report['conflict_groups'],
                'axioms': axioms,
            })
            print(
                f"[OK] {entry['id']}: {report['status']} "
                f"(firings={report['raw_firings']}, conflicts={report['conflict_groups']})"
            )

        (out_root / 'stack-formal-summary.json').write_text(
            json.dumps({'schema': 'tcpip-stack-formal-summary-v1', 'commit': head, 'modules': summary}, indent=2) + '\n',
            encoding='utf-8',
        )
        return 0
    except Exception as error:
        print(str(error), file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
