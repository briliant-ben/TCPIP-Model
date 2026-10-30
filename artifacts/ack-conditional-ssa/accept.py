"""Recheck every archived exact conditional query in a fresh directory."""
import argparse
import hashlib
import json
from pathlib import Path
import sys
import tarfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'formal'))
import conditional_ssa as c
HERE=Path(__file__).resolve().parent

def accept(out):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh verification directory')
    r=json.loads((HERE/'acceptance.json').read_text())
    archive=HERE/'evidence.tar.gz'
    if c.sha(archive)!=r['evidence_sha256']:raise ValueError('Archive hash changed')
    expected=json.loads((HERE/'members.json').read_text())
    if c.sha(HERE/'members.json')!=r['members_sha256']:raise ValueError('Member manifest changed')
    old=ROOT/'artifacts/sent-ledger-single-target-unknown'
    if c.sha(old/'members.json')!=r['original_members_sha256']or c.sha(old/'exact-single-disjunct-attempt.tar.gz')!=r['original_archive_sha256']:
        raise ValueError('Original provenance changed')
    originals=json.loads((old/'members.json').read_text())
    out.mkdir(parents=True)
    with tarfile.open(archive,'r:gz')as stream:
        entries=stream.getmembers()
        if len(entries)!=len(expected)or len(set(x.name for x in entries))!=len(entries):raise ValueError('Missing/duplicate members')
        for entry in entries:
            name=Path(entry.name)
            if not entry.isfile()or name.is_absolute()or '..'in name.parts or entry.name not in expected:
                raise ValueError('Unsafe or unexpected archive member')
            data=stream.extractfile(entry).read()
            if hashlib.sha256(data).hexdigest()!=expected[entry.name]:raise ValueError('Member hash changed')
            target=out/name;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data)
    results=[]
    for row in r['groups']:
        number=row['group'];source=out/f'group-{number:03}.smt2'
        if c.sha(source)!=originals[source.name]or c.sha(source)!=row['source_sha256']:
            raise ValueError('Expected original query changed')
        answer=c.verify(out/f'group-{number:03}',source)
        if answer['producer_status']!=row['producer_status']:raise ValueError('Original classification changed')
        results.append(dict(group=number,**answer))
    return dict(status='valid_retained_conditional_query_evidence',groups=results,
                original_tcp_unknown_reports_replaced=False,kernel_checked=False,
                scope='exact exported conjunctions only; no new original query closure')

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',required=True,type=Path)
    print(json.dumps(accept(p.parse_args().out)))
