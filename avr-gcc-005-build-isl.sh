#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

wget --no-check-certificate https://libisl.sourceforge.io/isl-0.15.tar.bz2
tar -xf isl-0.15.tar.bz2
mkdir objdir-isl-0.15
cd objdir-isl-0.15
../isl-0.15/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/isl-0.15

make --jobs=8
make install

exit