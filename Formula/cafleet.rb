class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.7.tar.gz"
  sha256 "533a3cfb667209adbad23304807f3d690a40dff017b22072c78c453c6611b57f"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9cd213206cb62f63edae52ccb8059d325cd7dcad0ec1bb32abd4a28191c2ad51"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f52d1d9e4354c1bbf18981655cea2e9977be268e4944fcee365ade7a1782514f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "4ef31f597cb41d66d0b30eaacb107681ac2db2837a3ef8753e7411e523c38b02"
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
