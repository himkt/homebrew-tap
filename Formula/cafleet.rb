class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.31.0.tar.gz"
  sha256 "eafbef0ed4005a3dcbb102694876b75c6e5a6d053869f2ff9dddb1413b4ebe85"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.31.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "fa18decb12f86a28d0a736786e01f96e964a0cc5c75500ee9f5bef60c7350755"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3ca088c418e9a31d550a1d44c13d046b618400827dac9c542d74d2a7c571d232"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "5ccc37e59503f6c9153594cb6cabb6a611a725766f86c218cae0ae0bddcf1b41"
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
