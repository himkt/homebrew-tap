class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.8.tar.gz"
  sha256 "b817523196ce39c7b91ee6ff081e2a9c6daa08ac968b005714a12d9e8cb7c3af"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "800a3f01988fcd16ee3e6faf113ebb50c8ee0626cd92274302d5c28fc30245f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8263eac722b6651b86ea32d816e38cb403082985d069f43401db5049ca34dc81"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "d6413377a83198d473a834873d0fa53f265608712019e3e449e1c4cee14ca6cc"
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
