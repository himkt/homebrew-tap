class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.26.0.tar.gz"
  sha256 "ee032d4e7eccb1f665a96df34924d3cc2c52717f888eda6d95bc8ac0912dbb4e"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.26.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a69871cbd35f836494bbc9c5110e8e1a8d4af60d12e1ba41e2957da0f7d5a18d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "26cda12290475cc6331ff38f49ba0fb84bce2c3ac6f17a4b8c5b9d661dca47c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a054bfe1ef129f83bf2db08684c78091fed7c8d86b6b9d99a58b0f37e29e874c"
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
