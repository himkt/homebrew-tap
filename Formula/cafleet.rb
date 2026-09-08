class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.5.tar.gz"
  sha256 "64beedf8c90dd37fc430acb8ce8d84b38d11fe00fbb08f7531b260b9acd3205a"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a0372fb2601a44577001cc468dd05f790b424a865ff208340af4e466e4ad5720"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3582fd55f49484c0b69838203876e2296cb05d8714856151c7fe32fcd044d9f7"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "51b1c412245dacb674b31cd15f5e90ef576fa8460fbf4acf5c3250d2cab5dad3"
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
