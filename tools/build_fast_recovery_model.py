"""Emit explicit Reno fast retransmit/recovery AST; not a runtime callback."""
import copy,json
from pathlib import Path
from build_congestion_model import ROOT,v,o,set_,choose,length,both,either,neg,var
from protocol_lab.ir import load

def event(n):return {'event':n}
def replace(expr,name,value):
 if type(expr)is dict:
  if expr=={'var':name}:return copy.deepcopy(value)
  return {k:replace(x,name,value)for k,x in expr.items()}
 if type(expr)is list:return [replace(x,name,value)for x in expr]
 return expr

def main():
 parent=load(ROOT/'model/tcp-congestion.json')
 retransmit=next(t for t in parent['transitions']if t['id']=='S-RETRANSMIT-WINDOW')
 ambiguous=next(a['set']['value']for a in retransmit['actions']if 'set'in a and a['set']['var']=='rtt_ambiguous')
 vs={n:var(t,x)for n,t,x in [('fr_window_ignored','bool',False),('fr_before_wire_window','int',0),('fr_before_window_valid','bool',False),('fr_active','bool',False),('fr_dupacks','int',0),('fr_window_valid','bool',False),('fr_last_window','int',0),('fr_was_active','bool',False),('fr_before_una','seq32',1000),('fr_before_nxt','seq32',1000),('fr_before_flight','int',0),('fr_before_rto','int',1000),('fr_before_retries','int',0),('fr_duplicate','bool',False),('fr_entered','bool',False),('fr_extra','bool',False),('fr_exited','bool',False),('fr_retransmitted','bool',False),('fr_emit_count','int',0),('fr_entries','int',0)]}
 req={
 'FR-ACK-PHASE':{'source':'spec/sources/rfc9293.txt','interpretation':'August2022 section3.10.7.4: receiver-sequence and ACK validation precede accepted-window metadata. Rejected sequence or future ACK must not replace the last accepted wire window or its validity. Reuse the explicit parent seg_acceptable and ack_is_future decisions.','kind':'normative','strength':'accepted segment phase correspondence'},
 'FR-SOURCE':{'source':'spec/sources/tcp-fast-recovery.json','interpretation':'Pinned full official RFC5681 and RFC6298 texts, versions and sections for this finite recovery model.','kind':'modeling_choice','strength':'module provenance'},
 'FR-DUPLICATE':{'source':'spec/sources/rfc5681.txt','interpretation':'September2009 section2: accepted pure ACK, outstanding data, no SYN/FIN/text, ACK=UNA, wire window equals last accepted ACK-bearing wire window. Invalid/future segments ignored; window updates/data/FIN do not increment. Positive cached send window as well as positive wire window and no persist are explicit scope guards. Counts reset on new UNA, actual congestion RTO, no flight or connection cleanup.','kind':'normative','strength':'explicit finite duplicate ACK classifier'},
 'FR-RETRANSMIT':{'source':'spec/sources/rfc5681.txt','interpretation':'Section3.2 steps2/3: third duplicate ACK retransmits oldest prefix without consuming sequence space or waiting for RTO; ssthresh=max(floor(FlightSize/2),2SMSS), cwnd=ssthresh+3SMSS. Extra duplicate ACK inflates by SMSS without retransmitting again.','kind':'normative','strength':'finite Reno entry and inflation'},
 'FR-EXIT':{'source':'spec/sources/rfc5681.txt','interpretation':'Section3.2 step6: first ACK advancing UNA exits Reno, deflates to ssthresh, clears CA credit without extra SS/CA growth. Partial ACK exits too: not NewReno. Actual congestion RTO leaves recovery with parent loss window.','kind':'normative','strength':'classic Reno exit'},
 'FR-KARN':{'source':'spec/sources/rfc6298.txt','interpretation':'Section3 Karn ambiguity applies also to fast retransmission. Update actual per-byte send times and overlapped sample ambiguity; do not increment RTO retries/backoff or relabel fast recovery as timer retransmission. Keep existing RTO deadline; parent byte-age rule defers an early expiry after the fast send.','kind':'normative','strength':'shared history and timer correspondence'},
 'FR-SCOPE':{'source':'docs/tcp-fast-recovery.md','interpretation':'MSS4/queue16; explicit app.transmit new-data scheduling; no limited transmit, automatic new-data emission on each duplicate, idle restart, ECN/SACK/NewReno, FIN-only fast recovery or complete TCP proof. Legacy FIN lacks wire window and invalidates last-window knowledge.','kind':'modeling_choice','strength':'bounded integration scope'},
 'CC-SCOPE':{'source':'docs/tcp-fast-recovery.md','interpretation':'Parent budget, growth, timeout and persist properties retained; this overlay adds explicit finite Reno recovery. Remaining exclusions are preserved in model scope and source documentation.','kind':'modeling_choice','strength':'explicit parent scope extension'}}
 connected=('ESTABLISHED','CLOSE-WAIT','FIN-WAIT-1','FIN-WAIT-2','CLOSING','LAST-ACK')
 amendments=[]
 for t in parent['transitions']:
  name=t['event'];schema=parent['events'][name]['fields'];has_window='window'in schema
  pure=name=='net.ack' and 'ACK-VALID'in t['id'] and t['from']in connected
  safe_window=has_window and name in ('net.ack','net.data','net.fin_segment','net.synack') and not any(x in t['id']for x in ('FUTURE','UNACCEPTABLE','BAD','REJECT'))
  pre=[set_('fr_window_ignored',False),set_('fr_before_wire_window',v('fr_last_window')),set_('fr_before_window_valid',v('fr_window_valid')),set_('fr_was_active',v('fr_active')),set_('fr_before_una',v('snd_una')),set_('fr_before_nxt',v('snd_nxt')),set_('fr_before_flight',length('rtx_buf')),set_('fr_before_rto',v('rto_ms')),set_('fr_before_retries',v('retries')),set_('fr_entered',False),set_('fr_extra',False),set_('fr_exited',False),set_('fr_retransmitted',False),set_('fr_emit_count',0)]
  duplicate=both(o('ge',length('rtx_buf'),1),neg(v('persist_active')),v('fr_window_valid'),o('ge',v('snd_wnd'),1),o('eq',event('ack'),v('snd_una')),o('eq',event('window'),v('fr_last_window')),o('ge',event('window'),1)) if pure else False
  pre.append(set_('fr_duplicate',duplicate));post=[]
  amendment={'id':t['id'],'prepend_actions':pre,'append_actions':post,'add_requirements':[n for n in req if n!='CC-SCOPE']}
  # Recovery ACKs must not also earn ordinary congestion credit on exit.
  edits=[]
  if t['from']in connected and name in ('net.ack','net.data','net.fin_segment','net.fin','net.synack'):
   for field in ('cc_growth','cc_ca_credit'):
    matches=[(i,a)for i,a in enumerate(t['actions'])if 'set'in a and a['set']['var']==field]
    if matches:
     i,old=matches[-1];edits.append({'at':i,'expected':old,'with':[set_(field,choose(v('fr_was_active'),0,old['set']['value']))]})
  if edits:amendment['edit_actions']=sorted(edits,key=lambda e:e['at'],reverse=True)
  advanced=neg(o('eq',v('snd_una'),v('fr_before_una')))
  post += [set_('fr_exited',both(v('fr_was_active'),advanced)),set_('fr_dupacks',choose(advanced,0,choose(v('fr_duplicate'),o('add',v('fr_dupacks'),1),v('fr_dupacks')))),set_('fr_entered',both(v('fr_duplicate'),neg(v('fr_was_active')),o('eq',v('fr_dupacks'),3))),set_('fr_extra',both(v('fr_duplicate'),v('fr_was_active')))]
  half=o('sub',v('fr_before_flight'),o('rat_ceil',o('rat_scale',o('rat_from_int',v('fr_before_flight')),{'rat':[1,2]})))
  post += [set_('cc_ssthresh',choose(v('fr_entered'),choose(o('ge',half,8),half,8),v('cc_ssthresh'))),set_('cc_cwnd',choose(v('fr_entered'),o('add',v('cc_ssthresh'),12),choose(v('fr_extra'),o('add',v('cc_cwnd'),4),choose(v('fr_exited'),v('cc_ssthresh'),v('cc_cwnd'))))),set_('cc_ca_credit',choose(either(v('fr_entered'),v('fr_exited')),0,v('cc_ca_credit'))),set_('fr_active',choose(v('fr_entered'),True,choose(v('fr_exited'),False,v('fr_active')))),set_('fr_entries',o('add',v('fr_entries'),choose(v('fr_entered'),1,0))),set_('fr_emit_count',choose(v('fr_entered'),o('min',4,o('min',length('rtx_buf'),v('snd_wnd'))),0)),set_('fr_retransmitted',o('ge',v('fr_emit_count'),1))]
  post.append(set_('rtt_ambiguous',choose(v('fr_retransmitted'),replace(ambiguous,'tx_emit_count',v('fr_emit_count')),v('rtt_ambiguous'))))
  post.append({'emit_if':{'when':v('fr_retransmitted'),'message':'tcp_data','fields':{'flags':'A','seq':v('snd_una'),'ack':v('rcv_nxt'),'window':v('local_window'),'payload':o('bytes_slice',v('rtx_buf'),0,v('fr_emit_count'))}}})
  for i in range(16):post.append(set_(f'tx_time_{i:02}',choose(both(v('fr_retransmitted'),o('ge',v('fr_emit_count'),i+1)),{'clock_ms':True},v(f'tx_time_{i:02}'))))
  # Actual retransmission ACK piggybacks the current receive frontier.
  for field,value in [('ack_pending',False),('ack_bytes',0),('ack_full_segments',0),('ack_since_ms',0)]:post.append(set_(field,choose(v('fr_retransmitted'),value,v(field))))
  post.append({'cancel_if':{'when':v('fr_retransmitted'),'timer':'delack'}})
  active_state=t['to']in connected
  for case in reversed(t.get('target_cases',[])):active_state=choose(case['when'],case['to']in connected,active_state)
  record_gate=active_state if safe_window else False
  if safe_window and name in ('net.data','net.fin_segment') and active_state is not False:
   assigned={a['set']['var'] for a in t['actions'] if 'set'in a}
   assert {'seg_acceptable','ack_is_future'}<=assigned, 'Parent receive phases not declared: '+t['id']
   record_gate=both(active_state,v('seg_acceptable'),neg(v('ack_is_future')))
  if has_window and name in ('net.ack','net.data','net.fin_segment','net.synack'):
   post.append(set_('fr_window_ignored',both(active_state,neg(record_gate))))
  if safe_window:
   post += [set_('fr_last_window',choose(record_gate,event('window'),v('fr_last_window'))),set_('fr_window_valid',choose(record_gate,True,v('fr_window_valid')))]
  elif name=='net.fin':post.append(set_('fr_window_valid',False))
  clear=either(neg(active_state),o('eq',length('rtx_buf'),0),v('cc_loss'),v('persist_active'))
  post += [set_('fr_active',choose(clear,False,v('fr_active'))),set_('fr_dupacks',choose(clear,0,v('fr_dupacks'))),set_('fr_window_valid',choose(neg(active_state),False,v('fr_window_valid')))]
  if t['from']=='CLOSED':post += [set_('fr_entries',0)]
  amendments.append(amendment)
 inv=[{'id':'FR-INV-BOUNDS','assert':both(o('ge',v('fr_dupacks'),0),o('ge',v('fr_entries'),0),o('ge',v('fr_emit_count'),0),o('le',v('fr_emit_count'),4),o('ge',v('fr_last_window'),0),o('le',v('fr_last_window'),65535)),'requirements':['FR-DUPLICATE','FR-RETRANSMIT']},
 {'id':'FR-INV-ACTIVE','assert':o('implies',v('fr_active'),both(o('ge',v('fr_dupacks'),3),o('ge',length('rtx_buf'),1),neg(v('persist_active')),either(*[{'state':s}for s in connected]))),'requirements':['FR-EXIT']},
 {'id':'FR-INV-FAST-CAUSE','assert':o('implies',v('fr_retransmitted'),both(v('fr_entered'),o('eq',v('fr_dupacks'),3),o('ge',v('fr_emit_count'),1),o('eq',v('snd_nxt'),v('fr_before_nxt')),o('eq',v('rto_ms'),v('fr_before_rto')),o('eq',v('retries'),v('fr_before_retries')),neg(v('tx_retransmitted')))),'requirements':['FR-RETRANSMIT','FR-KARN']},
 {'id':'FR-INV-WINDOW-IGNORED','assert':o('implies',v('fr_window_ignored'),both(o('eq',v('fr_last_window'),v('fr_before_wire_window')),o('eq',v('fr_window_valid'),v('fr_before_window_valid')))),'requirements':['FR-ACK-PHASE']},
 {'id':'FR-INV-ENTRY-SEND','assert':o('implies',v('fr_entered'),v('fr_retransmitted')),'requirements':['FR-RETRANSMIT']},
 {'id':'FR-INV-ENTRY-WINDOW','assert':o('implies',v('fr_entered'),o('eq',v('cc_cwnd'),o('add',v('cc_ssthresh'),12))),'requirements':['FR-RETRANSMIT']},
 {'id':'FR-INV-EXIT-WINDOW','assert':o('implies',v('fr_exited'),both(o('eq',v('cc_cwnd'),v('cc_ssthresh')),o('eq',v('cc_ca_credit'),0))),'requirements':['FR-EXIT']}]
 raw={'ir_version':'0.3','semantics':parent['semantics'],'extends':'tcp-congestion.json','protocol':'tcp-fast-recovery','scope':{'terminal_states':[],'excluded':['complete TCP and generic Reno conformance','limited transmit and automatic new-data emission on duplicate ACK','idle restart, ECN/SACK/NewReno and multiple-loss recovery guarantees','FIN-only fast retransmit and legacy FIN wire-window knowledge','universal byte/output/timing and interpreter/translator/implementation refinement proof']},'variables':vs,'requirements':req,'amend_transitions':amendments,'invariants':inv}
 target=ROOT/'model/tcp-fast-recovery.json';text=json.dumps(raw,indent=2)+'\n'
 if not target.exists() or target.read_text()!=text:target.write_text(text)
if __name__=='__main__':main()
