class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/cafleet/releases/download/0.23.1/cafleet-v0.23.1-aarch64-apple-darwin.tar.gz"
      sha256 "fa2a6e3c36b7ac55e9ee97cc755f2fc67f00bc6fe2f375f6b557f2d1b6ff6cfc"
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/cafleet/releases/download/0.23.1/cafleet-v0.23.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dede0cb0511147e3b7b3be65df9e98dc78ae82f9bbd512f1f762cb343683c811"
    end
    if Hardware::CPU.intel?
      url "https://github.com/himkt/cafleet/releases/download/0.23.1/cafleet-v0.23.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8dd3500998412d2ad0e12631cc9b0dc6364f4fa0e2c43fbfebda25562a3bee61"
    end
  end
  def install
    bin.install "cafleet"
  end
end
