class TipsCli < Formula
  desc "A CLI to collect tips for your own"
  homepage "https://github.com/himkt/tips-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/tips-cli/releases/download/0.2.0/tips-cli-aarch64-apple-darwin.tar.gz"
      sha256 "de77696526f14e30533d74d1907f9964dc2647c6e5922ed7b63136076e8c7423"
    end
  end
  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/himkt/tips-cli/releases/download/0.2.0/tips-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cf04d6cce387ed0aca49655cf160bfee69e96fbb52a3c19c4a4d4f357af5f879"
    end
  end

  def install
    bin.install "tips-cli"
  end
end
