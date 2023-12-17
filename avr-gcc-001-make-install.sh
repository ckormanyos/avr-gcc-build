#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

HOST_NAME=$1

mkdir -p gcc_build

cd gcc_build

cp ../gmp-6.3.0.tar.xz ./gmp-6.3.0.tar.xz
tar -xf gmp-6.3.0.tar.xz
mkdir objdir-gmp-6.3.0
cd objdir-gmp-6.3.0
../gmp-6.3.0/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --build=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared

make --jobs=8
make install



wget --no-check-certificate https://www.mpfr.org/mpfr-current/mpfr-4.2.1.tar.bz2
tar -xf mpfr-4.2.1.tar.bz2
mkdir objdir-mpfr-4.2.1
cd objdir-mpfr-4.2.1
../mpfr-4.2.1/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1 --build=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0

make --jobs=8
make install



wget --no-check-certificate https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz
tar -xf mpc-1.2.1.tar.gz
mkdir objdir-mpc-1.2.1
cd objdir-mpc-1.2.1
../mpc-1.2.1/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpc-1.2.1 --build=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --with-mpfr=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1

make --jobs=8
make install




wget --no-check-certificate https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.bz2
tar -xf binutils-2.41.tar.bz2
mkdir objdir-binutils-2.41-avr-gcc-13.2.0
cd objdir-binutils-2.41-avr-gcc-13.2.0
../binutils-2.41/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --target=avr --build=$HOST_NAME --host=$HOST_NAME --disable-shared --enable-static --disable-libada --disable-libssp --disable-nls --enable-mingw-wildcard --with-gnu-as --with-dwarf2 --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0

make --jobs=8
make install


wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.gz
tar -xf gcc-13.2.0.tar.gz
mkdir objdir-gcc-13.2.0-avr
cd objdir-gcc-13.2.0-avr
../gcc-13.2.0/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-13.2.0-avr --target=avr --build=$HOST_NAME --host=$HOST_NAME --with-pkgversion='Built by ckormanyos/real-time-cpp' --enable-languages=c,c++ --disable-nls --disable-libssp --disable-libada --with-dwarf2 --disable-shared --enable-static --enable-mingw-wildcard --enable-plugin --with-gnu-as --with-gmp=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --with-mpfr=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1 --with-mpc=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpc-1.2.1

make --jobs=8
make install



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

exit 0
