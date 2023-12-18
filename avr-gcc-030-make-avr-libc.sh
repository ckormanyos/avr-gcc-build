#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

BUILD_NAME=$1
HOST_NAME=$2

cd gcc_build/avr-libc

./bootstrap

cd ..

PATH=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr/bin:"$PATH"
export PATH

CC=""
export CC

cd objdir-gcc-13.2.0-avr
../avr-libc/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --build=$BUILD_NAME --host=avr

make --jobs=6
make install

exit 0
