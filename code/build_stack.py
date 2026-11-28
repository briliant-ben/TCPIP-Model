"""Verify stack manifest digests, compile NOSYS & POSIX C99 libraries, check -Os size <= 90 KiB, and test FreeRTOS port."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
GEN_DIR = ROOT / 'code/generated/stack'
MAX_GENERATED_TEXT_BYTES = 90 * 1024  # 92,160 B

FREERTOS_STUBS = {
    'FreeRTOS.h': """#ifndef FREERTOS_STUB_H
#define FREERTOS_STUB_H
#include <stddef.h>
#include <stdint.h>
typedef uint32_t TickType_t;
typedef int BaseType_t;
typedef unsigned int UBaseType_t;
#define pdPASS 1
#define portMAX_DELAY ((TickType_t)0xFFFFFFFFUL)
#define portTICK_PERIOD_MS ((TickType_t)1U)
#define pdMS_TO_TICKS(ms) ((TickType_t)(ms))
#endif
""",
    'task.h': """#ifndef TASK_STUB_H
#define TASK_STUB_H
#include "FreeRTOS.h"
typedef void *TaskHandle_t;
typedef void (*TaskFunction_t)(void *);
TickType_t xTaskGetTickCount(void);
BaseType_t xTaskCreate(TaskFunction_t fn, const char *name, uint32_t depth,
                       void *arg, UBaseType_t prio, TaskHandle_t *out);
void vTaskDelete(TaskHandle_t task);
#endif
""",
    'semphr.h': """#ifndef SEMPHR_STUB_H
#define SEMPHR_STUB_H
#include "FreeRTOS.h"
typedef void *SemaphoreHandle_t;
SemaphoreHandle_t xSemaphoreCreateMutex(void);
SemaphoreHandle_t xSemaphoreCreateBinary(void);
BaseType_t xSemaphoreTake(SemaphoreHandle_t sem, TickType_t ticks);
BaseType_t xSemaphoreGive(SemaphoreHandle_t sem);
void vSemaphoreDelete(SemaphoreHandle_t sem);
#endif
""",
    'queue.h': """#ifndef QUEUE_STUB_H
