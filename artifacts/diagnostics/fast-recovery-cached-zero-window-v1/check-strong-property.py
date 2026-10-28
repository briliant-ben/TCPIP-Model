from protocol_lab.flow import ROOT,read,write,digest
from protocol_lab.ir import load
from protocol_lab.symbolic import encode_trace,model_hash,replay
import json,subprocess,sys
out=ROOT/'artifacts/diagnostics/fast-recovery-cached-zero-window-v1'
model=load(ROOT/'model/tcp-fast-recovery.json');base=model_hash(model)
inv={'id':'FR-INV-ENTRY-SEND','assert':{'op':'implies','args':[{'var':'fr_entered'},{'var':'fr_retransmitted'}]},'requirements':['FR-RETRANSMIT']}
model['invariants'].append(inv);trace=read(out/'reference-trace.json');enc=encode_trace(model,trace);z=enc.z
enc.solver.add(z.Not(enc.expr(inv['assert'],enc.frames[-1])))
(out/'entry-violation.smt2').write_text(enc.solver.to_smt2());answer=enc.solve()
r={'classification':'fixed_input_violation_of_stronger_entry_output_property','query':str(answer),'scope':'fixed inputs and rule choices, not unrestricted reachability or protocol completeness','base_model_semantic_sha256':base,'added_invariant':inv,'strengthened_model_semantic_sha256':model_hash(model),'query_sha256':digest(out/'entry-violation.smt2'),'solver_version':z.get_version_string()}
if answer==z.sat:
 witness=enc.witness(enc.solver.model());write(out/'witness.json',witness);r['strong_reference_replay']=replay(model,witness)
 assert r['strong_reference_replay']['status']=='runtime_rejected' and 'FR-INV-ENTRY-SEND'in r['strong_reference_replay']['error']
 program='import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
 result=subprocess.run([sys.executable,'-c',program,str(out/'entry-violation.smt2')],capture_output=True,text=True,timeout=20)
 r.update(independent_recheck=result.stdout.strip(),independent_returncode=result.returncode)
 assert result.returncode==0 and result.stdout.strip()=='sat'
else:r['reason']=enc.reason_unknown() if answer==z.unknown else None
write(out/'strong-property-check.json',r);print(json.dumps(r))
