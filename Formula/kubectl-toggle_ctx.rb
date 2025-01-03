class KubectlToggleCtx < Formula
  desc "Tiny CLI to toggle kubectl context in prompt"
  homepage "https://github.com/himkt/kubectl-toggle_ctx"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/kubectl-toggle_ctx/releases/download/0.2.0/kubectl-toggle_ctx-aarch64-apple-darwin"
      sha256 "e1e926a8787e518deb7ad954d65f82fb3691326ddddc94141335dd5eb2681452"
    end
    if Hardware::CPU.intel?
      url "https://github.com/himkt/kubectl-toggle_ctx/releases/download/0.2.0/kubectl-toggle_ctx-x86_64-apple-darwin"
      sha256 "b5bac12d239fdf34a649d29c818a00fae6fbca8977320c10676528f569d9e4e1"
    end
  end

  def install
    bin.install "kubectl-toggle_ctx"
  end
end
