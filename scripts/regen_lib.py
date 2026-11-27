"""Deterministically regenerate all modular C99 FSMs under src/generated/ from model/."""
import argparse
import json
from pathlib import Path
import shutil
import sys

ROOT = Path(__file__).resolve().parents[1]

MODULES = (
    ('model/arch/sys_port.json', 'sys_port_fsm', 256, 2048),
    ('model/arch/pbuf_pool.json', 'pbuf_fsm', 256, 2048),
    ('model/arch/tcpip_actor.json', 'actor_fsm', 256, 2048),
    ('model/stack/arp_entry.json', 'arp_fsm', 256, 2048),
    ('model/stack/ip_reass_slot.json', 'ip_reass_fsm', 256, 2048),
    ('model/stack/tcp_pcb.json', 'tcp_fsm', 256, 2048),
    ('model/stack/dhcp_client.json', 'dhcp_fsm', 256, 2048),
    ('model/stack/dns_stub.json', 'dns_fsm', 256, 2048),
)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--framework', type=Path, required=True)
    p.add_argument('--byte-cap', type=int, default=256)
    p.add_argument('--verify', action='store_true', help='Verify committed src/generated matches fresh generation')
    args = p.parse_args()

    fw = args.framework.resolve()
    sys.path.insert(0, str(fw))
    from formal_spec_agent import codegen_lib  # noqa: E402

    dst = ROOT / 'src/generated'
    dst.mkdir(parents=True, exist_ok=True)
    summary = []

    for rel_model, prefix, byte_cap, arena_cap in MODULES:
        mpath = ROOT / rel_model
        if not mpath.is_file():
            continue
        tmp_out = ROOT / '.tmp-regen-lib' / prefix
        if tmp_out.exists():
            shutil.rmtree(tmp_out)
        tmp_out.parent.mkdir(parents=True, exist_ok=True)
        meta = codegen_lib.generate_lib(
            mpath, tmp_out, prefix=prefix, byte_cap=byte_cap,
            arena_cap=arena_cap, fast_dispatch=True, debug_names=True,
        )
        for fn in ('fsa_lib_runtime.h', f'{prefix}.h', f'{prefix}.c'):
            target = dst / fn
            new_bytes = (tmp_out / fn).read_bytes()
            if args.verify:
                if not target.is_file() or target.read_bytes() != new_bytes:
                    raise SystemExit(f'Drift detected in {target}')
            else:
                target.write_bytes(new_bytes)
        shutil.rmtree(tmp_out)
        summary.append({'prefix': prefix, 'rules': meta['rules'], 'switches': meta['decision_tree_switches']})

    tmp_parent = ROOT / '.tmp-regen-lib'
    if tmp_parent.exists():
        shutil.rmtree(tmp_parent)
    print(json.dumps({'status': 'pass', 'modules': summary}, indent=2))


if __name__ == '__main__':
    main()
