#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

cd gcc_build

cd avr-libc3
./bootstrap

cd ..
cd objdir-gcc-13.2.0-avr
../avr-libc3/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --build=`../gcc-13.2.0/config.guess` --host=avr

PATH=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr/bin:"$PATH"
export PATH

CC=""
export CC

make --jobs=8
make install

exit
