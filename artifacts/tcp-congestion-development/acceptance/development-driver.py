from pathlib import Path
import json,hashlib
from protocol_lab.flow import ROOT,read,write,digest
from protocol_lab.ir import load,require
from protocol_lab.profiles import run_profile,profile_inputs
out=ROOT/'artifacts/tcp-congestion-development';out.mkdir(exist_ok=True)
p={'id':'tcp-congestion-development','model':'model/tcp-congestion.json','scenarios':'scenarios/congestion','packetdrill':None,'symbolic_replay':True,'wire_projection':'tcp-connection-v1','inductive':False}
lock=read(ROOT/'spec/sources/tcp-congestion.json');require(len(lock)==1 and lock[0]['rfc']==5681 and lock[0]['version']=='September 2009' and lock[0]['url']=='https://www.rfc-editor.org/rfc/rfc5681.txt','Congestion source lock changed')
require(digest(ROOT/'spec/sources/rfc5681.txt')==lock[0]['sha256'],'Congestion RFC bytes changed')
write(out/'development-profile.json',p)
before=profile_inputs(p,load(ROOT/p['model']));write(out/'frozen-inputs.json',before)
r=run_profile(p,out,formal=True,depth=6)
require(profile_inputs(p,load(ROOT/p['model']))==before,'Congestion inputs changed')
print(json.dumps({'status':r['status'],'scenarios':len(r['scenarios']),'formal':r['formal'],'inductive_note':'separate primary induction executing in artifacts/congestion-initial; not claimed by this fixed-input profile'},ensure_ascii=False))
