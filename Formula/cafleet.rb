class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.3.tar.gz"
  sha256 "b4cc5af5444ff82a0f6d157321df0079eab577c832e960ec336d18eaf63b42aa"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "62ad07e275266691ff0e3e8deb0a87dec3f513a0fb2d93f73208b7b459a56cc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "96f7b8f194c2b45af4720092920bd6eee004f357b750b069a0e0524a6c6f8ef2"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "5a2c4b2cb50753f2b48a56ac7f87bfe9d58a8fb14210ddf76b5f43574c070f26"
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
