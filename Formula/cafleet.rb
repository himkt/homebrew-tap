class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.4.tar.gz"
  sha256 "fc28f7a5caf32e1459496bf78280b8ff9d1c79531614eb763c48189c5c42589b"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0b905a5108907dccabc6170d4061e7f7b3d8af3ace247aaba3a6978726c3cd4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8fbc80e73e696dfd5fd1359683ad0d9372b13505c47c3db16ddebb29c1d993fc"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "59f35046f6224669c4d996695b4793eb4d1434d4ccc21b3cbb22ecd4fb6e2947"
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
