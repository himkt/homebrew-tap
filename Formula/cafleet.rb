class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.6.tar.gz"
  sha256 "6e401ed6488bb5171d7a10ab6a48fba9d2e029c5841dcb0030e5773cd803aaf2"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "64a9375a4d33cfee1e492aa0392fc835fbb0074e583a5e6c45ba984ff82d1d68"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e2821b6b730b53aa60b28f3f21e88046052e16e2b6aeda25fa7532ee1efce1d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "78c7ba98ae27d1a1815327e06fca69420d906ce08b56a6a9a5fb857573851547"
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
