class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.35.3.tar.gz"
  sha256 "9a8fd0eccf4c2ccc20f922615aa80b311ae5ddadbdd4afbb3922a9a0a691df65"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.35.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e355253d2aeb649a604a20bb59ae512fa2697e5dd2511d770f6a900586f74c11"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "37efbc14ac7edc44a0faaafa9d14a4185d93cfdc15805f9296afd552880cc8d3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "08e997e39e6ceb8e7712f1a6ba1a98cd7ee640364f09f5471c2cbc2969580d21"
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
