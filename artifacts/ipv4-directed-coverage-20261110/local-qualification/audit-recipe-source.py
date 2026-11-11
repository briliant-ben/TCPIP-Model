from pathlib import Path
import sys,json,tarfile,hashlib,copy
R=Path('/Users/xubenling/Documents/ChatGPT/Protocol_Form/TCPIP-Model');sys.path.insert(0,str(R))
from protocol_lab.ir import load,Machine
from protocol_lab.codegen import render
from protocol_lab.codegen.execute import commands
from protocol_lab.symbolic import replay
from protocol_lab.pipeline.coverage import summarize
A=R/'artifacts/ipv4-directed-coverage-20261110';raw=A/'recipe-originals.tar.gz';sha=lambda b:hashlib.sha256(b).hexdigest();assert sha(raw.read_bytes())=='3611d6268d142b72b869a19d7f25b331f6ca6970da8214bc297c63f8f6bed823'
with tarfile.open(raw)as t:
 ms=t.getmembers();assert len(ms)==len({x.name for x in ms})and all(x.isfile()and not Path(x.name).is_absolute()and '..'not in Path(x.name).parts for x in ms);files={x.name:t.extractfile(x).read()for x in ms}
manifest=json.loads(files.pop('MANIFEST.json'));assert set(files)==set(manifest)and all(sha(b)==manifest[n]for n,b in files.items());j='ipv4-directed-recipe-agent-20261110-0196';get=lambda n:json.loads(files[j+'/'+n]);save=lambda p,x:p.write_text(json.dumps(x,indent=2)+'\n')
model=load(R/'model/ipv4-endpoint-virtual-link.json');ctx=get('frozen-context.json');response=get('coverage/planner/response.json');candidate=get('coverage/candidate-cases.json');assert sha(files[j+'/coverage/candidate-cases.json'])==get('coverage/candidate-freeze.json')['sha256'];assert not candidate['failures'];assert len(candidate['cases'])==6
c=render(model);assert files[j+'/coverage/generation/protocol.c']==c.encode();assert sha(c.encode())=='19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b';compiled=get('coverage/build/compile.json');assert compiled['status']=='pass'and sha(files[j+'/coverage/build/protocol-native'])==compiled['executable_sha256']
seeds={s['id']:s for s in ctx['seeds']};before=json.loads((A/'delivery.json').read_text());records=before['records'].copy();rows=get('coverage/results.json');corpus=json.loads((R/'scenarios/ipv4-rule-coverage/cases.json').read_text());assert len(corpus['cases'])==16;steps=0
for i,case in enumerate(candidate['cases']):
 d='coverage/case-'+str(i).zfill(3);scene=get(d+'/scenario.json');assert scene==case['scenario']and scene['initial']=={};index=int(scene['id'].split('-')[-1]);recipe=response['recipes'][index];assert set(recipe)=={'id','seed_id','prefix_steps','append','target_rule'};seed=seeds[recipe['seed_id']];k=recipe['prefix_steps'];assert type(k)is int and 0<=k<=len(seed['steps'])and not seed.get('initial',{})
 path=copy.deepcopy(seed['steps'][:k]);machine=Machine(model)
 def apply(step):
  if step.get('tick'):machine.tick(step['at_ms'])
  else:machine.dispatch(step['event'],copy.deepcopy(step.get('fields',{})),step['at_ms'])
 for s in path:apply(s)
 assert len(recipe['append'])<=8 and k+len(recipe['append'])<=20
 for action in recipe['append']:
  if action.get('op')in ['close','abort']and set(action)=={'op'}:s=dict(at_ms=machine.now_ms,event='T.app.'+action['op'],fields={})
  elif action.get('op')=='tick_earliest'and set(action)=={'op'}:assert machine.timers;s=dict(at_ms=min(machine.timers.values()),tick=True)
  elif action.get('op')=='seed_step'and set(action)=={'op','index'}and type(action['index'])is int and 0<=action['index']<len(seed['steps']):
   s=copy.deepcopy(seed['steps'][action['index']]);assert 'event'in s and model['events'][s['event']]['origin']!='timer';s['at_ms']=max(machine.now_ms,s['at_ms'])
  else:raise ValueError('unknown recipe action')
  apply(s);path.append(s)
 assert scene['steps']==path and scene['expect']==machine.snapshot();actual=[r['transition']for r in machine.trace];assert recipe['target_rule']in actual and set(case['target_rules'])<=set(actual)
 assert files[j+'/'+d+'/native/native-input.txt'].decode()==commands(model,scene);observed=[json.loads(x)for x in files[j+'/'+d+'/native/native.stdout'].decode().splitlines()];keys=('transition','requirements','time_ms','event','after','emitted');expected=[{k:r[k]for k in keys}for r in machine.trace];assert expected==[{k:r[k]for k in keys}for r in observed if r['status']=='transition'];assert observed[-1]['snapshot']==machine.snapshot()and not[r for r in observed if r['status']=='error']
 ex=get(d+'/native/execution.json');assert ex['status']=='pass'and ex['native_returncode']==0 and not files[j+'/'+d+'/native/native.stderr'];z=get(d+'/symbolic/result.json');assert z['query']=='sat'and z['status']=='match'and sha(files[j+'/'+d+'/symbolic/path.smt2'])==z['smt2_sha256'];assert z['witness']['initial']=={k:v['initial']for k,v in model['variables'].items()}and replay(model,z['witness'])['status']=='match'
 assert len(z['witness']['steps'])==len(machine.trace)
 for tr,w in zip(machine.trace,z['witness']['steps']):assert tr['transition']==w['transition']and tr['time_ms']==w['at_ms']and tr['event']==dict(name=w['event'],fields=w['fields'])and tr['after']==w['after']and tr['emitted']==w['emitted']
 assert actual==rows[i]['transitions'];rec={k:rows[i][k]for k in ['key','origin','initial_override','status','transitions']};rec['key']=j+'/'+rec['key'];records.append(rec);scene['id']='0196-'+scene['id'];corpus['cases'].append(dict(scenario=scene,target_rules=case['target_rules']));steps+=len(actual)