#define QUEUE_STUB_H
#include "FreeRTOS.h"
typedef void *QueueHandle_t;
QueueHandle_t xQueueCreate(UBaseType_t len, UBaseType_t item_size);
void vQueueDelete(QueueHandle_t q);
#endif
""",
}


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify_manifest() -> dict:
    manifest = json.loads((GEN_DIR / 'manifest.json').read_text(encoding='utf-8'))
    recipe_path = ROOT / 'model' / manifest['recipe']
    if _sha256(recipe_path) != manifest['recipe_sha256']:
        raise ValueError(f'System recipe digest mismatch: {recipe_path}')
    for mid, mmeta in manifest['modules'].items():
        mpath = ROOT / 'model' / mmeta['model']
        if _sha256(mpath) != mmeta['model_sha256']:
            raise ValueError(f'Module {mid} model digest mismatch: {mpath}')
    for fname, expected in manifest['outputs'].items():
        fpath = GEN_DIR / fname
        if not fpath.is_file() or _sha256(fpath) != expected:
            raise ValueError(f'Generated output digest mismatch: {fname}')
    return manifest


def _measure_text_bytes(obj_files: list[Path]) -> tuple[int, dict[str, int]]:
    size_bin = shutil.which('size')
    if not size_bin:
        raise ValueError('Missing `size` binary in PATH')
    proc = subprocess.run([size_bin, *[str(p) for p in obj_files]], capture_output=True, text=True, check=True)
    per_obj: dict[str, int] = {}
    lines = [ln.strip() for ln in proc.stdout.splitlines() if ln.strip()]
    for ln in lines[1:]:
        parts = ln.split()
        if len(parts) >= 6 and parts[0].isdigit():
            name = Path(parts[-1]).name
            per_obj[name] = int(parts[0])
    if len(per_obj) != len(obj_files):
        raise ValueError(f'Unexpected `size` output:\n{proc.stdout}')
    return sum(per_obj.values()), per_obj


def build_stack(out: Path, cc: str = None, opt: str = '-Os', extra_cflags: str = '',
                run_size_check: bool = False, check_freertos: bool = False) -> dict:
    out = out.resolve()
    if out.exists() or out.is_relative_to(ROOT):
        raise ValueError(f'Use a fresh output directory outside {ROOT}: {out}')
    manifest = verify_manifest()

    compiler = cc or os.environ.get('CC') or shutil.which('cc')
    ar_bin = os.environ.get('AR') or shutil.which('ar')
    if not compiler or not ar_bin:
        raise ValueError('Both a C99 compiler (`cc`) and archiver (`ar`) are required')

    out.mkdir(parents=True)
    gen_c_sources = sorted(GEN_DIR.glob('*.c'))
    base_flags = [
        '-std=c99', '-Wall', '-Wextra', '-Werror', '-Wsign-compare', '-Wtype-limits',
        opt, f'-I{ROOT / "code"}', f'-I{GEN_DIR}',
        *shlex.split(extra_cflags),
    ]

    def compile_variant(name: str, mode_flags: list[str]) -> tuple[Path, list[Path]]:
        vdir = out / name
        vdir.mkdir(parents=True)
        gen_objs: list[Path] = []
        all_objs: list[Path] = []
        for src in [*gen_c_sources, ROOT / 'code/host_runtime.c']:
            obj = vdir / f'{src.stem}.o'
            cmd = [compiler, *base_flags, *mode_flags, '-c', str(src), '-o', str(obj)]
            proc = subprocess.run(cmd, capture_output=True, text=True)
            if proc.returncode != 0:
                raise ValueError(f'Compile failed ({name}/{src.name}):\n{proc.stdout}\n{proc.stderr}')
            all_objs.append(obj)
            if src.parent == GEN_DIR:
                gen_objs.append(obj)
        archive = out / f'libtcpip_stack_{name}.a'
        proc = subprocess.run([ar_bin, 'rcs', str(archive), *[str(o) for o in all_objs]],
                              capture_output=True, text=True)
        if proc.returncode != 0:
            raise ValueError(f'Archive failed ({archive.name}):\n{proc.stderr}')
        return archive, gen_objs

    nosys_lib, nosys_gen_objs = compile_variant('nosys', ['-DFSA_HOST_NO_SYS=1'])
    posix_lib, _ = compile_variant('posix', ['-DFSA_HOST_NO_SYS=0', '-pthread'])

    result = {
        'schema': 'tcpip-stack-build-v1',
        'status': 'pass',
        'compiler': compiler,
        'opt': opt,
        'recipe_sha256': manifest['recipe_sha256'],
        'nosys_archive': str(nosys_lib),
        'posix_archive': str(posix_lib),
        'generated_objects': len(nosys_gen_objs),
    }

    if run_size_check:
        total_text, per_obj = _measure_text_bytes(nosys_gen_objs)
        result['generated_text_bytes'] = total_text
        result['max_generated_text_bytes'] = MAX_GENERATED_TEXT_BYTES
        result['per_object_text_bytes'] = per_obj
        if total_text > MAX_GENERATED_TEXT_BYTES:
            raise ValueError(
                f'Generated -Os text size {total_text} B exceeds budget {MAX_GENERATED_TEXT_BYTES} B'
            )

    if check_freertos:
        stub_dir = out / 'freertos_stubs'
        stub_dir.mkdir(parents=True)
        for hname, hbody in FREERTOS_STUBS.items():
            (stub_dir / hname).write_text(hbody, encoding='utf-8')
        fr_obj = out / 'host_runtime_freertos.o'
        cmd = [
            compiler, *base_flags, '-DFSA_HOST_NO_SYS=0', '-DFSA_HOST_FREERTOS=1',
            f'-I{stub_dir}', '-c', str(ROOT / 'code/host_runtime.c'), '-o', str(fr_obj),
        ]
        proc = subprocess.run(cmd, capture_output=True, text=True)
        if proc.returncode != 0:
            raise ValueError(f'FreeRTOS stub compile failed:\n{proc.stdout}\n{proc.stderr}')
        result['freertos_port_object'] = str(fr_obj)

    verify_manifest()
    (out / 'build-summary.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    return result


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--cc', default=None)
    parser.add_argument('--opt', default='-Os')
    parser.add_argument('--extra-cflags', default='')
    parser.add_argument('--run-size-check', action='store_true')
    parser.add_argument('--check-freertos', action='store_true')
    args = parser.parse_args()
    try:
        res = build_stack(
            args.out, cc=args.cc, opt=args.opt, extra_cflags=args.extra_cflags,
            run_size_check=args.run_size_check, check_freertos=args.check_freertos,
        )
        print(json.dumps(res))
        return 0
    except (ValueError, OSError, subprocess.CalledProcessError) as exc:
        print(json.dumps({'status': 'rejected', 'reason': str(exc)}), file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
