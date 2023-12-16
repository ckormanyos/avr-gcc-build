#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

wget --no-check-certificate https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.bz2
tar -xf binutils-2.41.tar.bz2
mkdir objdir-binutils-2.41-avr-gcc-13.2.0
cd objdir-binutils-2.41-avr-gcc-13.2.0
../binutils-2.41/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --target=avr --build=x86_64-unknown-linux-gnu --host=x86_64-w64-mingw32  --with-pkgversion='Built by ckormanyos/real-time-cpp' --disable-shared --enable-static --disable-nls --disable-werror --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0

make --jobs=8
make install

exit
