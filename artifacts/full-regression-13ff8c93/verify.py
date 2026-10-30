"""Accept a terminal frozen13ff8c93 standard regression, never a running marker."""
import argparse,hashlib,io,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
COMMIT='13ff8c934ad8e1d58467495997d316ea09f46beb'
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()

def verify(root):
 root=Path(root);r=json.loads((root/'result.json').read_text());start=json.loads((root/'started.json').read_text())
 inputs=json.loads((root/'inputs.json').read_text());ids=json.loads((root/'test-ids.json').read_text());log=(root/'unittest.log').read_text()
 if r['status']!='passed'or r['git_commit']!=COMMIT or start['git_commit']!=COMMIT:raise ValueError('No named terminal pass')
 if r['tests_run']!=478 or r['tests_discovered']!=478 or start['tests_discovered']!=478 or len(ids)!=len(set(ids))or len(ids)!=478:raise ValueError('Wrong discovery/test count')
 if any(r[x]!=0 for x in ('failures','errors','skipped'))or r['changed_dependencies']or r['environment_changed']is not False:raise ValueError('Test failure/skip or invalidated epoch')
 if r['environment']!=start['environment']or r['environment']['z3_solver_package']!='4.15.4.0':raise ValueError('Environment changed')
 if len(inputs)!=1281 or r['input_manifest_sha256']!=sha(root/'inputs.json')or start['input_manifest_sha256']!=sha(root/'inputs.json')or r['test_ids_sha256']!=sha(root/'test-ids.json'):raise ValueError('Manifest/IDs changed')
 if 'Ran 478 tests'not in log or json.loads(log.strip().splitlines()[-1])!=r:raise ValueError('Terminal log/result disagree')
 for name in inputs:
  p=Path(name)
  if p.is_absolute()or '..'in p.parts or '\n'in name or '\r'in name:raise ValueError('Unsafe source name')
 batch=('\n'.join(COMMIT+':'+name for name in inputs)+'\n').encode()
 stream=io.BytesIO(subprocess.run(['git','cat-file','--batch'],input=batch,capture_output=True,check=True,cwd=ROOT).stdout)
 for name,digest in inputs.items():
  header=stream.readline().decode().split()
  if len(header)!=3 or header[1]!='blob':raise ValueError('Named source absent: '+name)
  raw=stream.read(int(header[2]))
  if stream.read(1)!=b'\n'or hashlib.sha256(raw).hexdigest()!=digest:raise ValueError('Named source changed: '+name)
 if stream.read():raise ValueError('Unexpected blob output')
 return dict(status='accepted_terminal_frozen_standard_regression',git_commit=COMMIT,tests_run=478,seconds=r['seconds'],input_git_blobs_checked=1281,failures=0,errors=0,skipped=0,kernel_checked=False,whole_protocol_proved=False,scope='named13ff8c93 standard discovery only; later cache/proposal methods are separate; no later combined-discovery or Linux protocol proof claim')

if __name__=='__main__':
 parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('root',type=Path)
 print(json.dumps(verify(parser.parse_args().root)))
