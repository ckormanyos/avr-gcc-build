ckormanyos/avr-gcc-build
==================

<p align="center">
    <a href="https://github.com/ckormanyos/avr-gcc-build/actions">
        <img src="https://github.com/ckormanyos/avr-gcc-build/actions/workflows/avr-gcc-build.yml/badge.svg" alt="build-ubuntu"></a>
    <a href="https://github.com/ckormanyos/avr-gcc-build/actions">
        <img src="https://github.com/ckormanyos/avr-gcc-build/actions/workflows/avr-gcc-build-msys2-gcc.yml/badge.svg" alt="build-msys2"></a>
    <a href="https://github.com/ckormanyos/avr-gcc-build/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc">
        <img src="https://custom-icon-badges.herokuapp.com/github/issues-raw/ckormanyos/avr-gcc-build?logo=github" alt="Issues" /></a>
    <a href="https://github.com/ckormanyos/avr-gcc-build/blob/main/UNLICENSE">
        <img src="https://img.shields.io/badge/license-The Unlicense-blue.svg" alt="The Unlicense"></a>
</p>

`ckormanyos/avr-gcc-build` provides shell and YAML scripts to build a modern `avr-gcc`
on GHA native runner(s). Built toolchains are distributed as ZIP-archive(s)
directly from the Workflow-Run(s) on GHA.

Design goals:
  - Use shell and YAML scripts to build modern `avr-gcc` on-the-fly.
  - Build `avr-gcc` from up-to-date [gcc-releases](https://ftp.gnu.org/gnu/gcc).
  - Provide a non-trivial test of the newly-built toolchain(s) based on a real-world project.
  - Support cyclic monthly build of modern, evolving GCC branch(es) and trunk.
  - Publish the build artifacts directly from the GHA Workflow-Run(s).
  - TBD: Publish named releases instead of publishing directly from the GHA Workflow-Run(s), see also [issue 26](https://github.com/ckormanyos/avr-gcc-build/issues/26).

## Workflow-Run

Workflow:
  - The Workflow-Run [avr-gcc-build.yml](./.github/workflows/avr-gcc-build.yml) and its associated shell scripts (`avr-gcc-010*.sh`, `avr-gcc-020*.sh`, and `avr-gcc-030*.sh`) build `avr-gcc` for the _host_ `x86_64-linux-gnu`. These run on a GHA `ubuntu-latest` runner.
  - The Workflow-Run [avr-gcc-build-msys2-gcc.yml](./.github/workflows/avr-gcc-build-msys2-gcc.yml) and its associated shell script [avr-gcc-100-my_ver_x86_64-w64-mingw32.sh](./avr-gcc-100-my_ver_x86_64-w64-mingw32.sh) build `avr-gcc` for the _host_ `x86_64-w64-mingw32`. These run on a GHA `windows-latest` runner using `msys2`.
  - When building for `x86_64-w64-mingw32` on `msys2`, use a pre-built, dependency-free, statically linked `mingw` and host-compiler (see notes below). This separate `mingw` package is unpacked in a directory parallel to the runner workspace and its `bin` directory is added to the `PATH` variable.
  - GCC prerequisites including [GMP](https://gmplib.org), [MPFR](https://www.mpfr.org), [MPC](https://www.multiprecision.org), etc. are built on-the-fly in the Workflow-Run.
  - Build [`binutils`](https://www.gnu.org/software/binutils) and partially verify the build artifacts.
  - Then build `avr-gcc` and partially verify the build artifacts.
  - Get a modern release of [`avr-libc`](https://github.com/avrdudes/avr-libc/tags) from [`avrdudes/avr-libc`](https://github.com/avrdudes/avr-libc) and build it with its `--prefix` matching that of the above-mentioned `avr-gcc`-build.
  - Test the complete, newly built `avr-gcc` toolchain with a non-trivial compiler test. In the compiler test, we build `ref_app` (the reference application) from [`ckormanyos/real-time-cpp`](https://github.com/ckormanyos). Verify the creation of key build results from `ref_app` including ELF-file, HEX-file, map files, etc.

## Distribution

Build artifacts are compressed and stored as ZIP-archive(s)
directly from the Workflow-Run(s) on GHA.
The [`actions/upload-artifact`](https://github.com/actions/upload-artifact) action
is used for archiving build artifacts.

## Additional Notes

Notes:
  - This project is distributed under [The Unlicense](./UNLICENSE).
  - This work has been inspired by (the similar) project [`ZakKemble/avr-gcc-build`](https://github.com/ZakKemble/avr-gcc-build).
  - The pre-built, dependency-free, statically linked `mingw` and host-compiler system originate from Steven T. Lavavej's [`MinGW Distro`](https://nuwen.net/mingw.html).
