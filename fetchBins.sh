#!/bin/bash

if [[ "$OSTYPE" != "linux-gnu" ]]; then
    exit 1
fi

VERSION=$1
DOWNLOAD_PATH="https://7-zip.org/a"

echo "Downloading version $VERSION ..."

function tar_download_extract {
    wd="$1"
    url="$2"
    mkdir -p "${wd}"
    wget -O "${wd}/7z.tar.xz" "${url}"
    tar -x -C "${wd}/" -f "${wd}/7z.tar.xz"
}

function 7z_download_extract {
    wd="$1"
    url="$2"
    mkdir -p "${wd}"
    wget -O "${wd}/7z.7z" "${url}"
    /tmp/7z-bin/linux/x64/7zzs x -y -o"${wd}" "${wd}/7z.7z"
}

# Linux:
linux_downloads="x64 x86 arm64 arm"

for ARCH in $linux_downloads; do
    echo "linux-$ARCH ..."
    wd=/tmp/7z-bin/linux/${ARCH}
    tar_download_extract "$wd" "${DOWNLOAD_PATH}/7z${VERSION}-linux-${ARCH}.tar.xz"
    mkdir -p ./linux/${ARCH}/
    cp "${wd}/7zzs" ./linux/${ARCH}/7zzs
done

# Mac:
# Universal binary, so doesn't care about arch
echo "MacOS ..."
wd="/tmp/7z-bin/mac"
tar_download_extract "${wd}" "${DOWNLOAD_PATH}/7z${VERSION}-mac.tar.xz"
mkdir -p ./mac/
cp "${wd}/7zz" ./mac/7zz

# Windows:
# (on Linux)
win_downloads="x64 arm64"

for ARCH in $win_downloads; do
    echo "win-$ARCH ..."
    wd="/tmp/7z-bin/win/${ARCH}"
    7z_download_extract "$wd" "${DOWNLOAD_PATH}/7z${VERSION}-${ARCH}.exe"
    mkdir -p ./win/${ARCH}/
    cp "${wd}/7z.exe" ./win/${ARCH}/7z.exe
    cp "${wd}/7z.dll" ./win/${ARCH}/7z.dll
done

wd="/tmp/7z-bin/win/ia32"
ARCH="ia32"
7z_download_extract "$wd" "${DOWNLOAD_PATH}/7z${VERSION}.exe"
mkdir -p ./win/${ARCH}/
cp "${wd}/7z.exe" ./win/${ARCH}/7z.exe
cp "${wd}/7z.dll" ./win/${ARCH}/7z.dll
