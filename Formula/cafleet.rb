class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.28.0.tar.gz"
  sha256 "d9a529267556ab5fcf9009abe81663906e498428d7491be3d78e9efc81fc4fe6"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.28.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4e7dfb289ad1f2abc325ee7b9b81e33f8e823a55b6dc964fd9fc85f6ba6a7e02"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d68d1748869b6f8da633833ddcd7cfaf372659e720e89d64da05d811e6dda08e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "dab3713ace075e714d8029d9c16361f31d14ccd09db75ca37759ea8f2e7ba09b"
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
