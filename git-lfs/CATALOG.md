---
title: Git LFS
description: Git extension for versioning large files — keeps binaries out of your history and fetches them on checkout
keywords: git-lfs,lfs,git,large-files,binary,version-control,go,cli
---

# Git LFS

[Git Large File Storage](https://git-lfs.com) replaces large files in a Git
repository with small text pointers and stores their content on an LFS server.
Clones stay small, history stays fast, and the real files arrive on checkout.
It is a single self-contained binary with no runtime to install.

## What's included

- **git-lfs** — the Git LFS client, on `PATH` as a launcher, so `git lfs …`
  works. The bundled `install.sh` stays off `PATH`.

## Requires git

Git LFS extends Git: **`git` must be installed and on `PATH`**. This package
does not bundle Git.

## Quick start

```sh
git lfs install           # once per user: registers the LFS filters in ~/.gitconfig
git lfs track "*.psd"     # route matching files through LFS
git add .gitattributes
git lfs pull              # fetch LFS content for the current checkout
```

The filters `git lfs install` registers call `git-lfs` by bare name, so Git
finds it wherever this package is on `PATH` — in an `ocx exec`, an `ocx shell`,
or a shell with the package selected.

## Links

- [Git LFS](https://git-lfs.com)
- [Git LFS on GitHub](https://github.com/git-lfs/git-lfs)
- [Git LFS Releases](https://github.com/git-lfs/git-lfs/releases)
