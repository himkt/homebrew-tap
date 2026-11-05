class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.31.4.tar.gz"
  sha256 "3ea7d007c4c939f47295402d9d192e58db04ed08c1b9fc1399bca80269224d52"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.31.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "dd146a0ac9cdb2ce0f209b23e361aac30379f12336c2a70e41045486fc63c9fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "61531058bd8e55902c4dd1e61aac1b9613aaacb4933950e7c031cc2cb3ed5826"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7ce3ac7e21ff0afcf4fccf651a28b5999341531004f3313a0ab13ed68da8206f"
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
