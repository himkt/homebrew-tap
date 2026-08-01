class Pathfinder < Formula
  desc "MCP client for jumping to definitions using language servers written in Rust."
  homepage "https://github.com/himkt/pathfinder"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/himkt/pathfinder/releases/download/v0.1.0/pathfinder-aarch64-apple-darwin.tar.gz"
      sha256 "ef010af744b543bf60d709c5e1a2c4d279df471a281669900efea5e7f68da0e0"
    end
    on_intel do
      url "https://github.com/himkt/pathfinder/releases/download/v0.1.0/pathfinder-x86_64-apple-darwin.tar.gz"
      sha256 "a2f78bf19aeeda7558ba0a9fae60ce9d20d728d76b1d14712b75e944e491690f"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/himkt/pathfinder/releases/download/v0.1.0/pathfinder-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b3edc610c0f9fe7ca95510bacbed500e7821ba5218f7f9149936c4500cdc77a1"
    end
  end
  def install
    bin.install "pathfinder"
  end
end
