"""Exact source/coverage reconstruction plus fresh CLI checks; original reports retained."""
from pathlib import Path
import hashlib
import json
import shutil
import sys
import tarfile
import tempfile
import time
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'formal'))
import tactic_recheck as checker
from partition_queries import extract,disjuncts
import z3

def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,x):p.write_text(json.dumps(x,indent=2)+'\n')

if (HERE/'started.json').exists():raise ValueError('Existing run retained; use a new named snapshot')
work=Path(tempfile.mkdtemp(prefix='tcp-ledger-tactic-'));source=work/'source';source.mkdir()
archive=ROOT/'artifacts/sent-ledger-single-target-unknown/exact-single-disjunct-attempt.tar.gz'
members=json.loads((archive.parent/'members.json').read_text())
with tarfile.open(archive,'r:gz')as tar:
    for m in tar.getmembers():
        p=Path(m.name)
        assert m.isfile()and not p.is_absolute()and '..'not in p.parts
        data=tar.extractfile(m).read();assert hashlib.sha256(data).hexdigest()==members[m.name]
        (source/p).write_bytes(data)
original=json.loads((source/'result.json').read_text())
full=ROOT/original['source_file'];assert sha(full)==original['source_sha256']
assert sha(ROOT/'formal/partition_queries.py')==original['checker_source_sha256']
assertions=extract(full.read_text(),original['label']);index=original['assertion_index']
terms=disjuncts(assertions[index]);prefix=assertions[:index]+assertions[index+1:]
assert original['disjunct_count']==len(terms)==368 and original['group_size']==1
assert [g['disjunct_indices']for g in original['groups']]==[[j]for j in range(368)]
rows=[];start=time.monotonic()
write(HERE/'started.json',dict(status='running',work_dir=str(work),source_sha256=sha(full),
    original_bundle_sha256=sha(archive),runner_sha256=sha(__file__),checker_sha256=sha(ROOT/'formal/tactic_recheck.py'),
    original_status='unknown',targets=1,disjuncts=368,timeout_ms=10000))
checks=[('equivalence',source/'equivalence.smt2',[z3.Xor(assertions[index],z3.Or(*terms))])]
checks +=[(f'group-{j:03}',source/g['file'],prefix+[z3.Or(terms[j])])for j,g in enumerate(original['groups'])]
for name,path,expected in checks:
    assert sha(path)==original['query_hashes'][path.name]
    actual=checker.read_query(path)
    assert len(actual)==len(expected)and all(a.eq(b)for a,b in zip(actual,expected)),name
    out=work/name;r=checker.produce(path,out)
    row=dict(name=name,query=r['query'],producer_seconds=r['seconds'],independently_verified=False)
    if r['query']=='unsat':
        try:
            verification=checker.verify(out,path);write(out/'verification.json',verification)
            row['independently_verified']=True
        except ValueError as e:
            row['independent_failure']=str(e)
    rows.append(row)
    write(HERE/'progress.json',dict(status='running',completed=len(rows),expected=369,
        independent_unsat=sum(x['independently_verified']for x in rows),rows=rows,seconds=time.monotonic()-start))
    print(json.dumps(row),flush=True)
passed=all(x['query']=='unsat'and x['independently_verified']for x in rows)
files={str(p.relative_to(work)):sha(p)for p in sorted(work.rglob('*'))if p.is_file()}
write(HERE/'members.json',files)
bundle=HERE/'queries-and-checks.tar.gz'
with tarfile.open(bundle,'w:gz')as tar:
    for name in files:tar.add(work/name,arcname=name,recursive=False)
with tarfile.open(bundle,'r:gz')as tar:
    assert {m.name:hashlib.sha256(tar.extractfile(m).read()).hexdigest()for m in tar.getmembers()if m.isfile()}==files
result=dict(status='one_exact_original_target_unsat'if passed else'refinement_unknown',label=original['label'],
    source_file=original['source_file'],source_sha256=sha(full),original_status=original['status'],
    checker_sha256=sha(ROOT/'formal/tactic_recheck.py'),runner_sha256=sha(__file__),
    strategy=checker.PIPELINE,timeout_ms=10000,disjuncts=368,checks=len(rows),
    independent_unsat=sum(x['independently_verified']for x in rows),rows=rows,
    archive_sha256=sha(bundle),members_sha256=sha(HERE/'members.json'),seconds=time.monotonic()-start,
    all_original_assertions_retained=True,exhaustive_boolean_partition=True,
    primary_report_unchanged=True,kernel_checked=False,full_protocol_complete=False,
    scope='one original state/length induction destination only; no full-byte/time/interpreter/translator/implementation or unbounded proof')
write(HERE/'result.json',result)
print(json.dumps({k:v for k,v in result.items()if k!='rows'}),flush=True)
