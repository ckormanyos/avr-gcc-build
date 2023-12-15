#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build



wget --no-check-certificate https://gmplib.org/download/gmp/gmp-6.1.0.tar.xz
tar -xf gmp-6.1.0.tar.xz
mkdir objdir-gmp-6.1.0
cd objdir-gmp-6.1.0
../gmp-6.1.0/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.1.0 --build=x86_64-w64-mingw32 --host=x86_64-unknown-linux-gnu --enable-static --disable-shared

make --jobs=8
make install

exit
