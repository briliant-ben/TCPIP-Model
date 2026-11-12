"""Read/hash/parse finite ACK certificates against CURRENT source; never run archived code or solver.
Run with the repository virtualenv. Original solver answers remain trusted receipts;
this verifies exact bodies, complete case coverage and theorem instantiation, not a new proof run.
"""
from pathlib import Path
import tarfile,tempfile,json,hashlib
R=Path(__file__).resolve().parents[1];A=R/'artifacts/ipv4-directed-coverage-20261110';P=Path(tempfile.mkdtemp(prefix='ack-proof-readonly-'));C=P/'candidates';C.mkdir();manifest=json.loads((A/'ack-proof-chain-0216-manifest.json').read_text());assert hashlib.sha256((A/'ack-proof-chain-0216.tar.gz').read_bytes()).hexdigest()==manifest['sha256']
for rel,h in manifest['source_bindings'].items():assert hashlib.sha256((R/rel).read_bytes()).hexdigest()==h
assert hashlib.sha256((A/'formal-originals.tar.gz').read_bytes()).hexdigest()=='0f982a061e50ffb7024dbe6cc0c0a43b51888e9d92e373788a2615dd9d49ddbb'
for name in ['formal-originals.tar.gz','ack-proof-chain-0216.tar.gz']:
 with tarfile.open(A/name)as t:
  members=t.getmembers();assert len(members)==len({m.name for m in members})
  if name.startswith('ack-'):assert {m.name for m in members}==set(manifest['members']) and len(members)==398
  for m in t.getmembers():
   assert m.isfile() and not Path(m.name).is_absolute() and '..'not in Path(m.name).parts
   if name=='formal-originals.tar.gz'and not m.name.startswith('ipv4-remaining-rule-preservation-20261110-0194/'):continue
   data=t.extractfile(m).read()
   if name.startswith('ack-'):assert hashlib.sha256(data).hexdigest()==manifest['members'][m.name]
   f=C/m.name;f.parent.mkdir(parents=True,exist_ok=True);f.write_bytes(data)

import sys,os,time,traceback
import z3
O=P/"fresh-local-audit";O.mkdir()
save=lambda p,x:p.write_text(json.dumps(x,indent=2)+'\n')
sha=lambda b:hashlib.sha256(b).hexdigest()
(O/'controller.py').write_bytes(Path(__file__).read_bytes())
def state(s,**kw):save(O/'status.json',dict(status=s,pid=os.getpid(),updated_at=time.time(),**kw))
def read(p):return json.loads(p.read_text())
def terms(p):return list(z3.parse_smt2_string(p.read_text()))
def equal(a,b):return len(a)==len(b) and all(x.eq(y)for x,y in zip(a,b))
def split(t):
 if z3.is_or(t):return [x for c in t.children()for x in split(c)]
 if z3.is_not(t) and z3.is_and(t.arg(0)):return [x for c in t.arg(0).children()for x in split(z3.Not(c))]
 return [] if z3.is_false(t)else[t]
