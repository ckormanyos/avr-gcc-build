#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

PATH=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr/bin:"$PATH"
export PATH

CC=""
export CC

cd gcc_build/avr-libc3
./bootstrap

cd ../cd objdir-gcc-13.2.0-avr
../avr-libc3/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --host=avr

make --jobs=8
make install

exit
