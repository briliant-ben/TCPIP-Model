"""Generate explicit JSON AST amendments; never called by the IR executor."""
import json
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from protocol_lab.ir import load

def v(n):return {'var':n}
def o(name,*args):
 if name=='lt':return {'op':'not','args':[{'op':'ge','args':list(args)}]}
 return {'op':name,'args':list(args)}
def set_(name,value):return {'set':{'var':name,'value':value}}
def choose(c,a,b):return o('ite',c,a,b)
def length(n):return o('bytes_len',v(n))
def both(*a):
 r=True
 for x in a:r=o('and',r,x)
 return r
def either(*a):
 r=False
 for x in a:r=o('or',r,x)
 return r
def neg(a):return o('not',a)
def var(t,initial):return {'type':t,'initial':initial}
def main():
 parent=load(ROOT/'model/tcp-persist.json')
 vs={'cc_initial_window':var('int',4),'cc_initial_threshold':var('int',16),'cc_cwnd':var('int',4),'cc_ssthresh':var('int',16),'cc_ca_credit':var('int',0),'cc_acked':var('int',0),'cc_before_flight':var('int',0),'cc_before_una':var('seq32',1000),'cc_before_persist':var('bool',False),'cc_before_window':var('int',8),'cc_loss':var('bool',False),'cc_threshold_changed':var('bool',False),'cc_threshold_updates':var('int',0),'cc_growth':var('int',0),'cc_before_cwnd':var('int',4)}
 for i in range(16):vs[f'cc_rto_{i:02}']=var('bool',False)
 req={
 'CC-WINDOW':{'source':'spec/sources/rfc5681.txt','interpretation':'RFC5681 September2009 sections2/3.1: new data bounded by min(cwnd,rwnd). One SMSS=4 conservative IW; configurable 4..16. SYN/SYNACK acknowledgments do not grow cwnd.','kind':'normative','strength':'finite data congestion-window gate'},
 'CC-GROWTH':{'source':'spec/sources/rfc5681.txt','interpretation':'Section3.1 eq(2): slow-start increment min(newly acknowledged data bytes,SMSS). At cwnd>=ssthresh use acknowledged-byte counting; on reaching pre-ACK cwnd add one SMSS and reset credit to zero conservatively. No growth for invalid/old/duplicate/control-only ACKs or zero-window/persist probe epochs.','kind':'normative','strength':'explicit finite slow start and byte-counting congestion avoidance'},
 'CC-LOSS':{'source':'spec/sources/rfc5681.txt','interpretation':'Section3.1 eq(4): first actual positive-window data timeout for oldest byte sets ssthresh=max(floor(FlightSize/2),2*SMSS), cwnd=SMSS. Repeated timeout of that byte preserves ssthresh. Per-byte timeout marks shift with actual acknowledged data; zero-window probes and early-wait timer firings do not count as congestion loss.','kind':'normative','strength':'composed finite data timeout response'},
 'CC-SOURCE':{'source':'spec/sources/tcp-congestion.json','interpretation':'Module-local official RFC version and raw-byte SHA256 binding; the existing global source manifest and old profiles are unchanged.','kind':'modeling_choice','strength':'source provenance'},
 'CC-SCOPE':{'source':'docs/tcp-congestion.md','interpretation':'Finite developer overlay, no fast retransmit/recovery, limited transmit, idle restart, ECN or complete TCP claim. FIN/SYN control retains parent sequence/timer semantics; only data bytes earn congestion credit. Persist probe ownership remains explicit and excluded from congestion loss/growth.','kind':'modeling_choice','strength':'explicit exclusions and interpretation'}}
 amendments=[]
 for t in parent['transitions']:
  event=t['event'];actions=t['actions'];ack_event=event in ('net.ack','net.data','net.data_ack','net.fin_segment','net.fin','net.synack')
  connected=t['from']in ('ESTABLISHED','CLOSE-WAIT','FIN-WAIT-1','FIN-WAIT-2','CLOSING','LAST-ACK')
  pre=[set_('cc_before_flight',length('rtx_buf')),set_('cc_before_una',v('snd_una')),set_('cc_before_persist',v('persist_active')),set_('cc_before_window',v('snd_wnd')),set_('cc_before_cwnd',v('cc_cwnd')),set_('cc_acked',0),set_('cc_loss',False),set_('cc_threshold_changed',False),set_('cc_growth',0)]
  post=[];a={'id':t['id'],'prepend_actions':pre,'append_actions':post,'add_requirements':list(req)}
  budget=o('sub',v('cc_cwnd'),length('rtx_buf'))
  take=[(i,x)for i,x in enumerate(actions)if 'set'in x and x['set']['var']=='take'] if event=='app.transmit' else []
  if take:
   assert len(take)==1
   i,old=take[0];a['and_guard']=o('ge',budget,1)
   a['edit_actions']=[{'at':i,'expected':old,'with':[set_('take',o('min',old['set']['value'],budget))]}]
  elif event=='app.transmit' and 'FLUSH-BLOCKED'in t['id']:
   a['guard']=either(t['guard'],both(neg(v('fin_sent')),o('ge',length('snd_buf'),1),o('le',budget,0)))
  if ack_event and connected:
   post.append(set_('cc_acked',choose(neg(o('eq',v('snd_una'),v('cc_before_una'))),o('sub',v('cc_before_flight'),length('rtx_buf')),0)))
   allowed=both(o('ge',v('cc_acked'),1),neg(v('cc_before_persist')),o('ge',v('cc_before_window'),1))
   slow=o('lt',v('cc_cwnd'),v('cc_ssthresh'))
   credit=o('add',v('cc_ca_credit'),v('cc_acked'))
   post += [set_('cc_growth',choose(allowed,choose(slow,o('min',v('cc_acked'),4),choose(o('ge',credit,v('cc_cwnd')),4,0)),0)),set_('cc_ca_credit',choose(allowed,choose(slow,0,choose(o('ge',credit,v('cc_cwnd')),0,credit)),v('cc_ca_credit'))),set_('cc_cwnd',o('add',v('cc_cwnd'),v('cc_growth')))]
   # Ascending destination indices only read as-yet unchanged higher slots.
   for i in range(16):
    shifted=False
    for distance in range(16-i-1,-1,-1):shifted=choose(o('eq',v('cc_acked'),distance),v(f'cc_rto_{i+distance:02}'),shifted)
    post.append(set_(f'cc_rto_{i:02}',shifted))
  if event=='timer.rtx' and connected:
   post.append(set_('cc_loss',both(o('ge',v('cc_before_flight'),1),o('ge',v('cc_before_window'),1),v('tx_retransmitted'))))
   post.append(set_('cc_threshold_changed',both(v('cc_loss'),neg(v('cc_rto_00')))))
   half=o('sub',v('cc_before_flight'),o('rat_ceil',o('rat_scale',o('rat_from_int',v('cc_before_flight')),{'rat':[1,2]})))
   threshold=choose(o('ge',half,8),half,8)
   post += [set_('cc_ssthresh',choose(v('cc_threshold_changed'),threshold,v('cc_ssthresh'))),set_('cc_threshold_updates',o('add',v('cc_threshold_updates'),choose(v('cc_threshold_changed'),1,0))),set_('cc_cwnd',choose(v('cc_loss'),4,v('cc_cwnd'))),set_('cc_ca_credit',choose(v('cc_loss'),0,v('cc_ca_credit')))]
   for i in range(16):post.append(set_(f'cc_rto_{i:02}',either(v(f'cc_rto_{i:02}'),both(v('cc_loss'),o('ge',v('tx_emit_count'),i+1)))))
  # No stale timeout mark may survive outside the shared retransmission queue.
  for i in range(16):post.append(set_(f'cc_rto_{i:02}',choose(o('ge',i,length('rtx_buf')),False,v(f'cc_rto_{i:02}'))))
  if t['from']=='CLOSED':post += [set_('cc_cwnd',v('cc_initial_window')),set_('cc_ssthresh',v('cc_initial_threshold')),set_('cc_ca_credit',0),set_('cc_threshold_updates',0)]
  amendments.append(a)
 inv=[{'id':'CC-INV-CONFIG','assert':both(o('ge',v('cc_initial_window'),4),o('le',v('cc_initial_window'),16),o('ge',v('cc_initial_threshold'),8)),'requirements':['CC-WINDOW','CC-SCOPE']},{'id':'CC-INV-BOUNDS','assert':both(o('ge',v('cc_cwnd'),4),o('ge',v('cc_ssthresh'),8),o('ge',v('cc_ca_credit'),0),o('lt',v('cc_ca_credit'),v('cc_cwnd')),o('ge',v('cc_growth'),0),o('le',v('cc_growth'),4),o('ge',v('cc_acked'),0),o('le',v('cc_acked'),16),o('ge',v('cc_threshold_updates'),0)),'requirements':['CC-GROWTH','CC-LOSS']}]
 for i in range(16):inv.append({'id':f'CC-INV-MARK-{i:02}','assert':o('implies',o('ge',i,length('rtx_buf')),neg(v(f'cc_rto_{i:02}'))),'requirements':['CC-LOSS']})
 raw={'ir_version':'0.3','semantics':parent['semantics'],'extends':'tcp-persist.json','protocol':'tcp-congestion','scope':{'terminal_states':[],'excluded':['complete TCP congestion control','fast retransmit/recovery, limited transmit, idle restart, ECN, SACK/NewReno','FIN-only congestion response and control-byte congestion credit','universal output/timing or implementation refinement proof']},'variables':vs,'requirements':req,'amend_transitions':amendments,'invariants':inv}
 (ROOT/'model/tcp-congestion.json').write_text(json.dumps(raw,indent=2)+'\n')
if __name__=='__main__':main()
