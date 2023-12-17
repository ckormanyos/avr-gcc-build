#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

HOST_NAME=$1

cd gcc_build

echo "Clone stevenj/avr-libc3"
git clone -b master --depth 1 https://github.com/stevenj/avr-libc3 ./avr-libc3
cd ./avr-libc3
git checkout d09c2a61764aced3274b6dde4399e11b0aee4a87


PATH=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr/bin:"$PATH"
export PATH

CC=""
export CC

./bootstrap

cd ..
cd cd objdir-gcc-13.2.0-avr
../avr-libc3/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --host=avr

make --jobs=8
make install

exit 0
