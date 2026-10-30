class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.30.1.tar.gz"
  sha256 "abb346bc37ece76e4f6db645e2aa640a7461dbeabe41adbdb84a89ef97741054"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.30.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "690350f63df0c70349bd45d3a327376d56c49e2da2ff743f218fecea9a0cd232"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ccc171277a9c174b0fae45295fa00a06b40499d0f574fbe28f57ff06156f2fb7"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "4295c8f849c050bdcc8962b2c4b251b618693670508e059ab8cef75c50f20b71"
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
