class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.31.2.tar.gz"
  sha256 "4fc2b8c968c2c4933b3c1423872f63373cd9d2fc84c987c76e31871d4e884894"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.31.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5e54ca8000577a33c78b6861c6e607eaca7514e20f67562167d03ed746d15b38"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6f90accba391487c0d41c7483eb326bb7be749fd43665e790a76956a8476b88e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "89c23e8045b3d0b67e79502b967bae7c53058bb091b710e1d4fb3433ba67fcc1"
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
