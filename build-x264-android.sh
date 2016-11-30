#! /bin/bash

OS=`uname`
HOST_ARCH=`uname -m`
export CCACHE=; type ccache >/dev/null 2>&1 && export CCACHE=ccache
if [ $OS == 'Linux' ]; then
    export HOST_SYSTEM=linux-$HOST_ARCH
elif [ $OS == 'Darwin' ]; then
    export HOST_SYSTEM=darwin-$HOST_ARCH
fi

export PREFIX=./out
export NDK=$ANDROID_NDK
export SYSROOT=$NDK/platforms/android-14/arch-arm
export TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/$HOST_SYSTEM/bin/arm-linux-androideabi-
export HOST=arm-linux
EXTRA_CFLAGS=""
EXTRA_LDFLAGS=""

rm -r $PREFIX

PLATFORMS="armv5 armv7a x86"
for platform in $PLATFORMS; 
do
	if [ $platform = "armv5" ] ; then
        EXTRA_CFLAGS=""
        EXTRA_LDFLAGS=""
    elif [ $platform = "armv7a" ] ; then
        EXTRA_CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=neon -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__"
        EXTRA_LDFLAGS="-nostdlib"
    elif [ $platform = "x86" ] ; then 
        SYSROOT=$NDK/platforms/android-14/arch-x86
        TOOLCHAIN=$NDK/toolchains/x86-4.8/prebuilt/$HOST_SYSTEM/bin/i686-linux-android-
        HOST=x86-linux
        EXTRA_CFLAGS=""
        EXTRA_LDFLAGS=""
    fi
    echo "platform:$platform,EXTRA_CFLAGS:$EXTRA_CFLAGS"
    PREFIX=./detuout/$platform
    ./configure  --prefix=$PREFIX \
    --cross-prefix=$TOOLCHAIN \
    --extra-cflags="$EXTRA_CFLAGS" \
    --extra-ldflags="$EXTRA_LDFLAGS" \
    --enable-pic \
    --enable-static \
    --enable-shared \
    --disable-asm \
    --enable-strip \
    --disable-cli \
    --host=$HOST \
    --sysroot=$SYSROOT

    make clean
    make STRIP= -j4 install

done



