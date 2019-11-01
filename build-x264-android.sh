#! /bin/bash


if [ -z "$ANDROID_NDK" -o -z "$ANDROID_NDK" ]; then
    echo "You must define ANDROID_NDK, ANDROID_SDK before starting."
    echo "They must point to your NDK and SDK directories.\n"
    exit 1
fi

PREFIX=./detuout
NDK=$ANDROID_NDK



PLATFORM=""
TOOLCHAIN=""
CROSS_PREFIX=""
HOST=""


rm -r $PREFIX

PLATFORMS="armv7a arm64 x86_64 x86"
for platform in $PLATFORMS; 
do
	if [ $platform = "armv7a" ] ; then
        PLATFORM=$NDK/platforms/android-19/arch-arm/
        TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
        CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
        HOST="arm-linux"
    elif [ $platform = "arm64" ] ; then
         PLATFORM=$NDK/platforms/android-21/arch-arm64/
        TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64
        CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
        HOST="aarch64-linux"
    elif [ $platform = "x86_64" ] ; then 
        PLATFORM=$NDK/platforms/android-21/arch-x86_64/
        TOOLCHAIN=$NDK/toolchains/x86_64-4.9/prebuilt/darwin-x86_64
        CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android-
        HOST="x86_64-linux"
     elif [ $platform = "x86" ] ; then 
        PLATFORM=$NDK/platforms/android-19/arch-x86/
        TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/darwin-x86_64
        CROSS_PREFIX=$TOOLCHAIN/bin/i686-linux-android-
        HOST="i686-linux"
    fi

    echo "platform:$PLATFORM"
    echo "toolchains:$TOOLCHAIN"
    echo "cross-prefix:$CROSS_PREFIX"
    echo "prefix:$PREFIX"
    echo "host:$HOST"



    PREFIX=./detuout/$platform
    ./configure  --prefix=$PREFIX \
    --cross-prefix=$CROSS_PREFIX \
    --extra-cflags="$EXTRA_CFLAGS" \
    --extra-ldflags="$EXTRA_LDFLAGS" \
    --enable-pic \
    --enable-static \
    --enable-shared \
    --disable-asm \
    --enable-strip \
    --disable-cli \
    --host=$HOST \
    --sysroot=$PLATFORM

    echo " ./configure  --prefix=$PREFIX \
    --cross-prefix=$CROSS_PREFIX \
    --extra-cflags="$EXTRA_CFLAGS" \
    --extra-ldflags="$EXTRA_LDFLAGS" \
    --enable-pic \
    --enable-static \
    --enable-shared \
    --disable-asm \
    --enable-strip \
    --disable-cli \
    --host=$HOST \
    --sysroot=$PLATFORM"

  

    make -j4 install

done

echo Android builds finished

