#!/bin/bash

if [[ "$OSTYPE" != "linux-gnu" ]]; then
    exit 1
fi

VERSION=$1
DOWNLOAD_PATH="https://7-zip.org/a"

echo "Downloading version $VERSION ..."

# Linux:
linux_downloads="x64 x86 arm64 arm"

for ARCH in $linux_downloads; do
    echo "linux-$ARCH ..."
    wd=/tmp/7z-bin/linux/${ARCH}
    mkdir -p $wd
    wget -O "${wd}/7z.tar.xz" "${DOWNLOAD_PATH}/7z${VERSION}-linux-${ARCH}.tar.xz"
    tar -x -C "${wd}/" -f "${wd}/7z.tar.xz"
    mkdir -p ./linux/${ARCH}/
    cp "${wd}/7zzs" ./linux/${ARCH}/7za
done

# Mac:
# Universal binary, so doesn't care about arch
echo "MacOS ..."
wd="/tmp/7z-bin/mac"
mkdir -p "${wd}"
wget -O "${wd}/7za.tar.xz" "${DOWNLOAD_PATH}/7z${VERSION}-mac.tar.xz"
tar -x -C "${wd}/" -f "${wd}/7za.tar.xz"
mkdir -p ./mac/
cp "${wd}/7zz" ./mac/7za

# Windows:
# (on Linux)
echo "Windows"
wd="/tmp/7z-bin/win"
mkdir -p "${wd}"
wget -O "${wd}/7za.7z" "${DOWNLOAD_PATH}/7z${VERSION}-extra.7z"
/tmp/7z-bin/linux/x64/7zzs x -y -o"${wd}" "${wd}/7za.7z"
mkdir -p ./win/ia32
mkdir -p ./win/x64
cp "${wd}/7za.exe" ./win/ia32/7za.exe
cp "${wd}/x64/7za.exe" ./win/x64/7za.exe
