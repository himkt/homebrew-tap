### Use

```
brew tap himkt/tap
```

### Add formula

```
brew create https://github.com/himkt/tips-cli/releases/tag/0.1.0
mv $(brew --prefix)/Library/Taps/homebrew/homebrew-core/Formula/t/tips-cli.rb Formula
```

### Edit formula

1. Get checksum

```bash
#!env bash

PACKAGE=kubectl-toggle_ctx
BASE=https://github.com/himkt/$PACKAGE/releases/download/0.3.0/$PACKAGE

for platform in aarch64-apple-darwin x86_64-apple-darwin; do
  url=$BASE-$platform.tar.gz
  wget --quiet $url
  echo $platform
  echo "url \"$url\""
  echo "sha256 \"$(sha256sum $PACKAGE-$platform.tar.gz | cut -d ' ' -f 1)\""
done

# output:
# aarch64-apple-darwin
# url "https://github.com/himkt/kubectl-toggle_ctx/releases/download/0.3.0/kubectl-toggle_ctx-aarch64-apple-darwin.tar.gz"
# sha256 "407f150fdef75f3677fc8fa3f50caa96289edafb6a0d35dd79aa7baf4b0fe161"
# x86_64-apple-darwin
# url "https://github.com/himkt/kubectl-toggle_ctx/releases/download/0.3.0/kubectl-toggle_ctx-x86_64-apple-darwin.tar.gz"
# sha256 "1f837d6ba44fa2c148ca45f023eb2d070697e28944e22d693643b62e8753a014"
```

2. Add bin-installation

```ruby
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

on_linux do
end
```
