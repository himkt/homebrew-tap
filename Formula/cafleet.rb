class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.31.1.tar.gz"
  sha256 "f76138bee1ecfdf96e4817480d2b90105d107c43242de6451c15a83c49f548dc"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.31.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "76c7ced6659170072c0181579294735d7ef63a6f9c56469ee994ba98ae372ebc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "252bc1725deabe8ae0a29676309bb205376335cad5489c2707e188bd61f5cf63"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "0ce7acce408e0c9baa2e32b57b8908947f24576b878b4d20a2d5a00bf6098959"
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
