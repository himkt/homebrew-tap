class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.23.3.tar.gz"
  sha256 "84c2cc32a8d689888d0221979a10e3dfd39271811d0d1498534ca82219aa360e"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.23.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c262cda9480265d6328311e42b6d5fc0e07455cb597eb8d13aaa321bda31f888"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "793659240a737d6a979fd55a9df0892cca24baabb19cacdad291de8e96bd9bd6"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "4cec5e837153591150a2b4535bdd35fadff87120197a20bc5a2f8d1334aa1ddd"
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
