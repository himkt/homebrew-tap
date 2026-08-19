---
name: update-formula
description: Update a Homebrew formula in the himkt/homebrew-tap repository to a new release version. Use when the user shares a GitHub release URL (e.g. github.com/himkt/cafleet/releases/tag/X.Y.Z) and asks to update the Formula and its generated API JSON, or invokes /update-formula. Takes the release URL as argument.
---

# Update Formula

Bump a formula to the version of a given GitHub release, regenerate the API JSON, and open a PR.

Argument: the GitHub release URL. Parse `{owner}/{repo}` and `{tag}` from it (e.g. `https://github.com/himkt/cafleet/releases/tag/0.24.1` → repo `himkt/cafleet`, tag `0.24.1`). The formula name is the repo name: `Formula/{name}.rb`.

## Procedure

1. **Fetch bottle checksums from the release assets.** The `digest` field already contains the sha256 — no download needed:

   ```bash
   gh release view {tag} --repo {owner}/{repo} --json assets --jq '[.assets[] | {name, digest}]'
   ```

   Bottle assets are named `{name}-{tag}.{platform}.bottle.tar.gz` (platforms such as `arm64_sonoma`, `x86_64_linux`, `arm64_linux`).

2. **Compute the source tarball sha256.** Download via `gh` (curl/wget are prohibited); `gh --archive` fetches the same tarball as the formula's `archive/refs/tags/{tag}.tar.gz` URL:

   ```bash
   gh release download {tag} --repo {owner}/{repo} --archive tar.gz -O /tmp/{name}-{tag}.tar.gz
   shasum -a 256 /tmp/{name}-{tag}.tar.gz
   ```

3. **Edit `Formula/{name}.rb`** with the Edit tool:
   - `url` → `https://github.com/{owner}/{repo}/archive/refs/tags/{tag}.tar.gz`
   - `sha256` → source tarball checksum from step 2
   - `bottle do` block: `root_url` → `https://github.com/{owner}/{repo}/releases/download/{tag}`, and each platform `sha256` → the matching asset digest from step 1. Update only platforms the release ships; keep the existing platform list otherwise.

4. **Regenerate the API JSON** from the repo root:

   ```bash
   make api
   ```

   This rewrites every file under `api/` (the other formulae/casks pick up a new `tap_git_head`). Include all regenerated files in the commit.

5. **Deliver as a PR** per the git-workflow rules: branch `{name}-{tag}`, single-line commit `feat: update {name} to {tag}`, push, then `gh pr create --fill`.

## Verification

- The diff touches `Formula/{name}.rb` plus `api/**` only.
- `api/formula/{name}.json` shows the new tag in `versions.stable`, `urls.stable`, and every bottle URL/sha256.
