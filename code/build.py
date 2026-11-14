"""Compile the generated C snapshot; optionally compare a frozen native fixture."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sha = lambda path: hashlib.sha256(Path(path).read_bytes()).hexdigest()


def build(out, run_example=False):
    out = Path(out).resolve()
    if out.is_relative_to(ROOT) or out.exists():
        raise ValueError('Use a fresh output directory outside the repository')
    manifest = json.loads((ROOT/'code/generated/manifest.json').read_text())
    source, model = ROOT/manifest['source'], ROOT/manifest['authority']
    if sha(source) != manifest['C_sha256'] or sha(model) != manifest['model_sha256']:
        raise ValueError('Model or generated C differs from the pinned snapshot')
    compiler = shutil.which('cc')
    if not compiler:
        raise ValueError('A C99 compiler named cc is required')
    out.mkdir(parents=True)
    executable = out/'tcpip-reference'
    command = [compiler, '-std=c99', '-Wall', '-Wextra', '-Werror', str(source), '-o', str(executable)]
    compiled = subprocess.run(command, capture_output=True, text=True, timeout=90)
    (out/'compiler.stdout').write_text(compiled.stdout)
    (out/'compiler.stderr').write_text(compiled.stderr)
    result = dict(schema='tcpip-case-build-v1', status='pass' if compiled.returncode == 0 else 'fail',
                  command=command, returncode=compiled.returncode,
                  C_sha256=manifest['C_sha256'], model_sha256=manifest['model_sha256'],
                  executable=str(executable), new_network_execution=False,
                  fresh_formal_verification=False)
    if compiled.returncode == 0 and run_example:
        fixture = json.loads((ROOT/'tests/fixture.json').read_text())
        if sha(ROOT/'tests/example.in') != fixture['input_sha256'] or sha(ROOT/'tests/expected.json') != fixture['expected_sha256']:
            raise ValueError('Frozen acceptance input or expected output changed')
        # Only input commands are sent to the subject; expected output is read afterward.
        native = subprocess.run([str(executable)], input=(ROOT/'tests/example.in').read_bytes(), capture_output=True, timeout=30)
        (out/'native.stdout').write_bytes(native.stdout)
        (out/'native.stderr').write_bytes(native.stderr)
        observed = [json.loads(line) for line in native.stdout.splitlines()]
        expected = json.loads((ROOT/'tests/expected.json').read_text())
        matches = native.returncode == 0 and not native.stderr and observed == expected
        result.update(status='pass' if matches else 'fail', frozen_fixture_match=matches,
                      native_returncode=native.returncode,
                      scope='Exact frozen reference/native fixture correspondence; not a new reference/formal or network execution')
    if sha(source) != manifest['C_sha256'] or sha(model) != manifest['model_sha256']:
        raise ValueError('Snapshot changed during compilation')
    (out/'result.json').write_text(json.dumps(result, indent=2)+'\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--run-example', action='store_true')
    args = parser.parse_args()
    try:
        result = build(args.out, args.run_example)
        print(json.dumps(result))
        raise SystemExit(0 if result['status'] == 'pass' else 1)
    except (ValueError, OSError, subprocess.TimeoutExpired) as error:
        print(json.dumps(dict(status='rejected', reason=str(error))), file=sys.stderr)
        raise SystemExit(2)
