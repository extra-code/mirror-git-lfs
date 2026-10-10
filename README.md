# mirror-git-lfs

OCX mirror for [Git LFS](https://github.com/git-lfs/git-lfs). One repository,
one spec directory per package.

| Package | Spec | Publishes to | Announced as | Upstream SPDX |
|---|---|---|---|---|
| [Git LFS](https://github.com/git-lfs/git-lfs) | [`git-lfs/mirror.yml`](git-lfs/mirror.yml) | `ghcr.io/ocx-contrib/git-lfs/git-lfs` | `ocx.sh/git-lfs/git-lfs` | `MIT` |

Each upstream release is discovered, re-bundled, smoke-tested per
`(version, platform)` and only then pushed with cascade tags, after which the
result is announced into the OCX index.

## Layout

```
mirror-base.yml         repo-wide policy every spec inherits via `extends:`
git-lfs/
├── mirror.yml          the spec — never at the repo root
├── metadata.json       bundle interface
├── CATALOG.md          → ocx package describe
├── logo.svg / logo.png describe assets, 512px PNG
└── tests/smoke.star    Starlark smoke test
```

⚠️ `extends:` is a **shallow** merge of top-level keys. A spec that restates
`platforms:` replaces the whole block, container legs included.

## Platforms

Six platform entries: both Linux arches, both macOS arches and both Windows
arches. The Linux builds are fully static Go binaries, so both Linux keys are
**bare**; the ubuntu, alpine and fedora container legs in `mirror-base.yml`
verify that on every run.

## Interface

Every archive ships `git-lfs` next to an executable `install.sh`. The content
root is on a **private** `PATH`, and `git-lfs` is exposed as an entry point, so
consumers get `git-lfs` and nothing else. `bin_scan` is `off` because a bare
`${installPath}` offers the scan no directory; `binaries` is hand-listed.

## Editing

| File | Edit | Regenerate after |
|------|------|------------------|
| `mirror-base.yml`, `git-lfs/mirror.yml` | hand | yes — see below |
| `git-lfs/{metadata.json,CATALOG.md,logo.*}` | hand | — |
| `git-lfs/tests/smoke.star` | hand | — |
| `.github/workflows/*.yml` | **generated — never hand-edit** | re-run when a spec changes |

```bash
ocx-mirror package pipeline generate ci --spec git-lfs/mirror.yml
```

`verify-generated.yml` exits 65 on drift.

Run `direnv allow` once to put the pinned toolchain on `PATH`, and invoke
`ocx-mirror` directly — never `ocx run -- ocx-mirror`, which pins
`OCX_BINARY_PIN` to the bootstrap `ocx` and false-reds the nested push.

## Required secrets

| Secret | Use |
|--------|-----|
| `OCX_ANNOUNCE_TOKEN` | opens the index pull request from the `ocx-contrib/index` fork |
| `OCX_MIRROR_DISCORD_HOOK` | notify-stage Discord webhook URL |

(Inherited from the `ocx-contrib` org with visibility ALL. GHCR pushes use the
run's own `GITHUB_TOKEN`.)

## License

Apache-2.0 — see [`LICENSE`](LICENSE). Upstream assets are out of scope; each
package's redistribution license is recorded in [`NOTICE.md`](NOTICE.md).
