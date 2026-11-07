class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.32.2.tar.gz"
  sha256 "c76e6697a9f0ef74e0908a49a718ae0d01ec12060c3811c7b8ef71f72653bfbd"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.32.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "77251f5fbed3fc55928abff5d84803ac4aba67bd0718dab447bb5c1cfee203df"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e81d6ee9e65aab14627de92edfaf4ff5e40fff70e6ee07f4a5c1945df354f68e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1506fe61f409b23d48bb0c27289ad0be10c6dffe5175ccf1a08959e56056d1e6"
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
