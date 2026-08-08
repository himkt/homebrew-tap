class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.23.4.tar.gz"
  sha256 "c860193abecc2c0e08cab5530f00693af3b8142545d9102e4db59ac1822acb10"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.23.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "59ec6bab9e3d182add098bd3aa12689f5b0a66006135d36458c66f4d22709421"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ceb5067f3b4c5b83cb576ae9adc06e76a6010452f58ce9310c79eb4bc9184530"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "dc4757a2f49dec47a5a188ea50d0bb36d57341a44b7f4c076ed02b8e1b4585d6"
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
