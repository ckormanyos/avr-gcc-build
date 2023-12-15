#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

cp ../gmp-6.3.0.tar.xz ./gmp-6.3.0.tar.xz
tar -xf gmp-6.3.0.tar.xz
mkdir objdir-gmp-6.3.0
cd objdir-gmp-6.3.0
../gmp-6.3.0/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --build=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --enable-static --disable-shared

make --jobs=8
make install

exit
