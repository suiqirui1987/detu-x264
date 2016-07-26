#! /bin/bash

export PREFIX=./libx264
export NDK=/home/hcm/work/android-ndk-r10e
export SYSROOT=$NDK/platforms/android-8/arch-arm
export TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64

./configure --prefix=$PREFIX --enable-static --enable-pic --disable-asm --disable-cli \
	--host=arm-linux --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
 	--sysroot=$SYSROOT

make -j8 && make install
