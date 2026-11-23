class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.35.7.tar.gz"
  sha256 "c4f3e09419bc6c0d641199e57ebc594fa204f51cdcdd4670a96fe9c323e3a231"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.35.7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "1a92f74c2bd600ceaedf481297bd0e45e0da4ada63d6c2fc43d13795cf3ddb97"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3dcb58a8a12152efb62103a551671197de16c9a5ff264c01a62f42e1ab799ba4"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a7c84edf27d9fdcf3c914de33eced7c7d66e4b95dba10882ead115884e6dd615"
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
