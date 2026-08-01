#!/usr/bin/env python3
"""Render api/formula/*.json and api/cask/*.json via `brew info --json=v2`.

mise fetches these over raw.githubusercontent.com; brew evaluates platform
conditionals for the machine running this script.
"""

import json
import subprocess
import sys
from pathlib import Path

TAP = "himkt/tap"
ROOT = Path(__file__).parent.parent

FORMULA_STRIP = {"installed", "linked_keg", "pinned", "outdated"}
CASK_STRIP = {"installed", "installed_time", "outdated"}


def brew_info(args):
    out = subprocess.run(
        ["brew", "info", "--json=v2", *args],
        check=True,
        capture_output=True,
        text=True,
    ).stdout
    return json.loads(out)


def write(path, obj):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, indent=2, sort_keys=True) + "\n")
    print(f"Generated {path.relative_to(ROOT)}")


def main():
    formulas = sorted(p.stem for p in (ROOT / "Formula").glob("*.rb"))
    casks = sorted(p.stem for p in (ROOT / "Casks").glob("*.rb"))
    if not formulas and not casks:
        sys.exit("Error: no formulas or casks found — run from the tap repo")

    for name in formulas:
        entry = brew_info([f"{TAP}/{name}"])["formulae"][0]
        for key in FORMULA_STRIP:
            entry.pop(key, None)
        write(ROOT / "api" / "formula" / f"{name}.json", entry)

    for token in casks:
        entry = brew_info(["--cask", f"{TAP}/{token}"])["casks"][0]
        for key in CASK_STRIP:
            entry.pop(key, None)
        write(ROOT / "api" / "cask" / f"{token}.json", entry)


if __name__ == "__main__":
    main()
