"""Reconstruct every retained full-byte step query and run a fresh native CLI.

A retained report/UNSAT label is never mathematical authority. The existing IR
encoder remains trusted; this is not a kernel proof of that encoder.
"""
import argparse
import importlib.util
import json
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT));sys.path.insert(0,str(ROOT/'formal'))
from protocol_lab.ir import load,model_files
from protocol_lab.symbolic import Encoding,model_hash
import content_step as producer
import tactic_recheck as t


def recheck(source,out):
    source=Path(source).resolve();out=Path(out).resolve()
    if out.exists():raise ValueError('Fresh replay directory required')
    r=json.loads((source/'result.json').read_text());model_file=(ROOT/r['model_file']).resolve()
    if not model_file.is_relative_to(ROOT):raise ValueError('Model outside repository')
    m=load(model_file)
    expected=model_files(model_file)+[ROOT/'formal/content_step.py',ROOT/'protocol_lab/ir.py',ROOT/'protocol_lab/symbolic.py',ROOT/'formal/modular_normalization.py',ROOT/'formal/tactic_recheck.py',ROOT/'formal/partition_queries.py',ROOT/'docs/semantics.md']
    inputs={str(p.relative_to(ROOT)):producer.sha(p)for p in expected}
    if inputs!=r['inputs'] or model_hash(m)!=r['model_semantic_sha256']:raise ValueError('Source epoch changed/omitted')
    if r['solver_binary_sha256']!=producer.sha(t.solver_binary()) or r['timeout_ms']!=10000:raise ValueError('Native solver epoch/budget changed')
    for k in ('whole_model_induction','reachability_proved','kernel_checked','whole_protocol_proved','linux_execution','initial_state_assumed','reference_runtime_used_to_encode'):
        if r[k] is not False:raise ValueError('Scope broadened')
    if r['prestate_invariants_assumed']!=[] or r['poststate_invariants_assumed']!=[] or r['depth']!=1 or r['byte_encoding']!='Seq(BitVec(8))'or r['sequence_encoding']!='full_32bit_bitvector':raise ValueError('Encoding or assumptions changed')
    rules=r['rules'];invs=r['properties']
    if not rules or len(set(rules))!=len(rules)or not invs or len(set(invs))!=len(invs):raise ValueError('Incomplete selections')
    if [x['rule']for x in r['results']]!=rules:raise ValueError('Rule coverage changed')
    for name,h in r['files'].items():
        p=(source/name).resolve()
        if not p.is_relative_to(source)or producer.sha(p)!=h:raise ValueError('Retained artifact changed')
    out.mkdir(parents=True)
    replay=dict(status='incomplete',source_report_sha256=producer.sha(source/'result.json'),
                checker_sha256=producer.sha(__file__),results=[],fresh_native_execution=True,
                whole_model_induction=False,whole_protocol_proved=False,kernel_checked=False)
    by_inv={i['id']:i['assert'] for i in m['invariants']}
    def actual(expected_solver,relative,folder):
        path=source/relative
        expected_terms=list(expected_solver.assertions());actual_terms=t.read_query(path)
        # Compare the independently exported/parsed expected shape. Source
        # assertions are neither simplified nor assumed as extra premises.
        import z3
        parsed_expected=list(z3.parse_smt2_string(expected_solver.to_smt2()))
        if len(parsed_expected)!=len(actual_terms)or any(not a.eq(b)for a,b in zip(parsed_expected,actual_terms)):
            raise ValueError('Reconstructed complete source query differs: '+str(relative))
        target=folder/Path(relative).name;target.write_bytes(path.read_bytes())
        return dict(source_query_sha256=producer.sha(path),**producer.native.cli(target,target.with_suffix('.log')))
    for row in r['results']:
        rid=row['rule'];matches=[j for j,v in enumerate(m['transitions'])if v['id']==rid]
        if len(matches)!=1 or [p['id']for p in row['properties']]!=invs:raise ValueError('Unknown rule or incomplete property coverage')
        enc=Encoding(m,1,list(m['variables']),arbitrary_state=True,fixed_choices=matches)
        folder=out/rid;folder.mkdir();prefix=Path(rid)
        checked=dict(rule=rid,context=actual(enc.solver,prefix/'context.smt2',folder),properties=[])
        for iid in invs:
            prop=by_inv[iid];active=prop['args'][0]if type(prop)is dict and prop.get('op')=='implies'else True
            enc.solver.push();enc.solver.add(enc.expr(active,enc.frames[1],{}))
            applicability=actual(enc.solver,prefix/(iid+'-applicable.smt2'),folder);enc.solver.pop()
            enc.solver.push();enc.solver.add(enc.z.Not(enc.expr(prop,enc.frames[1],{})))
            proof=actual(enc.solver,prefix/(iid+'.smt2'),folder);enc.solver.pop()
            checked['properties'].append(dict(id=iid,applicability=applicability,**proof))
        replay['results'].append(checked)
        producer.write(out/'result.json',replay)
    if any(producer.sha(ROOT/n)!=h for n,h in inputs.items()):raise ValueError('Source changed during replay')
    if producer.sha(t.solver_binary())!=r['solver_binary_sha256']:raise ValueError('Solver changed during replay')
    replay['status']='fresh_complete_query_replay_recorded'
    replay['files']={str(p.relative_to(out)):producer.sha(p)for p in sorted(out.rglob('*'))if p.is_file()and p.name!='result.json'}
    producer.write(out/'result.json',replay);return replay


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path);p.add_argument('--out',required=True,type=Path)
    a=p.parse_args();print(recheck(a.source,a.out)['status'])
