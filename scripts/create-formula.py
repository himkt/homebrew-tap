#!/usr/bin/env python3
import argparse
import hashlib
import urllib.error
import urllib.request
from pathlib import Path

TEMPLATE = """\
class {class_name} < Formula
  desc ""
  homepage "https://github.com/{repo}"
  license "MIT"

{os_blocks}
  def install
    bin.install "{name}"
  end
end
"""

OS_BLOCK = """\
  on_{os_type} do
{arch_blocks}  end"""

# `on_arm` / `on_intel` are evaluated per simulated platform, so `brew ruby
# scripts/generate-api.rb` can resolve every platform's artifact from any
# machine. `Hardware::CPU` reads the host CPU instead and would pin the whole
# api/ payload to the architecture that happened to generate it.
ARCH_BLOCK = """\
    on_{cpu} do
      url "{url}"
      sha256 "{sha}"
    end
"""

ARCHS = {
    "aarch64-apple-darwin": ("macos", "arm"),
    "x86_64-apple-darwin": ("macos", "intel"),
    "aarch64-unknown-linux-gnu": ("linux", "arm"),
    "x86_64-unknown-linux-gnu": ("linux", "intel"),
}


def fetch_sha256(url):
    try:
        data = urllib.request.urlopen(url).read()
        return hashlib.sha256(data).hexdigest()
    except urllib.error.HTTPError as e:
        if e.code == 404:
            return None
        raise


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("repo")
    parser.add_argument("version")
    args = parser.parse_args()

    name = args.repo.split("/")[-1]
    class_name = "".join(x.title() for x in name.replace("-", "_").split("_"))
    base_url = f"https://github.com/{args.repo}/releases/download/{args.version}/{name}"

    blocks = {"macos": [], "linux": []}

    for arch, (os_type, cpu) in ARCHS.items():
        url = f"{base_url}-{arch}.tar.gz"
        sha = fetch_sha256(url)
        # A release that ships no artifact for this platform simply does not
        # support it: leaving the block out keeps that platform absent from the
        # formula and from the generated api/ metadata.
        if sha is None:
            print(f"{arch}: not released, skipping")
            continue
        print(f"{arch}: {sha}")
        blocks[os_type].append(ARCH_BLOCK.format(cpu=cpu, url=url, sha=sha))

    if not any(blocks.values()):
        raise SystemExit(f"Error: {args.repo} {args.version} publishes no supported artifact")

    os_blocks = "\n".join(
        OS_BLOCK.format(os_type=os_type, arch_blocks="".join(arch_blocks))
        for os_type, arch_blocks in blocks.items()
        if arch_blocks
    )

    formula = TEMPLATE.format(
        class_name=class_name,
        repo=args.repo,
        name=name,
        os_blocks=os_blocks,
    )

    out = Path(__file__).parent.parent / "Formula" / f"{name}.rb"
    out.write_text(formula)
    print(f"Created {out}")


if __name__ == "__main__":
    main()
