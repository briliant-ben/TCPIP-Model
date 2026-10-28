import json,subprocess,sys
from pathlib import Path
from protocol_lab.flow import ROOT,read,write,digest,run_scenario,verify_sources
from protocol_lab.profiles import profile_inputs,control_packets
from protocol_lab.ir import load,require
from protocol_lab.claims import verify as verify_claims
from protocol_lab.capture import normalize
from protocol_lab.packets import compare
out=ROOT/'artifacts/tcp-idle-restart-development';p=read(out/'development-profile.json');r=read(out/'report.json');m=load(ROOT/p['model'])
require(r['status']=='formal_pending','Expected explicit pending recovery primary BMC')
require(r['input_hashes']==profile_inputs(p,m)==read(out/'frozen-inputs.json'),'Development inputs stale');verify_sources()
for name,h in r['artifact_hashes'].items():
 path=(out/name).resolve();require(path.is_relative_to(out) and digest(path)==h,'Development artifact changed '+name)
verify_claims(m,p,r,out)
rows=[]
for scene in r['scenarios']:
 target=out/scene['id'];s=read(target/'scenario.json');machine=run_scenario(m,s);packets=control_packets(machine,s)
 require(machine.trace==read(target/'trace.json') and packets==read(target/'packets.json'),'Fresh reference changed')
 observed,metadata=normalize(target/'model.synthetic.pcap',read(ROOT/'packet-profile.json'),packets,origin='synthetic',projection=p['wire_projection'])
 require(observed==read(target/'normalized.synthetic.json') and metadata==read(target/'capture-metadata.json'),'Synthetic codec changed')
 require(compare(packets,observed,projection=p['wire_projection'])['status']=='match','Codec did not match')
 program='import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
 q=subprocess.run([sys.executable,'-c',program,str(target/'symbolic/path.smt2')],capture_output=True,text=True,timeout=20)
 require(q.returncode==0 and q.stdout.strip()=='sat','Independent fixed query recheck did not pass: '+scene['id'])
 rows.append({'id':scene['id'],'reference':'match','full_byte_fixed_query_recheck':'sat','synthetic_codec':'match_synthetic_only'})
result={'status':'valid_unregistered_development_evidence_formal_pending','report_sha256':digest(out/'report.json'),'input_hashes':r['input_hashes'],'source_lock':read(ROOT/'spec/sources/tcp-idle-restart.json'),'scenarios':rows,'formal':r['formal'],'registered':False,'external_implementation_evidence':False,'linux_execution':False,'full_stack_complete':False}
write(out/'development-verification.json',result);print(json.dumps({'status':result['status'],'scenarios':len(rows),'formal':r['formal']}))
