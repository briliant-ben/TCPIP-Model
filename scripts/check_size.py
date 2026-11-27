"""Verify compiled static library object section sizes."""
import glob
import subprocess
import sys

MAX_NOSYS_TEXT = 92160  # 90 KiB target for core L2-L4 (-Os)


def measure(pattern: str, label: str) -> tuple[int, int, int]:
    objs = sorted(glob.glob(pattern))
    if not objs:
        raise SystemExit(f"No object files matched {pattern}")
    out = subprocess.check_output(["size"] + objs, text=True).strip().splitlines()
    total_text = total_data = total_bss = 0
    print(f"=== {label} ===")
    for line in out[1:]:
        parts = line.split()
        if len(parts) < 4:
            continue
        t, d, b = int(parts[0]), int(parts[1]), int(parts[2])
        total_text += t
        total_data += d
        total_bss += b
        name = parts[-1].rsplit("/", 1)[-1]
        print(f"  {name:20s} text={t:6d} data={d:5d} bss={b:7d}")
    print(
        f"TOTAL {label}: text={total_text} B ({total_text / 1024:.2f} KiB), "
        f"data={total_data} B, bss={total_bss} B"
    )
    return total_text, total_data, total_bss


def main() -> int:
    nt, _, _ = measure("build/obj_nosys/*.o", "libtcpip_nosys.a")
    measure("build/obj_posix/*.o", "libtcpip_posix.a")
    if nt > MAX_NOSYS_TEXT:
        print(f"FAIL: Core L2-L4 .text {nt} B exceeds {MAX_NOSYS_TEXT} B (90 KiB)", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
