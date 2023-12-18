#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

BUILD_NAME=$1
HOST_NAME=$2
BRANCH_NAME=$3

cd gcc_build/avr-libc

./bootstrap

cd ..

PATH=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-"$BRANCH_NAME"-avr/bin:"$PATH"
export PATH

CC=""
export CC

cd objdir-gcc-"$BRANCH_NAME"-avr
../avr-libc/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-"$BRANCH_NAME"-avr --build=$BUILD_NAME --host=avr

make --jobs=6
make install

ls -la /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-"$BRANCH_NAME"-avr/lib/gcc/avr/"$BRANCH_NAME"/avr5 /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-"$BRANCH_NAME"-avr/lib/gcc/avr/"$BRANCH_NAME"/avr5/libgcc.a /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-"$BRANCH_NAME"-avr/lib/gcc/avr/"$BRANCH_NAME"/avr5/libgcov.a /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-"$BRANCH_NAME"-avr/lib/gcc/avr/"$BRANCH_NAME"/avr5/double64 /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-"$BRANCH_NAME"-avr/lib/gcc/avr/"$BRANCH_NAME"/avr5/long-double32
result_total=$?

echo "result_total: " "$result_total"

exit $result_total
