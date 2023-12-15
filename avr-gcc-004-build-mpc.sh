#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

wget --no-check-certificate https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz
tar -xf mpc-1.2.1.tar.gz
mkdir objdir-mpc-1.2.1
cd objdir-mpc-1.2.1
../mpc-1.2.1/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpc-1.2.1 --build=x86_64-unknown-linux-gnu --target=x86_64-w64-mingw32 --enable-static --disable-shared --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --with-mpfr=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1

make --jobs=8
make install

exit
