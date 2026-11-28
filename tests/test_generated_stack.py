"""End-to-end tests for the model-generated 10-module C99 TCP/IPv4 stack."""
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'code'))
sys.path.insert(0, str(ROOT / 'demo'))
import build_stack  # noqa: E402
import stack_demo  # noqa: E402

FORBIDDEN_LWIP_RE = re.compile(r'\b(?:pbuf|memp|pcb|lwip_[A-Za-z0-9_]*)\b', re.IGNORECASE)


class GeneratedStackTests(unittest.TestCase):
    def test_pins_manifests_and_zero_lwip_naming(self):
        v1_code_pin = json.loads((ROOT / 'code/framework.json').read_text(encoding='utf-8'))
        v1_formal_pin = json.loads((ROOT / 'formal/framework.json').read_text(encoding='utf-8'))
        self.assertEqual(v1_code_pin['commit'], '500a9a3daf779c48a1678744e32521bc1fd5f2aa')
        self.assertEqual(v1_formal_pin['commit'], '500a9a3daf779c48a1678744e32521bc1fd5f2aa')

        stack_code_pin = json.loads((ROOT / 'code/stack_framework.json').read_text(encoding='utf-8'))
        stack_formal_pin = json.loads((ROOT / 'formal/stack/framework.json').read_text(encoding='utf-8'))
        self.assertEqual(stack_code_pin['commit'], stack_formal_pin['commit'])
        self.assertEqual(len(stack_formal_pin['modules']), 10)

        manifest = build_stack.verify_manifest()
        self.assertEqual(len(manifest['modules']), 10)

        scan_roots = [
            ROOT / 'spec/arch', ROOT / 'spec/stack',
            ROOT / 'model/arch', ROOT / 'model/stack', ROOT / 'model/tcpip-stack-system.json',
            ROOT / 'formal/stack',
            ROOT / 'code/generated/stack', ROOT / 'code/host_runtime.h', ROOT / 'code/host_runtime.c',
            ROOT / 'code/author_models.py', ROOT / 'code/build_stack.py', ROOT / 'code/regenerate_stack.py',
            ROOT / 'tests/stack_suite.c',
            ROOT / 'demo/stack_live_driver.c', ROOT / 'demo/stack_demo.py', ROOT / 'demo/stack_bench.c',
        ]
        for entry in scan_roots:
            files = [entry] if entry.is_file() else [
                p for p in entry.rglob('*')
                if p.is_file() and p.suffix in ('.c', '.h', '.py', '.json', '.md', '.lean')
            ]
            for fpath in files:
                txt = fpath.read_text(encoding='utf-8')
                match = FORBIDDEN_LWIP_RE.search(txt)
                self.assertIsNone(match, f'Forbidden lwIP identifier {match and match.group(0)} in {fpath}')

    def test_size_budget_freertos_and_e2e_suites(self):
        cc = os.environ.get('CC') or shutil.which('cc')
        self.assertIsNotNone(cc)
        with tempfile.TemporaryDirectory(prefix='tcpip-stack-ut-') as tmp:
            troot = Path(tmp)
            fast_build = build_stack.build_stack(
                troot / 'fast', cc=cc, opt='-Os', run_size_check=True, check_freertos=True
            )
            self.assertEqual(fast_build['status'], 'pass')
            self.assertLessEqual(fast_build['generated_text_bytes'], 90 * 1024)

            strict_build = build_stack.build_stack(
                troot / 'strict', cc=cc, opt='-Os', extra_cflags='-DFSA_STRICT=1', check_freertos=True
            )
            self.assertEqual(strict_build['status'], 'pass')

            base_flags = [
                '-std=c99', '-Wall', '-Wextra', '-Werror', '-Wsign-compare', '-Wtype-limits',
                '-O2', f'-I{ROOT / "code"}', f'-I{ROOT / "code/generated/stack"}',
            ]
            # 1. NO_SYS=1 suite
            nosys_bin = troot / 'suite_nosys'
            subprocess.run(
                [cc, *base_flags, '-DFSA_HOST_NO_SYS=1', str(ROOT / 'tests/stack_suite.c'),
                 fast_build['nosys_archive'], '-o', str(nosys_bin)],
                check=True,
            )
            r_nosys = subprocess.run([str(nosys_bin)], capture_output=True, text=True, timeout=60, check=True)
            self.assertIn('ALL 8 STACK SUITE TESTS PASSED (NO_SYS=1)', r_nosys.stdout)

            # 2. NO_SYS=0 multi-threaded POSIX actor suite (with -DFSA_STRICT=1 runtime checks!)
            posix_bin = troot / 'suite_posix_strict'
            subprocess.run(
                [cc, *base_flags, '-DFSA_STRICT=1', '-DFSA_HOST_NO_SYS=0', '-pthread',
                 str(ROOT / 'tests/stack_suite.c'), strict_build['posix_archive'], '-o', str(posix_bin)],
                check=True,
            )
            r_posix = subprocess.run([str(posix_bin)], capture_output=True, text=True, timeout=60, check=True)
            self.assertIn('ALL 9 STACK SUITE TESTS PASSED (NO_SYS=0)', r_posix.stdout)

            # 3. Live PCAP demo
            demo_res = stack_demo.run_demo(troot / 'demo_out')
            self.assertEqual(demo_res['status'], 'pass')
            self.assertGreaterEqual(demo_res['protocol_frame_counts']['frames'], 20)

            # 4. -O2 benchmark
            bench_lib = build_stack.build_stack(troot / 'bench_lib', cc=cc, opt='-O2')
            bench_bin = troot / 'stack_bench'
            subprocess.run(
                [cc, *base_flags, '-DFSA_HOST_NO_SYS=1', str(ROOT / 'demo/stack_bench.c'),
                 bench_lib['nosys_archive'], '-o', str(bench_bin)],
                check=True,
            )
            r_bench = subprocess.run([str(bench_bin)], capture_output=True, text=True, timeout=60, check=True)
            bench_data = json.loads(r_bench.stdout.strip())
            self.assertGreater(bench_data['tcp_bulk_8mib_mbps'], 10.0)


if __name__ == '__main__':
    unittest.main()
