class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.27.1.tar.gz"
  sha256 "3684118f188ba8078747c0b599907b941c1fde3b6f10aaba1b8df52d461eda6b"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.27.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b90a9d6e6ae9fd32b9d2bfa339acc0e7d07f5c2fb1ccbb0f80bc76ec0e5677ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "26f6d1c107d4ed249001794682b6c45484ffa6f078433a202157776f4a1260b6"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6134f9a21d54ce1c56fc903b8f057a2b7251edeaf599fbddf37baa420c49775d"
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
