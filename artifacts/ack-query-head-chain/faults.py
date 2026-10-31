"""Early source/scope controls on temporary copies of the real head DAG."""
import importlib.util,json,shutil,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'formal'))
import query_lemmas as g
import query_certificates as q
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('head_controller',HERE/'check.py')
controller=importlib.util.module_from_spec(spec);spec.loader.exec_module(controller)

def run(original):
    original=Path(original);records=[]
    hashes=lambda root:{str(p.relative_to(root)):g.c.sha(p)for p in root.rglob('*')if p.is_file()}
    before=hashes(original)
    for kind in ('changed-parent-source','changed-target-source','promoted-protocol-scope'):
        with tempfile.TemporaryDirectory(prefix='ack-head-fault-')as tmp:
            copy=Path(tmp)/'copy';shutil.copytree(original,copy)
            graph=copy/'graph';r=json.loads((graph/'result.json').read_text())
            if kind=='changed-parent-source':
                source=q.source(graph/'dependencies'/r['dependencies'][0])[0]
                source.write_text('(assert false)(check-sat)')
            elif kind=='changed-target-source':
                (graph/'targets'/r['targets'][0]['name']/'original.smt2').write_text('(assert false)(check-sat)')
            else:r['whole_protocol_proved']=True
            r['files']={str(p.relative_to(graph)):g.c.sha(p)for p in graph.rglob('*')if p.is_file()and p!=graph/'result.json'}
            g.c.write(graph/'result.json',r)
            try:controller.verify(copy,Path(tmp)/'verification')
            except ValueError as error:records.append(dict(fault=kind,status='rejected',reason=str(error)))
            else:raise ValueError('False proof accepted: '+kind)
    if hashes(original)!=before:raise ValueError('Original evidence changed')
    return dict(status='all_head_source_scope_controls_rejected',controls=records,original_unchanged=True,
        scope='temporary-copy source/scope proof controls only; general wrong-cut and cache/cycle controls have separate unit tests')

if __name__=='__main__':
    parser=__import__('argparse').ArgumentParser(description=__doc__);parser.add_argument('source',type=Path)
    print(json.dumps(run(parser.parse_args().source)))
