# git-lfs/tests/smoke.star — offline checks that need no `git` on the host.

GIT_LFS = "git-lfs.exe" if ocx.target_platform.os == ocx.os.Windows else "git-lfs"

# Version shape and the platform the binary was built for. git-lfs prints Go's
# GOOS/GOARCH, which match the OCI spellings.
r = ocx.run(GIT_LFS, "version")
expect.ok(r)
expect.matches(r.stdout, r"^git-lfs/\d+\.\d+\.\d+ \(")
expect.contains(r.stdout, "; " + str(ocx.target_platform.os) + " " + str(ocx.target_platform.arch) + ";")

# `pointer --file` hashes a file into an LFS pointer without a repository.
ocx.write_file("payload.bin", "ocx-smoke\n")
p = ocx.run(GIT_LFS, "pointer", "--file=payload.bin")
expect.ok(p)
expect.contains(p.stdout, "version https://git-lfs.github.com/spec/v1")
expect.contains(p.stdout, "oid sha256:1bbca808067d25a5f598c3c41bd7e6e8b6c2a9e2d03a49d0b73971df43cc095c")
expect.contains(p.stdout, "size 10")

# `pointer --check` accepts the pointer it wrote and rejects the raw payload.
ocx.write_file("payload.pointer", p.stdout)
expect.ok(ocx.run(GIT_LFS, "pointer", "--check", "--file=payload.pointer"))
expect.eq(ocx.run(GIT_LFS, "pointer", "--check", "--file=payload.bin").exit_code, 1)

# An unknown command is rejected.
expect.eq(ocx.run(GIT_LFS, "ocx-smoke-not-a-command").exit_code, 127)
