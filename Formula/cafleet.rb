class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.32.1.tar.gz"
  sha256 "60bb26e8f799d8c8f4cd0b0467734c8521e4ba08ec419e571a4b38b8ef4bdca4"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.32.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8145a451605f8600a3282cb69cfaebf93fb5645d2f849d60632f63694c8961ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1a24e000ad605a1cb629f7cfaaec2b5ee66780e05b607ce7794128b42f173226"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ac2eeaa72462f2f646c2f68c0ff5b75eb50d4bd93e9be253ea93cfb46dc7f039"
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
