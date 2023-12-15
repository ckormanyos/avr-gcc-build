#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

mkdir -p gcc_build

cd gcc_build

mkdir -p usr

wget --no-check-certificate https://libisl.sourceforge.io/isl-0.15.tar.bz2
tar -xf isl-0.15.tar.bz2
mkdir objdir-isl-0.15
cd objdir-isl-0.15
../isl-0.15/configure --prefix=../usr/local/isl-0.15 --build=x86_64-w64-mingw32 --host=x86_64-pc-linux --enable-static --disable-shared

make --jobs=4
make install
