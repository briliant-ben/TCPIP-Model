"""Reproduce the archived reachable prototype defect without changing worktree."""
from pathlib import Path
import tempfile,shutil,sys
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT))
from protocol_lab.ir import load,Machine,model_files
from protocol_lab.flow import digest,read
out=Path(__file__).resolve().parent;r=read(out/'result.json')
for source,h in r['model_inputs'].items():
 if source!='model/tcp-fast-recovery.json':assert digest(ROOT/source)==h
with tempfile.TemporaryDirectory() as tmp:
 tmp=Path(tmp)
 for p in model_files(ROOT/'model/tcp-congestion.json'):shutil.copyfile(p,tmp/p.name)
 shutil.copyfile(out/'model.json',tmp/'tcp-fast-recovery.json')
 m=Machine(load(tmp/'tcp-fast-recovery.json'),{'cc_initial_window':16});m.dispatch('app.connect');m.dispatch('net.synack',{'seq':9000,'ack':1001,'window':16},10);m.dispatch('app.send',{'data':list(range(16))},20)
 for _ in range(4):m.dispatch('app.transmit',time_ms=21)
 for t in (30,31,32):m.dispatch('net.ack',{'seq':9001,'ack':1001,'window':16},t)
 assert {k:m.values[k]for k in r['actual']}==r['actual']
 print('archived_counterexample_reproduced; no current model reverted')
