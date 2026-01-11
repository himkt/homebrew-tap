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

ARCH_BLOCK = """\
    if Hardware::CPU.{cpu}?
      url "{url}"
      sha256 "{sha}"
    end
"""

ARCHS = {
    "aarch64-apple-darwin": ("macos", "arm"),
    "x86_64-apple-darwin": ("macos", "intel"),
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
        assert sha
        print(f"{arch}: {sha}")
        blocks[os_type].append(ARCH_BLOCK.format(cpu=cpu, url=url, sha=sha))

    os_blocks = "\n".join(
        OS_BLOCK.format(os_type=os_type, arch_blocks="".join(arch_blocks))
        for os_type, arch_blocks in blocks.items()
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
