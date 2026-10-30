"""Rehashed real-query cut controls; no original evidence is modified."""
import importlib.util,json
from pathlib import Path
import shutil,tempfile
ROOT=Path(__file__).resolve().parents[2]
import sys
sys.path.insert(0,str(ROOT/'formal'))
import query_lemmas as g
import query_certificates as q
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('ack_reuse_controller',HERE/'check.py')
controller=importlib.util.module_from_spec(spec);spec.loader.exec_module(controller)


def run(original):
    original=Path(original);records=[]
    hashes=lambda root:{str(path.relative_to(root)):g.c.sha(path)for path in root.rglob('*')if path.is_file()}
    before=hashes(original)
    for kind in ('changed-dependency-context','target-as-parent','wrong-cut-polarity','promoted-protocol-scope'):
        with tempfile.TemporaryDirectory(prefix='ack-reuse-fault-')as temp:
            copy=Path(temp)/'copy';shutil.copytree(original,copy)
            graph=copy/'graph';r=json.loads((graph/'result.json').read_text())
            item=r['dependencies'][0];source=q.source(graph/'dependencies'/item)[0]
            if kind=='changed-dependency-context':
                terms=g.c.read_query(source);terms.insert(0,g.c.z3.BoolVal(True));source.write_text(g.c.script(terms))
            elif kind=='target-as-parent':
                source.write_bytes((graph/'targets/group-292/original.smt2').read_bytes())
            elif kind=='wrong-cut-polarity':
                directory=graph/'targets/group-292';augmented=directory/'augmented.smt2'
                terms=g.c.read_query(augmented);terms[444]=g.c.z3.Not(terms[444])
                augmented.write_text(g.c.script(terms))
                # Supply a genuinely valid modulo equivalence for the forged
                # (contradictory) augmented query; the cut direction still fails.
                shutil.rmtree(directory/'modulo');g.p.produce(augmented,directory/'modulo')
                normalization=g.p.verify(directory/'modulo',augmented)
                g.c.write(directory/'normalization-verification.json',normalization)
            else:r['whole_protocol_proved']=True
            r['files']={str(path.relative_to(graph)):g.c.sha(path)for path in graph.rglob('*')if path.is_file()and path!=graph/'result.json'}
            g.c.write(graph/'result.json',r)
            try:controller.verify(copy,Path(temp)/'verification')
            except ValueError as error:records.append(dict(fault=kind,status='rejected',reason=str(error)))
            else:raise ValueError('Fault accepted: '+kind)
    if hashes(original)!=before:raise ValueError('Original evidence changed')
    return dict(status='all_query_reuse_controls_rejected',controls=records,original_unchanged=True,
                scope='temporary-copy proof-evidence controls only; no new protocol/implementation execution')


if __name__=='__main__':
    parser=__import__('argparse').ArgumentParser(description=__doc__);parser.add_argument('source',type=Path)
    print(json.dumps(run(parser.parse_args().source)))
