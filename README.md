### Use

```
brew tap himkt/himkt
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

BASE=https://github.com/himkt/tips-cli/releases/download/0.1.0/tips-cli

for platform in aarch64-apple-darwin x86_64-unknown-linux-gnu; do
  url=$BASE-$platform
  wget --quiet $url
  echo $platform
  echo "url \"$url\""
  echo "sha256 \"$(sha256sum tips-cli-$platform)\""
done

# output:
# aarch64-apple-darwin
# url "https://github.com/himkt/tips-cli/releases/download/0.1.0/tips-cli-aarch64-apple-darwin"
# sha256 "4bfe8fd914dc7680db6d56a0bd1f8ad0acf985153426edd509db451472706c53  tips-cli-aarch64-apple-darwin"
# x86_64-unknown-linux-gnu
# url "https://github.com/himkt/tips-cli/releases/download/0.1.0/tips-cli-x86_64-unknown-linux-gnu"
# sha256 "dbc1d5464cad7622b2a62e68cb893056391629b2e36837735eae9495aa0ffa59  tips-cli-x86_64-unknown-linux-gnu"
```

2. Add bin-installation

```ruby
on_macos do
  if Hardware::CPU.arm?
    url "https://github.com/himkt/tips-cli/releases/download/0.1.0/tips-cli-aarch64-apple-darwin"
    sha256 "4bfe8fd914dc7680db6d56a0bd1f8ad0acf985153426edd509db451472706c53  tips-cli-aarch64-apple-darwin"
    def install
      bin.install "tips-cli-aarch64-apple-darwin" => "tips-cli"
    end
  end
end

on_linux do
  if Hardware::CPU.intel?
    url "https://github.com/himkt/tips-cli/releases/download/0.1.0/tips-cli-x86_64-unknown-linux-gnu"
    sha256 "dbc1d5464cad7622b2a62e68cb893056391629b2e36837735eae9495aa0ffa59  tips-cli-x86_64-unknown-linux-gnu"
    def install
      bin.install "tips-cli-x86_64-unknown-linux-gnu" => "tips-cli"
    end
  end
end
```
