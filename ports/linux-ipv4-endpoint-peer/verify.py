"""Original-runtime or separately named retained IPv4 finite endpoint peer reconstruction."""
import argparse
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
sys.path.insert(0,str(Path(__file__).resolve().parent))
import run as driver
from protocol_lab.codegen import sha,render
from protocol_lab.ir import load,require
from protocol_lab.codegen.execute import write


def verify(out,runtime=True):
    report=json.loads((out/'report.json').read_text());require(report['schema']=='linux-live-ipv4-endpoint-peer-v1'and report['status']=='pass'and report['linux_peer_evidence'],'Not completed IPv4 finite endpoint peer evidence')
    require(report['input_hashes']==driver.inputs(),'IPv4 source changed')
    require(not report['packet_bytes_rewritten']and not report['generated_subject_uses_host_stack']and not report['whole_ipv4_endpoint_complete']and not report['physical_ethernet']and report['api_calls']==0,'IPv4 scope relabelled')
    actual={str(p.relative_to(out))for p in out.rglob('*')if p.is_file()}-{'runtime-verification.json','offline-verification.json'}
    require(actual==set(report['file_hashes'])|{'report.json'},'Artifact set changed')
    for n,h in report['file_hashes'].items():
        p=(out/n).resolve();require(p.is_relative_to(out)and sha(p)==h,'Artifact changed: '+n)
    cfg=driver.config();g=json.loads((out/'generated/generation.json').read_text());c=json.loads((out/'build/compile.json').read_text())
    for n,h in g['inputs'].items():
        require(n.startswith(report['execution_source_root']+'/'),'Unexpected generation source root')
        p=(driver.ROOT/n[len(report['execution_source_root'])+1:]).resolve();require(p.is_relative_to(driver.ROOT)and sha(p)==h,'Generation source changed')
    require(render(load(driver.ROOT/cfg['model']))==(out/'generated/protocol.c').read_text(),'C differs from IR lowering')
    require(c['status']=='pass'and c['returncode']==0 and c['generation_sha256']==sha(out/'generated/generation.json')and c['generated_source_sha256']==g['outputs']['protocol.c']==sha(out/'generated/protocol.c'),'Compilation binding changed')
    require(c['executable_sha256']==sha(out/'build/protocol-native'),'Native executable changed')
    if runtime:
        require(platform.system()=='Linux'and platform.release()==report['kernel'],'Original Linux runtime required')
        require(str(out)==report['execution_output_dir'],'Runtime output path changed')
        require(subprocess.check_output(['git','-c','safe.directory='+str(driver.ROOT),'rev-parse','HEAD'],cwd=driver.ROOT,text=True).strip()==report['source_commit'],'Runtime source checkout changed')
        tools=[shutil.which(n)for n in driver.TOOLS];require(all(tools),'Runtime tool unavailable')
        require(set(report['tool_hashes'])=={str(Path(n).resolve())for n in [sys.executable,*tools]},'Tool hash set changed')
        for n,h in report['tool_hashes'].items():require(sha(n)==h,'Original tool changed')
    else:
        saved=json.loads((out/'runtime-verification.json').read_text());require(saved['status']=='valid_linux_ipv4_endpoint_peer_runtime'and saved['report_sha256']==sha(out/'report.json')and saved['checker_sha256']==sha(__file__),'Original bound runtime proof required')
    case=out/'network';ns=json.loads((case/'namespace.json').read_text())
    if runtime:require(os.readlink('/proc/self/ns/net')==ns['parent_netns']and ns['kernel']==report['kernel'],'Original namespace/kernel differs')
    fresh=driver.assess_case(case,save=False);require(fresh==report['cases'],'IPv4 finite endpoint peer assessment changed')
    symbolic=json.loads((case/'symbolic/result.json').read_text())
    from protocol_lab.symbolic import model_hash
    require(symbolic['backend']=='z3-constrained-trace'and symbolic['scope']=='fixed_inputs_and_rule_choices'and symbolic['all_input_safety']=='not_claimed'and symbolic['query']=='sat'and symbolic['status']==symbolic['replay']['status']=='match','Original fixed-input Z3 invalid')
    require(symbolic['model_semantic_sha256']==model_hash(load(driver.ROOT/cfg['model']))and symbolic['smt2_sha256']==sha(case/'symbolic/path.smt2'),'Fixed-input model/query changed')
    driver.symbolic_trace_check(symbolic,load(driver.ROOT/cfg['model']),json.loads((case/'scenario.json').read_text()))
    result=dict(status='valid_linux_ipv4_endpoint_peer_runtime'if runtime else'valid_retained_linux_ipv4_endpoint_peer_bindings',report_sha256=sha(out/'report.json'),checker_sha256=sha(__file__),cases=fresh,new_linux_execution=False,original_runtime_rechecked=runtime,archive_native_program_executed=False,compiler_correctness_proved=False,offline_provenance_requires_trusted_ci=True)
    write(out/('runtime-verification.json'if runtime else'offline-verification.json'),result);return result


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',type=Path,required=True);p.add_argument('--offline',action='store_true');a=p.parse_args();print(json.dumps(verify(a.out.resolve(),not a.offline)))
