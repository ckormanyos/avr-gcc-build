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
