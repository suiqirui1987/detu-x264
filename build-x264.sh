#! /bin/bash

### MAC

export PREFIX=./libx264
export NDK=$ANDROID_NDK
export SYSROOT=$NDK/platforms/android-8/arch-arm
export TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/darwin-x86_64



./configure --prefix=$PREFIX --enable-static --enable-shared --enable-pic  --disable-cli \
	--host=arm-linux --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
 	--sysroot=$SYSROOT

make -j8 && make install
