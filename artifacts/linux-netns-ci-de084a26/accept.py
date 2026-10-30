"""Accept two separately scoped CI kernel runs; local verification is offline."""
import hashlib
from pathlib import Path
import sys
import zipfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from protocol_lab.flow import read,write,digest
HEAD='de084a26deaa6d3c48e26e747410968a5e6a32ef'
MERGE='ca46eb95093ef38bd0362e337f7e0ba0233ce7d0'
PIN='2a8b4d80459e157d5bb7a99fe620c83e5ce036bb'
EXPECTED={'handshake':(12955232422,123900008817,'9275c4cd28557bd2e581a895ca4e8d08c50823bb8a6ea2f0cf2dc730a4600e48',3,5010),
          'syn-loss':(12955108849,123900009128,'94dbeda61ff73e36a138a7fb65420792072ab69015acba1406e4ea88683d8ee9',4,6010)}
neg=read(HERE/'negative-controls.json')
assert neg['status']=='ten_offline_faults_rejected' and not neg['new_linux_execution'] and neg['original_evidence_unchanged']
assert neg['checker_sha256']==digest(ROOT/'ports/linux-netns/verify.py')
assert {(x['scenario'],x['fault'])for x in neg['tests']}=={(s,f)for s in EXPECTED for f in ('reference','checksum','short_window','packet_cap','scenario')}
for row in neg['tests']:assert digest(HERE/row['log'])==row['log_sha256']
for filename in ('run.c','config.c'):
    path=HERE/'upstream-timing'/filename;data=path.read_bytes();meta=read(path.with_name(filename+'.provenance.json'))
    assert meta['repository']=='google/packetdrill' and meta['ref']==PIN
    assert meta['sha256']==digest(path) and meta['git_blob_sha']==hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
config=(HERE/'upstream-timing/config.c').read_text();run=(HERE/'upstream-timing/run.c').read_text()
assert 'config->tolerance_percent\t= 12.5;'in config
assert 'dynamic_tolerance = (state->config->tolerance_percent / 100.0) * delta;'in run
assert 'if (dynamic_tolerance > tolerance_usecs)'in run
rows=[]
for scenario,(artifact_id,job,zip_sha,count,settle)in EXPECTED.items():
    parent=HERE/scenario;out=parent/'download';prov=read(parent/'provenance.json');a=prov['artifact']
    assert prov['source_head']==HEAD and prov['merge_snapshot']==MERGE and prov['job_conclusion']=='success'
    assert prov['run']==41005706790 and prov['job']==job and a['id']==artifact_id
    assert a['workflow_run']['head_sha']==HEAD and a['workflow_run']['head_branch']=='codex/tcp-timers'
    assert a['name']=='linux-tcp-'+scenario+'-'+MERGE
    assert a['digest']=='sha256:'+zip_sha and digest(parent/'workflow-artifact.zip')==zip_sha
    with zipfile.ZipFile(parent/'workflow-artifact.zip')as archive:
        for name in archive.namelist():
            if name.endswith('/'):continue
            p=Path(name);assert not p.is_absolute() and '..'not in p.parts
            assert archive.read(name)==(out/p).read_bytes(),name
    result=read(out/'report.json');runtime=read(out/'runtime-verification.json');offline=read(out/'offline-verification.json')
    assert result['scenario_id']==scenario and result['source_commit']==PIN and result['linux_execution']
    assert result['host_tcp_stack'] and not result['upstream_modified'] and not result['full_tcp_complete']
    assert result['projection']=='active-open-v1' and result['oracle_tolerance_ms']==0 and result['packetdrill_tolerance_us']==50000
    for name,sha in result['input_hashes'].items():assert digest(ROOT/name)==sha,name
    for name,sha in result['file_hashes'].items():assert digest(out/name)==sha,name
    assert runtime['status']=='valid_linux_runtime_evidence' and runtime['local_linux_execution_checked']
    assert offline['status']=='valid_retained_linux_snapshot_bindings' and not offline['local_linux_execution_checked']
    assert not offline['tool_binary_rechecked_locally'] and not offline['new_linux_execution']
    for check in (runtime,offline):
        assert check['report_sha256']==digest(out/'report.json') and check['query_equivalence']=='unsat'
        assert check['checker_sha256']==digest(ROOT/'ports/linux-netns/verify.py')
        for name,sha in check['file_hashes'].items():assert digest(out/name)==sha,name
    ns=read(out/'namespace.json');observed=read(out/'observed.json');difference=read(out/'difference.json')
    assert ns['scenario_id']==scenario and ns['declared_settle_ms']==settle
    assert ns['capture_packet_limit']is None and '-c'not in ns['capture_command'] and ns['quiet_interval_complete']
    assert '--tolerance_usecs=50000'in ns['packetdrill_command']
    assert not any(x.startswith('--tolerance_percent')for x in ns['packetdrill_command'])
    assert result['observed_window_ms']>=settle and len(observed)==count
    assert difference['tolerance_ms']==0 and difference['status']=='mismatch'
    assert all(x['kind']=='field' and x['field']=='time_ms'for x in difference['differences'])
    rows.append(dict(scenario=scenario,status='real_linux_execution_with_retained_time_differences',kernel=result['kernel'],
        observed_window_ms=result['observed_window_ms'],declared_window_ms=settle,selected_packets=count,
        observed_flags_and_times=[dict(flags=p['flags'],time_ms=p['time_ms'])for p in observed],
        difference=difference,raw_capture_sha256=digest(out/'capture.pcap'),report_sha256=digest(out/'report.json'),
        runtime_verification_sha256=digest(out/'runtime-verification.json'),offline_verification_sha256=digest(out/'offline-verification.json'),
        artifact_id=artifact_id,job=job,zip_sha256=zip_sha))
write(HERE/'acceptance.json',dict(status='two_real_linux_active_open_scenarios_accepted_with_differences',
    source_head=HEAD,merge_snapshot=MERGE,ci_run=41005706790,cases=rows,
    packetdrill_execution_tolerance=dict(minimum_us=50000,upstream_default_percent=12.5,
        rule='max(minimum_us, percent/100 * event_interval_us)',one_second_event_effective_us=125000,
        source_pin=PIN,configuration_inferred_from_pinned_default=True),independent_difference_tolerance_ms=0,
    negative_controls_sha256=digest(HERE/'negative-controls.json'),local_linux_rerun=False,
    local_CI_binary_recheck=False,physical_network_loss=False,internal_kernel_RTO_state_observed=False,
    full_tcp_complete=False,unbounded_protocol_proof=False,
    scope='two finite VM kernel active-open runs with an injected peer, including unanswered first SYN; not data/window/recovery or later protocols',
    retained_lwip_syn_loss_ms=2750,integrity_is_not_authenticity=True,
    trusts=['GitHub VM/job/artifact provenance','Linux kernel/toolchain','pinned packetdrill','independent tcpdump',
        'IR reference/SMT encoder','PCAP parser/normalizer/comparator','offline Python/Z3 evidence checkers']))
print('Two actual Linux scenarios accepted with strict time differences and explicit dynamic tool tolerance')
