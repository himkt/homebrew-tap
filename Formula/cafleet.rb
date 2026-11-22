class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.35.6.tar.gz"
  sha256 "6ffcbf1c6c1b53d52e20b016091f5034b030fa0f3f2f3d729db599c62049dc02"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.35.6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4a69bdea1397a13ade5dc6c73954bd89ab181daad8dc128b273103511502e550"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6d18c18ceeede922f53b9112e5021efe96c315ee69bb3fffe6eff5a9a9d1c41c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "31b266d59543513f043b5dc717c5b3b2c3332cc0831e36e8be97c9ae7174d247"
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
