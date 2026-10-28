"""Run standard unittest discovery with commit-scoped dependency/hash evidence.

New files added after discovery are outside this recorded commit's test set.
Changing a frozen dependency invalidates the run even if its tests pass.
"""
import argparse
import hashlib
import importlib.metadata
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
import time
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read
from protocol_lab.ir import load
from protocol_lab.profiles import profile_inputs


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def write(path, value):
    Path(path).write_text(json.dumps(value, indent=2, ensure_ascii=False) + '\n')


def inputs():
    prefixes = ['protocol_lab', 'model', 'scenarios', 'tests', 'tools', 'ports',
                'formal', 'spec', 'third_party', 'profiles.json',
                'packet-profile.json', 'requirements-formal.txt']
    names = subprocess.check_output(['git', 'ls-files', '-z', '--', *prefixes],
                                    cwd=ROOT).decode().split('\0')
    result = {name: digest(ROOT / name) for name in names if name}
    profiles = read(ROOT / 'profiles.json')['profiles']
    for name in ('tcp-congestion-development', 'tcp-fast-recovery-development'):
        path = ROOT / 'artifacts' / name / 'development-profile.json'
        if path.exists():
            profiles.append(read(path))
            result[str(path.relative_to(ROOT))] = digest(path)
    for profile in profiles:
        result.update(profile_inputs(profile, load(ROOT / profile['model'])))
    return result


def cases(suite):
    for test in suite:
        if isinstance(test, unittest.TestSuite):
            yield from cases(test)
        else:
            yield test.id()


def environment():
    compiler = shutil.which('cc')
    try:
        solver = importlib.metadata.version('z3-solver')
    except importlib.metadata.PackageNotFoundError:
        solver = None
    return {'python': sys.version, 'platform': platform.platform(),
            'z3_solver_package': solver, 'compiler': compiler,
            'compiler_sha256': digest(compiler) if compiler else None,
            'compiler_version': subprocess.check_output([compiler, '--version'], text=True)
                                if compiler else None}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', required=True, type=Path)
    args = parser.parse_args()
    out = args.out.resolve()
    out.mkdir(parents=True, exist_ok=True)
    if (out / 'started.json').exists() or (out / 'result.json').exists():
        parser.error('Use a fresh output directory; existing run evidence is preserved')
    os.chdir(ROOT)
    commit = subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip()
    before = inputs()
    tool_environment = environment()
    write(out / 'inputs.json', before)
    suite = unittest.defaultTestLoader.discover(str(ROOT / 'tests'), pattern='test*.py')
    identifiers = list(cases(suite))
    write(out / 'test-ids.json', identifiers)
    write(out / 'started.json', {'status': 'running', 'pid': os.getpid(),
          'git_commit': commit, 'tests_discovered': len(identifiers),
          'environment': tool_environment,
          'input_manifest_sha256': digest(out / 'inputs.json')})
    print(json.dumps({'phase': 'started', 'git_commit': commit,
                      'tests_discovered': len(identifiers)}), flush=True)
    started = time.monotonic()
    result = unittest.TextTestRunner(verbosity=2).run(suite)
    changed = [name for name, sha in before.items()
               if not (ROOT / name).is_file() or digest(ROOT / name) != sha]
    environment_changed = tool_environment != environment()
    status = ('invalidated_inputs_changed' if changed else
              'invalidated_environment_changed' if environment_changed else
              'test_failure' if not result.wasSuccessful() else
              'passed_with_skips' if result.skipped else 'passed')
    report = {'status': status, 'git_commit': commit,
              'seconds': time.monotonic() - started,
              'tests_discovered': len(identifiers), 'tests_run': result.testsRun,
              'failures': len(result.failures), 'errors': len(result.errors),
              'skipped': len(result.skipped), 'changed_dependencies': changed,
              'environment_changed': environment_changed,
              'environment': tool_environment,
              'input_manifest_sha256': digest(out / 'inputs.json'),
              'test_ids_sha256': digest(out / 'test-ids.json'),
              'scope': 'standard unittest discovery at the recorded commit; '
                       'does not claim external Linux or whole-protocol proof'}
    write(out / 'result.json', report)
    print(json.dumps(report), flush=True)
    return 2 if changed or environment_changed else 0 if result.wasSuccessful() else 1


if __name__ == '__main__':
    sys.exit(main())
