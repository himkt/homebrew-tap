class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.2.tar.gz"
  sha256 "a46b315f4da668a24e87a9f0296444157144b4166ee9fe9ad10273e494fc4dd6"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c30ceffe2993b2102fe3cac7b570d8d4ebf4ebcaaf34810b5dc6788bf4f53933"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "17484bf3b43157c8b634faa7cee25bbeb15ca0afb9e1673efb441ffd4d806e26"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "be108584fafb34aab99000833e999dc73c1965e9a96c332f651419454dba7655"
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
