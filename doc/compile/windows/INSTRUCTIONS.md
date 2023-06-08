Compiling on Windows
====================
Requirements
------------
[MSYS2](https://www.msys2.org/) is needed. The program is available for 64-bits for the updated version.<br>
For 32-bits, use this [old release](https://github.com/msys2/msys2-installer/releases/tag/nightly-i686).

| Type          | Size    |
|---------------|---------|
| MSYS2         | 3GB     |
| Compilation   | 203MB   |
| Installation  | 78MB    |

It counts already with dependencies installed. Not optional dependencies.

Update MSYS2
------------

MSYS2 uses `pacman`. A copy of Arch's package manager, but for Windows.

First update the MSYS2 system:
```sh
pacman -Syu --noconfirm
```
It will restart.

Re-open and update the packages:
```sh
pacman -Syu --noconfirm
```
Now MSYS2 can be used. Remind to update it regularly.

If MSYS2 throws a GPG error, head to `C:/msysXX/etc/` and edit the file `pacman.conf`.<br>
Find `SigLevel` line and comment it. Then paste this line instead:
```sh
SigLevel = Never TrustAll
```
Then proceed to install the keyrings:
```sh
pacman -S --noconfirm msys2-keyrings
```
Then remove the recently added line from `pacman.conf` and uncomment the `SigLevel` line.

Dependencies
------------

Open Clang variant of MSYS2 and install all necessary packages:
```sh
ARCH="x86_64"; pacman -Sy --noconfirm base-devel mingw-w64-${ARCH}-clang mingw-w64-${ARCH}-cmake mingw-w64-${ARCH}-extra-cmake-modules mingw-w64-${ARCH}-freetype git mingw-w64-${ARCH}-gmp mingw-w64-${ARCH}-jsoncpp mingw-w64-${ARCH}-libvorbis mingw-w64-${ARCH}-luajit mingw-w64-${ARCH}-mesa mingw-w64-${ARCH}-openjpeg2 mingw-w64-${ARCH}-openal mingw-w64-${ARCH}-sqlite3 mingw-w64-${ARCH}-zstd
```

For 32-bit, change `ARCH` to `i686`.

Download
--------

- Using git:
```sh
git clone --depth 1 https://gitlab.com/KanuX/freecraft.git
cd freecraft/
git clone --depth 1 https://gitlab.com/KanuX/freecraft_game.git ./games/freecraft/
git clone --depth 1 https://github.com/minetest/irrlicht.git ./lib/irrlichtmt/
```

- Without using git:
```sh
curl -L https://gitlab.com/KanuX/freecraft/-/archive/master/freecraft-master.tar.gz --output freecraft-master.tar.gz
tar -xvf freecraft-master.tar.gz
mv freecraft-master/ freecraft/
curl -L https://gitlab.com/KanuX/freecraft_game/-/archive/master/freecraft-master.tar.gz --output freecraft_game-master.tar.gz
tar -xvf freecraft_game-master.tar.gz
mv freecraft_game-master/ games/freecraft/
curl -L https://github.com/minetest/irrlicht/archive/master.tar.gz --output irrlicht-master.tar.gz
tar -xvf irrlicht-master.tar.gz
mv irrlicht-master/ lib/irrlichtmt/
```

Build
-----

Build a version and package it in a single folder:
```sh
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=./build/compiled/ -DRUN_IN_PLACE=TRUE -DENABLE_GETTEXT=OFF -DENABLE_CURSES=OFF -G "Unix Makefiles"
cmake --build build -j$(nproc)
cmake --install build
```

Run it:
```sh
build/compiled/bin/freecraft
```

To use it as a standalone release:
```sh
cp -v ${MINGW_PREFIX}/bin/libbrotlicommon.dll ${MINGW_PREFIX}/bin/libbrotlidec.dll \
      ${MINGW_PREFIX}/bin/libbz2-1.dll        ${MINGW_PREFIX}/bin/libc++.dll \
      ${MINGW_PREFIX}/bin/libcrypto-3.dll     ${MINGW_PREFIX}/bin/libcrypto-3-x64.dll \
      ${MINGW_PREFIX}/bin/libfreetype-6.dll   ${MINGW_PREFIX}/bin/libglib-2.0-0.dll \
      ${MINGW_PREFIX}/bin/libgmp-10.dll       ${MINGW_PREFIX}/bin/libgraphite2.dll \
      ${MINGW_PREFIX}/bin/libharfbuzz-0.dll   ${MINGW_PREFIX}/bin/libiconv-2.dll \
      ${MINGW_PREFIX}/bin/libidn2-0.dll       ${MINGW_PREFIX}/bin/libintl-8.dll \
      ${MINGW_PREFIX}/bin/libjpeg-8.dll       ${MINGW_PREFIX}/bin/libjsoncpp-25.dll \
      ${MINGW_PREFIX}/bin/libnghttp2-14.dll   ${MINGW_PREFIX}/bin/libogg-0.dll \
      ${MINGW_PREFIX}/bin/libopenal-1.dll     ${MINGW_PREFIX}/bin/libpcre2-8-0.dll \
      ${MINGW_PREFIX}/bin/libpng16-16.dll     ${MINGW_PREFIX}/bin/libpsl-5.dll \
      ${MINGW_PREFIX}/bin/libsqlite3-0.dll    ${MINGW_PREFIX}/bin/libssh2-1.dll \
      ${MINGW_PREFIX}/bin/libssl-3.dll        ${MINGW_PREFIX}/bin/libssl-3-x64.dll \
      ${MINGW_PREFIX}/bin/libstdc++-6.dll     ${MINGW_PREFIX}/bin/libunistring-5.dll \
      ${MINGW_PREFIX}/bin/libunwind.dll       ${MINGW_PREFIX}/bin/libvorbis-0.dll \
      ${MINGW_PREFIX}/bin/libvorbisfile-3.dll ${MINGW_PREFIX}/bin/libwinpthread-1.dll \
      ${MINGW_PREFIX}/bin/libzstd.dll         ${MINGW_PREFIX}/bin/lua51.dll \
      ${MINGW_PREFIX}/bin/zlib1.dll           build/compiled/bin/

mv build/compiled/ FreeCraft/
```
The binary will be located inside `FreeCraft/bin/` folder.
