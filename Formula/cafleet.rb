class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.35.2.tar.gz"
  sha256 "6fe02c585c4bf6a1d0e7dfcec2057d451b2684815be6f00c7d01a0670eab86be"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.35.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "1c8f6d9a53f8048862a45fa517ffc1d0e0e66a4413b874fb18c8c134f344f320"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fae66bea13928d35267f7a61127f735dae23c90f2df19a1b9c568ae4d6d58bff"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "68e50bf85e4a2cb833cf6c5e33eda8f9f8f574c3dabfa8e409597102a3c36ebc"
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
