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

Each file holds one base hash plus a `variations` object keyed by bottle tag
(`x86_64_linux`, `sonoma`, ...). A consumer deep-merges the entry matching its
own platform over the base; a platform the project publishes no artifact for has
no entry. Regenerate after editing a formula or cask:

```bash
make api
```
