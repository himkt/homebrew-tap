class AcRandomTest < Formula
  desc "A CLI tool to run random tests for programming contest"
  homepage "https://github.com/himkt/ac-random-test"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/ac-random-test/releases/download/0.1.1/ac-random-test-aarch64-apple-darwin.tar.gz"
      sha256 "e166a309fcf6d3f0971abe9e4180cb2ea2a6750b98beac6d16baff4208c825b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/himkt/ac-random-test/releases/download/0.1.1/ac-random-test-x86_64-apple-darwin.tar.gz"
      sha256 "49486e4c15027f56187a0be20c2bbdfd1fe3b7591c80ad057bb058079b3d8474"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/ac-random-test/releases/download/0.1.1/ac-random-test-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d09cca254c4a9aad03a047580231cdd3199a190fcb2e9192e117ef9fcebb58dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/himkt/ac-random-test/releases/download/0.1.1/ac-random-test-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "157a7e1692fff627daa2fa47d524b10bb9e95a7df573ffd56c75fcc8e2bc906b"
    end
  end
end

def install
  bin.install "ac-random-test"
end
