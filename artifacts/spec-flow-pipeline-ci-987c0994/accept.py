"""Audit official CI using its immutable Git validator, not current or archive code."""
import gzip
import hashlib
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import zipfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
SOURCE='987c0994fdef4372b5776530996256c128b96232'
MERGE='c1e21ad007e4cae79e5b8bb51e10ee7397ba77bb'
ZIP='bc78a22b607285d4ee8146d3724c3a757f7b096fef5d7e27b6cfba7c27dd8f46'
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
read=lambda p:json.loads(Path(p).read_text())


def accept():
 p=read(HERE/'provenance.json');a=p['artifact']
 assert p['source_head']==SOURCE and p['merge_snapshot']==MERGE
 assert p['run']==41216276646 and p['job']==124581357915 and p['conclusion']=='success'
 assert a['id']==13048601703 and a['digest']=='sha256:'+ZIP and a['size_in_bytes']==105272
 assert a['workflow_run']['head_sha']==SOURCE and a['name']=='spec-flow-'+MERGE
 assert sha(HERE/'workflow-artifact.zip')==ZIP
 with tempfile.TemporaryDirectory(prefix='ci-spec-flow-audit-')as tmp:
  tmp=Path(tmp);data=tmp/'data';seen=set()
  with zipfile.ZipFile(HERE/'workflow-artifact.zip')as z:
   for info in z.infolist():
    q=Path(info.filename)
    assert not q.is_absolute()and '..'not in q.parts and '\\'not in info.filename and info.filename not in seen
    assert (info.external_attr>>16)&0o170000 != 0o120000
    seen.add(info.filename)
    if info.is_dir():continue
    target=data/q;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(z.read(info))
  job=data/'run';r=read(job/'flow.json');bindings={}
  for name,h in r['input_hashes'].items():
   prefix,tail=name.split('/',1);assert prefix in ('workspace','tool')
   n=tail if prefix=='workspace'else'protocol_lab/'+tail
   assert not Path(n).is_absolute()and '..'not in Path(n).parts and '\n'not in n and '\r'not in n
   bindings[n]=h
  assert len(bindings)==36
  # Export only named, SHA-matching Git input blobs into a clean validator tree.
  # No Python file from the artifact is imported or executed.
  stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=('\n'.join(SOURCE+':'+n for n in bindings)+'\n').encode(),cwd=ROOT))
  source=tmp/'source'
  for n,h in bindings.items():
   header=stream.readline().decode().split();assert len(header)==3 and header[1]=='blob'
   raw=stream.read(int(header[2]));assert stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==h,n
   target=source/n;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(raw)
  assert not stream.read()
  env=dict(os.environ);env['PYTHONPATH']=str(source);env['PYTHONDONTWRITEBYTECODE']='1'
  checked=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(job),'--workspace',str(source)],
                         cwd=source,env=env,text=True,capture_output=True,timeout=30)
  assert checked.returncode==0,(checked.stdout,checked.stderr)
  audit=json.loads(checked.stdout)
  assert audit==read(data/'verification.json')and audit['assessment']=='verified_event_slice'
  assert len(r['stages'])==10 and all(s['status']=='pass'for s in r['stages'].values())
  assert r['stages']['formal']['data']['depth']==6 and r['stages']['formal']['data']['safety_query']=='unsat'and r['stages']['formal']['data']['overlap_query']=='unsat'
  assert len(r['stages']['compare']['data']['cases'])==12
  tests=(data/'tests.log').read_text();assert 'Ran 12 tests'in tests and tests.rstrip().endswith('OK')and 'skipped'not in tests
  compiler=r['stages']['build']['data'];binary=job/'stages/build/build/protocol-native'
  assert binary.read_bytes().startswith(b'\x7fELF')and sha(binary)==compiler['executable_sha256']
  assert not r['pcap_evidence']and not r['protocol_correctness_proved']and not r['whole_goal_complete']
  logs=read(HERE/'log-hashes.json');assert sha(HERE/'job.log.gz')==logs['gzip_sha256']
  assert hashlib.sha256(gzip.decompress((HERE/'job.log.gz').read_bytes())).hexdigest()==logs['decoded_sha256']
  result=dict(status='original_ubuntu_ten_stage_flow_accepted',source_head=SOURCE,merge_snapshot=MERGE,
   ci_run=p['run'],job=p['job'],artifact_id=a['id'],original_zip_sha256=ZIP,tests_run=12,
   source_git_blobs_checked=len(bindings),original_stages_passed=10,native_cases_compared=12,
   formal_depth=6,original_solver_safety='unsat',original_solver_overlap='unsat',
   linux_executable_sha256=sha(binary),compiler_sha256=compiler['compiler_sha256'],compiler_version=compiler['compiler_version'],
   validator_source_epoch=SOURCE,validator_from_immutable_git=True,archive_code_executed=False,
   new_native_or_solver_execution=False,pcap_evidence=False,linux_tcp_network_evidence=False,whole_goal_complete=False,
   scope='actual Ubuntu event-level pipeline with original source validator; not current-tool replay, IPv4 or completed goal')
 (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result

if __name__=='__main__':print(json.dumps(accept()))
