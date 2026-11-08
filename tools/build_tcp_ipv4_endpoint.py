#!/usr/bin/env python3
"""Build the finite TCP/IPv4 endpoint IR model from pinned components.

Reads two pre-lowered component models, lowers, namespaces, merges, verifies
canonical semantic hashes at each stage, couples the approved TCP link logic,
and writes the final JSON exactly as committed.
"""
import argparse
import copy
import hashlib
import json
import sys
from pathlib import Path

# Ensure repository root is on sys.path when running from arbitrary CWD.
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from protocol_lab.compose.disjoint_union import merge_disjoint_components
from protocol_lab.compose.lower_component_state import lower_component_state
from protocol_lab.compose.namespace_component import namespace_component
from protocol_lab.compose.tcp_link import couple_tcp
from protocol_lab.ir import load
from protocol_lab.symbolic import model_hash

BASE_DIR = Path(__file__).resolve().parent.parent
COMPONENT_PATHS = {
    "ipv4-udp-icmp": BASE_DIR / "model/ipv4-udp-icmp-endpoint.json",
    "tcp-wire": BASE_DIR / "model/tcp-wire-endpoint.json",
}
OUTPUT_DEFAULT = BASE_DIR / "model/tcp-ipv4-endpoint.json"

# Approved canonical semantic SHA256 bindings for pinned inputs and outputs.
APPROVED_COMPONENT_SHA = {
    "ipv4-udp-icmp": "ab315577e4149d9fe8f969b335954a00bba29af8c24a3fb870e9ba06873b537e",
    "tcp-wire": "6c45feb2760edb3b125165061d5077bd57d1fcd1f0195b3f61053f9a951bc0af",
}
APPROVED_ASSEMBLED_BASE_SHA = "70aaa4a55b7b0c17cd0ad7147c9d46b8285716117a6e92e928c51f0888d3e540"
APPROVED_OUTPUT_SHA = "d70dab238d34ba667ac356f1c7119c09f49ddb9fc62ea5b6aa1d0aa53d74a0b1"
APPROVED_OUTPUT_FILE_SHA = "d8c99c333b287657e028b8a367b1f46f7e523e2cd30fbb9037056b11f8ed1e87"


def _read_component(name):
    """Load a component model using the IR loader (resolves overlays)."""
    return load(COMPONENT_PATHS[name])


def _check_expression_based_t_control(model):
    """Reject any T.control assignment that is not a literal string.

    The couple_tcp transform relies on literal `'CLOSED'` detection to inject
    pending owner cleanup. Expression-based assignments would silently break
    this and are unsupported for the pinned profile.
    """
    for tr in model["transitions"]:
        for act in tr.get("actions", []):
            if (isinstance(act, dict) and "set" in act
                    and act["set"].get("var") == "T.control"
                    and not isinstance(act["set"].get("value"), str)):
                raise ValueError(
                    f"unsupported expression-based T.control assignment in transition {tr['id']}"
                )


def build_model():
    """Build and return the coupled TCP/IPv4 endpoint model dict."""
    # Step 1: load and verify raw component semantic hashes.
    raw_components = {}
    for name, expected_sha in APPROVED_COMPONENT_SHA.items():
        component = _read_component(name)
        actual_sha = model_hash(component)
        if actual_sha != expected_sha:
            raise ValueError(
                f"component {name} semantic hash mismatch: expected {expected_sha}, got {actual_sha}"
            )
        raw_components[name] = component

    # Step 2: lower each component into a single COMPOSED state with control variable.
    lowered = {}
    lowered["ipv4-udp-icmp"] = lower_component_state(
        raw_components["ipv4-udp-icmp"], "control", "COMPOSED"
    )
    lowered["tcp-wire"] = lower_component_state(
        raw_components["tcp-wire"], "control", "COMPOSED"
    )

    # Step 3: namespace each component with prefix L and T respectively.
    namespaced_L, _ = namespace_component(lowered["ipv4-udp-icmp"], "L")
    namespaced_T, _ = namespace_component(lowered["tcp-wire"], "T")

    # Step 4: merge disjoint components, verify assembled base hash.
    merged_base = merge_disjoint_components(
        [namespaced_L, namespaced_T],
        "finite-ipv4-tcp-udp-icmp-arp",
    )
    actual_assembled_sha = model_hash(merged_base)
    if actual_assembled_sha != APPROVED_ASSEMBLED_BASE_SHA:
        raise ValueError(
            f"assembled base semantic hash mismatch: expected {APPROVED_ASSEMBLED_BASE_SHA}, got {actual_assembled_sha}"
        )

    # Step 5: reject unsupported expression-based T.control assignments.
    _check_expression_based_t_control(merged_base)

    # Step 6: apply approved TCP link coupling transform.
    coupled = couple_tcp(merged_base)

    # Step 7: verify final output semantic hash.
    actual_output_sha = model_hash(coupled)
    if actual_output_sha != APPROVED_OUTPUT_SHA:
        raise ValueError(
            f"output semantic hash mismatch: expected {APPROVED_OUTPUT_SHA}, got {actual_output_sha}"
        )

    return coupled


def write_output(model, out_path):
    """Write the model to out_path only if the file hash matches approved."""
    text = json.dumps(model, indent=2) + "\n"
    file_sha = hashlib.sha256(text.encode("utf-8")).hexdigest()
    if file_sha != APPROVED_OUTPUT_FILE_SHA:
        raise ValueError(
            f"output file hash mismatch: expected {APPROVED_OUTPUT_FILE_SHA}, got {file_sha}"
        )
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(text, encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(description="Build TCP/IPv4 endpoint model.")
    parser.add_argument(
        "--out",
        type=Path,
        default=OUTPUT_DEFAULT,
        help="output path (default: %(default)s)",
    )
    args = parser.parse_args()
    model = build_model()
    write_output(model, args.out)
    print(f"Wrote {args.out}")


if __name__ == "__main__":
    main()
