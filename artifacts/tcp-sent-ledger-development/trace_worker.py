"""Isolate the unchanged full-byte fixed-trace encoder, with explicit model binding."""
import argparse
import importlib.util
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read
from protocol_lab.ir import load, require
from protocol_lab.symbolic import crosscheck_trace, model_hash
parser = argparse.ArgumentParser()
parser.add_argument('--model', type=Path, required=True)
parser.add_argument('--trace', type=Path, required=True)
parser.add_argument('--out', type=Path, required=True)
parser.add_argument('--model-hash', required=True)
parser.add_argument('--equivalent-to', type=Path)
args = parser.parse_args()
model = load(args.model)
require(model_hash(model) == args.model_hash, 'Worker model hash differs')
result = crosscheck_trace(model, read(args.trace), args.out)
require(result['status'] == 'match', 'Isolated fixed-trace query did not match')
if args.equivalent_to:
    from protocol_lab.flow import write
    spec = importlib.util.spec_from_file_location('worker_equivalence', ROOT / 'ports/lwip-stream/run.py')
    checker = importlib.util.module_from_spec(spec); spec.loader.exec_module(checker)
    equivalence = checker.query_equivalence(args.equivalent_to, args.out / 'path.smt2')
    write(args.out / 'equivalence.json', equivalence)
    require(equivalence['status'] == 'unsat', 'Fixed-query equivalence inconclusive or different')
print(result['status'])
