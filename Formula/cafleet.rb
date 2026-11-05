class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.31.3.tar.gz"
  sha256 "aff4ffeb31bfa7321d58d96143c98bfdfc0de9f825fe982739b9c818be57724e"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.31.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8e6f06a7a10f059614e14ca9ccf9aadcca599a2cf10f554bd399f6c237067a0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b4e6a2719dea64084c9006db83280c2475fbb46028a52896f85ea806f0673e4f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "9c99ee31f701001158cca742195868a524339044afdd78240f6900fc40232043"
  end

  # mise.toml pins the whole toolchain (node, pnpm, rust, zig), so it is the only build dep
  depends_on "mise" => :build

  def install
    ENV["MISE_DATA_DIR"] = buildpath/".mise/data"
    ENV["MISE_CACHE_DIR"] = buildpath/".mise/cache"
    ENV["MISE_STATE_DIR"] = buildpath/".mise/state"
    ENV["MISE_CONFIG_DIR"] = buildpath/".mise/config"
    ENV["MISE_YES"] = "1"
    system "mise", "trust", "--all"
    system "mise", "install"
    system "mise", "run", "//admin:install"
    system "mise", "run", "//cafleet:build"
    bin.install "cafleet/target/release/cafleet"
  end
end
