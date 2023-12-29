ckormanyos/avr-gcc-build
==================

<p align="center">
    <a href="https://github.com/ckormanyos/avr-gcc-build/actions">
        <img src="https://github.com/ckormanyos/avr-gcc-build/actions/workflows/avr-gcc-build.yml/badge.svg" alt="Build Status"></a>
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
  - Build `avr-gcc` from up-to-date releases such as 12.3.0 or modern branches like `trunk` and `releases/gcc-13` found in [`gcc-mirror/gcc`](https://github.com/gcc-mirror/gcc).
  - Provide a non-trivial test of the newly-built toolchain(s) based on a real-world project.
  - Support cyclic monthly build of modern, evolving GCC branch(es) and trunk.
  - Publish the build artifacts directly from the Workflow-Run(s) on GHA.

## Workflow-Run

Workflow:
  - The Workflow-Run [avr-gcc-build.yml](./.github/workflows/avr-gcc-build.yml) and its associated shell scripts (`avr-gcc-010*.sh`, `avr-gcc-020*.sh`, and `avr-gcc-030*.sh`) build `avr-gcc` for the _host_ `x86_64-linux-gnu`. These run on a GHA `ubuntu-latest` runner.
  - The Workflow-Run [avr-gcc-build-msys2-gcc.yml](./.github/workflows/avr-gcc-build-msys2-gcc.yml) and its associated shell script [avr-gcc-100-12.3.0_x86_64-w64-mingw32.sh](./avr-gcc-100-12.3.0_x86_64-w64-mingw32.sh) build `avr-gcc` for the _host_ `x86_64-w64-mingw32`. These run on a GHA `windows-latest` runner using `msys2`.
  - GCC prerequisites such as [GMP](https://gmplib.org), [MPFR](https://www.mpfr.org) and [MPC](https://www.multiprecision.org) are built on-the-fly in the Workflow-Run.
  - Build [`binutils`](https://www.gnu.org/software/binutils) and partially verify the build artifacts. At the moment, version 2.41 is used.
  - Then build `avr-gcc` and partially verify the build artifacts.
  - Clone [`avrdudes/avr-libc`](https://github.com/avrdudes/avr-libc) and build it directly in its expected location relative to `avr-gcc`. After this, partially verify the presence of the build artifacts.
  - Test the complete, newly built `avr-gcc` toolchain with a non-trivial compiler test.
  - In the compiler test, we build `ref_app` (the reference application) from [`ckormanyos/real-time-cpp`](https://github.com/ckormanyos). Verify the creation of key build results from `ref_app` including ELF-file, HEX-file, map files, etc.

## Distribution

Build artifacts are compressed and stored as ZIP-archive(s)
directly from the Workflow-Run on GHA.
The [`actions/upload-artifact`](https://github.com/actions/upload-artifact) action
is used for archiving build artifacts.

## Additional Details

Details:
  - This project is distributed under [The Unlicense](./UNLICENSE).
  - This work has been inspired by (the similar) project [`ZakKemble/avr-gcc-build`](https://github.com/ZakKemble/avr-gcc-build).
