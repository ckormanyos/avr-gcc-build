#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

wget --no-check-certificate https://www.mpfr.org/mpfr-current/mpfr-4.2.1.tar.bz2
tar -xf mpfr-4.2.1.tar.bz2
mkdir objdir-mpfr-4.2.1
cd objdir-mpfr-4.2.1
../mpfr-4.2.1/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1 --build=x86_64-unknown-linux-gnu --host=x86_64-w64-mingw32 --enable-static --disable-shared --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0

make --jobs=8
make install

exit
