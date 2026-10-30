"""Safely unpack retained exact-query evidence and independently run its checker."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import tarfile
HERE=Path(__file__).resolve().parent


def accept(out):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh verification directory')
    record=json.loads((HERE/'acceptance.json').read_text())
    sha=lambda path:hashlib.sha256(Path(path).read_bytes()).hexdigest()
    if sha(HERE/'evidence.tar.gz')!=record['evidence_sha256']or sha(HERE/'members.json')!=record['members_sha256']:
        raise ValueError('Archive or member manifest changed')
    expected=json.loads((HERE/'members.json').read_text())
    out.mkdir(parents=True)
    with tarfile.open(HERE/'evidence.tar.gz','r:gz')as stream:
        entries=stream.getmembers()
        if len(entries)!=len(expected)or len(set(x.name for x in entries))!=len(entries):raise ValueError('Member coverage changed')
        for entry in entries:
            path=Path(entry.name)
            if not entry.isfile()or path.is_absolute()or '..'in path.parts or entry.name not in expected:raise ValueError('Unsafe archive')
            data=stream.extractfile(entry).read()
            if hashlib.sha256(data).hexdigest()!=expected[entry.name]:raise ValueError('Member changed')
            target=out/path;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data)
    spec=importlib.util.spec_from_file_location('ack_piecewise_checker',HERE/'check.py')
    checker=importlib.util.module_from_spec(spec);spec.loader.exec_module(checker)
    return checker.verify(out)

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',required=True,type=Path)
    print(json.dumps(accept(p.parse_args().out)))
