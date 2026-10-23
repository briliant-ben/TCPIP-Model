import argparse
import json
from pathlib import Path
import sys

from .flow import ROOT, build, digest, read, run_packetdrill, write
from .ir import ModelError, load
from .explore import explore
from .packets import compare


def main():
    parser = argparse.ArgumentParser(description="Protocol modeling flow lab")
    sub = parser.add_subparsers(dest="command", required=True)
    p = sub.add_parser("build", help="Run the local slice and generate evidence")
    p.add_argument("--out", type=Path, default=ROOT / "artifacts")
    sub.add_parser("validate")
    p = sub.add_parser("check", help="Bounded safety exploration, not an Ivy proof")
    p.add_argument("--out", type=Path, default=ROOT / "artifacts/bounded-check.json")
    p = sub.add_parser("run-packetdrill")
    p.add_argument("script", type=Path)
    p.add_argument("--out", type=Path, required=True)
    p = sub.add_parser("suite", help="Execute all declared protocol profiles and report missing stack modules")
    p.add_argument("--out", type=Path, default=ROOT / "artifacts/suite")
    p.add_argument("--formal", action="store_true")
    p.add_argument("--depth", type=int, default=6)
    p = sub.add_parser("suite-verify", help="Check profile input and output hashes without claiming full-stack acceptance")
    p.add_argument("--out", type=Path, default=ROOT / "artifacts/suite")
    for name in ("lwip", "lwip-verify"):
        p = sub.add_parser(name, help="Run/verify the pinned lwIP implementation over an in-memory IPv4 interface")
        p.add_argument("--artifacts", type=Path, default=ROOT / "artifacts")
    p = sub.add_parser("formal", help="Independent Z3 bounded check with replay")
    p.add_argument("--artifacts", type=Path, default=ROOT / "artifacts")
    p.add_argument("--depth", type=int, default=6)
    p = sub.add_parser("observe", help="Decode, normalize and bind a PCAP to a built scenario")
    p.add_argument("pcap", type=Path)
    p.add_argument("--profile", type=Path, required=True)
    p.add_argument("--scenario", required=True)
    p.add_argument("--artifacts", type=Path, default=ROOT / "artifacts")
    p.add_argument("--origin", choices=("unverified", "synthetic", "external_capture"), default="unverified")
    p.add_argument("--checksum-policy", choices=("strict", "record_offload"), default="strict")
    p = sub.add_parser("assess", help="Verify evidence hashes and scenario acceptance gates")
    p.add_argument("--artifacts", type=Path, default=ROOT / "artifacts")
    p.add_argument("--scenario", action="append")
    p = sub.add_parser("compare", help="Compare an independently normalized observation")
    p.add_argument("expected", type=Path)
    p.add_argument("observed", type=Path)
    p.add_argument("--tolerance-ms", type=int, default=50)
    p.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()
    try:
        if args.command == "build":
            result = build(args.out)
            print(f"{result['flow_status']}: {len(result['scenarios'])} scenarios; {args.out / 'report.json'}")
        elif args.command == "suite":
            from .profiles import run_suite
            result = run_suite(args.out, args.formal, args.depth)
            print(f"{result['status']}; {len(result['implemented_profiles'])} profiles; {args.out / 'report.json'}")
            return 1 if result["status"] == "fail" else 0
        elif args.command == "suite-verify":
            from .profiles import verify_suite
            result = verify_suite(args.out)
            print(f"{result['status']}; {args.out / 'verification.json'}")
        elif args.command in ("lwip", "lwip-verify"):
            from .lwip import run_lwip, verify_lwip
            result = run_lwip(args.artifacts) if args.command == "lwip" else verify_lwip(args.artifacts)
            print(f"{result['status']}; {args.artifacts / 'lwip/report.json'}")
            return 1 if result["status"] == "executed_with_differences" else 0
        elif args.command == "validate":
            load(ROOT / "model/tcp.json")
            print("IR validation passed")
        elif args.command == "check":
            result = explore(load(ROOT / "model/tcp.json"), read(ROOT / "model/exploration.json"))
            args.out.parent.mkdir(parents=True, exist_ok=True)
            write(args.out, result)
            print(f"{result['status']}; {len(result['uncovered'])} model coverage gaps; {args.out}")
            return int(result["status"] == "fail")
        elif args.command == "run-packetdrill":
            result = run_packetdrill(args.script, args.out)
            print(json.dumps(result, ensure_ascii=False))
            return 0 if result["status"] == "pass" else 2
        elif args.command == "compare":
            result = compare(read(args.expected), read(args.observed), args.tolerance_ms)
            result["observation_source"] = str(args.observed.resolve())
            args.out.parent.mkdir(parents=True, exist_ok=True)
            write(args.out, result)
            print(f"{result['status']}; {args.out}")
            return int(result["status"] != "match")
        elif args.command == "formal":
            from .evidence import ensure_snapshot
            from .symbolic import check
            ensure_snapshot(args.artifacts)
            target = args.artifacts / "formal"
            target.mkdir(exist_ok=True)
            write(target / "result.json", {"status": "incomplete"})
            result = check(load(ROOT / "model/tcp.json"), depth=args.depth, out=target)
            result["build_sha256"] = digest(args.artifacts / "report.json")
            write(target / "result.json", result)
            print(f"{result['status']}; Z3 depth={args.depth}; {target / 'result.json'}")
            return 0 if result["status"] == "bounded_pass" else 2
        elif args.command == "observe":
            from .evidence import observe
            result = observe(args.artifacts, args.scenario, args.pcap, read(args.profile), args.origin, args.checksum_policy)
            print(f"{result['status']}; origin={result['origin']}; {args.artifacts / args.scenario / 'observation/evidence.json'}")
            return 0 if result["status"] == "match" else 1
        elif args.command == "assess":
            from .evidence import assess
            result = assess(args.artifacts, args.scenario)
            print(f"{result['status']}; {args.artifacts / 'acceptance.json'}")
            return 0 if result["status"] == "selected_scenarios_closed_loop_pass" else 2
    except (ValueError, KeyError, TypeError, OSError) as exc:
        if args.command == "build":
            args.out.mkdir(parents=True, exist_ok=True)
            write(args.out / "report.json", {"flow_status": "fail", "error": str(exc)})
        print(f"ERROR: {exc}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
