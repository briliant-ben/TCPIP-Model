import argparse
import json
from pathlib import Path
from .runner import run,verify


def main():
    p=argparse.ArgumentParser(description='Provider-neutral spec modeling stage runner')
    sub=p.add_subparsers(dest='command',required=True)
    r=sub.add_parser('run');r.add_argument('task',type=Path);r.add_argument('--workspace',type=Path,default=Path.cwd());r.add_argument('--out',type=Path,required=True)
    v=sub.add_parser('verify');v.add_argument('out',type=Path);v.add_argument('--workspace',type=Path,default=Path.cwd())
    a=p.parse_args()
    try:
        result=run(a.task,a.workspace,a.out)if a.command=='run'else verify(a.out,a.workspace)
        print(json.dumps(result))
        return 0 if result.get('assessment')=='verified_event_slice'else 1
    except (ValueError,OSError,KeyError,TypeError)as e:
        print(json.dumps(dict(schema='spec-flow-stage-v1',stage='intake'if a.command=='run'else'verify',status='rejected',classification='invalid_input_or_evidence',reason=str(e))))
        return 2

if __name__=='__main__':raise SystemExit(main())
