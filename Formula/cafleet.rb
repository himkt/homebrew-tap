class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.33.0.tar.gz"
  sha256 "e06b28f462e20638839146498ac54ec862eae2234e0b7750f11ba4d213b53f54"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.33.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "630f9ded6ece456d68e9de708ea4ee1316a6560ae7c160ad5fe9453c712f33e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "52006ff8531a5daa9d52761d31f7f3a1f1c0aea3d45f1920a4dc4618d5e0459c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "86deef88e50c1cf63fa793ba6fc6c2d659e7beed3f2b216d0662d357a2afb0b4"
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
