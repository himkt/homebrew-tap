### Use

```
brew tap himkt/tap
```

### Add formula

1. Get checksums

```bash
make sha256 REPO=himkt/tips-cli VERSION=0.2.2
# aarch64-apple-darwin: 3e27012a84859a69cd48f6c2070b848c3428b1e879b94059f86f532d2e4fdf5a
# x86_64-apple-darwin: 0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5
# x86_64-unknown-linux-gnu: 75519eff0b52909ad199b02ea2579f657ecbd6b9ace7f2a649ec2eccffaf6152
```

2. Create formula

```ruby
# Formula/tips-cli.rb
class TipsCli < Formula
  desc "A CLI to collect tips for your own"
  homepage "https://github.com/himkt/tips-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/himkt/tips-cli/releases/download/0.2.2/tips-cli-aarch64-apple-darwin.tar.gz"
      sha256 "3e27012a84859a69cd48f6c2070b848c3428b1e879b94059f86f532d2e4fdf5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/himkt/tips-cli/releases/download/0.2.2/tips-cli-x86_64-apple-darwin.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end
  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/himkt/tips-cli/releases/download/0.2.2/tips-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "75519eff0b52909ad199b02ea2579f657ecbd6b9ace7f2a649ec2eccffaf6152"
    end
  end

  def install
    bin.install "tips-cli"
  end
end
```
