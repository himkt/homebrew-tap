class Omoide < Formula
  desc "🤖 Browse and clean tweets in CLI"
  homepage "https://github.com/himkt/omoide"
  url "https://github.com/himkt/omoide/archive/refs/tags/0.0.1.tar.gz"
  sha256 "c0e7170f45481302df25ff2d7d12ad7ae7d88b0ca7a338ba53bee79203743bad"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end
end
