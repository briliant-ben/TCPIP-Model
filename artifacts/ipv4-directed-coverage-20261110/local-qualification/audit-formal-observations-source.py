from pathlib import Path
import sys,json,tarfile,hashlib,subprocess
R=Path('/Users/xubenling/Documents/ChatGPT/Protocol_Form/TCPIP-Model');sys.path.insert(0,str(R));from protocol_lab.ir import load;from protocol_lab.symbolic import model_hash
A=R/'artifacts/ipv4-directed-coverage-20261110';raw=A/'formal-originals.tar.gz';sha=lambda b:hashlib.sha256(b).hexdigest();assert sha(raw.read_bytes())=='0f982a061e50ffb7024dbe6cc0c0a43b51888e9d92e373788a2615dd9d49ddbb'
with tarfile.open(raw)as t:
 ms=t.getmembers();assert len(ms)==len({m.name for m in ms})and all(m.isfile()and not Path(m.name).is_absolute()and '..'not in Path(m.name).parts for m in ms);files={m.name:t.extractfile(m).read()for m in ms}
manifest=json.loads(files.pop('MANIFEST.json'));assert set(files)==set(manifest)and all(sha(b)==manifest[n]for n,b in files.items());get=lambda j,n:json.loads(files[j+'/'+n]);save=lambda p,x:p.write_text(json.dumps(x,indent=2)+'\n')
m=load(R/'model/ipv4-endpoint-virtual-link.json');j='ipv4-remaining-rule-preservation-20261110-0194';scope=get(j,'scope.json');assert scope['model_semantic_sha256']==model_hash(m)and scope['property_ids']==[r['id']for r in m['invariants']];assert scope['solver_timeout_ms']==10000;rows=get(j,'results.json');assert len(rows)==610;by={};source_checks=0
for name,h in get(j,'source-bindings.json').items():
 pfx='/home/blxu/protocol-flow/candidates/ipv4-qualified-flow-20261109-0181/workspace/'
 if name.startswith(pfx):b=(R/name[len(pfx):]).read_bytes()
 elif name.endswith('/incoming/qualified-0187/qualified_rule_probe.py'):b=(A/'local-qualification/qualified_rule_probe.py').read_bytes()
 elif name.endswith('/'+j+'/controller.py'):b=files[j+'/controller.py']
 else:raise ValueError('unmapped source binding '+name)
 assert sha(b)==h;source_checks+=1
for row in rows:
 assert row['rule']in scope['rule_ids']and row['role']in ['preservation','nonvacuity']and row['answer']in ['sat','unsat','unknown']and row['solver_timeout_ms']==10000;assert sha(files[j+'/'+row['file']])==row['sha256'];group=row['file'].split('/')[0];rendered=get(j,group+'/rendered-queries.json');assert rendered['rule_ids']==[row['rule']]and rendered['property_ids']==scope['property_ids']and rendered['model_semantic_sha256']==model_hash(m)
 q=next(q for q in rendered['queries']if q['role']==row['role']);assert files[j+'/'+row['file']].decode()==q['smt2']and q['sha256']==row['sha256'];by.setdefault(row['rule'],{})[row['role']]=row['answer']
assert set(by)==set(scope['rule_ids'])and len(by)==305
prior=json.loads((A/'delivery.json').read_text());allrules={}
for row in prior['selected_rule_preservation']:allrules.setdefault(row['rule'],{})[row['role']]=row['answer']
assert len(allrules)==30 and not(set(allrules)&set(by));allrules.update(by);assert len(allrules)==335
counts={role:{a:sum(r[role]==a for r in allrules.values())for a in ['sat','unsat','unknown']}for role in ['preservation','nonvacuity']};assert counts==dict(preservation=dict(sat=0,unsat=332,unknown=3),nonvacuity=dict(sat=161,unsat=11,unknown=163))
g='ipv4-guard-disabled-certificates-20261110-0199';guardrows=get(g,'results.json');assert len(guardrows)==11 and all(r['answer']=='unsat'and r['solver_timeout_ms']==10000 for r in guardrows)
# Rebuild only the separate guard certificates with fresh current code, never execute archive sources or solver.
worker="""import sys,json,hashlib;sys.path.insert(0,sys.argv[1]);from protocol_lab.ir import load;from protocol_lab.symbolic import Encoding;m=load(sys.argv[1]+'/model/ipv4-endpoint-virtual-link.json');ids=json.loads(sys.argv[2]);out=[]
for rid in ids:
 i=next(i for i,r in enumerate(m['transitions'])if r['id']==rid);e=Encoding(m,1,tuple(m['variables']),arbitrary_state=True,fixed_choices=[i]);s=e.z.Solver();s.add(e.enabled[0][i][1]);text=s.to_smt2();out.append(dict(rule=rid,sha256=hashlib.sha256(text.encode()).hexdigest(),smt2=text))
print(json.dumps(out))"""
p=subprocess.run([str(R/'.venv/bin/python'),'-c',worker,str(R),json.dumps([r['rule']for r in guardrows])],capture_output=True,text=True,check=True);fresh=json.loads(p.stdout)
for q,row in zip(fresh,guardrows):assert q['rule']==row['rule']and q['sha256']==row['sha256']and q['smt2']==files[g+'/'+row['file']].decode()and allrules[row['rule']]['nonvacuity']=='unsat'
d='ipv4-exact-query-diagnostic-20261110-0201';diag=get(d,'results.json');assert len(diag)==3
for row in diag:assert row['answer']=='unknown'and row['solver_timeout_ms']==10000 and sha(files[j+'/'+row['original_file'].split(j+'/')[1]])==row['smt2_sha256']and allrules[row['rule']]['preservation']=='unknown'
review=get('ipv4-bounded-result-review-20261110-0197','response.json');assert type(review['blocking'])is dict
save(A/'formal-observation-audit.json',dict(status='original_receipts_consistent',original_files_checked=len(files),originals_sha256=sha(raw.read_bytes()),current_source_bindings_checked=source_checks,recorded_queries_checked=610,all_305_preservation_queries_freshly_rebuilt=False,guard_certificates_rebuilt_byte_identically=11,solver_rerun=False,archived_Python_ELF_solver_executed=False,authenticity='server execution receipts are separately trusted; no execution attestation or independent UNSAT proof objects'))
save(A/'formal-observations.json',dict(schema='selected-transition-observation-account-v1',status='unresolved',rules=allrules,counts=counts,guard_disabled_in_composite_profile=[r['rule']for r in guardrows],negative_unknown_rules=[rid for rid,r in allrules.items()if r['preservation']=='unknown'],old_UNKNOWN_unchanged=True,execution_coverage_not_increased_by_proofs=True,scope='recorded full-sequence selected defined-transition checks of65declared invariants; source/receipts bound, remaining305queries not all freshly reconstructed, not wholeprotocol/compiler/wire proof',independent_review_disposition=dict(accepted=False,reasons=['blocking/findings were objects instead of required lists','preservation UNKNOWN rule names conflated with nonvacuity unknowns','reject timeout30s, rerun completed30, or strengthen preconditions to repair UNSAT'],correct_numeric_counts_confirmed_against_raw_receipts=True),exact_diagnostic_preserves_all_three_unknown=True))
save(A/'guard-rebuilt.json',fresh);print(json.dumps(dict(files=len(files),counts=counts,guard_certificates=11)))
