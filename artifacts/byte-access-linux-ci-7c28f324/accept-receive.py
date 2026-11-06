"""Read-only original-Git reconstruction; no archived code/ELF/solver execution."""
import hashlib,io,json,os,re,subprocess,sys,tarfile,tempfile,zipfile
from pathlib import Path
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
SOURCE='7c28f324b9da4d79e6003ee403260dcf4c7541ec'
TESTED='a3de424c057d14a28d69bb46a7055ac43560e4cb'
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
read=lambda p:json.loads(Path(p).read_text())

def audit():
    provenance=read(HERE/'provenance.json');assert sha(HERE/'receive.zip')==provenance['hashes']['receive.zip']
    assert subprocess.check_output(['git','rev-parse',SOURCE+'^{tree}'],cwd=ROOT,text=True).strip()==provenance['tested_tree_sha1']
    with tempfile.TemporaryDirectory(prefix='kernel-capture-original-audit-')as temporary:
        tmp=Path(temporary);source=tmp/'source';out=tmp/'observed';total=0;names=set()
        # Export trusted immutable Git code, never Python shipped inside a CI artifact.
        paths=['protocol_lab','ports/linux-netns','model','scenarios','packet-profile.json','requirements-formal.txt','spec/sources','.github/workflows/linux-tcp.yml','docs']
        raw=subprocess.check_output(['git','archive',SOURCE,*paths],cwd=ROOT)
        with tarfile.open(fileobj=io.BytesIO(raw))as tar:
            for m in tar:
                p=Path(m.name);assert not p.is_absolute()and '..'not in p.parts
                if m.isdir():continue
                assert m.isfile();dest=source/p;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(tar.extractfile(m).read())
        with zipfile.ZipFile(HERE/'receive.zip')as z:
            for m in z.infolist():
                p=Path(m.filename);total+=m.file_size
                assert not m.is_dir()and not p.is_absolute()and '..'not in p.parts and m.filename not in names and '\\'not in m.filename
                assert total<=32*1024*1024;dest=out/p;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(z.read(m));names.add(m.filename)
        assert len(names)==39
        report=read(out/'report.json');namespace=read(out/'namespace.json');runtime=read(out/'runtime-verification.json')
        for n,h in report['input_hashes'].items():assert sha(source/n)==h,n
        for n,h in report['file_hashes'].items():assert sha(out/n)==h,n
        assert runtime['status']=='valid_linux_runtime_evidence'and runtime['query_equivalence']=='unsat'
        assert runtime['report_sha256']==sha(out/'report.json')and runtime['checker_sha256']==sha(source/'ports/linux-netns/verify.py')
        for n,h in runtime['file_hashes'].items():assert sha(out/n)==h
        assert 'Ran 16 tests'in(out/'driver-tests.log').read_text()
        sys.path.insert(0,str(source));sys.path.insert(0,str(source/'ports/linux-netns'))
        import run as driver
        from protocol_lab.capture import normalize
        from protocol_lab.packets import compare
        from protocol_lab.symbolic import model_hash
        scene=driver.scenario_config(driver.receive.CASE)
        model,machine,expected,base,mapping=driver.reference(out,driver.receive.CASE)
        assert report['input_hashes']==driver.inputs()
        assert expected==read(out/'expected.json')and machine.trace==read(out/'trace.json')and model_hash(model)==report['model_semantic_sha256']
        assert base==(out/'base-generated.pkt').read_text()and mapping==read(out/'script-map.json')
        script=driver.execution_script(base,Path(report['execution_output_dir']),driver.quiet_after_protocol_ms(expected,driver.receive.CASE))
        assert script==(out/'test.pkt').read_text()
        assert driver.execution_mapping(base,script,mapping)==read(out/'execution-map.json')
        assert driver.driver_policy(expected,driver.receive.CASE)==read(out/'driver-policy.json')
        assert driver.verify_sources()==read(out/'source-validation.json')
        assert report['projection']=='tcp-connection-v1'and report['oracle_tolerance_ms']==0
        assert report['packetdrill_tolerance_us']==50000 and report['packetdrill_tolerance_percent']==12.5
        driver.require_isolation(namespace['parent_netns'],namespace['execution_netns'])
        assert namespace['actual_parent_netns']==namespace['parent_netns']and not namespace['host_network_mutations']
        assert namespace['packetdrill_returncode']==namespace['capture_returncode']==0 and namespace['quiet_interval_complete']
        dropped=re.findall(r'(\d+) packets dropped by kernel',(out/'capture.log').read_text())
        assert dropped and int(dropped[-1])==0
        tool=read(out/'tool-build.json');pin=read(source/'ports/linux-netns/upstream.json')
        assert tool['commit']==pin['commit']==report['source_commit']and not tool['modified_upstream_code']
        assert tool['binary_sha256']==report['tool_binary_sha256']and not report['upstream_modified']
        assert report['linux_execution']and report['host_tcp_stack']and not report['full_tcp_complete']
        assert namespace['capture_packet_limit']is None and '-c'not in namespace['capture_command']
        assert namespace['capture_scope']=='all_selected_packets_through_scenario_settle_before_socket_cleanup'
        assert namespace['observation_boundary_policy']=='first_selected_capture_timestamp_plus_declared_settle_v1'
        assert namespace['capture_ready_monotonic_ns']<=namespace['packetdrill_start_monotonic_ns']<=namespace['quiet_barrier_monotonic_ns']<=namespace['capture_stop_request_monotonic_ns']<=namespace['capture_exit_monotonic_ns']
        assert namespace['declared_settle_ms']==scene['settle_ms']==5020
        observed,metadata=normalize(out/'capture.pcap',read(source/'packet-profile.json'),expected,origin='external_capture',checksum_policy='strict',projection='tcp-connection-v1')
        assert observed==read(out/'observed.json')and metadata==read(out/'metadata.json')
        driver.validate_observation(expected,observed,driver.receive.CASE)
        assert metadata['time_origin_ns']==namespace['capture_time_origin_ns']
        assert namespace['observation_deadline_epoch_ns']==metadata['time_origin_ns']+5020000000
        assert namespace['quiet_barrier_epoch_ns']<=namespace['capture_stop_request_epoch_ns']
        window=(namespace['capture_stop_request_epoch_ns']-metadata['time_origin_ns'])/1000000
        assert window>=5020 and window==report['observed_window_ms']
        difference=compare(expected,observed,tolerance_ms=0,projection='tcp-connection-v1')
        assert difference==read(out/'difference.json')and report['status']=='linux_execution_with_projection_'+difference['status']
        assert difference['status']=='mismatch' # Valid evidence retains strict mismatches.
        ack=observed[-1];assert ack['time_ms']==20.055 and ack['window']==64236
        result=dict(status='valid_retained_linux_receive_snapshot',source_commit=TESTED,audit_git_commit=SOURCE,original_ci_runtime_gate='valid_linux_runtime_evidence',observed_window_ms=window,minimum_window_ms=5020,difference=difference['status'],expected_last_ack_ms=expected[-1]['time_ms'],observed_last_ack_ms=ack['time_ms'],expected_last_window=expected[-1]['window'],observed_last_window=ack['window'],raw_files=len(names),source_bindings_checked=len(report['input_hashes']),archive_code_executed=False,fresh_native_or_solver_execution=False,new_linux_execution=False,project_server_deployed=False,offline_provenance_requires_trusted_ci=True,whole_tcp_complete=False)
    (HERE/'receive-acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result
if __name__=='__main__':print(json.dumps(audit()))
