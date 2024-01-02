#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023 - 2024.
#  Distributed under The Unlicense.
#
# Example call:
#   ./avr-gcc-100-12.3.0_x86_64-linux-gnu.sh 12.3.0 x86_64-linux-gnu x86_64-linux-gnu
#

SCRIPT_PATH=$(readlink -f "$BASH_SOURCE")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

MY_VERSION=$1
HOST_NAME=$2
BUILD_NAME=$3


echo 'clean gcc_build directory'
rm -rf gcc_build | true


echo 'make and enter gcc_build directory'
mkdir -p $SCRIPT_DIR/gcc_build
echo


if [[ "$1" != "12.3.0" ]]; then
echo 'copy gcc patch file'
cd $SCRIPT_DIR/gcc_build
cp ../avr-gcc-100-"$MY_VERSION"_"$BUILD_NAME".patch .
echo
fi


echo 'query system gcc'
g++ -v
result_system_gcc=$?
echo "result_system_gcc: " "$result_system_gcc"
echo


cd $SCRIPT_DIR/gcc_build
echo 'get tar-balls'
wget --no-check-certificate https://github.com/facebook/zstd/releases/download/v1.5.5/zstd-1.5.5.tar.gz
wget --no-check-certificate https://ftp.gnu.org/gnu/libiconv/libiconv-1.17.tar.gz
wget --no-check-certificate https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
wget --no-check-certificate https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz
wget --no-check-certificate https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
wget --no-check-certificate https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.15.tar.bz2
wget --no-check-certificate https://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz
wget --no-check-certificate https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.xz
wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-"$MY_VERSION"/gcc-"$MY_VERSION".tar.xz
wget --no-check-certificate https://github.com/avrdudes/avr-libc/archive/refs/tags/avr-libc-2_1_0-release.tar.gz
echo


cd $SCRIPT_DIR/gcc_build
echo 'build zstd'
tar -xf zstd-1.5.5.tar.gz
mkdir objdir-zstd-1.5.5
cd objdir-zstd-1.5.5
cmake "-DCMAKE_BUILD_TYPE=Release" "-DCMAKE_C_FLAGS=-s -O2" "-DCMAKE_INSTALL_PREFIX=$SCRIPT_DIR/local/zstd-1.5.5" "-DZSTD_BUILD_SHARED=OFF" -G Ninja $SCRIPT_DIR/gcc_build/zstd-1.5.5/build/cmake
ninja
ninja install
echo


cd $SCRIPT_DIR/gcc_build
echo 'build libiconv'
tar -xf libiconv-1.17.tar.gz
mkdir objdir-libiconv-1.17
cd objdir-libiconv-1.17
../libiconv-1.17/configure --prefix=$SCRIPT_DIR/local/libiconv-1.17 --build="$BUILD_NAME" --target="$HOST_NAME" --host="$HOST_NAME" --enable-static --disable-shared
make --jobs=6
make install
echo


cd $SCRIPT_DIR/gcc_build
echo 'build gmp'
tar -xf gmp-6.3.0.tar.xz
mkdir objdir-gmp-6.3.0
cd objdir-gmp-6.3.0
../gmp-6.3.0/configure --prefix=$SCRIPT_DIR/local/gmp-6.3.0 --build="$BUILD_NAME" --target="$HOST_NAME" --host="$HOST_NAME" --enable-static --disable-shared
make --jobs=6
make install
echo


cd $SCRIPT_DIR/gcc_build
echo 'build mpfr'
tar -xf mpfr-4.2.1.tar.xz
mkdir objdir-mpfr-4.2.1
cd objdir-mpfr-4.2.1
../mpfr-4.2.1/configure --prefix=$SCRIPT_DIR/local/mpfr-4.2.1 --build="$BUILD_NAME" --target="$HOST_NAME" --host="$HOST_NAME" --enable-static --disable-shared --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0
make --jobs=6
make install
echo


cd $SCRIPT_DIR/gcc_build
echo 'build mpc'
tar -xf mpc-1.3.1.tar.gz
mkdir objdir-mpc-1.3.1
cd objdir-mpc-1.3.1
../mpc-1.3.1/configure --prefix=$SCRIPT_DIR/local/mpc-1.3.1 --build="$BUILD_NAME" --target="$HOST_NAME" --host="$HOST_NAME" --enable-static --disable-shared --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0 --with-mpfr=$SCRIPT_DIR/local/mpfr-4.2.1
make --jobs=6
make install
echo


cd $SCRIPT_DIR/gcc_build
echo 'build isl'
tar -xjf isl-0.15.tar.bz2
mkdir objdir-isl-0.15
cd objdir-isl-0.15
../isl-0.15/configure --prefix=$SCRIPT_DIR/local/isl-0.15 --build="$BUILD_NAME" --target="$HOST_NAME" --host="$HOST_NAME" --enable-static --disable-shared --with-gmp-prefix=$SCRIPT_DIR/local/gmp-6.3.0
make --jobs=6
make install
echo


cd $SCRIPT_DIR/gcc_build
echo 'build cloog'
tar -xf cloog-0.18.1.tar.gz
mkdir objdir-cloog-0.18.1
cd objdir-cloog-0.18.1
../cloog-0.18.1/configure --prefix=$SCRIPT_DIR/local/cloog-0.18.1 --build="$BUILD_NAME" --target="$HOST_NAME" --host="$HOST_NAME" --enable-static --disable-shared --with-isl=$SCRIPT_DIR/local/isl-0.15 --with-gmp-prefix=$SCRIPT_DIR/local/gmp-6.3.0
make --jobs=6
make install
echo


