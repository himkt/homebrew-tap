class Pathfinder < Formula
  desc "MCP client for jumping to definitions using language servers written in Rust."
  homepage "https://github.com/himkt/pathfinder"
  url "https://github.com/himkt/pathfinder/archive/refs/tags/0.1.1.tar.gz"
  sha256 "5b028717aa25a49b8f9ec60e12e796f75f46989cd1b6ef513015de402e90c1e3"
  license "MIT"

  bottle do
    root_url "https://github.com/himkt/pathfinder/releases/download/0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e254ad8ef6009a22e9838d8bc26c3af79778aecee3a19c670a7fe61611ff09f3"
    sha256 cellar: :any_skip_relocation, sonoma:       "4c07b517078f51c80fca097e9e8b661748fae17f056bc5d5620a63d221dfbca0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9585901bb8cba71b3375789a765ed9162925a79baef76e0b1a20d597553e27e5"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3e801db535675fcf2521810bcdf210fdaca23eb9e8dd18c1cfcecbb6e5b9c4b0"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end
end
