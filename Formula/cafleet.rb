class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.35.0.tar.gz"
  sha256 "95478cf11903ca4954334c5064f607ca310e1f6ea02c3017064f5a2bac78f6df"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.35.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9cc96be2ea23648dc85d1c2e543a1033cd60ac8631f3baab6a5e2f5308332424"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "94b488c94df9e96bb2242f3867281e9fa3ffd53ab66990e8ff3a4c0cfe672ca6"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "bdf3b795e0115ea0a27c3465a5154ccf8bd74acac91ce1d87720bce7c8ff0393"
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
