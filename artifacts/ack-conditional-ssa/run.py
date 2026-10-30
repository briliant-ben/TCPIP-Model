"""Reproduce both queries in a fresh directory, preserving the retained bundle."""
import argparse
import importlib.util
from pathlib import Path

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--out',type=Path,required=True)
    out=p.parse_args().out.resolve()
    if out.exists():raise ValueError('Use a fresh evidence directory')
    out.mkdir(parents=True)
    spec=importlib.util.spec_from_file_location('retained_ack_ssa_producer',Path(__file__).with_name('producer-run.py'))
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    module.OUT=out
    module.main()
