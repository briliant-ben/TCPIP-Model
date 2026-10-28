from pathlib import Path
import json,importlib.util
s=importlib.util.spec_from_file_location('driver',Path('ports/lwip-stream/run.py').resolve());d=importlib.util.module_from_spec(s);s.loader.exec_module(d)
import z3
out=d.ROOT/'artifacts/diagnostics/receive-multiprocess-recheck-v1';m=d.load(d.MODEL)
tx=d.run_scenario(m,d.read(d.PORT/'scenarios/two-segments-partial-ack.json'))
for i in range(10):d.crosscheck_trace(m,tx.trace)
rx=d.run_scenario(m,d.read(d.PORT/'scenarios/receive-fin-with-payload.json'))
a=d.crosscheck_trace(m,rx.trace,out/'original');b=d.crosscheck_trace(m,rx.trace,out/'regenerated')
left=z3.And(*z3.parse_smt2_file(str(out/'original/path.smt2')));right=z3.And(*z3.parse_smt2_file(str(out/'regenerated/path.smt2')))
solver=z3.Solver();solver.set(timeout=10000);solver.add(z3.Xor(left,right));(out/'equivalence.smt2').write_text(solver.to_smt2());answer=solver.check()
r={'status':str(answer),'reason':solver.reason_unknown() if answer==z3.unknown else None,'original_replay':a['status'],'regenerated_replay':b['status'],'input_hashes':d.inputs(),'query_sha256':d.digest(out/'equivalence.smt2')}
if answer==z3.sat:(out/'counterexample.txt').write_text(str(solver.model()))
d.write(out/'diagnosis.json',r);print(json.dumps({k:v for k,v in r.items()if k!='input_hashes'}),flush=True)
