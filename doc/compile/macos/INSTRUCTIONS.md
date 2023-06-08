Compiling on MacOS
==================
Requirements
------------
- [Homebrew](https://brew.sh/)
- [Git](https://git-scm.com/downloads)

Install dependencies with homebrew:
```
brew install cmake freetype gettext gmp hiredis jpeg jsoncpp leveldb libogg libpng libvorbis luajit zstd
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

Build
-----
- Using cmake:
```sh
cmake -S . -B build -DCMAKE_OSX_DEPLOYMENT_TARGET=10.14 \
  -DCMAKE_FIND_FRAMEWORK=LAST \
  -DCMAKE_INSTALL_PREFIX=../build/macos/ \
  -DRUN_IN_PLACE=FALSE \
  -DENABLE_GETTEXT=TRUE
cmake --build build -j$(sysctl -n hw.logicalcpu)
cmake --install build
```

Run
---
```
open ./build/macos/freecraft.app
```
