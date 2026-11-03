"""Reconstruct actual UDP peer evidence; offline provenance needs trusted original CI."""
import argparse
import json
import os
from pathlib import Path
import platform
import subprocess
import sys
sys.path.insert(0,str(Path(__file__).resolve().parent))
import run as driver
from protocol_lab.codegen import sha,render
from protocol_lab.ir import load,require
from protocol_lab.codegen.execute import write


def verify(out,runtime=True):
    report=json.loads((out/'report.json').read_text());namespace=json.loads((out/'namespace.json').read_text())
    require(report['schema']=='linux-ir-udp-peer-v1'and report['linux_peer_evidence']and report['status']in ('pass','unresolved'),'Not completed peer evidence')
    require(report['input_hashes']==driver.inputs(),'Peer source inputs changed')
    require(not report['upstream_modified']and not report['packet_bytes_rewritten']and not report['whole_ipv4_endpoint_complete']and report['api_calls']==0,'Scope relabelled')
    expected=set(report['file_hashes'])|{'report.json'}
    actual={str(p.relative_to(out))for p in out.rglob('*')if p.is_file()}-{'runtime-verification.json','offline-verification.json'}
    require(actual==expected,'Peer artifact file set changed')
    for n,h in report['file_hashes'].items():
        p=(out/n).resolve();require(p.is_relative_to(out)and sha(p)==h,'Peer evidence hash changed: '+n)
    def binding(n,h):
        if n.startswith(report['execution_source_root']+'/'):p=driver.ROOT/n[len(report['execution_source_root'])+1:]
        elif n.startswith(report['execution_output_dir']+'/'):p=out/n[len(report['execution_output_dir'])+1:]
        else:raise ValueError('Generation binding outside approved roots')
        require(sha(p)==h,'Native generation binding changed')
    config=json.loads((driver.PORT/'cases.json').read_text())
    for kind in ('tx','rx'):
        folder=out/(kind+'-source');generation=json.loads((folder/'generation.json').read_text());compiled=json.loads((out/(kind+'-build')/'compile.json').read_text())
        require(compiled['status']=='pass'and compiled['returncode']==0,'Native compilation failed')
        for n,h in generation['inputs'].items():binding(n,h)
        require(render(load(driver.ROOT/config[kind+'_model']))==(folder/'protocol.c').read_text(),'C differs from actual IR lowering')
        require(compiled['generation_sha256']==sha(folder/'generation.json')and compiled['generated_source_sha256']==generation['outputs']['protocol.c']==sha(folder/'protocol.c'),'C compilation binding changed')
        require(compiled['executable_sha256']==sha(out/(kind+'-build')/'protocol-native'),'Compiled executable binding changed')
    if runtime:
        require(platform.system()=='Linux'and platform.release()==report['kernel']==namespace['kernel'],'Original Linux runtime required')
        require(os.readlink('/proc/self/ns/net')==namespace['parent_netns'],'Original namespace parent required')
        require(str(out)==report['execution_output_dir'],'Runtime path changed')
        require(subprocess.check_output(['git','rev-parse','HEAD'],cwd=driver.ROOT,text=True).strip()==report['source_commit'],'Runtime source checkout changed')
        for n,h in report['tool_hashes'].items():require(sha(n)==h,'Original tool binary changed')
    else:
        saved=json.loads((out/'runtime-verification.json').read_text())
        require(saved['status']=='valid_linux_udp_peer_runtime'and saved['report_sha256']==sha(out/'report.json')and saved['checker_sha256']==sha(__file__),'Offline evidence lacks original bound runtime verification')
    fresh=driver.assess(out,save=False)
    require(fresh=={k:report[k]for k in fresh},'Peer/reference/capture assessment changed')
    result=dict(status='valid_linux_udp_peer_runtime'if runtime else'valid_retained_linux_udp_peer_bindings',report_sha256=sha(out/'report.json'),checker_sha256=sha(__file__),assessment=report['status'],roundtrips=report['roundtrips'],captured_packets=report['captured_packets'],new_linux_execution=False,local_runtime_rechecked=runtime,archive_native_program_executed=False,compiler_correctness_proved=False,offline_provenance_requires_trusted_ci=True)
    write(out/('runtime-verification.json'if runtime else'offline-verification.json'),result);return result


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',type=Path,required=True);p.add_argument('--offline',action='store_true');a=p.parse_args()
    print(json.dumps(verify(a.out.resolve(),not a.offline)))
