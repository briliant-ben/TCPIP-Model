"""Full-byte one-step IR properties from arbitrary encoded prestates.

Uses the independent existing Encoding, never runtime evaluate/dispatch. No
prestate invariants or poststate properties are assumed; the selected property's
negation is queried. This does not establish reachability or full induction.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
sys.path.insert(0,str(ROOT/'formal'))
from protocol_lab.ir import load, model_files
from protocol_lab.symbolic import Encoding, model_hash
spec=importlib.util.spec_from_file_location('content_native',ROOT/'formal/modular_normalization.py')
native=importlib.util.module_from_spec(spec);spec.loader.exec_module(native)


def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,r):Path(p).write_text(json.dumps(r,indent=2)+'\n')


def check(model_file, rules, invariants, out):
    model_file=Path(model_file).resolve();out=Path(out).resolve()
    if out.exists():raise ValueError('Fresh output directory required')
    m=load(model_file)
    if not rules or len(set(rules))!=len(rules) or not invariants or len(set(invariants))!=len(invariants):
        raise ValueError('Explicit nonempty unique rule/property selections required')
    by_rule={r['id']:i for i,r in enumerate(m['transitions'])}
    by_inv={r['id']:r['assert'] for r in m['invariants']}
    if not set(rules)<=set(by_rule) or not set(invariants)<=set(by_inv):raise ValueError('Unknown selected rule/property')
    paths=model_files(model_file)+[Path(__file__).resolve(),ROOT/'protocol_lab/ir.py',ROOT/'protocol_lab/symbolic.py',ROOT/'formal/modular_normalization.py',ROOT/'formal/tactic_recheck.py',ROOT/'formal/partition_queries.py',ROOT/'docs/semantics.md']
    inputs={str(p.relative_to(ROOT)):sha(p)for p in paths}
    out.mkdir(parents=True)
    r=dict(status='incomplete',model_file=str(model_file.relative_to(ROOT)),model_semantic_sha256=model_hash(m),inputs=inputs,
           properties=invariants,rules=rules,results=[],byte_encoding='Seq(BitVec(8))',
           sequence_encoding='full_32bit_bitvector',depth=1,prestate_invariants_assumed=[],
           poststate_invariants_assumed=[],initial_state_assumed=False,
           source_encoder_trusted=True,reference_runtime_used_to_encode=False,
           solver_binary_sha256=sha(native.solver_binary()),timeout_ms=native.TIMEOUT_MS,
           whole_model_induction=False,reachability_proved=False,kernel_checked=False,
           whole_protocol_proved=False,linux_execution=False,
           scope='selected full-rule full-byte one-step properties from arbitrary encoded prestates; no reachable-prestate claim')
    write(out/'result.json',r)
    for rid in rules:
        print('Encoding '+rid,flush=True)
        enc=Encoding(m,1,list(m['variables']),arbitrary_state=True,fixed_choices=[by_rule[rid]])
        z=enc.z;folder=out/rid;folder.mkdir()
        context=folder/'context.smt2';context.write_text(enc.solver.to_smt2())
        row=dict(rule=rid,context=native.cli(context,folder/'context.log'),properties=[])
        for iid in invariants:
            assertion=by_inv[iid]
            applicable=assertion['args'][0] if type(assertion)is dict and assertion.get('op')=='implies' else True
            enc.solver.push()
            enc.solver.add(enc.expr(applicable,enc.frames[1],{}))
            active_path=folder/(iid+'-applicable.smt2');active_path.write_text(enc.solver.to_smt2())
            active=native.cli(active_path,folder/(iid+'-applicable.log'))
            enc.solver.pop()
            enc.solver.push()
            enc.solver.add(z.Not(enc.expr(by_inv[iid],enc.frames[1],{})))
            path=folder/(iid+'.smt2');path.write_text(enc.solver.to_smt2())
            result=native.cli(path,folder/(iid+'.log'))
            row['properties'].append(dict(id=iid,source_query_sha256=sha(path),applicability=active,**result))
            enc.solver.pop()
        r['results'].append(row)
        print(rid,[(x['id'],x['query'])for x in row['properties']],flush=True)
        write(out/'result.json',r)
    unchanged=all(sha(ROOT/p)==h for p,h in inputs.items()) and sha(native.solver_binary())==r['solver_binary_sha256']
    queries=[p['query']for row in r['results']for p in row['properties']]
    r['status']=('invalidated_inputs_changed' if not unchanged else 'property_counterexample' if 'sat'in queries
                 else 'unknown' if 'unknown'in queries or any(x['context']['query']=='unknown'for x in r['results']) or any(p['applicability']['query']=='unknown'for row in r['results']for p in row['properties'])
                 else 'vacuous_context' if any(x['context']['query']=='unsat'for x in r['results']) or any(p['applicability']['query']=='unsat'for row in r['results']for p in row['properties'])
                 else 'selected_content_steps_verified')
    r['files']={str(p.relative_to(out)):sha(p)for p in sorted(out.rglob('*'))if p.is_file()and p.name!='result.json'}
    write(out/'result.json',r);return r


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--model',type=Path,required=True);p.add_argument('--rule',action='append',required=True)
    p.add_argument('--invariant',action='append',required=True);p.add_argument('--out',type=Path,required=True)
    a=p.parse_args();r=check(a.model,a.rule,a.invariant,a.out)
    print(r['status']);raise SystemExit(0 if r['status']=='selected_content_steps_verified'else 1)
