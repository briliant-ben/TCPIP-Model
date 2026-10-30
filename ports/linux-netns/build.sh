#!/usr/bin/env bash
set -euo pipefail
task_root="$(cd -- "$(dirname -- "$0")/../.." && pwd)"
task_out="$task_root/artifacts/linux-netns"
mkdir -p "$task_out"
task_source="$(mktemp -d "${RUNNER_TEMP:-/tmp}/protocol-packetdrill-XXXXXXXX")"
task_pin="$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1]))["commit"])' "$task_root/ports/linux-netns/upstream.json")"
git clone --no-checkout https://github.com/google/packetdrill.git "$task_source" > "$task_out/tool-clone.log" 2>&1
git -C "$task_source" checkout --detach "$task_pin" >> "$task_out/tool-clone.log" 2>&1
(
  cd "$task_source/gtests/net/packetdrill"
  ./configure > "$task_out/tool-configure.log" 2>&1
  make -j2 > "$task_out/tool-build.log" 2>&1
)
cc --version > "$task_out/compiler.log"
python3 - "$task_source" "$task_out" "$task_pin" <<'PY'
import hashlib,json,pathlib,subprocess,sys,shutil
source,out,pin=map(str,sys.argv[1:]); out=pathlib.Path(out)
head=subprocess.check_output(['git','-C',source,'rev-parse','HEAD'],text=True).strip()
assert head==pin
subprocess.run(['git','-C',source,'diff','--exit-code','--','*.c','*.h','*.y','*.l'],check=True)
binary=pathlib.Path(source)/'gtests/net/packetdrill/packetdrill'
value=dict(repository='https://github.com/google/packetdrill.git',commit=head,
    source_root=source,binary=str(binary),binary_sha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
    modified_upstream_code=False,commands=['./configure','make -j2'],
    compiler_path=shutil.which('cc'),compiler_sha256=hashlib.sha256(pathlib.Path(shutil.which('cc')).read_bytes()).hexdigest(),
    file_hashes={n:hashlib.sha256((out/n).read_bytes()).hexdigest() for n in ['tool-clone.log','tool-configure.log','tool-build.log','compiler.log']})
(out/'tool-build.json').write_text(json.dumps(value,indent=2)+'\n')
PY
