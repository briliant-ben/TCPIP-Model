"""Aggregate independently qualified finite-prototype channels; no new protocol verdict."""
from pathlib import Path
import argparse
import hashlib
import json
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from protocol_lab.codegen import render
from protocol_lab.ir import load

sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
read = lambda p: json.loads(Path(p).read_text())


def report():
    base = ROOT / 'artifacts/ipv4-directed-coverage-20261110'
    final = ROOT / 'artifacts/ipv4-prototype-delivery-20261112'
    model_path = ROOT / 'model/ipv4-endpoint-virtual-link.json'
    delivery = read(final / 'original-delivery-recheck.json')
    assert delivery['status'] == 'finite_ipv4_prototype_delivery_pass'
    assert sha(model_path) == delivery['model_file_sha256']
    generated = render(load(model_path))
    assert hashlib.sha256(generated.encode()).hexdigest() == delivery['generated_C_sha256']
    coverage = read(base / 'subset-delivery.json')['coverage']
    assert len(coverage['covered_default']) == 102 and len(coverage['declared_rule_ids']) == 335
    ack = read(base / 'ack-certificate-readonly-audit.json')
    witness = read(base / 'nonvacuity-witness-readonly-audit.json')
    assert ack['status'] == 'readonly_body_audit_pass' and ack['additional_sufficient_certificates'] == 3
    assert witness['status'] == 'pass' and witness['new_separate_SAT_witnesses'] == 13
    assert ack['whole_flow_status'] == witness['whole_flow'] == delivery['flow_assessment'] == 'unresolved'
    assert len(ack['checks']) == 3 and len(witness['checks']) == 13
    for archive, audit in [('ack-proof-chain-0216.tar.gz', ack), ('nonvacuity-observed-0220.tar.gz', witness)]:
        assert sha(base / archive) == audit['archive_sha256']
    inputs = [model_path, final / 'original-delivery-recheck.json', final / 'original-git-source-bindings.json', base / 'subset-delivery.json', base / 'rule-matrix-102.json', base / 'ack-certificate-readonly-audit.json', base / 'nonvacuity-witness-readonly-audit.json']
    return dict(
        schema='finite-ipv4-prototype-summary-v1', status='finite_ipv4_prototype_delivery_pass',
        model_file_sha256=delivery['model_file_sha256'], generated_C_sha256=delivery['generated_C_sha256'],
        support='fixed single-peer Ethernet/ARP, atomic IPv4 MTU1500, UDP, ICMP Echo, finite TCP buffer16/SMSS4; no upper protocols',
        pipeline='spec -> Protocol IR -> reference/independent Z3 -> generated tests -> standalone generated C -> raw peer/PCAP/trace -> Difference/spec traceability',
        base_channels=dict(reference_native_cases=77, initialized_depth1_negative_UNSAT=563, initialized_witness_SAT_replay=True, delivery_rechecked_with_original_git_core=True, fresh_protocol_or_solver_run=False),
        supplements=dict(default_initial_paths=24, transitions=157, execution_rules=102, declared_rules=335, unobserved_not_unreachable=233),
        declared_preservation=dict(original_direct_UNSAT=332, original_UNKNOWN=3, new_sufficient_certificates=3, scope='defined-transition declared invariants only, includes vacuous disabled branches; not scheduler/wire/compiler/full protocol'),
        nonvacuity=dict(original_SAT=161, original_UNSAT_disabled=11, original_UNKNOWN=163, new_separate_SAT_witnesses=13, with_SAT_certificate=174, without_SAT_certificate=150, default_reachability_not_claimed_for_arbitrary_SAT=True),
        live=dict(captured=25, dropped=0, same_generated_C_process=True, scope='retained independent Linux peers on virtual Ethernet; no new network execution', original_zip_sha256=delivery['live']['original_sha256']),
        generic_flow_assessment='unresolved', old_unknown_and_differences_preserved=True,
        excluded=['dynamic routing', 'IPv4 fragmentation/reassembly', 'general TCP congestion/recovery/options', 'sockets', 'IPv6', 'upper application protocols', 'physical Ethernet qualification', 'unbounded/compiler/English-spec correctness proof'],
        framework_repository='https://github.com/briliant-ben/Formal-Spec-Agent', framework_started=False,
        trust='original controlled execution/CI provenance; current source/hash/body/reference/witness audits, with Z3 and IR encoding trusted; no execution attestation from hashes alone',
        input_sha256={str(p.relative_to(ROOT)): sha(p) for p in inputs})


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path)
    args = parser.parse_args()
    result = report()
    text = json.dumps(result, indent=2) + '\n'
    if args.out:
        args.out.write_text(text)
    print(text)
