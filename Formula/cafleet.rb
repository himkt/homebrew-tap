class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  url "https://github.com/himkt/cafleet/archive/refs/tags/0.30.3.tar.gz"
  sha256 "cbd6e92499fd95611a29bc3a0c16e847b668eb73e16e87a96121c08fb18bd9f8"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/cafleet/releases/download/0.30.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "dfad90a9a530f748f0d5bbd18df914c49533a2e3cd8766eaaf0d4398eb502985"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "46868fbdf707d464c85286a6952455ac084836dca4ef4e78c6a09948314f4256"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "979b5d767bec57d30e1956db61d2e301302ebf3497ad0a61434a7ad6e6797831"
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
