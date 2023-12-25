#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

SCRIPT_PATH=$(readlink -f "$BASH_SOURCE")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

BUILD_NAME=$1
HOST_NAME=$2

# echo 'install necessary packages and build tools'
# pacman -S --needed --noconfirm wget make patch git mingw-w64-ucrt-x86_64-gcc texinfo bzip2 xz autoconf automake python unzip


# echo 'clean gcc_build directory'
# rm -rf gcc_build | true


echo 'make and enter gcc_build directory'
mkdir $SCRIPT_DIR/gcc_build


cd $SCRIPT_DIR/gcc_build
cp ../avr-gcc-100-12.3.0_x86_64-w64-mingw32.patch .


cd $SCRIPT_DIR/gcc_build
echo 'get needed tar-balls'
wget --no-check-certificate https://ftp.gnu.org/gnu/libiconv/libiconv-1.17.tar.gz
wget --no-check-certificate https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
wget --no-check-certificate https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz
wget --no-check-certificate https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
wget --no-check-certificate https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.15.tar.bz2
wget --no-check-certificate https://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz
wget --no-check-certificate https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.xz
wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-12.3.0/gcc-12.3.0.tar.xz


cd $SCRIPT_DIR/gcc_build
echo 'clone and build zstd'
git clone -b dev --depth 1 https://github.com/facebook/zstd.git $SCRIPT_DIR/gcc_build/zstd-dev
cd zstd-dev
make OS=Windows


cd $SCRIPT_DIR/gcc_build
echo 'build libiconv'
tar -xf libiconv-1.17.tar.gz
mkdir objdir-libiconv-1.17
cd objdir-libiconv-1.17
../libiconv-1.17/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/libiconv-1.17 --build=$BUILD_NAME --target=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared
make --job=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build gmp'
tar -xf gmp-6.3.0.tar.xz
mkdir objdir-gmp-6.3.0
cd objdir-gmp-6.3.0
../gmp-6.3.0/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --build=$BUILD_NAME --target=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build mpfr'
tar -xf mpfr-4.2.1.tar.xz
mkdir objdir-mpfr-4.2.1
cd objdir-mpfr-4.2.1
../mpfr-4.2.1/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1 --build=$BUILD_NAME --target=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared --with-gmp=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build mpc'
tar -xf mpc-1.3.1.tar.gz
mkdir objdir-mpc-1.3.1
cd objdir-mpc-1.3.1
../mpc-1.3.1/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpc-1.3.1 --build=$BUILD_NAME --target=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared --with-gmp=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --with-mpfr=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build isl'
tar -xjf isl-0.15.tar.bz2
mkdir objdir-isl-0.15
cd objdir-isl-0.15
../isl-0.15/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/isl-0.15 --build=$BUILD_NAME --target=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared --with-gmp=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build cloog'
tar -xf cloog-0.18.1.tar.gz
mkdir objdir-cloog-0.18.1
cd objdir-cloog-0.18.1
../cloog-0.18.1/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/cloog-0.18.1 --build=$BUILD_NAME --target=$HOST_NAME --host=$HOST_NAME --enable-static --disable-shared --with-isl=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/isl-0.15 --with-gmp=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build binutils'
tar -xf binutils-2.41.tar.xz
mkdir objdir-binutils-2.41-avr-gcc-12.3.0
cd objdir-binutils-2.41-avr-gcc-12.3.0
../binutils-2.41/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-12.3.0-avr --target=avr --enable-languages=c,c++ --build=$BUILD_NAME --host=$HOST_NAME --with-pkgversion='Built by ckormanyos/real-time-cpp' --enable-static --disable-shared --disable-libada --disable-libssp --disable-nls --enable-mingw-wildcard --with-gnu-as --with-dwarf2 --with-isl=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/isl-0.15 --with-cloog=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/cloog-0.18.1 --with-gmp=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --with-mpfr=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1 --with-mpc=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpc-1.3.1 --with-libiconv-prefix=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/libiconv-1.17 --with-zstd=$SCRIPT_DIR/zstd-dev/lib --disable-werror
make --jobs=6
make install


#
# Notes on patch of GCC-12.3.0
#

# How do you make the patch?
#   diff -ru gcc-12.3.0/ gcc-12.3.0_new/ > avr-gcc-100-12.3.0_x86_64-w64-mingw32.patch

# How do you apply the patch?
#   patch -p0 < avr-gcc-100-12.3.0_x86_64-w64-mingw32.patch


cd $SCRIPT_DIR/gcc_build
echo 'build gcc'
tar -xf gcc-12.3.0.tar.xz
patch -p0 < avr-gcc-100-12.3.0_x86_64-w64-mingw32.patch
mkdir objdir-gcc-12.3.0-avr
cd objdir-gcc-12.3.0-avr
../gcc-12.3.0/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-12.3.0-avr --target=avr --enable-languages=c,c++ --build=$BUILD_NAME --host=$HOST_NAME --with-pkgversion='Built by ckormanyos/real-time-cpp' --enable-static --disable-shared --disable-libada --disable-libssp --disable-nls --enable-mingw-wildcard --with-gnu-as --with-dwarf2 --with-isl=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/isl-0.15 --with-cloog=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/cloog-0.18.1 --with-gmp=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gmp-6.3.0 --with-mpfr=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpfr-4.2.1 --with-mpc=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/mpc-1.3.1 --with-libiconv-prefix=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/libiconv-1.17 --with-zstd=$SCRIPT_DIR/zstd-dev/lib
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'clone and bootstrap avr-libc'
git clone -b main --depth 1 https://github.com/avrdudes/avr-libc.git ./avr-libc
rm -f avr-libc/tests/simulate/time/aux.c
cd avr-libc
./bootstrap


cd $SCRIPT_DIR/gcc_build
echo 'add avr-gcc path'
PATH=--prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-12.3.0-avr/bin:"$PATH"
export PATH
CC=""
export CC


cd $SCRIPT_DIR/gcc_build
echo 'build avr-libc'
cd objdir-gcc-12.3.0-avr
../avr-libc/configure --prefix=/home/runner/work/avr-gcc-build/avr-gcc-build/local/gcc-12.3.0-avr --build=$BUILD_NAME --host=avr --enable-static --disable-shared
make --jobs=6
make install
