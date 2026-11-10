from pathlib import Path
import sys,json,hashlib,tarfile
R=Path('/Users/xubenling/Documents/ChatGPT/Protocol_Form/TCPIP-Model');sys.path[:0]=[str(R),'/tmp/ipv4-0186-review']
from protocol_lab.ir import load
from protocol_lab.codegen import render
from protocol_lab.codegen.execute import compare,commands
from protocol_lab.symbolic import model_hash,replay
from protocol_lab.pipeline.coverage import summarize
from qualified_rule_probe import render_probe
A=R/'artifacts/ipv4-directed-coverage-20261110';raw=A/'originals.tar.gz';sha=lambda b:hashlib.sha256(b).hexdigest();assert sha(raw.read_bytes())=='4db41c595e20eacd2f8d55971b0d942585537613c661a153cb3466b35f98aafe'
with tarfile.open(raw)as t:files={m.name:t.extractfile(m).read()for m in t.getmembers()if m.isfile()}
manifest=json.loads(files.pop('MANIFEST.json'));assert set(files)==set(manifest)
assert all(sha(b)==manifest[n]for n,b in files.items());get=lambda j,n:json.loads(files[j+'/'+n]);save=lambda p,x:p.write_text(json.dumps(x,indent=2)+'\n')
m=load(R/'model/ipv4-endpoint-virtual-link.json');assert sha((R/'model/ipv4-endpoint-virtual-link.json').read_bytes())=='7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5';c=render(m);assert sha(c.encode())=='19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b'
prior=json.loads((R/'artifacts/ipv4-ci-hardening-20261110/delivery.json').read_text());records=prior['records'].copy();allscenes=[];cases=0;steps=0;queries=[];binding_count=0
for j in ['ipv4-directed-gates-20261110-0187','ipv4-directed-focused-gates-20261110-0190']:
 ctx=get(j,'frozen-context.json');f=get(j,'coverage/candidate-freeze.json');assert sha(files[j+'/coverage/candidate-cases.json'])==f['sha256'];candidate=get(j,'coverage/candidate-cases.json');rows=get(j,'coverage/results.json');assert len(rows)==len(candidate['cases']);assert not candidate['failures']
 assert files[j+'/coverage/generation/protocol.c']==c.encode();compile=get(j,'coverage/build/compile.json');assert compile['status']=='pass';assert sha(files[j+'/coverage/build/protocol-native'])==compile['executable_sha256']
 for path,h in get(j,'source-bindings.json').items():
  prefix='/home/blxu/protocol-flow/candidates/ipv4-qualified-flow-20261109-0181/workspace/'
  if path.startswith(prefix):assert sha((R/path[len(prefix):]).read_bytes())==h;binding_count+=1
 for i,case in enumerate(candidate['cases']):
  d='coverage/case-'+str(i).zfill(3);scene=get(j,d+'/scenario.json');assert scene==case['scenario']and scene['initial']=={}
  assert files[j+'/'+d+'/native/native-input.txt'].decode()==commands(m,scene)
  observed=[json.loads(x)for x in files[j+'/'+d+'/native/native.stdout'].decode().splitlines()];ref=get(j,d+'/reference.json');keys=('transition','requirements','time_ms','event','after','emitted');fresh={'reference_trace':[{k:r[k]for k in keys}for r in ref['trace']]};assert fresh['reference_trace']==[{k:r[k]for k in keys}for r in observed if r['status']=='transition'];assert observed[-1]['snapshot']==ref['snapshot'];assert not [r for r in observed if r['status']=='error']
  ex=get(j,d+'/native/execution.json');assert ex['status']=='pass'and ex['native_returncode']==0 and not files[j+'/'+d+'/native/native.stderr']
  z=get(j,d+'/symbolic/result.json');assert z['query']=='sat'and z['status']=='match';assert sha(files[j+'/'+d+'/symbolic/path.smt2'])==z['smt2_sha256'];assert replay(m,z['witness'])['status']=='match';assert z['witness']['initial']=={k:v['initial']for k,v in m['variables'].items()};assert len(z['witness']['steps'])==len(ref['trace'])
  before=dict(state=m['initial_state'],variables=z['witness']['initial'],timers={})
  for tr,w in zip(ref['trace'],z['witness']['steps']):
   assert tr['before']==before and tr['after']==w['after']and tr['emitted']==w['emitted']and tr['transition']==w['transition']and tr['event']==dict(name=w['event'],fields=w['fields'])and tr['time_ms']==w['at_ms'];assert tr['requirements']==next(r['requirements']for r in m['transitions']if r['id']==tr['transition']);before=tr['after']
  actual=[r['transition']for r in fresh['reference_trace']];assert set(case['target_rules'])<=set(actual);assert actual==rows[i]['transitions'];assert not rows[i]['initial_override']
  scene['id']=j[-4:]+'-'+scene['id'];allscenes.append(dict(scenario=scene,target_rules=case['target_rules']));record={k:rows[i][k]for k in ('key','origin','initial_override','status','transitions')};record['key']=j+'/'+record['key'];records.append(record);cases+=1;steps+=len(actual)
