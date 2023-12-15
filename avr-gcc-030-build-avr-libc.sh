#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

cd objdir-gcc-13.2.0-avr
../avr-libc3/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --build=`../gcc-13.2.0/config.guess` --host=avr

make --jobs=8
make install

exit
