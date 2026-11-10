from pathlib import Path
import json,tarfile,subprocess,sys
R=Path('/Users/xubenling/Documents/ChatGPT/Protocol_Form/TCPIP-Model');A=R/'artifacts/ipv4-directed-coverage-20261110'
with tarfile.open(A/'originals.tar.gz')as t:fs={m.name:t.extractfile(m).read()for m in t.getmembers()if m.isfile()}
for j in ['ipv4-directed-gates-20261110-0187','ipv4-selected-rule-preservation-20261110-0191']:
 stored=json.loads(fs[j+'/formal/rendered-queries.json']);code="import sys,json;sys.path[:0]=[sys.argv[1],sys.argv[2]];from qualified_rule_probe import render_probe;from protocol_lab.ir import load;print(json.dumps(render_probe(load(sys.argv[2]+'/model/ipv4-endpoint-virtual-link.json'),json.loads(sys.argv[3]))))"
 p=subprocess.run([str(R/'.venv/bin/python'),'-c',code,'/tmp/ipv4-0186-review',str(R),json.dumps(stored['rule_ids'])],capture_output=True,text=True,check=True)
 fresh=json.loads(p.stdout);(A/('fresh-render-'+j[-4:]+'.json')).write_text(json.dumps(fresh,indent=2)+'\n');print(j,{k:('same'if fresh[k]==v else'different')for k,v in stored.items()})
 if fresh['queries']!=stored['queries']:
  for x,y in zip(fresh['queries'],stored['queries']):
   if x!=y:print(x['rule'],x['role'],x['sha256'],y['sha256']);break
