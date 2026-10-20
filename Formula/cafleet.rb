class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.27.0.tar.gz"
  sha256 "4ca411fa6bfa82d1e17e2d0692f0767e3b9a326bbb0b2d22388a7a46bbd1a288"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.27.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0e417c0fc37e611077585ba94899a2e04d7342441d3f3a722889b30cdc1b36bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "05890d603b639ca5e0685072feeb865255ba8177fe96e51c2a0444ffc328cb0b"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "842f961cfb143edf8e3adb86a65acc74fdbbc13cc2d080bb21e8a23108b2ec40"
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
