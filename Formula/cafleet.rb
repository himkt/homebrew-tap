class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.30.0.tar.gz"
  sha256 "aa55558068f579f22482d3758e76ed8d7da0ddc9cdc9b1c9b266c641694fccc3"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.30.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "88188967df533f5bbc9a1fc1293dcce1548fec622dc0dc6def6ef41b7c63b6fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "25446fa058b7f9c7f26a1d318b7fa78df500cffeef430f619a6c476353dc874a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "26ebf7006703c17a4403ace9decd72617e1d61ce461687b7b735ce95553eea5c"
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
