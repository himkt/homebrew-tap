class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.24.0.tar.gz"
  sha256 "d6dc540f10beb8b43047609b7f9e4abcf56e02d1da44fc568e7913b11650789e"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.24.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "02ecf2efde0b7dc0e7f988c243c020ec6dcdd4c0c1e3f493c042f52c4c6f8fad"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4ba3ddb6c980af3337db5627e254f93c68a12b8fffaaceb5e5c184420bd042db"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "fb9ba55876b38236ea0e0ab74094749bfdd94a07e8ea807921c783dc625d8a88"
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
