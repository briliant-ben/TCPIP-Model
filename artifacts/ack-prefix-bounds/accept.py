"""Safely restore and freshly check the named original prefix certificates."""
import argparse,hashlib,importlib.util,json,tarfile
from pathlib import Path
HERE=Path(__file__).resolve().parent

def module(name,file):
    spec=importlib.util.spec_from_file_location(name,HERE/file)
    value=importlib.util.module_from_spec(spec);spec.loader.exec_module(value);return value

def accept(out):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh archive verification directory')
    record=json.loads((HERE/'acceptance.json').read_text());sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
    for file,digest in record['checker_sources'].items():
        if Path(file).name!=file or sha(HERE/file)!=digest:raise ValueError('Named application/checker changed')
    if sha(HERE/'evidence.tar.gz')!=record['evidence_sha256']or sha(HERE/'members.json')!=record['members_sha256']:raise ValueError('Archive or manifest changed')
    members=json.loads((HERE/'members.json').read_text());out.mkdir(parents=True)
    with tarfile.open(HERE/'evidence.tar.gz','r:gz')as stream:
        entries=stream.getmembers()
        if len(entries)!=len(members)or len({x.name for x in entries})!=len(entries):raise ValueError('Archive coverage changed')
        for entry in entries:
            path=Path(entry.name)
            if not entry.isfile()or path.is_absolute()or '..'in path.parts or entry.name not in members:raise ValueError('Unsafe member')
            data=stream.extractfile(entry).read()
            if hashlib.sha256(data).hexdigest()!=members[entry.name]:raise ValueError('Member changed')
            target=out/path;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data)
    controller=module('prefix_controller','check.py')
    if record['closed_original_disjuncts']!=controller.selection()['targets']:raise ValueError('Different selected originals')
    anchor=module('prefix_anchor','anchor.py').verify(out/'execution')
    checked=controller.verify(out/'execution',out/'fresh-verification')
    if checked['status']!='verified_original_prefix_queries_nonvacuous':raise ValueError('Missing fresh original-query proof')
    result=dict(status='accepted_original_prefix_queries_after_archive_replay',closed_original_disjuncts=record['closed_original_disjuncts'],
        ir_anchor=anchor,proof_checks=checked,kernel_checked=False,ir_translation_proved=False,whole_target_closed=False,
        scope='two original finite state/length queries only; no combined368/basis/IR translation/byte/time/implementation/TCP proof')
    (out/'acceptance-result.json').write_text(json.dumps(result,indent=2)+'\n');return result

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    print(json.dumps(accept(parser.parse_args().out)),flush=True)
