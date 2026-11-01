"""Validate a controller-recorded structural normalization without API calls."""
import argparse
import json
from pathlib import Path
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from agents.run_model_job import worker,write
from agents.repair_model_job import hostile_domain_checks
from protocol_lab.ir import load


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',required=True);a=p.parse_args();out=Path(a.out)
    try:
        write(out/'hostile-domain.json',hostile_domain_checks(load(out/'model.json')))
        result=worker(out/'model.json',out/'scenarios',out/'validation',3)
    except Exception as error:result=dict(status='failed',error_type=type(error).__name__,diagnosis=str(error))
    write(out/'status.json',result);print(json.dumps(result))
