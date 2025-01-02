class KubectlToggleCtx < Formula
  desc ""
  homepage "https://github.com/himkt/kubectl-toggle_ctx"
  url "https://github.com/himkt/kubectl-toggle_ctx/releases/tag/0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/kubectl-toggle_ctx/releases/download/0.1.0/kubectl-toggle_ctx-aarch64-apple-darwin"
      sha256 "c499a3c4feaeb63e65f6de5563d10a7c0102aa19d161027dbe8cba545cc443c1"
      def install
        bin.install "kubectl-toggle_ctx-aarch64-apple-darwin" => "kubectl-toggle_ctx"
      end
    end

    if Hardware::CPU.intel?
      url "https://github.com/himkt/kubectl-toggle_ctx/releases/download/0.1.0/kubectl-toggle_ctx-x86_64-apple-darwin"
      sha256 "c9258cbd2f2efaceba286a89196cb6ae2439799ec4577831593ae7721642ea60"
      def install
        bin.install "kubectl-toggle_ctx-x86_64-apple-darwin" => "kubectl-toggle_ctx"
      end
    end
  end
end
