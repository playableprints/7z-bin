#!/bin/bash

if [[ "$OSTYPE" != "linux-gnu" ]]; then
    exit(1)
fi

VERSION=$ARG[2]
DOWNLOAD_PATH="https://7-zip.org/a"

# Linux:
linux_downloads=("x64","x86", "arm64", "arm")

for ARCH in $linux_downloads; do
    wd=/tmp/7z-bin/linux/${ARCH}
    mkdir -p $wd
    wget -o "${wd}/7z.tar.xz" "${DOWNLOAD_PATH}/7z${VERSION}-linux-${ARCH}.tar.xz"
    tar xf -C  -C "${wd}/" "7z.tar.xz"
    mkdir -p ./linux/${ARCH}/
    cp "${wd}/7zzs" ./linux/${ARCH}/7za
done

# Mac:
# Universal binary, so doesn't care about arch
wd="/tmp/7z-bin/mac"
mkdir -p "${wd}"
wget -o "${wd}/7za.tar.xz" "${DOWNLOAD_PATH}/7z${VERSION}-mac.tar.xz"
tar xf -C "${wd}/" "7z.tar.xz"
cp "${wd}/7zz" ./mac/7za

# Windows:
# (on Linux)
mkdir -p /tmp/7z-bin/win/
wget -o /tmp/7z-bin/win/7za.7z "${DOWNLOAD_PATH}/7z${VERSION}-extra.7z"
/tmp/7z-bin/linux/7zzs x -y -o /tmp/7z-bin/win/ "7za.7z"
mkdir -p ./win/{ia32, x64}
cp 7za.exe ./win/ia32/7za.exe
cp x64/7za.exe ./win/x64/7za.exe
