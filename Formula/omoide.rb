class Omoide < Formula
  desc "🤖 Browse and clean tweets in CLI"
  homepage "https://github.com/himkt/omoide"
  url "https://github.com/himkt/omoide/archive/refs/tags/0.1.1.tar.gz"
  sha256 "98baa691de79fa8a562854819354ec3d764401ee21837115390cca0236848058"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end
end
