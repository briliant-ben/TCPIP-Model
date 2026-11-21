"""Run the pinned Lean proof for the published IPv4 endpoint."""
import argparse
from pathlib import Path
import json
import os
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--framework', type=Path, required=True)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--lean', default='lean')
    args = parser.parse_args()
    pin = json.loads((ROOT/'formal/framework.json').read_text())
    framework = args.framework.resolve()
    try:
        head = subprocess.check_output(['git', '-C', str(framework), 'rev-parse', 'HEAD'],
                                       text=True).strip()
        if head != pin['commit']:
            raise ValueError('Framework HEAD differs from formal/framework.json')
        dirty = subprocess.check_output(
            ['git', '-C', str(framework), 'status', '--porcelain', '--untracked-files=all',
             '--', 'formal_spec_agent', 'protocol_lab'], text=True)
        if dirty:
            raise ValueError('Use source files from the pinned framework commit')
        lean = str(Path(args.lean).resolve()) if '/' in args.lean else args.lean
        command = [
            sys.executable, '-S', '-m', 'formal_spec_agent', 'lean-timed-check',
            str(ROOT/'model/ipv4-endpoint-virtual-link.json'),
            '--proof-manifest', str(ROOT/'formal/lean/manifest.json'),
            '--proof-sha256', pin['proof_manifest_sha256'],
            '--out', str(args.out.resolve()), '--lean', lean,
        ]
        env = dict(os.environ, PYTHONPATH=str(framework), PYTHONDONTWRITEBYTECODE='1')
        return subprocess.run(command, cwd=framework, env=env, check=False).returncode
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        print(str(error), file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
