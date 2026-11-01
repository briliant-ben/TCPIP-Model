"""One controller-diagnosed repair, with unchanged frozen scenarios and budget."""
import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from agents.run_model_job import read,write,sha,validate_shape
from agents.deepseek_gateway import request


def hostile_domain_checks(model):
    from protocol_lab.ir import Machine,Uncovered
    base=dict(source_port=1,destination_port=8080,length=10,checksum=1,sum_valid=True,data=[0,255])
    probes=[dict(base,**{name:value})for name in ('source_port','destination_port','length','checksum')for value in (-1,65536)]
    probes.append(dict(base,length=4105,data=[17]*4097))
    for fields in probes:
        machine=Machine(model);before=machine.snapshot()
        try:machine.dispatch('net.datagram',fields,0)
        except Uncovered:pass
        else:raise ValueError('Invalid receive domain was accepted')
        if machine.snapshot()!=before:raise ValueError('Rejected operation changed state')
    return dict(status='pass',invalid_domain_probes=len(probes))


def run(a):
    folder=Path(a.out);status=folder/'status.json'
    if status.exists():raise ValueError('Repair already attempted; inspect retained result')
    write(status,dict(status='running',started_at=time.time(),messages_sha256=sha(folder/'repair-messages.json'),runner_sha256=sha(__file__)))
    try:
        response=request(read(folder/'repair-messages.json'),a.ledger,a.credential_file,max_tokens=8192,max_calls=12)
        original=Path(a.original);scenarios=original/'scenarios'
        hashes={p.name:sha(p)for p in scenarios.glob('*.json')}
        write(folder/'frozen-oracles.json',hashes)
        model=read(Path(a.ledger)/response['response_file'])['response']['model']
        validate_shape(model,read(a.job));write(folder/'model.json',model)
        from protocol_lab.ir import load
        write(folder/'hostile-domain.json',hostile_domain_checks(load(folder/'model.json')))
        shutil.copytree(scenarios,folder/'scenarios')
        assert hashes=={p.name:sha(p)for p in (folder/'scenarios').glob('*.json')}
        p=subprocess.run([sys.executable,a.controller,'validate','--model',str(folder/'model.json'),'--scenarios',str(folder/'scenarios'),'--out',str(folder/'validation'),'--depth','3'],capture_output=True,text=True,cwd=a.tools,timeout=240)
        (folder/'stdout.log').write_text(p.stdout);(folder/'stderr.log').write_text(p.stderr)
        result=read(folder/'validation/result.json')if (folder/'validation/result.json').exists()else dict(status='failed',diagnosis=p.stderr[-3000:])
    except Exception as error:result=dict(status='unresolved'if isinstance(error,subprocess.TimeoutExpired)else'failed',error_type=type(error).__name__)
    result.update(finished_at=time.time(),independently_approved=False,integrated=False)
    write(status,result);return result


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    for n in ('out','original','job','tools','controller','ledger','credential-file'):p.add_argument('--'+n,required=True)
    print(json.dumps(run(p.parse_args())))
