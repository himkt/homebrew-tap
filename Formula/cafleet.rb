class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.35.5.tar.gz"
  sha256 "f322b5cfd0117123f582acbab1da34501ec031bfb1cc288b93254e9eb7b7190b"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.35.5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "01062ecbc862ad5166978009f7d2e6b0d69e6fbe7389b16cc9e43547be0fa3b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e27cba340e18dd79845574a5b10a60c7c1c02248db57674940925dba4eb3d72c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6e01f2722dca9a080838cb67128e2b79de07c1c806570c4b46ddeb6a219e7bde"
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
