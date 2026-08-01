class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.23.2.tar.gz"
  sha256 "456fb231ab6c43e5b021876db6a0097959de6ec45aa7acacd501633439726e7c"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.23.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "babff6f7f37119f016a5f6786b573c2899c6f70f2583faf0da4bd512de4abf2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "adb1a40e4e2f439db54d6876b95a8b8f1ef9b54d951c0717f85853ae742266c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a0107b3aa131c7bd7ff31c4d28513afbefe9167830f3651c2160da1c0eefd40b"
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
