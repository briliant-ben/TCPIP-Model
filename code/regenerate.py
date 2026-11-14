"""Optional regeneration using a separate, pinned Formal-Spec-Agent checkout."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def regenerate(framework, python, out):
    framework, python, out = (Path(p).resolve() for p in (framework, python, out))
    if out.exists() or out.is_relative_to(ROOT) or out.is_relative_to(framework):
        raise ValueError('Fresh output must be outside both checkouts')
    pin = json.loads((ROOT/'code/framework.json').read_text())
    actual = subprocess.check_output(['git', '-C', str(framework), 'rev-parse', 'HEAD'], text=True).strip()
    if actual != pin['commit']:
        raise ValueError('Check out the framework commit specified in code/framework.json')
    def verify_sources():
        names={str(p.relative_to(framework))for folder in ['protocol_lab','formal_spec_agent']for p in (framework/folder).rglob('*')if p.is_file()and p.suffix in ('.py','.c')}
        names.update(['pyproject.toml','requirements-formal.txt'])
        if names != set(pin['source_files']):raise ValueError('Framework source set differs')
        for name, digest in pin['source_files'].items():
            if hashlib.sha256((framework/name).read_bytes()).hexdigest() != digest:
                raise ValueError('Framework source changed: '+name)
    verify_sources()
    manifest = json.loads((ROOT/'code/generated/manifest.json').read_text())
    model = ROOT/'model/ipv4-endpoint-virtual-link.json'
    if hashlib.sha256(model.read_bytes()).hexdigest() != manifest['model_sha256']:
        raise ValueError('Model differs from the pinned case')
    env = dict(os.environ, PYTHONPATH=str(framework), PYTHONDONTWRITEBYTECODE='1')
    completed = subprocess.run([str(python), '-m', 'protocol_lab.codegen', str(model), '--out', str(out)], cwd=framework, env=env, capture_output=True, text=True)
    if out.is_dir():
        (out/'generator.stdout').write_text(completed.stdout)
        (out/'generator.stderr').write_text(completed.stderr)
    if completed.returncode:
        raise ValueError('Generation failed; inspect the external framework and generator logs')
    verify_sources()
    if hashlib.sha256(model.read_bytes()).hexdigest() != manifest['model_sha256']:
        raise ValueError('Model changed during generation')
    if hashlib.sha256((out/'protocol.c').read_bytes()).hexdigest() != manifest['C_sha256']:
        raise ValueError('Regenerated C differs from the committed derived snapshot')
    print(json.dumps(dict(status='pass', C_sha256=manifest['C_sha256'], framework_commit=pin['commit'], output=str(out))))


if __name__ == '__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--framework',type=Path,required=True)
    p.add_argument('--python',type=Path,default=Path(sys.executable))
    p.add_argument('--out',type=Path,required=True)
    a=p.parse_args()
    try:regenerate(a.framework,a.python,a.out)
    except (ValueError,OSError,subprocess.CalledProcessError)as e:
        print(json.dumps(dict(status='rejected',reason=str(e))),file=sys.stderr);raise SystemExit(2)
