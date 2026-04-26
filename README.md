# learn-dutch

Beginner Dutch grammar book written in Typst.

Current book title: **Basic Dutch Grammar**. Project focuses on short, practical explanations for early grammar topics like articles, pronouns, word order, present tense, negation, questions, past tense, and separable verbs.

## Project layout

```text
main.typ              # book entrypoint
chapters/             # chapter content
frontmatter/          # preface and other front matter
dist/                 # generated PDF artifacts
.github/workflows/    # CI and release automation
```

Current chapters:

- grammar terms
- sounds and spelling
- nouns and articles
- pronouns and word order
- present tense and negation
- questions and useful patterns
- past tense and perfect tense
- separable verbs

## Requirements

- [Bun](https://bun.sh/)
- [Typst](https://typst.app/)
- [typstyle](https://github.com/Enter-tainer/typstyle)

Example macOS setup:

```bash
brew install bun typst commitizen
cargo binstall typstyle
bun install
```

## Work on book locally

Install project dependencies:

```bash
bun install
```

Format Typst files:

```bash
bun run typstyle
```

Format everything:

```bash
bun run format
```

Run lint checks:

```bash
bun run lint
typstyle --check -v main.typ chapters/ frontmatter/
bunx prettier . --check
```

Build PDF locally:

```bash
mkdir -p dist
typst compile main.typ dist/learn-dutch.pdf
```

## Commits

This repo uses conventional commits with Commitizen, commitlint, and lefthook.

Normal `git commit` triggers lefthook and opens Commitizen prompt automatically:

```bash
git commit
```

You can still run Commitizen directly if wanted:

```bash
bun run commit
```

## Local release flow

> `bun run commit` uses JS Commitizen for writing commits. `cz bump` below refers to Python Commitizen CLI installed with Homebrew.

```bash
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

## Release workflow

Manual release workflow follows same shape as local release flow. On non-dry runs it:

- bumps version and updates changelog with Commitizen
- pushes bump commit and new Git tag
- compiles `main.typ` to `dist/learn-dutch-${TAG}.pdf`
- creates GitHub release and uploads compiled PDF

After workflow finishes, local checkout is behind remote because release commit and tag were created on GitHub. Sync before more work:

```bash
git pull --ff-only origin main
git fetch --tags
```

Test release workflow locally with `act`:

```bash
act workflow_dispatch \
  --container-architecture linux/amd64 \
  -W .github/workflows/release.yaml \
  -j bump-version
```

`act` sets `ACT=true`, so workflow stays in dry-run mode locally and skips release publishing steps.

## Automation

CI runs on pull requests, pushes to `main`, and merge queues. It checks:

- ESLint
- Typst formatting with `typstyle --check`
- Prettier formatting

Run CI workflow locally with `act`:

```bash
act -W .github/workflows/ci.yaml -j check --container-architecture linux/amd64
```
