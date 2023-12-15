#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.gz
tar -xf gcc-13.2.0.tar.gz
mkdir objdir-gcc-13.2.0-avr
cd objdir-gcc-13.2.0-avr
../gcc-13.2.0/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --target=avr --host=x86_64-w64-mingw32 --enable-languages=c,c++ --with-pkgversion='Built by ckormanyos/real-time-cpp' --disable-shared --enable-static --disable-libada --disable-libssp --disable-nls --enable-mingw-wildcard --with-gnu-as --with-dwarf2 --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --with-mpfr=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1 --with-mpc=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpc-1.2.1 --with-isl=/home/runner/work/avr-gcc-build/avr-gcc-build/local/isl-0.15

#make --jobs=8
#make install

exit
