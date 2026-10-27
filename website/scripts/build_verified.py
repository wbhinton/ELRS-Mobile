"""Build website/src/data/verified.json from an analytics export.

A target counts as verified once it has at least one successful flash. Names
are ExpressLRS `product_name` values, matching assets/targets.json.

Usage (CSV columns: hardware_target, successful_flashes, first_flash, last_flash):
    python3 website/scripts/build_verified.py verified_hardware.csv
"""

import csv
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "website/src/data/verified.json"
IGNORED = {"Unknown"}


def main(csv_path):
    with open(csv_path, newline="") as f:
        rows = list(csv.DictReader(f))

    # Flashes of unidentified hardware still count toward the total, not as targets.
    flashed = [r for r in rows if int(r["successful_flashes"]) >= 1]
    data = {
        "asOf": max(r["last_flash"] for r in flashed),
        "totalSuccessfulFlashes": sum(int(r["successful_flashes"]) for r in flashed),
        "targets": sorted({r["hardware_target"] for r in flashed} - IGNORED, key=str.lower),
    }
    OUT.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n")
    print(f"{len(data['targets'])} verified targets, {data['totalSuccessfulFlashes']} flashes -> {OUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else ROOT / "verified_hardware.csv")
