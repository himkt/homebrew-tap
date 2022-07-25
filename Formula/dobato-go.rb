class DobatoGo < Formula
  desc "A CLI tool to post a message to discord server"
  homepage "https://github.com/himkt/dobato-go"
  url "https://github.com/himkt/dobato-go/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3d8a9836ffc3d105b4cbe59275ef21f58323a4a8470ceea803c781c49af443a3"
  license "MIT"

  # depends_on "cmake" => :build

  def install
    system "go", "build", "-o", "dobato"
  end

  test do
    system "false"
  end
end
