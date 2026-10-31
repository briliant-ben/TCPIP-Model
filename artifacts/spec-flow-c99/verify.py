"""Audit retained source/native-observation bindings; does not rerun a native binary."""
import json
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from protocol_lab.codegen import render,sha
from protocol_lab.codegen.execute import commands,compare,write
from protocol_lab.ir import load
HERE=Path(__file__).resolve().parent
read=lambda p:json.loads(Path(p).read_text())

def verify():
 g=read(HERE/'generation/generation.json');c=read(HERE/'build/compile.json');m=load(g['model_file'])
 if g['status']!='pass'or g['backend']!='direct-c99-scalar-v1'or c['status']!='pass'or c['returncode']!=0:raise ValueError('No successful generation/build')
 for name,h in g['inputs'].items():
  if sha(name)!=h:raise ValueError('Source version changed')
 if render(m)!=(HERE/'generation/protocol.c').read_text():raise ValueError('IR/C lowering differs')
 if sha(HERE/'generation/protocol.c')!=g['outputs']['protocol.c']or c['generated_source_sha256']!=g['outputs']['protocol.c']:raise ValueError('Source changed')
 if c['generation_sha256']!=sha(HERE/'generation/generation.json'):raise ValueError('Build/generation differs')
 cases=[]
 for name in ('handshake','syn-loss','two-syn-losses','sequence-wrap'):
  folder=HERE/name;r=read(folder/'execution.json');scenario=read(ROOT/'scenarios'/ (name+'.json'))
  if r['status']!='pass'or r['native_returncode']!=0 or r['executable_sha256']!=c['executable_sha256']:raise ValueError('No successful named native execution')
  if r['linux_network_evidence']or r['pcap_evidence']or r['python_interpreter_in_native_process']:raise ValueError('Observation origin promoted')
  for n,h in r['outputs'].items():
   if sha(folder/n)!=h:raise ValueError('Observation/difference bytes changed')
  if commands(m,scenario)!=(folder/'native-input.txt').read_text():raise ValueError('Input encoding differs')
  for n,h in r['inputs'].items():
   p=Path(n)
   mapped=HERE/'generation/generation.json'if p.name=='generation.json'else HERE/'build/compile.json'if p.name=='compile.json'else p
   if sha(mapped)!=h:raise ValueError('Execution input/checker changed')
  observed=[json.loads(x)for x in (folder/'native.stdout').read_text().splitlines()]
  difference=compare(m,scenario,observed)
  if difference!=read(folder/'difference.json')or difference['status']!='match':raise ValueError('Reference correspondence differs')
  cases.append(dict(id=name,transitions=difference['transitions_compared']))
 result=dict(status='retained_generated_native_scalar_evidence_accepted',scenarios=cases,
             generated_source_sha256=g['outputs']['protocol.c'],original_executable_sha256=c['executable_sha256'],
             native_tests=12,legacy_flow_tests=24,fresh_native_execution=False,
             binary_in_repository=False,compiler_correctness_proved=False,wire_or_pcap_evidence=False,
             whole_flow_complete=False,scope='actual generated scalar TCP active-open native execution; no bytes/IPv4 or second-spec acceptance')
 write(HERE/'verification.json',result);return result

if __name__=='__main__':print(json.dumps(verify()))
