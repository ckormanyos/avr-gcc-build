#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

wget --no-check-certificate https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.bz2
tar -xf binutils-2.41.tar.bz2
mkdir objdir-binutils-2.41-avr-gcc-12.1.0
cd objdir-binutils-2.41-avr-gcc-12.1.0
../binutils-2.41/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-12.1.0-avr --target=avr --build=`../binutils-2.41/config.guess` --host=x86_64-w64-mingw32  --disable-shared --enable-static --disable-libada --disable-libssp --disable-nls --enable-mingw-wildcard --with-gnu-as --with-dwarf2 --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0

make --jobs=8
make install

exit
