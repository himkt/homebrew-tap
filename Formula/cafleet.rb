class Cafleet < Formula
  desc "Coding agent orchestrator for multi-agents collaboration across coding agent providers"
  homepage "https://github.com/himkt/cafleet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/himkt/cafleet/releases/download/0.23.4/cafleet-v0.23.4-aarch64-apple-darwin.tar.gz"
      sha256 "47946c97359951dbd5345dd4259db2986186be9ef6559c4463686a0ee4d3ddb2"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/himkt/cafleet/releases/download/0.23.4/cafleet-v0.23.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "40624d5906a1b1ef2bc25f17b1d563cc9997297852cd9a286b1a997615923d05"
    end
    on_intel do
      url "https://github.com/himkt/cafleet/releases/download/0.23.4/cafleet-v0.23.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "24eeebc15cd3c70bc14e64eda9a8c95cbd2e9a0f1f3623145cbd2949ab76ac47"
    end
  end
  def install
    bin.install "cafleet"
  end
end
