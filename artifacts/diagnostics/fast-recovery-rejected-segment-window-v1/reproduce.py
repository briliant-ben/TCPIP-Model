from protocol_lab.flow import ROOT,write,digest
from protocol_lab.ir import load,Machine,model_files
from protocol_lab.symbolic import encode_trace,model_hash,replay
import subprocess,sys,json
out=ROOT/'artifacts/diagnostics/fast-recovery-rejected-segment-window-v1';out.mkdir(parents=True,exist_ok=True)
m=load(ROOT/'model/tcp-fast-recovery.json');x=Machine(m,{'cc_initial_window':16});x.dispatch('app.connect');x.dispatch('net.synack',{'seq':9000,'ack':1001,'window':16},10);x.dispatch('app.send',{'data':list(range(16))},20)
for _ in range(4):x.dispatch('app.transmit',time_ms=21)
x.dispatch('net.data',{'seq':9030,'ack':1001,'window':8,'data':[128]},25);index=len(x.trace)-1
before=x.trace[-1]['before']['variables']['fr_last_window'];after=x.values['fr_last_window']
assert not x.values['seg_acceptable'] and before==16 and after==8
for t in (30,31,32):x.dispatch('net.ack',{'seq':9001,'ack':1001,'window':16},t)
assert not x.values['fr_active'] and x.values['fr_dupacks']==2
write(out/'reference-trace.json',x.trace);write(out/'result.json',{'classification':'reachable_reference_model_counterexample','expected_rejected_window_unchanged':before,'actual_after_rejected_data':after,'expected_after_three_valid_duplicates':{'fr_active':True,'fr_dupacks':3},'actual_after_three_valid_duplicates':{k:x.values[k]for k in ('fr_active','fr_dupacks')},'model_semantic_sha256':model_hash(m),'model_inputs':{str(p.relative_to(ROOT)):digest(p)for p in model_files(ROOT/'model/tcp-fast-recovery.json')}})
enc=encode_trace(m,x.trace);z=enc.z
enc.solver.add(z.Not(enc.frames[index+1]['values']['seg_acceptable']))
enc.solver.add(enc.frames[index+1]['values']['fr_last_window']!=enc.frames[index]['values']['fr_last_window'])
(out/'rejected-window-violation.smt2').write_text(enc.solver.to_smt2());answer=enc.solve();r={'query':str(answer),'scope':'fixed inputs and rule choices, rejected-data metadata trace property','query_sha256':digest(out/'rejected-window-violation.smt2'),'solver_version':z.get_version_string(),'model_semantic_sha256':model_hash(m)}
assert answer==z.sat
witness=enc.witness(enc.solver.model());write(out/'witness.json',witness);r['reference_replay']=replay(m,witness)
assert r['reference_replay']['status']=='match'
program='import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
p=subprocess.run([sys.executable,'-c',program,str(out/'rejected-window-violation.smt2')],capture_output=True,text=True,timeout=20);assert p.returncode==0 and p.stdout.strip()=='sat'
r.update(independent_recheck=p.stdout.strip(),independent_returncode=p.returncode);write(out/'trace-property-check.json',r);print(json.dumps(r))