try:
 state('running',stage='independent_readonly_proof_body_audit')
 g=C/'ipv4-remaining-rule-preservation-20261110-0194'; p=C/'ipv4-ack-compact-partition-20261111-0206'; b=C/'ipv4-partial-ack-postcondition-split-20261111-0211'; j=C/'ipv4-partial-ack-joint-lemma-20261111-0213'
 old={r['rule']:r for r in read(g/'results.json')if r['role']=='preservation'and r['answer']=='unknown'}; checks=[]
 # Full ACK: reconstruct every leaf from the exact original and expression selected from real IR.
 S=R;sys.path.insert(0,str(S))
 from protocol_lab.ir import load
 from protocol_lab.symbolic import Encoding
 m=load(S/'model/ipv4-endpoint-virtual-link.json');assert sha((S/'model/ipv4-endpoint-virtual-link.json').read_bytes())=='7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5'
 rid='T.D-ACK-FULL-STALE-WINDOW'; rr=old[rid]; orig=terms(g/rr['file']); assert sha((g/rr['file']).read_bytes())==rr['sha256']; rows=[r for r in read(p/'results.json')if r['rule']==rid];assert len(rows)==18 and {str(r['case'])for r in rows}=={str(x)for x in range(17)}|{'outside'}
 scope=read(p/'scope.json');pool=read(p/'candidate-expressions.json');idx=next(i for i,r in enumerate(m['transitions'])if r['id']==rid);e=Encoding(m,1,tuple(m['variables']),arbitrary_state=True,fixed_choices=[idx]);selector=e.expr(pool[scope['selectors'][rid]],e.frames[0],e.events[0][m['transitions'][idx]['event']]);d=next(x.parent for x in p.glob('*/original.smt2')if sha(x.read_bytes())==rr['sha256']);finite=[selector==i for i in range(17)]
 for r in rows:
  f=d/(str(r['case'])+'.smt2');assert sha(f.read_bytes())==r['query_sha256'];t=terms(f);expected=z3.Not(z3.Or(*finite))if r['case']=='outside'else selector==r['case'];assert equal(t[:-1],orig) and t[-1].eq(expected)and r['answer']=='unsat'
 checks.append(dict(rule=rid,leaves=18,all_original_assertions_exact=True,outside_complement_exact=True,answers='18 UNSAT',original_unknown_retained=True))
 # Reconstruct the theorem's original NEG query text, not execute archived code or re-solve old jobs.
 cx=z3.Context();byte=z3.SeqSort(z3.BitVecSort(8,ctx=cx));buf=z3.Const('lemma_buf',byte);u=z3.BitVec('lemma_una',32,ctx=cx);a=z3.BitVec('lemma_ack',32,ctx=cx);n=z3.Length(buf);d=z3.BV2Int(a-u);tail=z3.SubSeq(buf,z3.If(d<0,0,d),z3.If(n<0,0,n));premise=z3.And(n<=16,d<=n);eq=a+z3.Int2BV(z3.Length(tail),32)==u+z3.Int2BV(n,32);bad=z3.And(premise,z3.Not(eq));sv=z3.Solver(ctx=cx);sv.add(bad);render=sv.to_smt2();(O/'lemma-fresh-render.smt2').write_text(render);raw=(j/'lemma-generic.smt2').read_text();(O/'lemma-original.smt2').write_text(raw);import difflib;(O/'lemma-render.diff').write_text(''.join(difflib.unified_diff(raw.splitlines(True),render.splitlines(True))));assert render==raw;receipt=read(j/'lemma-generic.json');assert receipt['answer']=='unsat'and sha((j/'lemma-generic.smt2').read_bytes())==receipt['sha256']
 for i,rid in enumerate(['T.D-ACK-PARTIAL-WINDOW','T.D-ACK-PARTIAL-STALE-WINDOW']):
  rr=old[rid];orig=terms(g/rr['file']);d=b/str(i).zfill(3);assert sha((d/'original.smt2').read_bytes())==rr['sha256'];leaves=split(orig[-1]);assert len(leaves)==75;cr=read(b/('coverage-'+str(i)+'.json'));cf=b/('coverage-'+str(i)+'.smt2');assert cr['answer']=='unsat'and sha(cf.read_bytes())==cr['sha256'];assert terms(cf)[0].eq(z3.Xor(orig[-1],z3.Or(*leaves)))
  rows=read(d/'results.json');assert len(rows)==75 and {r['leaf']for r in rows}==set(range(75))
  for r in rows:
   f=d/('leaf-'+str(r['leaf']).zfill(3)+'.smt2');assert sha(f.read_bytes())==r['query_sha256'];t=terms(f);assert equal(t[:-1],orig[:-1])and t[-1].eq(leaves[r['leaf']]);assert r['answer']==('unknown'if r['leaf']==56 else'unsat')
  jd=j/str(i).zfill(3);assert (jd/'original-leaf56.smt2').read_bytes()==(d/'leaf-056.smt2').read_bytes();t=terms(jd/'with-verified-joint-lemma.smt2');assert equal(t[:-1],terms(d/'leaf-056.smt2'))
  idx=next(k for k,r in enumerate(m['transitions'])if r['id']==rid);rule=m['transitions'][idx];enc=Encoding(m,1,tuple(m['variables']),arbitrary_state=True,fixed_choices=[idx]);oldf=enc.frames[0];fields=enc.events[0][rule['event']];sets=[x['set']for x in rule['actions']if 'set'in x];rt=next(x for x in sets if x['var']=='T.rtx_buf');ua=next(x for x in sets if x['var']=='T.snd_una');assert sets.index(rt)<sets.index(ua)and not any(x['var']=='T.snd_nxt'for x in sets);av=enc.expr(ua['value'],oldf,fields);bv=oldf['values']['T.rtx_buf'];uv=oldf['values']['T.snd_una'];nv=z3.Length(bv);dv=z3.BV2Int(av-uv);actual=enc.expr(rt['value'],oldf,fields);assert actual.eq(z3.SubSeq(bv,z3.If(dv<0,0,dv),z3.If(nv<0,0,nv)));fact=z3.Implies(z3.And(nv<=16,dv<=nv),av+z3.Int2BV(z3.Length(actual),32)==uv+z3.Int2BV(nv,32));assert t[-1].eq(fact)
  r=read(j/'results.json')[i];assert r['answer']=='unsat'and sha((jd/'with-verified-joint-lemma.smt2').read_bytes())==r['new_query_sha256'];checks.append(dict(rule=rid,leaves=75,complete_OR_equivalence='UNSAT',unchanged_leaves_UNSAT=74,leaf56='UNSAT with universally verified exact theorem instance',all_original_base_assertions_exact=True,original_unknown_retained=True))
 audit=dict(status='body_audit_pass_requires_independent_review',checks=checks,theorem_negative_query_fresh_render_byte_identical=True,theorem_receipt='UNSAT10s Z3 4.15.4',scope='all 65 declared invariants on defined selected transitions; not scheduler/reachability/wire/compiler/full protocol',coverage='102/335 executed, unchanged',nonvacuity='161SAT/11UNSAT/163UNKNOWN unchanged',production_backend_changed=False,model_changed=False,archived_code_executed=False,solver_rerun=False)
 review=read(C/'ipv4-ack-proof-chain-review-20261111-0216/response.json');assert review['blocking']==[];audit.update(status='readonly_body_audit_pass',archive_sha256=manifest['sha256'],member_hashes_verified=len(manifest['members']),source_bindings_verified=manifest['source_bindings'],independent_review=review,original_direct_preservation='332 UNSAT / 3 UNKNOWN retained',additional_sufficient_certificates=3,whole_flow_status='unresolved');save(A/'ack-certificate-readonly-audit.json',audit);print(json.dumps({'status':audit['status'],'additional_sufficient_certificates':3,'whole_flow_status':'unresolved'}))

except Exception:
 (O/'traceback.txt').write_text(traceback.format_exc());raise
