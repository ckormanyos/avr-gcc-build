#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2023.
#  Distributed under The Unlicense.
#

SCRIPT_PATH=$(readlink -f "$BASH_SOURCE")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")


# echo 'install necessary packages and build tools'
# pacman -S --needed --noconfirm wget git make cmake ninja patch texinfo bzip2 xz autoconf automake python

# Get standalone msys2 from nuwen (contains standalone gcc-x86_64-w64-mingw32).
# The page describing this is: https://nuwen.net/mingw.html
# The exact download link is: https://nuwen.net/files/mingw/mingw-18.0.exe

# For detailed background information, see also the detailed instructions
# at GitHub from Stephan T. Lavavej's repositiony.
# These can be found here: https://github.com/StephanTLavavej/mingw-distro


echo 'clean gcc_build directory'
rm -rf gcc_build | true


echo 'make and enter gcc_build directory'
mkdir -p $SCRIPT_DIR/gcc_build


echo 'copy gcc 12.3.0 patch file'
cd $SCRIPT_DIR/gcc_build
cp ../avr-gcc-100-12.3.0_x86_64-w64-mingw32.patch .


echo 'append standalone gcc-x86_64-w64-mingw32 path'
export X_DISTRO_ROOT=$SCRIPT_DIR/mingw
export X_DISTRO_BIN=$X_DISTRO_ROOT/bin
export X_DISTRO_INC=$X_DISTRO_ROOT/include
export X_DISTRO_LIB=$X_DISTRO_ROOT/lib
export PATH=$PATH:$X_DISTRO_BIN
export C_INCLUDE_PATH=$X_DISTRO_INC
export CPLUS_INCLUDE_PATH=$X_DISTRO_INC


echo 'query version pre-installed standalone gcc-x86_64-w64-mingw32'
g++ -v


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
#wget --no-check-certificate https://ftp.gnu.org/gnu/gcc/gcc-12.3.0/gcc-12.3.0.tar.xz


cd $SCRIPT_DIR/gcc_build
echo 'build zstd'
tar -xf zstd-1.5.5.tar.gz
mkdir objdir-zstd-1.5.5
cd objdir-zstd-1.5.5
cmake "-DCMAKE_BUILD_TYPE=Release" "-DCMAKE_C_FLAGS=-s -O3" "-DCMAKE_INSTALL_PREFIX=$SCRIPT_DIR/local/zstd-1.5.5" "-DZSTD_BUILD_SHARED=OFF" -G Ninja $SCRIPT_DIR/gcc_build/zstd-1.5.5/build/cmake
ninja
ninja install


cd $SCRIPT_DIR/gcc_build
echo 'build libiconv'
tar -xf libiconv-1.17.tar.gz
mkdir objdir-libiconv-1.17
cd objdir-libiconv-1.17
../libiconv-1.17/configure --prefix=$SCRIPT_DIR/local/libiconv-1.17 --build=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-static --disable-shared
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build gmp'
tar -xf gmp-6.3.0.tar.xz
mkdir objdir-gmp-6.3.0
cd objdir-gmp-6.3.0
../gmp-6.3.0/configure --prefix=$SCRIPT_DIR/local/gmp-6.3.0 --build=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-static --disable-shared
make --jobs=`nproc`
make install


cd $SCRIPT_DIR/gcc_build
echo 'build mpfr'
tar -xf mpfr-4.2.1.tar.xz
mkdir objdir-mpfr-4.2.1
cd objdir-mpfr-4.2.1
../mpfr-4.2.1/configure --prefix=$SCRIPT_DIR/local/mpfr-4.2.1 --build=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-static --disable-shared --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build mpc'
tar -xf mpc-1.3.1.tar.gz
mkdir objdir-mpc-1.3.1
cd objdir-mpc-1.3.1
../mpc-1.3.1/configure --prefix=$SCRIPT_DIR/local/mpc-1.3.1 --build=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-static --disable-shared --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0 --with-mpfr=$SCRIPT_DIR/local/mpfr-4.2.1
make --jobs=`nproc`
make install


cd $SCRIPT_DIR/gcc_build
echo 'build isl'
tar -xjf isl-0.15.tar.bz2
mkdir objdir-isl-0.15
cd objdir-isl-0.15
../isl-0.15/configure --prefix=$SCRIPT_DIR/local/isl-0.15 --build=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-static --disable-shared --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0
make --jobs=`nproc`
make install


cd $SCRIPT_DIR/gcc_build
echo 'build cloog'
tar -xf cloog-0.18.1.tar.gz
mkdir objdir-cloog-0.18.1
cd objdir-cloog-0.18.1
../cloog-0.18.1/configure --prefix=$SCRIPT_DIR/local/cloog-0.18.1 --build=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --enable-static --disable-shared --with-isl=$SCRIPT_DIR/local/isl-0.15 --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0
make --jobs=6
make install


cd $SCRIPT_DIR/gcc_build
echo 'build binutils'
tar -xf binutils-2.41.tar.xz
mkdir objdir-binutils-2.41-avr-gcc-12.3.0
cd objdir-binutils-2.41-avr-gcc-12.3.0
../binutils-2.41/configure --prefix=$SCRIPT_DIR/local/gcc-12.3.0-avr --target=avr --enable-languages=c,c++ --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --with-pkgversion='Built by ckormanyos/real-time-cpp' --enable-static --disable-shared --disable-libada --disable-libssp --disable-nls --enable-mingw-wildcard --with-gnu-as --with-dwarf2 --with-isl=$SCRIPT_DIR/local/isl-0.15 --with-cloog=$SCRIPT_DIR/local/cloog-0.18.1 --with-gmp=$SCRIPT_DIR/local/gmp-6.3.0 --with-mpfr=$SCRIPT_DIR/local/mpfr-4.2.1 --with-mpc=$SCRIPT_DIR/local/mpc-1.3.1 --with-libiconv-prefix=$SCRIPT_DIR/local/libiconv-1.17 --with-zstd=$SCRIPT_DIR/local/zstd-1.5.5/lib --disable-werror
make --jobs=`nproc`
make install


ls -la $SCRIPT_DIR/local/gcc-12.3.0-avr/bin $SCRIPT_DIR/local/gcc-12.3.0-avr/bin/avr-ld*


echo "result_total: " "$result_total"


exit $result_total
