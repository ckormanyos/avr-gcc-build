#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

BUILD_NAME=$1
HOST_NAME=$2

cd gcc_build

wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.gz
tar -xf gcc-13.2.0.tar.gz
mkdir objdir-gcc-13.2.0-avr
cd objdir-gcc-13.2.0-avr
../gcc-13.2.0/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --target=avr --build=$BUILD_NAME --host=$HOST_NAME --with-pkgversion='Built by ckormanyos/real-time-cpp' --enable-languages=c,c++ --disable-shared --enable-static --disable-libada --disable-libssp --disable-nls --disable-quadmath --disable-decimal_float --enable-mingw-wildcard --with-dwarf2 --enable-plugin --with-gnu-as --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --with-mpfr=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1 --with-mpc=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpc-1.2.1

make --jobs=`nproc`
make install

ls -la /home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr/bin/avr-gcc
result_total=$?

echo "result_total: " "$result_total"

exit $result_total
