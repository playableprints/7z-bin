"use strict";

const path = require("path");

function getPath() {
    if (process.platform === "darwin") {
        return path.join(__dirname, "mac", "7zz");
    } else if (process.platform === "win32") {
        return path.join(__dirname, "win", process.arch, "7z.exe");
    } else {
        return path.join(__dirname, "linux", process.arch, "7zzs");
    }
}

exports.path7z = getPath();