for j in ['ipv4-directed-gates-20261110-0187','ipv4-selected-rule-preservation-20261110-0191']:
 scope=get(j,'formal/scope.json');actual=get(j,'formal/results.json');r=json.loads((A/('fresh-render-'+j[-4:]+'.json')).read_text());assert files[j+'/qualified_rule_probe.py']==Path('/tmp/ipv4-0186-review/qualified_rule_probe.py').read_bytes();stored=get(j,'formal/rendered-queries.json');assert r==stored
 assert len(actual)==len(r['queries'])==2*len(scope['rule_ids'])
 for q,row in zip(r['queries'],actual):
  assert files[j+'/formal/'+q['file']].decode()==q['smt2'];assert sha(q['smt2'].encode())==row['sha256']==q['sha256'];assert row['rule']==q['rule']and row['role']==q['role'];assert row['solver_timeout_ms']==10000
  assert row['answer']==('unsat'if q['role']=='preservation'else'sat');queries.append({k:row[k]for k in ['rule','role','file','sha256','answer','solver_version','solver_timeout_ms']})
save(A/'audit-checked-phase.json',dict(original_files=len(files),cases=cases,transitions=steps,selected_rule_queries=len(queries),fixed_input_queries=cases,status='all_source_query_replay_checks_passed_before_accounting'))
coverage=summarize([r['id']for r in m['transitions']],records);assert len(coverage['covered_default'])==94;assert set(prior['coverage']['covered_default'])<=set(coverage['covered_default'])
save(A/'fresh-readonly-audit.json',dict(status='pass',originals_sha256=sha(raw.read_bytes()),original_files_checked=len(files),current_source_bindings_checked=binding_count,cases_checked=cases,actual_reference_native_transitions=steps,fixed_input_queries=cases,selected_rules_preservation_queries=len(queries),fresh_queries_byte_identical=True,archived_Python_ELF_solver_executed=False,fresh_current_reference_and_witness_replay_executed=True,new_network_execution=False,solver_rerun=False,authenticity='server execution receipts trusted separately; readonly audit does not establish host authenticity'))
save(A/'delivery.json',dict(schema='ipv4-directed-closure-experiment-v1',status='selected_experiments_pass',model_file_sha256=sha((R/'model/ipv4-endpoint-virtual-link.json').read_bytes()),model_semantic_sha256=model_hash(m),generated_C_sha256=sha(c.encode()),coverage=coverage,records=records,new_rules=sorted(set(coverage['covered_default'])-set(prior['coverage']['covered_default'])),new_fixed_input_cases=cases,new_fixed_input_transitions=steps,selected_rule_preservation=queries,selected_rule_count=len(queries)//2,selected_scope='All listed pre-invariants and encoded type/timer constraints, exact selected defined transition, negated listed post-invariants/timer legality/action faults; nonvacuity separately SAT. Not initial reachability, overlap/coverage completeness, wire/compiler/whole-protocol proof.',flow_assessment='unresolved',original_flow_search_coverage='10/335 unchanged; supplemental aggregate is a different account',old_UNKNOWN_unchanged=True,all_335_obligations_closed=False,originals_sha256=sha(raw.read_bytes())))
sc=R/'scenarios/ipv4-rule-coverage';sc.mkdir(exist_ok=True);save(sc/'cases.json',dict(schema='ipv4-model-derived-directed-cases-v1',independent_RFC_oracle=False,model_file_sha256=sha((R/'model/ipv4-endpoint-virtual-link.json').read_bytes()),cases=allscenes,scope='16 default-initial input paths with model-derived expected snapshots; canonical reference/C/fixed-input Z3 validated on server'))
print(json.dumps(dict(files=len(files),cases=cases,transitions=steps,coverage=len(coverage['covered_default']),selected_rules=len(queries)//2)))
