### Use

```
brew tap himkt/tap
```

### Add formula

```bash
make formula REPO=himkt/tips-cli VERSION=0.2.2
```

### API metadata

`api/formula/*.json` and `api/cask/*.json` mirror the format published by
formulae.brew.sh, so consumers such as mise can read this tap over
raw.githubusercontent.com without running `brew`.

A consumer installs the prebuilt binary from `bottle.stable.files`, keyed by
bottle tag (`arm64_sonoma`, `x86_64_linux`, ...), and falls back to building the
platform-independent `urls.stable` source archive when no bottle matches its tag.
Regenerate after editing a formula or cask:

```bash
make api
```
