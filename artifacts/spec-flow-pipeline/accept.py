"""Safely unpack and audit an original pipeline job, without executing its programs."""
from pathlib import Path
import hashlib
import io
import subprocess
import json
import sys
import tarfile
import tempfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from protocol_lab.pipeline.runner import verify
from protocol_lab.pipeline.task import read,write


def accept():
 expected=read(HERE/'members.json');seen=set()
 with tempfile.TemporaryDirectory(prefix='retained-spec-flow-')as tmp:
  root=Path(tmp).resolve()
  with tarfile.open(HERE/'run.tar.gz')as t:
   for m in t:
    p=Path(m.name)
    if not m.isfile()or p.is_absolute()or '..'in p.parts or '\\'in m.name or m.name not in expected or m.name in seen:
     raise ValueError('Unsafe/unlisted/duplicate data member')
    raw=t.extractfile(m).read()
    if hashlib.sha256(raw).hexdigest()!=expected[m.name]:raise ValueError('Original archive member changed')
    out=root/p;out.parent.mkdir(parents=True,exist_ok=True);out.write_bytes(raw);seen.add(m.name)
  if seen!=set(expected):raise ValueError('Incomplete original archive')
  result=verify(root,ROOT);r=read(root/'flow.json');summary=read(HERE/'run-summary.json')
  if result!=read(HERE/'retained-verification.json'):raise ValueError('Verification differs from original retained audit')
  if result['assessment']!='verified_event_slice'or result['run_id']!=summary['run_id']:raise ValueError('No successful named event flow')
  source=read(HERE/'source-git-bindings.json')
  if source['source_commit']!='987c0994fdef4372b5776530996256c128b96232':raise ValueError('Named source epoch changed')
  bindings={}
  for name,h in r['input_hashes'].items():
   prefix,tail=name.split('/',1);bindings[tail if prefix=='workspace'else 'protocol_lab/'+tail]=h
  if bindings!=source['bindings']:raise ValueError('Named input coverage differs')
  batch=('\n'.join(source['source_commit']+':'+name for name in bindings)+'\n').encode()
  stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=batch,cwd=ROOT))
  for name,h in bindings.items():
   header=stream.readline().decode().split()
   if len(header)!=3 or header[1]!='blob':raise ValueError('Named input absent: '+name)
   raw=stream.read(int(header[2]))
   if stream.read(1)!=b'\n'or hashlib.sha256(raw).hexdigest()!=h:raise ValueError('Named input changed: '+name)
  if stream.read():raise ValueError('Extra named input bytes')
  if len(r['stages'])!=10 or any(s['status']!='pass'for s in r['stages'].values()):raise ValueError('Incomplete actual stages')
  cases=r['stages']['tests']['data']['cases']
  if len(cases)!=12 or sum(c['negative']for c in cases)!=2:raise ValueError('Case coverage changed')
  if r['stages']['formal']['data']['depth']!=6 or r['stages']['formal']['data']['unbounded_proof']:raise ValueError('Formal scope changed')
  if r['stages']['execute']['data']['reference_values_supplied']or r['stages']['execute']['data']['pcap_evidence']:raise ValueError('Native observation scope changed')
  result.update(status='retained_ten_stage_event_flow_accepted',original_stages_executed=10,
                positive_cases=10,negative_cases=2,formal_depth=6,new_native_or_solver_execution=False,
                archive_programs_executed=False,named_git_input_blobs_checked=len(bindings),pcap_evidence=False,whole_goal_complete=False)
 write(HERE/'acceptance.json',result);return result

if __name__=='__main__':print(json.dumps(accept()))
