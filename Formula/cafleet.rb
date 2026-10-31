class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.30.2.tar.gz"
  sha256 "1d3dee9c200b07550a023a083b9773c1682833e2168b26fe130d07f0e7a2d60c"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.30.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "abefa4a0aa118436da87153db8480734d19b423d25263678081a29ced029827f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d6e476005aca1035809e3c577a5aeae8d64f093e5ac3e9191146b62ad2d0b409"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1f8fb22d96286892e88a504627d646528448b89349080c81eedc891a08820319"
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
