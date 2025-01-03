class KubectlToggleCtx < Formula
  desc "Tiny CLI to toggle kubectl context in prompt"
  homepage "https://github.com/himkt/kubectl-toggle_ctx"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/kubectl-toggle_ctx/releases/download/0.3.0/kubectl-toggle_ctx-aarch64-apple-darwin.tar.gz"
      sha256 "407f150fdef75f3677fc8fa3f50caa96289edafb6a0d35dd79aa7baf4b0fe161"
    end
    if Hardware::CPU.intel?
      url "https://github.com/himkt/kubectl-toggle_ctx/releases/download/0.3.0/kubectl-toggle_ctx-x86_64-apple-darwin.tar.gz"
      sha256 "1f837d6ba44fa2c148ca45f023eb2d070697e28944e22d693643b62e8753a014"
    end
  end

  def install
    bin.install "kubectl-toggle_ctx"
  end
end
