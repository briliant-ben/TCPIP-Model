"""One independent process per real implementation run; retain all Differences."""
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
rows = []
for source in sorted((PORT / 'scenarios').glob('*.json')):
    out = HERE / source.stem
    write(HERE / 'execution-index.json', dict(status='incomplete', scenario=source.stem, completed=rows))
    command = [sys.executable, str(PORT / 'run.py'), '--scenario', str(source), '--out', str(out)]
    process = subprocess.run(command, capture_output=True, text=True, timeout=180)
    (out / 'generation.log').write_text(process.stdout + process.stderr)
    require(process.returncode in (0, 1), 'Independent service run failed: ' + source.stem)
    report = read(out / 'report.json')
    require(report['status'] in ('execution_and_projection_pass', 'executed_with_differences'), 'Execution incomplete')
    service = read(out / 'receiver-difference.json')
    rows.append(dict(id=source.stem, overall=report['comparison'], wire=read(out / 'difference.json')['status'],
        service=service['sent']['status'], expected_callbacks=service['sent']['expected'],
        actual_callbacks=service['sent']['observed'], report_sha256=digest(out / 'report.json'),
        command=command, returncode=process.returncode))
write(HERE / 'execution-index.json', dict(status='independent_service_executions_complete',
    scenarios=rows, linux_execution=False, universal_refinement=False,
    script_sha256=digest(HERE / 'rebuild.py')))
print(json.dumps(rows))
