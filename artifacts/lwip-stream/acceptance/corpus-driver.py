from pathlib import Path
import json,subprocess,sys
root=Path.cwd();port=root/'ports/lwip-stream';base=root/'artifacts/lwip-stream';rows=[]
for scenario in sorted((port/'scenarios').glob('*.json')):
    out=base/scenario.stem;out.mkdir(parents=True,exist_ok=True)
    cmd=[sys.executable,str(port/'run.py'),'--scenario',str(scenario),'--out',str(out)]
    with (out/'generation.log').open('w') as log:r=subprocess.run(cmd,stdout=log,stderr=subprocess.STDOUT)
    report=json.loads((out/'report.json').read_text())
    row={'case':scenario.stem,'generation_returncode':r.returncode,'status':report['status']}
    if r.returncode in (0,1) and report['status'] in ('execution_and_projection_pass','executed_with_differences'):
        with (out/'verification.log').open('w') as log:v=subprocess.run(cmd+['--verify'],stdout=log,stderr=subprocess.STDOUT)
        row['verification_returncode']=v.returncode
    rows.append(row);print(json.dumps(row),flush=True)
(base/'batch-result.json').write_text(json.dumps(rows,indent=2)+'\n')
if len(rows)!=6 or any(r.get('verification_returncode')!=0 for r in rows):sys.exit(2)
if sum(r['status']=='execution_and_projection_pass' for r in rows)!=5 or sum(r['status']=='executed_with_differences' for r in rows)!=1:sys.exit(3)
