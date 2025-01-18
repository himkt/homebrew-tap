class TipsCli < Formula
  desc "A CLI to collect tips for your own"
  homepage "https://github.com/himkt/tips-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/tips-cli/releases/download/0.2.1/tips-cli-aarch64-apple-darwin.tar.gz"
      sha256 "58ba4560309fa6907063350e44f8846fb56ad80b3079d88aa40d74b894d25ddc"
    end
  end
  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/himkt/tips-cli/releases/download/0.2.1/tips-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "03d39c382275c9cc86830a44f2a40bf0939967beeba1828a119a285ffe37551b"
    end
  end

  def install
    bin.install "tips-cli"
  end
end
