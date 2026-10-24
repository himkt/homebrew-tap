class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.29.0.tar.gz"
  sha256 "a8761a25335a56d98453e8c7fc07df9ecedc89cd06ae97b98fdff1714c67f0ab"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.29.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8995c55d3e81fe178615a5b00648f6bf600ca6feafdecc5652981d37c81eb648"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a2474ec0213c1d48e6736e03436d5da891121d56ba0e5069fd1d714ec5167928"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "456bd351ef84cb0300f651a429e871be06f33052fb65f0e2c9a8a3f26e2133ed"
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
