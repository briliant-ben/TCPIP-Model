"""Build and run the live generated C99 TCP/IPv4 stack demo, capturing a real PCAP trace."""
import argparse
import json
import os
from pathlib import Path
import shutil
import struct
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'code'))
import build_stack  # noqa: E402


def _inspect_pcap(pcap_path: Path) -> dict:
    raw = pcap_path.read_bytes()
    if len(raw) < 24:
        raise ValueError('Truncated PCAP global header')
    magic, vmaj, vmin, _, _, _, linktype = struct.unpack('<IHHiIII', raw[:24])
    if magic != 0xA1B2C3D4 or (vmaj, vmin) != (2, 4) or linktype != 1:
        raise ValueError(f'Unexpected PCAP header: magic={hex(magic)} linktype={linktype}')
    off = 24
    counts = {'frames': 0, 'arp': 0, 'icmp': 0, 'udp': 0, 'tcp': 0, 'dhcp': 0, 'dns': 0}
    while off + 16 <= len(raw):
        _, _, incl_len, _ = struct.unpack('<IIII', raw[off:off + 16])
        off += 16
        frame = raw[off:off + incl_len]
        off += incl_len
        counts['frames'] += 1
        if len(frame) < 14:
            continue
        ethtype = struct.unpack('!H', frame[12:14])[0]
        if ethtype == 0x0806:
            counts['arp'] += 1
        elif ethtype == 0x0800 and len(frame) >= 34:
            ihl = (frame[14] & 0x0F) * 4
            proto = frame[23]
            l4 = frame[14 + ihl:]
            if proto == 1:
                counts['icmp'] += 1
            elif proto == 17 and len(l4) >= 8:
                counts['udp'] += 1
                sport, dport = struct.unpack('!HH', l4[:4])
                if {sport, dport} & {67, 68}:
                    counts['dhcp'] += 1
                if 53 in (sport, dport):
                    counts['dns'] += 1
            elif proto == 6:
                counts['tcp'] += 1
    return counts


def run_demo(out: Path) -> dict:
    out = out.resolve()
    if out.exists() or out.is_relative_to(ROOT):
        raise ValueError(f'Use a fresh output directory outside {ROOT}: {out}')
    lib_dir = out / 'lib'
    build_res = build_stack.build_stack(lib_dir)

    cc = os.environ.get('CC') or shutil.which('cc')
    bin_path = out / 'stack-live-driver'
    cmd = [
        cc, '-std=c99', '-Wall', '-Wextra', '-Werror', '-Wsign-compare', '-Wtype-limits', '-O2',
        '-DFSA_HOST_NO_SYS=0', '-pthread',
        f'-I{ROOT / "code"}', f'-I{ROOT / "code/generated/stack"}',
        str(ROOT / 'demo/stack_live_driver.c'),
        build_res['posix_archive'],
        '-o', str(bin_path),
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        raise ValueError(f'Driver compile failed:\n{proc.stdout}\n{proc.stderr}')

    pcap_path = out / 'stack-live.pcap'
    run_proc = subprocess.run([str(bin_path), str(pcap_path)], capture_output=True, text=True, timeout=30)
    if run_proc.returncode != 0:
        raise ValueError(f'Driver run failed:\n{run_proc.stdout}\n{run_proc.stderr}')
    driver_json = json.loads(run_proc.stdout.strip())
    counts = _inspect_pcap(pcap_path)
    for key in ('arp', 'icmp', 'dhcp', 'dns', 'udp', 'tcp'):
        if counts[key] < 2:
            raise ValueError(f'Expected >= 2 {key} frames in PCAP, got {counts}')

    tcpdump_lines = []
    tcpdump = shutil.which('tcpdump')
    if tcpdump:
        td = subprocess.run([tcpdump, '-nn', '-r', str(pcap_path)], capture_output=True, text=True, timeout=15)
        if td.returncode == 0:
            tcpdump_lines = td.stdout.strip().splitlines()
            (out / 'tcpdump.txt').write_text(td.stdout, encoding='utf-8')

    summary = {
        'schema': 'tcpip-stack-live-demo-v1',
        'status': 'pass',
        'pcap': str(pcap_path),
        'driver': driver_json,
        'protocol_frame_counts': counts,
        'tcpdump_decoded_frames': len(tcpdump_lines),
    }
    (out / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n', encoding='utf-8')
    return summary


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    try:
        res = run_demo(args.out)
        print(json.dumps(res))
        return 0
    except Exception as exc:
        print(json.dumps({'status': 'rejected', 'reason': str(exc)}), file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
