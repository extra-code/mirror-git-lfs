# NOTICE

This repository packages and redistributes upstream software published by the
[Git LFS project](https://github.com/git-lfs). The Apache-2.0 license in
[`LICENSE`](LICENSE) covers the OCX pipeline files authored here. It does
**not** cover any upstream-derived asset — each package's redistributed bytes
carry their own license, recorded below.

The package logo is reproduced from the Git LFS project's artwork for catalog
identification only, under nominative fair use. No endorsement is implied.

| Package | GHCR path | Upstream SPDX |
|---|---|---|
| `git-lfs` | `ghcr.io/ocx-contrib/git-lfs/git-lfs` | `MIT` |

---

## `git-lfs`

Upstream: <https://github.com/git-lfs/git-lfs>
Published to `ghcr.io/ocx-contrib/git-lfs/git-lfs`.

| Component | SPDX | Holder |
|---|---|---|
| Git LFS (`git-lfs`) | **MIT** | GitHub, Inc. and Git LFS contributors |
| Portions copied from Go (`subprocess`, `tools`) | **BSD-3-Clause** | The Go Authors |

Permissive; redistribution of the compiled binary is granted provided the
copyright and permission notices are retained. The upstream release archives do
not carry a license file; the full text is upstream's
[`LICENSE.md`](https://github.com/git-lfs/git-lfs/blob/main/LICENSE.md). The
binaries statically link third-party Go modules under permissive licenses,
enumerated in upstream's `go.mod`.

No modifications are made to any upstream artifact in this repository; they are
republished byte-for-byte inside an OCX bundle.
