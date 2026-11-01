"""Verify the caller-approved archive digest and unpack regular release data only."""
import argparse
import hashlib
import json
from pathlib import Path,PurePosixPath
import re
import tarfile


def unpack(archive,expected_sha256,out):
    archive=Path(archive);out=Path(out).resolve()
    if not re.fullmatch('[0-9a-f]{64}',expected_sha256)or hashlib.sha256(archive.read_bytes()).hexdigest()!=expected_sha256:
        raise ValueError('Release archive differs from caller-approved digest')
    data={};total=0
    with tarfile.open(archive)as tar:
        for member in tar:
            p=PurePosixPath(member.name)
            if not member.isfile()or p.is_absolute()or '..'in p.parts or '\\'in member.name or member.name in data:raise ValueError('Unsafe release member')
            total+=member.size
            if member.size>10*1024*1024 or total>100*1024*1024:raise ValueError('Release resource bound exceeded')
            data[member.name]=tar.extractfile(member).read()
    manifest=json.loads(data['release.json'])
    if manifest['schema']!='spec-flow-server-release-v1':raise ValueError('Unsupported release schema')
    expected={'tools/'+n for n in manifest['files']}|{'release.json'}
    if set(data)!=expected:raise ValueError('Incomplete or extra release files')
    for name,digest in manifest['files'].items():
        if hashlib.sha256(data['tools/'+name]).hexdigest()!=digest:raise ValueError('Release source hash differs')
    out.mkdir(parents=True,exist_ok=False)
    for name,raw in data.items():
        p=out/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(raw)
    return dict(schema='spec-flow-deploy-unpack-v1',source_commit=manifest['source_commit'],files=len(manifest['files']),root=str(out),archive_sha256=expected_sha256)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('archive');parser.add_argument('--sha256',required=True);parser.add_argument('--out',required=True);a=parser.parse_args()
    try:r=unpack(a.archive,a.sha256,a.out)
    except (ValueError,OSError,KeyError,tarfile.TarError)as error:r=dict(status='rejected',reason=str(error));print(json.dumps(r));raise SystemExit(1)
    print(json.dumps(r))
