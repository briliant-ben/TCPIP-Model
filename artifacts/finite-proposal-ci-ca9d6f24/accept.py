"""Accept the named official CI ZIP and its fresh-certificate unit-test scope.

This verifies retained provenance/report/source bindings only. It does not rerun
Linux tests, execute a retained Linux binary or verify Mac protocol certificates.
"""
import argparse
import hashlib
import gzip
import io
import json
from pathlib import Path
import subprocess
import zipfile
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
RUN=41165740563
JOB=124432792129
ARTIFACT=13029157918
HEAD='ca9d6f24ac92f4588c094705c8c6c0d80ba6118f'
CHECKOUT='7ee7ecdd523e56d7bc4ba5a7af469c6a43397d70'
ZIP_SHA='4e96a94a052d90b2399bc08d2da9ae4b480d5a3f3b7e3d4589f8da40f2c52f64'
DECODED_LOG_SHA='52f5e09a42e967f529cb2d7bf8e4ebac78db75d1d1eb3a97bacec137b0795651'
FILES={'report/inputs.json','report/started.json','report/result.json','report/test-ids.json','unittest.log'}


def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def verify(extracted=None):
    provenance=json.loads((HERE/'provenance.json').read_text());artifact=provenance['artifact']
    run=next(row for row in provenance['runs']['workflow_runs']if row['id']==RUN)
    job=next(row for row in provenance['jobs']['jobs']if row['id']==JOB)
    if run['status']!='completed'or run['conclusion']!='success'or job['run_id']!=RUN or job['status']!='completed'or job['conclusion']!='success':
        raise ValueError('Official workflow/job did not succeed')
    if artifact['id']!=ARTIFACT or artifact['workflow_run']['id']!=RUN or artifact['workflow_run']['head_sha']!=HEAD or artifact['digest']!='sha256:'+ZIP_SHA:
        raise ValueError('Official artifact/source binding changed')
    if provenance['source_head_sha']!=HEAD or provenance['checkout_merge_sha']!=CHECKOUT:
        raise ValueError('Source/checkout identity changed')
    if artifact['name']!='query-verification-'+CHECKOUT or sha(HERE/'workflow-artifact.zip')!=ZIP_SHA or (HERE/'workflow-artifact.zip').stat().st_size!=artifact['size_in_bytes']:
        raise ValueError('Original ZIP changed')
    with zipfile.ZipFile(HERE/'workflow-artifact.zip')as stream:
        entries=stream.infolist()
        if len(entries)!=len(FILES)or {x.filename for x in entries}!=FILES:raise ValueError('ZIP coverage changed')
        data={}
        for entry in entries:
            name=Path(entry.filename)
            if name.is_absolute()or '..'in name.parts or entry.is_dir()or (entry.external_attr>>16)&0o170000==0o120000:
                raise ValueError('Unsafe ZIP member')
            data[entry.filename]=stream.read(entry)
    if extracted is not None:
        extracted=Path(extracted)
        if extracted.exists():raise ValueError('Use a fresh extraction directory')
        extracted.mkdir(parents=True)
        for name,raw in data.items():
            target=extracted/name;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(raw)
    r=json.loads(data['report/result.json']);started=json.loads(data['report/started.json'])
    inputs=json.loads(data['report/inputs.json']);ids=json.loads(data['report/test-ids.json'])
    if r['status']!='passed'or r['tests_run']!=77 or r['tests_discovered']!=77 or len(ids)!=len(set(ids))or len(ids)!=77:
        raise ValueError('Wrong unit-test result/coverage')
    if r['failures']!=0 or r['errors']!=0 or r['skipped']!=0 or r['changed_dependencies']or r['environment_changed']is not False:
        raise ValueError('Unit-test failure/skip or invalidated source epoch')
    for field in ('retained_host_specific_artifacts_verified','protocol_implementation_executed','kernel_checked','full_protocol_proved'):
        if r[field]is not False:raise ValueError('Unit-test scope promoted')
    if r['git_commit']!=CHECKOUT or started['git_commit']!=CHECKOUT or started['tests_discovered']!=77 or started['environment']!=r['environment']:
        raise ValueError('Runtime source/environment binding changed')
    if r['input_manifest_sha256']!=hashlib.sha256(data['report/inputs.json']).hexdigest()or r['test_ids_sha256']!=hashlib.sha256(data['report/test-ids.json']).hexdigest():
        raise ValueError('Input/test ID hashes changed')
    if started['input_manifest_sha256']!=r['input_manifest_sha256']or r['environment']['z3_solver_package']!='4.15.4.0'or not r['environment']['platform'].startswith('Linux-'):
        raise ValueError('Fresh Linux tool epoch changed')
    log=data['unittest.log'].decode()
    if 'Ran 77 tests'in log and json.loads(log.strip().splitlines()[-1])==r:pass
    else:raise ValueError('Raw unit-test log/result disagree')
    decoded=gzip.decompress((HERE/'decoded-job.log.gz').read_bytes())
    if hashlib.sha256(decoded).hexdigest()!=DECODED_LOG_SHA or CHECKOUT not in decoded.decode():
        raise ValueError('Official decoded job log/checkout binding changed')
    local=json.loads((ROOT/'artifacts/finite-proposal-local-77/test-ids.json').read_text())
    if ids!=local:raise ValueError('CI did not cover the same selected local methods')
    required={'formal/query_certificates.py','formal/query_lemmas.py','tests/test_query_lemmas.py',
              'tools/run_query_verification_tests.py','.github/workflows/query-verification.yml',
              'tools/propose_finite_certificate.py','tests/test_finite_proposals.py'}
    if not required<=set(inputs):raise ValueError('New checker/test/workflow sources missing')
    names=list(inputs)
    for name in names:
        path=Path(name)
        if path.is_absolute()or '..'in path.parts or '\n'in name or '\r'in name:raise ValueError('Unsafe source path')
    # One process reads immutable named Git blobs; do not substitute the current
    # worktree or silently ignore source changes made after this checkpoint.
    batch=('\n'.join(HEAD+':'+name for name in names)+'\n').encode()
    completed=subprocess.run(['git','cat-file','--batch'],cwd=ROOT,input=batch,capture_output=True,check=True)
    stream=io.BytesIO(completed.stdout)
    for name in names:
        header=stream.readline().decode().strip().split()
        if len(header)!=3 or header[1]!='blob':raise ValueError('Named source blob unavailable: '+name)
        length=int(header[2]);raw=stream.read(length)
        if len(raw)!=length or stream.read(1)!=b'\n'or hashlib.sha256(raw).hexdigest()!=inputs[name]:
            raise ValueError('CI input does not match named source: '+name)
    if stream.read():raise ValueError('Unexpected Git blob output')
    return dict(status='accepted_fresh_query_unit_ci_checkpoint',run_id=RUN,job_id=JOB,artifact_id=ARTIFACT,
        source_head_sha=HEAD,checkout_merge_sha=CHECKOUT,official_zip_sha256=ZIP_SHA,
        tests_run=77,seconds=r['seconds'],input_source_files_checked=len(inputs),
        solver_binary_sha256=r['solver_binary_sha256'],environment=r['environment'],
        linux_tests_rerun_locally=False,retained_mac_protocol_artifacts_verified=False,
        kernel_checked=False,linux_protocol_implementation_executed=False,
        scope='retained official Linux CI unit-test provenance/source/report bindings only; not Linux TCP/PCAP, kernel or whole protocol evidence')


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--extract',type=Path)
    print(json.dumps(verify(parser.parse_args().extract)))
