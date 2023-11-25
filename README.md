# 7z-bin

Borrowed with pride from (@develar/7zip-bin)[https://github.com/develar/7zip-bin].

We needed an updated 7z binary implementation for an Electron app, and wanted a documented process for updating.

This repo uses GitHub Actions to run `./fetchBins.sh` on a Linux machine, which downloads and unpacks the 7z binaries per OS/arch, and creates an NPM package from the results.

## Differences

(7zip-bin)[https://www.npmjs.com/package/7zip-bin] exports `path7za` and `path7x`. We only export `path7z`.

## Things we learned

1. Windows: exe installers can be unpacked with 7z itself.
2. Windows: standalone binaries (7za.exe) don't include many of the modules, including RAR5.
3. Windows: require the dll file next to the 7z binaries.
4. MacOS: provides universal binaries.
5. Linux: provides static binaries.

## TODO

-   Download active arch on package install, instead of everything
