"""Accept original Linux CI bytes and named sources; no local ELF execution."""
import gzip
import hashlib
import io
import json
from pathlib import Path
import subprocess
import sys
import zipfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from protocol_lab.codegen import render,sha
from protocol_lab.codegen.execute import commands,compare,write
from protocol_lab.ir import load
read=lambda p:json.loads(Path(p).read_text())
SOURCE='0ee33d52bb235a8e34acdc85eb083c3ae4ba5125'
MERGE='3d3a0d06aa7095d55ffd5fcbecb334ca9d8465cf'
ZIP='96e5c8547f0dfa1638f75a1371ee05854bb09fd2f4a04f5d4d7277f69274db9e'


def accept():
 p=read(HERE/'provenance.json');a=p['artifact'];out=HERE/'download'
 assert p['run']==41212382314 and p['job']==124569888828 and p['conclusion']=='success'
 assert p['source_head']==SOURCE and p['merge_snapshot']==MERGE
 assert a['id']==13046537061 and a['digest']=='sha256:'+ZIP and a['size_in_bytes']==21593
 assert a['workflow_run']['head_sha']==SOURCE and a['workflow_run']['head_branch']=='codex/spec-flow-c99'
 assert a['name']=='native-ir-codegen-'+MERGE and sha(HERE/'workflow-artifact.zip')==ZIP
 assert p['jobs'][0]['id']==p['job']and p['jobs'][0]['conclusion']=='success'
 binary=None
 with zipfile.ZipFile(HERE/'workflow-artifact.zip')as z:
  seen=set()
  for info in z.infolist():
   n=info.filename;q=Path(n)
   assert n not in seen and not q.is_absolute()and '..'not in q.parts and '\\'not in n
   assert (info.external_attr>>16)&0o170000 != 0o120000
   seen.add(n)
   if info.is_dir():continue
   raw=z.read(info)
   if n=='build/protocol-native':binary=raw
   else:assert raw==(out/n).read_bytes(),'Original ZIP entry changed: '+n
 assert binary is not None and binary.startswith(b'\x7fELF')
 g=read(out/'generated/generation.json');c=read(out/'build/compile.json');r=read(out/'syn-loss/execution.json')
 assert g['status']==c['status']==r['status']=='pass' and c['returncode']==r['native_returncode']==0
 assert not g['runtime_python_required']and not g['external_protocol_stack_used']
 assert not r['python_interpreter_in_native_process']and not r['linux_network_evidence']and not r['pcap_evidence']
 assert hashlib.sha256(binary).hexdigest()==c['executable_sha256']==r['executable_sha256']
 assert c['generated_source_sha256']==g['outputs']['protocol.c']==sha(out/'generated/protocol.c')
 assert c['generation_sha256']==sha(out/'generated/generation.json')
 assert c['command'][1:6]==['-std=c99','-Wall','-Wextra','-Werror',g['model_file'].replace('model/tcp.json','artifacts/native-codegen-ci/generated/protocol.c')]
 assert 'Ubuntu'in c['compiler_version']and '13.3.0'in c['compiler_version']
 prefix=Path(g['model_file']).parents[1];artifact_prefix=prefix/'artifacts/native-codegen-ci'
 sources={}
 for name,h in {**g['inputs'],**r['inputs']}.items():
  path=Path(name)
  if path.is_relative_to(artifact_prefix):assert sha(out/path.relative_to(artifact_prefix))==h
  else:
   rel=path.relative_to(prefix).as_posix();assert sha(ROOT/rel)==h
   sources[rel]=h
 assert sources['protocol_lab/codegen/execute.py']==c['checker_sha256']
 # Runtime source hashes are actual stage records. Test/workflow source bindings
 # additionally rely on the official checkout/job provenance, not a new test run.
 for name in ('tests/test_codegen_native.py','.github/workflows/native-codegen.yml'):sources[name]=sha(ROOT/name)
 stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=('\n'.join(SOURCE+':'+n for n in sources)+'\n').encode(),cwd=ROOT))
 for n,h in sources.items():
  header=stream.readline().decode().split();assert len(header)==3 and header[1]=='blob'
  raw=stream.read(int(header[2]));assert stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==h,n
 assert not stream.read()
 model=load(ROOT/'model/tcp.json');scenario=read(ROOT/'scenarios/syn-loss.json')
 assert render(model)==(out/'generated/protocol.c').read_text()
 assert commands(model,scenario)==(out/'syn-loss/native-input.txt').read_text()
 for name,h in r['outputs'].items():assert sha(out/'syn-loss'/name)==h
 observed=[json.loads(x)for x in (out/'syn-loss/native.stdout').read_text().splitlines()]
 assert compare(model,scenario,observed)==read(out/'syn-loss/difference.json')
 assert read(out/'syn-loss/difference.json')['status']=='match'
 tests=(out/'tests.log').read_text();assert 'Ran 12 tests'in tests and tests.rstrip().endswith('OK')and 'skipped'not in tests
 logs=read(HERE/'log-hashes.json');assert sha(HERE/'job.log.gz')==logs['gzip_sha256']
 assert hashlib.sha256(gzip.decompress((HERE/'job.log.gz').read_bytes())).hexdigest()==logs['decoded_sha256']
 result=dict(status='original_linux_native_codegen_ci_accepted',source_head=SOURCE,merge_snapshot=MERGE,
  ci_run=p['run'],job=p['job'],artifact_id=a['id'],original_zip_sha256=ZIP,
  tests_run=12,source_git_blobs_checked=len(sources),runtime_source_input_bindings=len(sources)-2,
  test_and_workflow_sources_bound_via_checkout_provenance=True,source_bindings=sources,
  generated_source_sha256=g['outputs']['protocol.c'],linux_executable_sha256=c['executable_sha256'],
  compiler_sha256=c['compiler_sha256'],compiler_version=c['compiler_version'],
  independent_native_syn_loss_trace='match',transitions_compared=3,
  new_native_execution=False,local_elf_execution=False,kernel_checked=False,
  linux_tcp_network_evidence=False,pcap_evidence=False,whole_flow_complete=False,
  scope='actual Ubuntu build/native tests and generated active-open event trace; no IPv4 wire or complete flow claim')
 write(HERE/'acceptance.json',result);return result


if __name__=='__main__':print(json.dumps(accept()))
