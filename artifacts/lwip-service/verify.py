"""Reconstruct every real observation in a fresh checker process, plus SAT export."""
from pathlib import Path
import json
import subprocess
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import require
HERE = Path(__file__).resolve().parent
PORT = ROOT / 'ports/lwip-service'
index = read(HERE / 'execution-index.json')
require(index['status'] == 'independent_service_executions_complete', 'Executions incomplete')
rows = []
for entry in index['scenarios']:
    name = entry['id']; out = HERE / name; scene = PORT / 'scenarios' / (name + '.json')
    require(digest(out / 'report.json') == entry['report_sha256'], 'Report changed')
    command = [sys.executable, str(PORT / 'run.py'), '--verify', '--scenario', str(scene), '--out', str(out)]
    process = subprocess.run(command, capture_output=True, text=True, timeout=180)
    (out / 'verification.log').write_text(process.stdout + process.stderr)
    require(process.returncode == 0, 'Independent verification failed: ' + name + process.stderr)
    result = json.loads(process.stdout)
    require(result['query_equivalence']['status'] == 'unsat', 'Query equivalence did not pass')
    program = 'import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
    exported = subprocess.run([sys.executable, '-c', program, str(out / 'symbolic/path.smt2')],
                              capture_output=True, text=True, timeout=20)
    require(exported.returncode == 0 and exported.stdout.strip() == 'sat', 'Exported query not SAT: ' + name)
    rows.append(dict(id=name, verification=result, independent_export='sat', command=command,
        log_sha256=digest(out / 'verification.log'), report_sha256=digest(out / 'report.json')))
write(HERE / 'verification.json', dict(status='valid_independent_public_sent_observations', scenarios=rows,
    index_sha256=digest(HERE / 'execution-index.json'), checker_sha256=digest(HERE / 'verify.py'),
    linux_execution=False, universal_refinement=False))
print(json.dumps({'status': 'valid_independent_public_sent_observations', 'scenarios': len(rows)}))
