"""Regenerate or verify the multi-module C99 stack snapshot via Formal-Spec-Agent system-codegen."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _verify_framework(framework: Path, pin: dict) -> None:
    head = subprocess.check_output(
        ['git', '-C', str(framework), 'rev-parse', 'HEAD'], text=True
    ).strip()
    if head != pin['commit']:
        raise ValueError(
            f"Framework HEAD {head} differs from code/stack_framework.json ({pin['commit']})"
        )
    dirty = subprocess.check_output(
        ['git', '-C', str(framework), 'status', '--porcelain', '--untracked-files=all',
         '--', 'formal_spec_agent', 'protocol_lab'],
        text=True,
    )
    if dirty:
        raise ValueError('Framework checkout has dirty source files')
    for rel, expected in pin['source_files'].items():
        actual = _sha256(framework / rel)
        if actual != expected:
            raise ValueError(f'Framework source digest mismatch: {rel}')


def run(framework: Path, python: Path, out: Path = None, verify: bool = False) -> dict:
    pin = json.loads((ROOT / 'code/stack_framework.json').read_text(encoding='utf-8'))
    framework = framework.resolve()
    py_str = str(python)
    python_bin = shutil.which(py_str) if '/' not in py_str else str(Path(python).resolve())
    if not python_bin:
        raise ValueError(f'Python executable not found: {python}')
    _verify_framework(framework, pin)

    recipe = ROOT / pin['recipe']
    committed_dir = ROOT / pin['output_dir']

    with tempfile.TemporaryDirectory(prefix='tcpip-stack-regen-') as tmp:
        stage = Path(tmp) / 'stack'
        cmd = [
            python_bin, '-S', '-m', 'formal_spec_agent', 'system-codegen',
            str(recipe), '--out', str(stage),
        ]
        env = dict(os.environ, PYTHONPATH=str(framework), PYTHONDONTWRITEBYTECODE='1')
        proc = subprocess.run(cmd, cwd=framework, env=env, capture_output=True, text=True)
        if proc.returncode != 0:
            raise ValueError(f'system-codegen failed: {proc.stderr or proc.stdout}')
        _verify_framework(framework, pin)

        gen_manifest = json.loads((stage / 'manifest.json').read_text(encoding='utf-8'))
        expected_files = sorted([*gen_manifest['outputs'].keys(), 'manifest.json'])

        if verify:
            if not committed_dir.is_dir():
                raise ValueError(f'Missing committed snapshot directory: {committed_dir}')
            actual_files = sorted(
                p.name for p in committed_dir.iterdir()
                if p.is_file() and not p.name.startswith('.')
            )
            if actual_files != expected_files:
                raise ValueError(
                    f'Committed file set {actual_files} != regenerated {expected_files}'
                )
            for fname in expected_files:
                if _sha256(stage / fname) != _sha256(committed_dir / fname):
                    raise ValueError(f'Regenerated file differs from committed snapshot: {fname}')
            target = committed_dir
        else:
            target = out.resolve() if out is not None else committed_dir
            if out is not None and out.exists():
                raise ValueError(f'Output directory already exists: {out}')
            if target == committed_dir and target.exists():
                shutil.rmtree(target)
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copytree(stage, target)

    return {
        'schema': 'tcpip-stack-regen-v1',
        'status': 'pass',
        'mode': 'verify' if verify else 'write',
        'framework_commit': pin['commit'],
        'recipe_sha256': gen_manifest['recipe_sha256'],
        'output': str(target),
        'files': len(expected_files),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--framework', type=Path, required=True)
    parser.add_argument('--python', type=Path, default=Path(sys.executable))
    parser.add_argument('--out', type=Path, default=None)
    parser.add_argument('--verify', action='store_true')
    args = parser.parse_args()
    try:
        res = run(args.framework, args.python, out=args.out, verify=args.verify)
        print(json.dumps(res))
        return 0
    except (ValueError, OSError, subprocess.CalledProcessError) as exc:
        print(json.dumps({'status': 'rejected', 'reason': str(exc)}), file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
