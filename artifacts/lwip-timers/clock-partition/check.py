"""Re-execute the same real binary with split TICK commands; compare raw PCAP."""
import importlib.util
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('timer_clock_check', ROOT / 'ports/lwip-timers/run.py')
driver = importlib.util.module_from_spec(spec)
spec.loader.exec_module(driver)
base = ROOT / 'artifacts/lwip-timers/unacknowledged-backoff'
scene = driver.PORT / 'scenarios/unacknowledged-backoff.json'
verification = driver.verify(base, scene)
report = driver.stream.read(base / 'report.json')
stimulus = (base / 'stimulus.txt').read_text()
assert stimulus.count('12000 TICK\n') == 1
fine = stimulus.replace('12000 TICK\n', ''.join(f'{t} TICK\n' for t in range(250, 12001, 250)))
assert len(fine.splitlines()) <= 64
(HERE / 'fine-stimulus.txt').write_text(fine)
command = [str(base / 'lwip-harness'), str(HERE / 'fine-capture.pcap'), str(HERE / 'fine-stimulus.txt')]
process = subprocess.run(command, capture_output=True, text=True, timeout=10)
(HERE / 'execution.log').write_text(process.stdout + process.stderr)
assert process.returncode == 0, process.stderr
summary = json.loads(process.stdout)
assert summary['end_ms'] == 12000 and summary['clock_step_ms'] == 1
assert summary['clock_checks'] == 12000 + len(fine.splitlines())
assert (HERE / 'fine-capture.pcap').read_bytes() == (base / 'capture.pcap').read_bytes()
result = dict(status='bounded_driver_clock_partition_matches_raw_capture',
              scope='same fixed real-binary stimulus apart from explicit TICK partition; not universal scheduler/protocol proof',
              coarse_scenario=str(scene.relative_to(ROOT)), coarse_verification=verification,
              coarse_report_sha256=driver.stream.digest(base / 'report.json'),
              coarse_capture_sha256=driver.stream.digest(base / 'capture.pcap'),
              input_hashes=report['input_hashes'], binary_sha256=report['binary_sha256'],
              command=command, summary=summary, linux_execution=False,
              full_stack_complete=False,
              file_hashes={n: driver.stream.digest(HERE / n) for n in
                           ['check.py', 'fine-stimulus.txt', 'fine-capture.pcap', 'execution.log']})
driver.stream.write(HERE / 'result.json', result)
print(json.dumps({k: result[k] for k in ['status', 'coarse_capture_sha256', 'summary']}))
