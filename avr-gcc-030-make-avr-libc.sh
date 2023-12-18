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

ls -la /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr//lib/gcc/avr/13.2.0/avr5 /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr//lib/gcc/avr/13.2.0/avr5/libgcc.a /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr//lib/gcc/avr/13.2.0/avr5/libgcov.a /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr//lib/gcc/avr/13.2.0/avr5/double64 /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr//lib/gcc/avr/13.2.0/avr5/long-double32
result_total=$?

echo "result_total: " "$result_total"

exit $result_total
