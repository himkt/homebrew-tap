class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.35.4.tar.gz"
  sha256 "dc2c00b1b2326129d680e7ccf76fb96e13e175e46fcfec4f21510064d686e224"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.35.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f71b05fc1e7db98b8f00bd14f5cc2965ceba55b114661b7d96f0b12582bdcf3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "16a3cb30d40e567eb72bd9d095fc98c735a7b5e0dfdb143f172e6b1848cd1565"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "006cd809c895f2b547b9db8ffc9bf2158499a0af3400e6b85998d95d6169a0d1"
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
