"""Generate and compile the case-study C implementation with the pinned framework."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('framework_client',ROOT/'tools/run_framework_candidate.py')
client=importlib.util.module_from_spec(spec);spec.loader.exec_module(client)


def build(out, run_example=False):
    out=Path(out).resolve()
    if out.is_relative_to(ROOT):raise ValueError('Use a fresh output directory outside the repository')
    framework=client.verify_framework()
    if out.exists():raise ValueError('Fresh output directory required')
    program='''import json,sys
from pathlib import Path
from protocol_lab.codegen import generate,sha
from protocol_lab.codegen.execute import build,run
root=Path(sys.argv[1]);model=Path(sys.argv[2]);root.mkdir();g=generate(model,root/'generation');b=build(root/'generation',root/'build');r=dict(schema='tcpip-case-code-v1',status=b['status'],model_sha256=sha(model),C_sha256=sha(root/'generation/protocol.c'),framework_commit=sys.argv[4],standalone_executable=str(root/'build/protocol-native'),new_network_execution=False)
if b['status']=='pass' and sys.argv[3]!='-':
 scene=json.loads(Path(sys.argv[3]).read_text())['cases'][0]['scenario'];(root/'scenario.json').write_text(json.dumps(scene));n=run(root/'generation',root/'build',root/'scenario.json',root/'native');r['status']=n['status'];r['reference_native_example']=n['status']
(root/'result.json').write_text(json.dumps(r,indent=2)+'\\n');print(json.dumps(r));sys.exit(0 if r['status']=='pass'else 1)
'''
    lock=json.loads((ROOT/'framework.lock.json').read_text())
    env=dict(os.environ,PYTHONPATH=str(framework),PYTHONDONTWRITEBYTECODE='1')
    result=subprocess.run([sys.executable,'-c',program,str(out),str(ROOT/'model/ipv4-endpoint-virtual-link.json'),str(ROOT/'scenarios/ipv4-rule-coverage/cases.json')if run_example else'-',lock['commit']],cwd=framework,env=env)
    client.verify_framework()
    return result.returncode


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',type=Path,required=True);p.add_argument('--run-example',action='store_true');a=p.parse_args()
    try:raise SystemExit(build(a.out,a.run_example))
    except (ValueError,OSError)as e:print(json.dumps(dict(status='rejected',reason=str(e))),file=sys.stderr);raise SystemExit(2)
