from protocol_lab.flow import ROOT,read,write,digest
from protocol_lab.ir import load,require
from protocol_lab.profiles import run_profile,profile_inputs
import json
out=ROOT/'artifacts/tcp-fast-recovery-development';out.mkdir(exist_ok=True)
p={'id':'tcp-fast-recovery-development','model':'model/tcp-fast-recovery.json','scenarios':['scenarios/congestion','scenarios/fast-recovery'],'packetdrill':None,'symbolic_replay':True,'wire_projection':'tcp-connection-v1','inductive':False}
for source in read(ROOT/'spec/sources/tcp-fast-recovery.json'):
 require(source['url']==f"https://www.rfc-editor.org/rfc/rfc{source['rfc']}.txt",'Unexpected recovery source URL')
 require(digest(ROOT/'spec/sources'/f"rfc{source['rfc']}.txt")==source['sha256'],'Recovery RFC bytes changed')
write(out/'development-profile.json',p);before=profile_inputs(p,load(ROOT/p['model']));write(out/'frozen-inputs.json',before)
r=run_profile(p,out,formal=True,depth=6);require(before==profile_inputs(p,load(ROOT/p['model'])),'Recovery inputs changed')
print(json.dumps({'status':r['status'],'scenarios':len(r['scenarios']),'formal':r['formal'],'inductive':'separate primary checker artifact, not claimed by this fixed-input profile'}))