cd $SCRIPT_DIR/gcc_build
echo 'build binutils'
tar -xf binutils-2.41.tar.xz
mkdir objdir-binutils-2.41-avr-gcc-"$MY_VERSION"
cd objdir-binutils-2.41-avr-gcc-"$MY_VERSION"
../binutils-2.41/configure --prefix=$SCRIPT_DIR/local/gcc-"$MY_VERSION"-avr --target=avr --enable-languages=c,c++ --build="$BUILD_NAME" --host="$HOST_NAME" --with-pkgversion='Built by ckormanyos/real-time-cpp' --disable-plugins --enable-static --disable-shared --disable-tls --disable-libada --disable-libssp --disable-nls --enable-mingw-wildcard --with-gnu-as --with-dwarf2 --with-isl=$SCRIPT_DIR/local/isl-0.15 --with-cloog=$SCRIPT_DIR/local/cloog-0.18.1 --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0 --with-mpfr=$SCRIPT_DIR/local/mpfr-4.2.1 --with-mpc=$SCRIPT_DIR/local/mpc-1.3.1 --with-libiconv-prefix=$SCRIPT_DIR/local/libiconv-1.17 --with-zstd=$SCRIPT_DIR/local/zstd-1.5.5/lib --disable-werror
make --jobs=6
make install
echo


ls -la $SCRIPT_DIR/local/gcc-"$MY_VERSION"-avr/bin
ls -la $SCRIPT_DIR/local/gcc-"$MY_VERSION"-avr/bin/avr-ld
result_binutils=$?


echo "result_binutils: " "$result_binutils"
echo


#
# Notes on patch of GCC-12.3.0
#

# How do you make the patch? (Example for gcc-12.3.0)
#   diff -ru gcc-12.3.0/ gcc-12.3.0_new/ > avr-gcc-100-12.3.0_x86_64-w64-mingw32.patch

# How do you apply the patch? (Example for gcc-12.3.0)
#   patch -p0 < avr-gcc-100-12.3.0_x86_64-w64-mingw32.patch


cd $SCRIPT_DIR/gcc_build
echo 'build gcc'
tar -xf gcc-"$MY_VERSION".tar.xz
if [[ "$1" != "12.3.0" ]]; then
patch -p0 < avr-gcc-100-"$MY_VERSION"_"$BUILD_NAME".patch
fi
mkdir objdir-gcc-"$MY_VERSION"-avr
cd objdir-gcc-"$MY_VERSION"-avr
../gcc-"$MY_VERSION"/configure --prefix=$SCRIPT_DIR/local/gcc-"$MY_VERSION"-avr --target=avr --enable-languages=c,c++ --build="$BUILD_NAME" --host="$HOST_NAME" --with-pkgversion='Built by ckormanyos/real-time-cpp' --disable-gcov --enable-static --disable-shared --disable-tls --disable-libada --disable-libssp --disable-nls --enable-mingw-wildcard --with-gnu-as --with-dwarf2 --with-isl=$SCRIPT_DIR/local/isl-0.15 --with-cloog=$SCRIPT_DIR/local/cloog-0.18.1 --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0 --with-mpfr=$SCRIPT_DIR/local/mpfr-4.2.1 --with-mpc=$SCRIPT_DIR/local/mpc-1.3.1 --with-libiconv-prefix=$SCRIPT_DIR/local/libiconv-1.17 --with-zstd=$SCRIPT_DIR/local/zstd-1.5.5/lib
make --jobs=6
make install
echo


ls -la $SCRIPT_DIR/local/gcc-"$MY_VERSION"-avr/bin
ls -la $SCRIPT_DIR/local/gcc-"$MY_VERSION"-avr/bin/avr-g++
result_gcc=$?


echo "result_gcc: " "$result_gcc"
echo


cd $SCRIPT_DIR/gcc_build
echo 'unpack and bootstrap avr-libc'
tar -xf avr-libc-2_1_0-release.tar.gz
mv avr-libc-avr-libc-2_1_0-release avr-libc-2_1_0-release
rm -f avr-libc-2_1_0-release/tests/simulate/time/aux.c
cd avr-libc-2_1_0-release
./bootstrap
result_bootstrap=$?
echo "result_bootstrap: " "$result_bootstrap"
echo


cd $SCRIPT_DIR/gcc_build
echo 'add avr-gcc path'
PATH=$SCRIPT_DIR/local/gcc-"$MY_VERSION"-avr/bin:"$PATH"
export PATH
CC=""
export CC
echo


cd $SCRIPT_DIR/gcc_build
echo 'build avr-libc'
cd objdir-gcc-"$MY_VERSION"-avr
../avr-libc-2_1_0-release/configure --prefix=$SCRIPT_DIR/local/gcc-"$MY_VERSION"-avr --build="$BUILD_NAME" --host=avr --enable-static --disable-shared
make --jobs=8
make install
echo


result_total=$((result_system_gcc+result_binutils+result_gcc+result_bootstrap))


echo "result_total: " "$result_total"
echo


exit $result_total