coverage=summarize([r['id']for r in model['transitions']],records);assert len(coverage['covered_default'])==100;assert set(before['coverage']['covered_default'])<=set(coverage['covered_default'])
corpus['scope']='22 frozen default-initial model-derived paths:16 prefix-search plus6 primitive DeepSeek recipes, all reference/C/fixed-Z3 gated. New recipe timing variants reuse frozen bytes; no independent RFC oracle.';save(R/'scenarios/ipv4-rule-coverage/cases.json',corpus)
save(A/'recipe-readonly-audit.json',dict(status='pass',originals_sha256=sha(raw.read_bytes()),original_files_checked=len(files),recipes_reconstructed_with_current_IR=6,reference_native_transitions=steps,fixed_queries_SAT_and_strict_replay=6,raw_fields_unchanged_from_frozen_seed=True,timestamps='new variants: original prefix unchanged; frozen step reuse at max(original,current); tick only earliest actual timer',archived_Python_ELF_solver_executed=False,solver_rerun=False,new_network_execution=False,authenticity='server receipts trusted separately'))
save(A/'recipe-delivery.json',dict(schema='ipv4-bounded-recipe-experiment-v1',status='selected_experiments_pass',previous_accepted_rules=94,coverage=coverage,records=records,new_rules=sorted(set(coverage['covered_default'])-set(before['coverage']['covered_default'])),additional_cases=6,additional_transitions=steps,total_supplemental_cases=22,selected_rule_preservation_count=30,selected_preservation_source='delivery.json unchanged',old_UNKNOWN_unchanged=True,flow_assessment='unresolved',all_335_obligations_closed=False,originals_sha256=sha(raw.read_bytes())))
matrix=json.loads((A/'rule-matrix.json').read_text())
for row in matrix['rows']:row['observed_default']=row['rule']in coverage['covered_default'];row['status']='observed_default'if row['observed_default']else'unobserved_not_proved_unreachable'
matrix['scope']='100 default-initial executed rules plus separate30selected contracts; not full specification coverage, wholeprotocol proof, or unreachability';save(A/'rule-matrix-100.json',matrix);print(json.dumps(dict(cases=6,transitions=steps,coverage=100,files=len(files))))
