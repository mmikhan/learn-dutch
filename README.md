# learn-dutch

To install dependencies:

```bash
bun install
```

To run:

```bash
bun run index.ts
```

Local release flow:

> `bun run commit` uses JS Commitizen for writing commits. `cz bump` below refers to Python Commitizen CLI.

```bash
# one-time install
brew install commitizen

# bump version, update changelog, create bump commit + tag,
# and write incremental release notes to body.md
cz bump --changelog --changelog-to-stdout --git-output-to-stderr > body.md

# build release artifact with versioned filename
TAG="$(git describe --tags --abbrev=0)"
ASSET="dist/learn-dutch-${TAG}.pdf"
mkdir -p dist
typst compile main.typ "$ASSET"

# push bump commit + tag
git push origin main
git push origin --tags

# create GitHub release and attach artifact
gh release create "$TAG" \
  "$ASSET" \
  --notes-file body.md
```

This project was created using `bun init` in bun v1.3.13. [Bun](https://bun.com) is a fast all-in-one JavaScript runtime.
