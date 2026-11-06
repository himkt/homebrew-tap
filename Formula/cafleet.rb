class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.32.0.tar.gz"
  sha256 "e9a31b50888adfe2951d372010e65f6aa298fa1e4644bd9be5cc95ca7aa53932"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.32.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b8158def5ffbb736cc862542e49cc731d3f6d1ce497d75f7800a46159a9d7a79"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "463632b6bb0bc6a34df9c55d64e0ecd67d6c520aad10c03b60c5d5b3e1e0e38f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "859651c304e113b9926a8b358686d5f812e751892d8bd74b014d97b3f261458a"
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
