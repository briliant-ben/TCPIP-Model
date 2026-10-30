"""Safely unpack and recheck model anchors and every query-proof dependency."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import tarfile
HERE=Path(__file__).resolve().parent


def load(name,file):
    spec=importlib.util.spec_from_file_location(name,HERE/file)
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module);return module


def accept(out):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh verification directory')
    record=json.loads((HERE/'acceptance.json').read_text())
    sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
    for file,digest in record['checker_sources'].items():
        if Path(file).name!=file or sha(HERE/file)!=digest:raise ValueError('Named checker/selection changed')
    if sha(HERE/'evidence.tar.gz')!=record['evidence_sha256']or sha(HERE/'members.json')!=record['members_sha256']:
        raise ValueError('Archive or member manifest changed')
    expected=json.loads((HERE/'members.json').read_text())
    out.mkdir(parents=True)
    with tarfile.open(HERE/'evidence.tar.gz','r:gz')as stream:
        entries=stream.getmembers()
        if len(entries)!=len(expected)or len({x.name for x in entries})!=len(entries):raise ValueError('Archive coverage changed')
        for entry in entries:
            path=Path(entry.name)
            if not entry.isfile()or path.is_absolute()or '..'in path.parts or entry.name not in expected:
                raise ValueError('Unsafe or unexpected member')
            data=stream.extractfile(entry).read()
            if hashlib.sha256(data).hexdigest()!=expected[entry.name]:raise ValueError('Member changed')
            target=out/path;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data)
    anchor=load('ack_reuse_anchor','anchor.py').verify(out/'execution')
    controller=load('ack_reuse_controller','check.py')
    if record['closed_original_disjuncts']!=controller.selection()['targets']:raise ValueError('Scope/query selection changed')
    graph=controller.verify(out/'execution',out/'fresh-verification')
    if graph['producer_status']!='original_queries_unsat_nonvacuous'or graph['context']['query']!='sat'or any(x['query']['query']!='unsat'for x in graph['targets']):
        raise ValueError('Selected original queries not independently closed')
    result=dict(status='accepted_original_queries_with_checked_dependencies',
        closed_original_disjuncts=record['closed_original_disjuncts'],ir_anchor=anchor,proof_graph=graph,
        kernel_checked=False,ir_translation_proved=False,whole_target_closed=False,
        scope='named ledger state/length queries only, not whole ACK/basis/TCP, byte/time or implementation proof')
    (out/'acceptance-result.json').write_text(json.dumps(result,indent=2)+'\n')
    return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    print(json.dumps(accept(parser.parse_args().out)))
