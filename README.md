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
  - Build `avr-gcc` from up-to-date branches such as `trunk` and `releases/gcc-13` found in [`gcc-mirror/gcc`](https://github.com/gcc-mirror/gcc).
  - Provide a non-trivial test of the newly-built toolchain(s) based on a real-world project.
  - Support cyclic monthly build of modern, evolving GCC branch(es) and trunk.
  - Publish the build artifacts directly from the Workflow-Run(s) on GHA.

## Workflow-Run

Workflow:
  - The build runs on GHA `ubuntu-latest` (i.e., `x86_64-linux-gnu` host).
  - GCC prerequisites such as [GMP](https://gmplib.org), [MPFR](https://www.mpfr.org) and [MPC](https://www.multiprecision.org) are built on-the-fly in the Workflow-Run.
  - Build [`binutils`](https://www.gnu.org/software/binutils) and partially verify the build artifacts. At the moment, version 2.41 is used.
  - Then build `avr-gcc` and partially verify the build artifacts.
  - Clone [`avrdudes/avr-libc`](https://github.com/avrdudes/avr-libc) and build it directly in the propoer location relative to `avr-gcc` and partially verify the build artifacts.
  - Test the newly built compiler. In this test, we build `ref_app` (the reference application) from [`ckormanyos/real-time-cpp`](https://github.com/ckormanyos). Subsequently verify the creation of all expected `ref_app` build results (such as ELF-file, HEX-file, map files, etc.).

## Distribution

Build artifacts are compressed and stored as ZIP-archive(s)
directly from the Workflow-Run on GHA.
The [`actions/upload-artifact`](https://github.com/actions/upload-artifact) action
is used for archiving build artifacts.

## Additional Details

This project is distributed under [The Unlicense](./UNLICENSE).

Limitations:
  - At the moment, the Workflow-Run builds `avr-gcc` for the _host_ `x86_64-linux-gnu` only. Cross-host compilation for `x86_64-w64-mingw32` does not work.

This work has been inspired by a similar project: [`ZakKemble/avr-gcc-build`](https://github.com/ZakKemble/avr-gcc-build).
