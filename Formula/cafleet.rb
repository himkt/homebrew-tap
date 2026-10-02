class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.9.tar.gz"
  sha256 "519661384b405d32871c388ce466de125cff382b51cedd1638cb6f464caf13cf"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "119c8ffb211f98d03ba8ccefb65fd20ee6ad101a74760d4989b92c6f099439a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9a5ff5887307dbf24fd31e3d9e66747678ea71b2e073c50139a44f5cb7f477d8"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7b26a3b2cbdd391a684ef9ef94ab8b3ee24e3e6f4db33f6dd0955698457382a5"
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
