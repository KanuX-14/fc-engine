Compiling on Linux
==================
Musl may be possible, generally. Compatibility is being taken care.

Dependencies
------------
As <b>root</b>:

- Debian/Ubuntu:
```sh
apt install g++ make libc6-dev cmake libpng-dev libjpeg-dev libxi-dev libgl1-mesa-dev libsqlite3-dev libogg-dev libvorbis-dev libopenal-dev libcurl4-gnutls-dev libfreetype6-dev zlib1g-dev libgmp-dev libjsoncpp-dev libzstd-dev libluajit-5.1-dev
```
- Fedora:
```sh
dnf install make automake gcc gcc-c++ kernel-devel cmake libcurl-devel openal-soft-devel libpng-devel libjpeg-devel libvorbis-devel libXi-devel libogg-devel freetype-devel mesa-libGL-devel zlib-devel jsoncpp-devel gmp-devel sqlite-devel luajit-devel leveldb-devel ncurses-devel spatialindex-devel libzstd-devel
```
- Arch:
```sh
pacman -S base-devel libcurl-gnutls cmake libxi libpng sqlite libogg libvorbis openal freetype2 jsoncpp gmp luajit leveldb ncurses zstd
```
- Alpine:
```sh
sudo apk add build-base cmake libpng-dev jpeg-dev libxi-dev mesa-dev sqlite-dev libogg-dev libvorbis-dev openal-soft-dev curl-dev freetype-dev zlib-dev gmp-dev jsoncpp-dev luajit-dev zstd-dev
```

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
Build a version that runs directly from the source directory:
```sh
cmake -S . -B build -DRUN_IN_PLACE=TRUE
cmake --build build -j$(nproc)
```

Run it:
```sh
../bin/freecraft
```

- Use `cmake . -LH` to see all CMake options and their current state.
- If you want to install it system-wide (or are making a distribution package),
  you will want to use `-DRUN_IN_PLACE=FALSE`.
- You can build a bare server by specifying `-DBUILD_SERVER=TRUE`.
- You can disable the client build by specifying `-DBUILD_CLIENT=FALSE`.
- You can select between Release and Debug build by `-DCMAKE_BUILD_TYPE=<Debug or Release>`.
  - Debug build is slower, but gives much more useful output in a debugger.
- If you build a bare server you don't need to compile IrrlichtMt, just the headers suffice.
  - In that case use `-DIRRLICHT_INCLUDE_DIR=/some/where/irrlichtmt/include`.

- FreeCraft will use the IrrlichtMt package that is found first, given by the following order:
  1. Specified `IRRLICHTMT_BUILD_DIR` CMake variable
  2. `${PROJECT_SOURCE_DIR}/lib/irrlichtmt` (if existent)
  3. Installation of IrrlichtMt in the system-specific library paths
  4. For server builds with disabled `BUILD_CLIENT` variable, the headers from `IRRLICHT_INCLUDE_DIR` will be used.
  - NOTE: Changing the IrrlichtMt build directory (includes system installs) requires regenerating the CMake cache (`rm CMakeCache.txt`)
