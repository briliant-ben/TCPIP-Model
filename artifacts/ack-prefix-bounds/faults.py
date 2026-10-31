"""Real copied-certificate controls; no original or checker is modified."""
import importlib.util,json,shutil,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'formal'))
import query_certificates as q
import tactic_recheck as t
c=q.c
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('prefix_controller',HERE/'check.py')
controller=importlib.util.module_from_spec(spec);spec.loader.exec_module(controller)

def run(original):
    original=Path(original);records=[]
    hashes=lambda root:{str(p.relative_to(root)):c.sha(p)for p in root.rglob('*')if p.is_file()}
    before=hashes(original)
    for kind in ('missing-case','hidden-original-premise','changed-source','promoted-protocol-scope'):
        with tempfile.TemporaryDirectory(prefix='prefix-proof-fault-')as tmp:
            copy=Path(tmp)/'copy';shutil.copytree(original,copy);cert=copy/'certificates/group-295';proof=cert/'proof';finite=proof/'finite'
            record=json.loads((finite/'result.json').read_text())
            if kind=='missing-case':
                record['cases'].pop();c.write(finite/'result.json',record)
            elif kind=='hidden-original-premise':
                path=finite/'case-00/equivalence.smt2';terms=c.read_query(path)
                source=c.read_query(finite/'source.smt2');path.write_text(c.script([terms[0],c.z3.And(*source),terms[1]]))
                # The additional original conjunction makes this a genuine
                # native UNSAT query, but it is not an admitted local theorem.
                directory=proof/'equivalence-tactic-00';shutil.rmtree(directory)
                answer=t.produce(path,directory)
                if answer['query']!='unsat':raise ValueError('Control premise did not produce native UNSAT')
                methods=json.loads((proof/'proof-methods.json').read_text());methods[0]['equivalence_method_source_sha256']=c.sha(path);c.write(proof/'proof-methods.json',methods)
                record['files']={str(p.relative_to(finite)):c.sha(p)for p in finite.rglob('*')if p.is_file()and p.name!='result.json'and not p.name.endswith('.independent.log')}
                c.write(finite/'result.json',record)
            elif kind=='changed-source':(cert/'source.smt2').write_text('(assert false)(check-sat)')
            else:
                metadata=json.loads((copy/'controller-result.json').read_text());metadata['whole_target_closed']=True;c.write(copy/'controller-result.json',metadata)
            try:controller.verify(copy,Path(tmp)/'verification')
            except ValueError as error:records.append(dict(fault=kind,status='rejected',reason=str(error)))
            else:raise ValueError('Fault accepted: '+kind)
    if hashes(original)!=before:raise ValueError('Original evidence changed')
    return dict(status='all_prefix_certificate_controls_rejected',controls=records,original_unchanged=True,
        scope='temporary copied proof-data faults only; no protocol or implementation execution')

if __name__=='__main__':
    parser=__import__('argparse').ArgumentParser(description=__doc__);parser.add_argument('source',type=Path)
    print(json.dumps(run(parser.parse_args().source)),flush=True)
