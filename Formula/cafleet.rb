class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.1.tar.gz"
  sha256 "83ba1b53ad1fa46348ea85f8430b2b597b72e0f7478183ec91bce017f5177def"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d4fc7ac94192d1e610f368fd0628e25fcae36ac6da977dc788ed9b6a88c8074c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0c8324533aba968bd033bc25e206d45a4e0eda99de1ec701b58f3c9286a4b604"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "457b9e6f98226d0e5dc60440ffda0e4f0c1e91e334c4d7ff33655aa721f0e920"
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
