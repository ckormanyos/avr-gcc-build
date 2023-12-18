#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

HOST_NAME=$1

cd gcc_build/avr-libc

./bootstrap

cd ..

PATH=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr/bin:"$PATH"
export PATH

CC=""
export CC

cd objdir-gcc-13.2.0-avr
../avr-libc/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --host=avr

make --jobs=6
make install

exit 0
