"""Bind one actual CI kernel run, offline checks and semantic fault controls."""
import hashlib
from pathlib import Path
import sys
import zipfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from protocol_lab.flow import read,write,digest
from protocol_lab.ir import require
HERE=Path(__file__).resolve().parent
out=HERE/'download'; provenance=read(HERE/'provenance.json')
artifact=provenance['artifact']
require(provenance['conclusion']=='success' and artifact['workflow_run']['id']==provenance['workflow_run_id'],
    'CI provenance differs')
require(artifact['workflow_run']['head_sha']==provenance['head_sha'] and not artifact['expired'],'CI source/availability differs')
require('sha256:'+digest(HERE/'workflow-artifact.zip')==artifact['digest'],'GitHub archive digest differs')
with zipfile.ZipFile(HERE/'workflow-artifact.zip')as archive:
    for member in archive.infolist():
        path=Path(member.filename)
        require(not path.is_absolute() and '..'not in path.parts,'Unsafe archive member')
        if not member.is_dir():require((out/path).read_bytes()==archive.read(member),'Original CI member changed')
report=read(out/'report.json');runtime=read(out/'runtime-verification.json');offline=read(out/'offline-verification.json')
require(report['linux_execution'] and report['host_tcp_stack'] and not report['full_tcp_complete'],'Linux scope changed')
require(runtime['status']=='valid_linux_runtime_evidence' and runtime['report_sha256']==digest(out/'report.json')
    and runtime['tool_binary_rechecked_locally'] and runtime['query_equivalence']=='unsat','CI runtime gate missing')
require(offline['status']=='valid_retained_linux_snapshot_bindings' and not offline['tool_binary_rechecked_locally']
    and offline['report_sha256']==digest(out/'report.json') and offline['query_equivalence']=='unsat','Offline gate missing')
require(runtime['checker_sha256']==offline['checker_sha256']==digest(ROOT/'ports/linux-netns/verify.py'),'Checker changed')
for name,sha in report['input_hashes'].items():require(digest(ROOT/name)==sha,'Current source differs from named CI checkpoint')
for name,sha in report['file_hashes'].items():require(digest(out/name)==sha,'CI evidence member changed')
for verification in [runtime,offline]:
    for name,sha in verification['file_hashes'].items():require(digest(out/name)==sha,'Independent query artifact changed')
negative=read(HERE/'negative-controls.json')
require(negative['status']=='four_offline_semantic_faults_rejected' and len(negative['tests'])==4
    and not negative['new_linux_execution'] and negative['original_evidence_unchanged'],'Fault controls incomplete')
for row in negative['tests']:require(digest(HERE/(row['fault']+'-rejected.log'))==row['log_sha256'],'Fault log changed')
namespace=read(out/'namespace.json');metadata=read(out/'metadata.json')
require(namespace['capture_packet_limit']is None and namespace['quiet_interval_complete']
    and report['observed_window_ms']>=namespace['declared_settle_ms']==5010,'Quiet window incomplete')
write(HERE/'acceptance.json',dict(status='one_real_linux_kernel_active_open_and_quiet_window_evidence_accepted',
    linux_execution_evidence=True,new_linux_execution=False,kernel=report['kernel'],
    source_head=provenance['head_sha'],ci_run=provenance['workflow_run_id'],job=provenance['job_id'],
    model_semantic_sha256=report['model_semantic_sha256'],tool_source_commit=report['source_commit'],
    observed_window_ms=report['observed_window_ms'],declared_window_ms=5010,
    selected_packets=metadata['selected_packets'],checksum_policy=metadata['checksum_policy'],
    projection='active-open-v1',oracle_tolerance_ms=0,difference=read(out/'difference.json'),
    scope='one kernel active-open plus finite quiet interval; injected peer; VM and isolated network namespace',
    raw_capture_sha256=digest(out/'capture.pcap'),runtime_verification_sha256=digest(out/'runtime-verification.json'),
    offline_verification_sha256=digest(out/'offline-verification.json'),negative_controls_sha256=digest(HERE/'negative-controls.json'),
    local_linux_rerun=False,local_CI_binary_recheck=False,internal_RTO_state_observed=False,
    full_tcp_complete=False,unbounded_protocol_proof=False,physical_NIC_or_remote_loss_test=False,
    excluded=['TCP data/window/options/payload/recovery and later protocols','universal implementation refinement'],
    trusted_components=report['trusted_components']+['GitHub VM/job/artifact provenance'],
    integrity_is_not_authenticity=True,artifact_zip_sha256=digest(HERE/'workflow-artifact.zip'),
    input_hashes=report['input_hashes']))
print('One real Linux active-open plus5010ms quiet observation accepted; strict Differences retained')
