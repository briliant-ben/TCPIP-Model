from protocol_lab.flow import ROOT,write,digest
from protocol_lab.ir import load,Machine,model_files
m=load(ROOT/'model/tcp-fast-recovery.json');x=Machine(m,{'cc_initial_window':16});x.dispatch('app.connect');x.dispatch('net.synack',{'seq':9000,'ack':1001,'window':16},10);x.dispatch('app.send',{'data':list(range(16))},20)
for _ in range(4):x.dispatch('app.transmit',time_ms=21)
x.dispatch('net.ack',{'seq':9005,'ack':1001,'window':0},25)
x.dispatch('net.ack',{'seq':9005,'ack':1000,'window':16},26)
for t in (30,31,32):x.dispatch('net.ack',{'seq':9001,'ack':1001,'window':16},t)
out=ROOT/'artifacts/diagnostics/fast-recovery-cached-zero-window-v1';out.mkdir(parents=True,exist_ok=True)
result={'classification':'reachable_reference_model_counterexample','expected':'Cached send window remains zero: no recovery inflation/entry in the declared positive-window recovery subset','actual':{k:x.values[k]for k in ('snd_wnd','snd_wl1','fr_last_window','fr_entered','fr_active','fr_emit_count','fr_retransmitted','cc_cwnd')},'last_output':x.trace[-1]['emitted'],'model_inputs':{str(p.relative_to(ROOT)):digest(p)for p in model_files(ROOT/'model/tcp-fast-recovery.json')}}
assert result['actual']['snd_wnd']==0 and result['actual']['fr_entered'] and not result['actual']['fr_retransmitted']
write(out/'result.json',result);write(out/'reference-trace.json',x.trace);print(result['actual'])
