class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.34.1.tar.gz"
  sha256 "fdab26c88f05b1c142400ae01bb2b58df5d076cfd7eb427312d2250be5ebae6d"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.34.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c1e21b8e60f65f3ce5644b2296eac6995d85e9a2624eea222d7f18e548245267"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "140de832d8f870e365051ec079a49aebeb693ed72948be152b367d5f22908e70"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "54ab711734ac14c85982f56b02dbf963f574699253a34893668b9d7aab2e5a3a"
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
