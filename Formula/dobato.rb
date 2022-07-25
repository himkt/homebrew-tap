class Dobato < Formula
  desc "A CLI tool to post a message to discord server"
  homepage "https://github.com/himkt/dobato-go"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/dobato-go/releases/download/0.1.0/dobato-darwin-arm64-v0.1.0"
      sha256 "2b258de40d742b8b8e9f99ee85cf5525a97c8c9de026075f43a58a7c5f3b2c9b"

      def install
        bin.install "dobato-darwin-arm64-v0.1.0" => "dobato"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/himkt/dobato-go/releases/download/0.1.0/dobato-darwin-amd64-v0.1.0"
      sha256 "3b62cda2e88bc494f476f5242f1991b3b8450b25ec50c33b9d63f602e0b143f1"

      def install
        bin.install "dobato-darwin-amd64-v0.1.0" => "dobato"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/dobato-go/archive/refs/tags/0.1.0.tar.gz"
      sha256 "58f0a540f5b38c26b9747034064f5ad9f3fca7793f9bc660c89599309afa961f"

      depends_on "go" => :build

      def install
        system "go", "build", "-o", "dobato"
        bin.install "dobato"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/himkt/dobato-go/releases/download/0.1.0/dobato-linux-amd64-v0.1.0"
      sha256 "89fbf514e39f8809306a90e768b7be47fd2032316e32378278f07982f1434758"

      def install
        bin.install "dobato-linux-amd64-v0.1.0" => "dobato"
      end
    end
  end
end
