"""Run the PINNED external framework in another process, never import its core here."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def verify_framework(root=None, lock=None):
    root = Path(root or ROOT/'framework').resolve()
    lock = lock or json.loads((ROOT/'framework.lock.json').read_text())
    if not (root/'protocol_lab/ir.py').is_file():
        raise ValueError('Framework submodule missing; run git submodule update --init --recursive')
    actual = subprocess.check_output(['git','-C',str(root),'rev-parse','HEAD'],text=True).strip()
    if actual != lock['commit']:
        raise ValueError('Framework commit differs from approved pin')
    paths = set()
    for directory in ['protocol_lab','formal_spec_agent']:
        paths.update(str(p.relative_to(root)) for p in (root/directory).rglob('*') if p.is_file() and p.suffix in ('.py','.c'))
    paths.update(['pyproject.toml','requirements-formal.txt'])
    if paths != set(lock['source_files']):
        raise ValueError('Framework source file set differs from pin')
    for path, expected in lock['source_files'].items():
        if hashlib.sha256((root/path).read_bytes()).hexdigest() != expected:
            raise ValueError('Framework source changed: '+path)
    return root


def main(argv=None):
    p=argparse.ArgumentParser(description=__doc__)
    sub=p.add_subparsers(dest='command',required=True)
    r=sub.add_parser('run');r.add_argument('task',type=Path);r.add_argument('--out',type=Path,required=True)
    v=sub.add_parser('verify');v.add_argument('out',type=Path)
    for parser in (r,v):
        parser.add_argument('--workspace',type=Path,default=ROOT)
        parser.add_argument('--task-sha256',required=True)
    a=p.parse_args(argv)
    try:
        framework=verify_framework()
        workspace=a.workspace.resolve();out=a.out.resolve()
        args=[a.command,str((workspace/a.task).resolve())]if a.command=='run'else['verify',str(out)]
        if a.command=='run':args+=['--out',str(out)]
        args+=['--workspace',str(workspace),'--task-sha256',a.task_sha256]
        env=dict(os.environ,PYTHONPATH=str(framework),PYTHONDONTWRITEBYTECODE='1')
        completed=subprocess.run([sys.executable,'-m','formal_spec_agent',*args],cwd=framework,env=env)
        verify_framework()
        return completed.returncode
    except (ValueError,OSError,subprocess.CalledProcessError)as error:
        print(json.dumps(dict(status='rejected',classification='framework_pin_or_environment',reason=str(error))),file=sys.stderr)
        return 2


if __name__=='__main__':raise SystemExit(main())
