class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.35.1.tar.gz"
  sha256 "213aa14a688c53263abeb153bf4600a9b588ca0fadaf9583d05af9ea9b1cd99b"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.35.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "cc5f7fe4747b11d8959136b5c3dc49babcca864800f41d6857a51814ff081938"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b1c1cdd8470ee30a36b9a64a6c73b539955eb649d8849f3c2831595d1a82ba00"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "af153708170dd5c32dc38dd3c5aca70739d9d545b8bdb44cfc033a3bcd5fda02"
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
