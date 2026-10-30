"""Strict runtime verification; offline snapshot checks are explicitly separate."""
import argparse
import json
import os
from pathlib import Path
import platform
import re
import subprocess
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
sys.path.insert(0,str(Path(__file__).resolve().parent))
import run as driver
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import require
from protocol_lab.capture import normalize
from protocol_lab.packets import compare
from protocol_lab.symbolic import crosscheck_trace, model_hash


def verify(out, runtime=True):
    result=read(out/'report.json')
    scenario=result['scenario_id']; scene=driver.scenario_config(scenario)
    require(result['status'] in ['linux_execution_with_projection_match','linux_execution_with_projection_mismatch']
        and result['linux_execution'] and result['host_tcp_stack'] and not result['upstream_modified'], 'Not completed Linux evidence')
    require(result['input_hashes']==driver.inputs(), 'Linux source inputs changed')
    for name,sha in result['file_hashes'].items():
        path=(out/name).resolve(); require(path.is_relative_to(out) and digest(path)==sha,'Linux artifact changed: '+name)
    require(result['loss_mechanism']==('no peer response to first SYN; observed at egress' if scenario=='syn-loss' else 'none'),
        'Loss mechanism relabelled')
    require(result['projection']==driver.projection(scenario) and result['oracle_tolerance_ms']==0
        and result['packetdrill_tolerance_us']==50000 and result['packetdrill_tolerance_percent']==12.5
        and not result['full_tcp_complete'], 'Linux oracle/scope changed')
    namespace=read(out/'namespace.json')
    require('--tolerance_usecs=50000'in namespace['packetdrill_command']
        and '--tolerance_percent=12.5'in namespace['packetdrill_command']
        and namespace['packetdrill_tolerance_percent']==12.5,'Tool timing configuration changed')
    driver.require_isolation(namespace['parent_netns'],namespace['execution_netns'])
    require(namespace['platform']=='Linux' and namespace['kernel']==result['kernel']
        and namespace['actual_parent_netns']==namespace['parent_netns']
        and namespace['scenario_id']==scenario
        and namespace['packetdrill_returncode']==namespace['capture_returncode']==0
        and not namespace['host_network_mutations'], 'Execution/isolation incomplete')
    require(namespace['capture_scope']=='all_selected_packets_through_scenario_settle_before_socket_cleanup'
        and namespace['capture_packet_limit']is None and namespace['quiet_interval_complete'], 'Quiet capture scope changed')
    require('-c' not in namespace['capture_command'],'Capture was silently packet-count limited')
    require(namespace['capture_ready_monotonic_ns']<=namespace['packetdrill_start_monotonic_ns']
        <=namespace['quiet_barrier_monotonic_ns']<=namespace['capture_exit_monotonic_ns'],'Capture lifecycle order changed')
    dropped=re.findall(r'(\d+) packets dropped by kernel',(out/'capture.log').read_text())
    require(dropped and int(dropped[-1])==0,'Capture drops invalidate complete observation')
    tool=read(out/'tool-build.json'); pin=read(driver.PORT/'upstream.json')
    require(tool['commit']==pin['commit']==result['source_commit'] and not tool['modified_upstream_code'], 'Tool source pin differs')
    require(tool['binary_sha256']==result['tool_binary_sha256'], 'Tool binary binding differs')
    if runtime:
        require(platform.system()=='Linux' and platform.release()==result['kernel'], 'Original Linux runtime required')
        require(os.readlink('/proc/self/ns/net')==namespace['parent_netns'], 'Runtime parent namespace differs')
        require(result['execution_output_dir']==str(out),'Runtime evidence output path differs')
        require((out/'quiet-complete').stat().st_mtime_ns==namespace['quiet_barrier_epoch_ns'],'Runtime barrier metadata differs')
        require(digest(Path(tool['binary']))==tool['binary_sha256'], 'Runtime packetdrill binary missing/changed')
        require(digest(Path(tool['compiler_path']))==tool['compiler_sha256'],'Runtime compiler binding changed')
        head=subprocess.check_output(['git','-c','safe.directory='+tool['source_root'],'-C',tool['source_root'],'rev-parse','HEAD'],text=True).strip()
        require(head==pin['commit'],'Runtime tool checkout changed')
        subprocess.run(['git','-c','safe.directory='+tool['source_root'],'-C',tool['source_root'],
            'diff','--exit-code','--','*.c','*.h','*.y','*.l'],check=True)
    else:
        saved=read(out/'runtime-verification.json')
        require(saved['status']=='valid_linux_runtime_evidence' and saved['report_sha256']==digest(out/'report.json'),
            'Offline snapshot lacks bound runtime verification')
    model,machine,expected,base,mapping=driver.reference(out,scenario)
    require(model_hash(model)==result['model_semantic_sha256'] and expected==read(out/'expected.json')
        and machine.trace==read(out/'trace.json'),'Rehashed reference evidence changed')
    require((out/'base-generated.pkt').read_text()==base and read(out/'script-map.json')==mapping,'Generated script changed')
    script=driver.execution_script(base,Path(result['execution_output_dir']),driver.quiet_after_protocol_ms(expected,scenario))
    require((out/'test.pkt').read_text()==script
        and digest(out/'test.pkt')==result['input_script_sha256'],'Execution script mapping changed')
    require(read(out/'driver-policy.json')==driver.driver_policy(expected,scenario),'Driver/observation policy changed')
    require(read(out/'execution-map.json')==driver.execution_mapping(base,script,mapping),'Execution line mapping changed')
    require(read(out/'source-validation.json')==driver.verify_sources(),'Normative-source verification differs')
    observed,metadata=normalize(out/'capture.pcap',read(ROOT/'packet-profile.json'),expected,
        origin='external_capture',checksum_policy='strict',projection=driver.projection(scenario))
    driver.validate_observation(expected,observed,scenario)
    require(observed==read(out/'observed.json') and metadata==read(out/'metadata.json'),
        'Independent raw-capture normalization changed')
    require(namespace['declared_settle_ms']==scene['settle_ms'],'Scenario settle scope changed')
    window_ms=(namespace['quiet_barrier_epoch_ns']-metadata['time_origin_ns'])/1000000
    require(window_ms==result['observed_window_ms'] and window_ms>=namespace['declared_settle_ms'],
        'Quiet observation window shortened or relabelled')
    difference=compare(expected,observed,tolerance_ms=0,projection=driver.projection(scenario))
    require(difference==read(out/'difference.json') and result['status']=='linux_execution_with_projection_'+difference['status'],
        'Difference changed even if rehashed')
    target=out/('runtime-query-recheck' if runtime else 'offline-query-recheck')
    regenerated=crosscheck_trace(model,machine.trace,target)
    require(regenerated['status']=='match','Fresh reference-query check failed')
    import z3
    original=z3.parse_smt2_file(str(out/'symbolic/path.smt2'))
    current=z3.parse_smt2_file(str(target/'path.smt2'))
    solver=z3.Solver();solver.set(timeout=10000);solver.add(z3.Xor(z3.And(*original),z3.And(*current)))
    (target/'equivalence.smt2').write_text(solver.to_smt2())
    answer=str(solver.check());require(answer=='unsat','Fresh-query equivalence unproved')
    write(out/('runtime-verification.json' if runtime else 'offline-verification.json'),dict(
        status='valid_linux_runtime_evidence' if runtime else 'valid_retained_linux_snapshot_bindings',
        local_linux_execution_checked=runtime,new_linux_execution=False,report_sha256=digest(out/'report.json'),
        checker_sha256=digest(driver.PORT/'verify.py'),query_equivalence=answer,projection=difference['status'],
        tool_binary_rechecked_locally=runtime,offline_provenance_requires_trusted_CI=True,
        file_hashes={str(p.relative_to(out)):digest(p)for p in sorted(target.iterdir())if p.is_file()}))
    print('valid_linux_runtime_evidence' if runtime else 'valid_retained_linux_snapshot_bindings')


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--out',type=Path,default=ROOT/'artifacts/linux-netns')
    parser.add_argument('--offline',action='store_true');args=parser.parse_args()
    verify(args.out.resolve(),runtime=not args.offline)
