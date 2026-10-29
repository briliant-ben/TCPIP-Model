"""Reconstruct each oracle/query and check exported full-byte queries separately."""
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('timer_verify_all', ROOT / 'ports/lwip-timers/run.py')
driver = importlib.util.module_from_spec(spec)
spec.loader.exec_module(driver)
program = ('import z3,sys,json;s=z3.Solver();s.set(timeout=60000);'
           's.add(z3.parse_smt2_file(sys.argv[1]));a=s.check();'
           'print(json.dumps(dict(status=str(a),version=z3.get_version_string())))')
rows = []
for scene in sorted((driver.PORT / 'scenarios').glob('*.json')):
    out = HERE / scene.stem
    result = driver.verify(out, scene)
    command = [sys.executable, '-c', program, str(out / 'symbolic/path.smt2')]
    process = subprocess.run(command, capture_output=True, text=True, timeout=90)
    assert process.returncode == 0, process.stderr
    answer = json.loads(process.stdout)
    assert answer['status'] == 'sat'
    row = dict(scenario=scene.stem, verification=result,
               independent_exported_query=answer, command=command,
               report_sha256=driver.stream.digest(out / 'report.json'))
    driver.stream.write(out / 'verification.json', row)
    rows.append(row)
    print(scene.stem, result['comparison'], flush=True)
driver.stream.write(HERE / 'verification.json', dict(
    status='valid_finite_independent_lwip_timer_observations', scenarios=rows,
    verifier_sha256=driver.stream.digest(Path(__file__)),
    linux_execution=False, full_stack_complete=False))
