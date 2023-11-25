import { zversion } from "./package.json";
const fs = require("fs/promises");
const path = require("path");

const DOWNLOAD_URL = "https://7-zip.org/a";

// 2301

/**
 * Downloads run in the following order:
 *
 * linux x64
 * linux others
 * mac all
 * windows
 */

// Only runs on a Linux builder
if (process.platform !== "linux") {
    return;
}

/**
 * Linux:
 *
 * tar xf *-linux-x64.tar.xz
 * cp 7zzs linux/x64/7za
 */

/**
 * Mac:
 *
 * tar xf *-mac.tar.xz
 * cp 7zz mac/<arch>/7za
 *
 * Universal binary, so doesn't care about arch
 */

/**
 * Windows:
 *
 * (on Linux)
 * ./7zzs x -y *-extra.7z
 * cp 7za.exe win/ia32/7za.exe
 * cp x64/7za.exe win/x64/7za.exe
 *
 */

const linux_downloads = ["x64", "x86", "arm64", "arm"];

const fetchFile = async (url, savepath) => {
    const result = await fetch({
        url,
    });
    if (result.ok) {
        try {
            await fs.mkdir(path.dirname(savepath), { recursive: true });
            await fs.writeFile(savepath, await result.arrayBuffer());
            return;
        } catch (e) {
            throw e;
        }
    } else {
        throw new Error(result.statusText);
    }
};

const doTheThing = async () => {
    // Linux
    await Promise.all(
        linux_downloads.map(async (arch) => {
            const url = `${DOWNLOAD_URL}/7z${zversion}-linux-${arch}.tar.xz`;
            const savepath = path.normalize(`/tmp/7z-bin/linux/${arch}/7z.tar.xz`);

            // Grab the file
            await fetchFile(url, savepath);

            // Extract the contents
            child_process.spawn;

            // Copy somewhere useful
        })
    );

    // Mac

    // Windows
};

doTheThing()
    .then(() => {
        console.log("done");
    })
    .catch((e) => {
        console.error(e);
    });

// const getList = {
//     "linux/x64": "linux-x64.tar.xz",
// }

/*
const OSes = {
    linux: ["x64", "x86", "arm64", "arm"],
    mac: [],
    win: [],
};

Object.entries(OSes).forEach(([os, arches]) => {
    if (arches.length === 0) {

    } 

    arches.forEach((arch) => {
        const theUrl = `${DOWNLLOAD_URL}7z${zversion}-${os}-${arch}.tar.xz`;
    });
});
*/
