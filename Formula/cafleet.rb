class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.25.0.tar.gz"
  sha256 "07c1895b7560c7defe25eaedb8966380b2f437d1c6e50d2cd4b716ccaaa2b8e1"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.25.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9c7d83dc1f40a30aca8dc7d8efc17a1b7cecee9a7fe7c4267789e4d593188607"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "db49ba81465a0e83e63efb654902fba81c82f083064df8ba9d385bed6c9dbe12"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "db7e5e2e665a817827c4d15abc629630cd649819784b589a245832c48994d3ce"
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
