ckormanyos/avr-gcc-build
==================

---
**NOTE**

`ckormanyos/avr-gcc-build` (this repository) is work in progress.

---

<p align="center">
    <a href="https://github.com/ckormanyos/avr-gcc-build/actions">
        <img src="https://github.com/ckormanyos/avr-gcc-build/actions/workflows/avr-gcc-build.yml/badge.svg" alt="Build Status"></a>
</p>

`ckormanyos/avr-gcc-build` provides shell and YAML scripts to build a modern `avr-gcc`
on GHA native runners.

## Workflow

The build runs on GHA `ubuntu-latest` which is a `x86_64-linux-gnu` host.
  - The GCC prerequisites GMP, MPFR and MPC are built on-the-fly in the Workflor-RUN.
  - Subsequently `binutils-2.41` is built.
  - Then build `avr-gcc`.
  - Clone `avr-libc` and build it directly in the propoer location relative to `avr-gcc`.

A simple test of the newly built compiler is performed. In this test,
we build `ref_app` (the reference application)
from [ckormanyos/real-time-cpp`](https://github.com/ckormanyos)
and verify the creation of all expected build artifacts.

## Additional Details

Limitations:
  - At the moment, the script builds `avr-gcc` version 13.2.0 for the target `x86_64-linux-gnu` only.
  - Build artifacts are archived and stored directly from the Workflow-Run on GHA.
