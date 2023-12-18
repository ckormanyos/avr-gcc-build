ckormanyos/avr-gcc-build
==================

<p align="center">
    <a href="https://github.com/ckormanyos/avr-gcc-build/actions">
        <img src="https://github.com/ckormanyos/avr-gcc-build/actions/workflows/avr-gcc-build.yml/badge.svg" alt="Build Status"></a>
</p>

`ckormanyos/avr-gcc-build` provides shell and YAML scripts to build a modern `avr-gcc`
on GHA native runner(s).

## Workflow-Run

Workflow:
  - The build runs on GHA `ubuntu-latest` (i.e., `x86_64-linux-gnu` host).
  - The GCC prerequisites GMP, MPFR and MPC are built on-the-fly in the Workflow-Run.
  - Subsequently build `binutils-2.41` and partially verify the build artifacts.
  - Then build `avr-gcc` and partially verify the build artifacts.
  - Clone [`avrdudes/avr-libc`](https://github.com/avrdudes/avr-libc) and build it directly in the propoer location relative to `avr-gcc` and partially verify the build artifacts.
  - Test the newly built compiler. In this test, we build `ref_app` (the reference application) from [`ckormanyos/real-time-cpp`](https://github.com/ckormanyos).
  - Verify the creation of all expected `ref_app` build results (such as ELF-file, HEX-file, map files, etc.).

## Additional Details

This project is distributed under [The Unlicense](./LICENSE).

Limitations:
  - At the moment, the Workflow-Run builds `avr-gcc` version 13.2.0 for the target `x86_64-linux-gnu` only.
  - Build artifacts are archived and stored directly from the Workflow-Run on GHA.

This work has been inspired by a similar project: [`ZakKemble/avr-gcc-build`](https://github.com/ZakKemble/avr-gcc-build).
