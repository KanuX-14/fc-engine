<p align="center">
<img src="./.media/page_images/header.png" alt="FreeCraft logo" width="50%"/>
</p>

![Build Status](https://gitlab.com/KanuX/freecraft/workflows/build/badge.svg)
[![Translation status](https://hosted.weblate.org/widgets/minetest/-/svg-badge.svg)](https://hosted.weblate.org/engage/minetest/?utm_source=widget)
[![License](https://img.shields.io/badge/license-LGPLv2.1%2B-blue.svg)](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

FreeCraft is a free open-source voxel game engine with easy modding and game creation.

FreeCraft Engine is a modificated version of Minetest engine, used for extra content under the [FreeCraft](https://github.com/KanuX-14/freecraft) game.

Copyright (C):<br>
2010-2022 Perttu Ahola <celeron55@gmail.com> (Minetest creator)<br>
2022-2023 KanuX-14 <kanux.dev@gmail.com> (FreeCraft creator)<br>
and contributors (see source file comments and the version control log)

In case you downloaded the source code
--------------------------------------
If you downloaded the FreeCraft Engine source code in which this file is
contained, you probably want to download the [FreeCraft game](https://github.com/KanuX-14/freecraft)
project too. See its README.txt for more information.

Table of Contents
------------------
1. [Further Documentation](#further-documentation)
2. [Default Controls](#default-controls)
3. [Paths](#paths)
4. [Configuration File](#configuration-file)
5. [Command-line Options](#command-line-options)
6. [Compiling](#compiling)
7. [Docker](#docker)
8. [Version Scheme](#version-scheme)


Further documentation
----------------------
- Website: Here.
- Wiki: https://wiki.minetest.net/
- Developer wiki: https://dev.minetest.net/
- Forum: https://forum.minetest.net/
- GitLab: https://gitlab.com/KanuX/freecraft/ ([GitHub](https://github.com/KanuX-14/fc-engine))
- [doc/](doc/) directory of source distribution

Default controls
----------------
All controls are re-bindable using settings.
Some can be changed in the key config dialog in the settings tab.

| Button                        | Action                                                         |
|-------------------------------|----------------------------------------------------------------|
| Move mouse                    | Look around                                                    |
| W, A, S, D                    | Move                                                           |
| Space                         | Jump/move up                                                   |
| Shift                         | Sneak/move down                                                |
| Q                             | Drop itemstack                                                 |
| Shift + Q                     | Drop single item                                               |
| Left mouse button             | Dig/punch/take item                                            |
| Right mouse button            | Place/use                                                      |
| Shift + right mouse button    | Build (without using)                                          |
| E                             | Inventory menu                                                 |
| Mouse wheel                   | Select item                                                    |
| 0-9                           | Select item                                                    |
| C                             | Zoom (needs zoom privilege)                                    |
| T                             | Chat                                                           |
| /                             | Command                                                        |
| Esc                           | Pause menu/abort/exit (pauses only singleplayer game)          |
| +                             | Increase view range                                            |
| -                             | Decrease view range                                            |
| K                             | Enable/disable fly mode (needs fly privilege)                  |
| J                             | Enable/disable fast mode (needs fast privilege)                |
| H                             | Enable/disable noclip mode (needs noclip privilege)            |
| Ctrl                          | Aux1 (Move fast in fast mode. Games may add special features)  |
| Z                             | Aux2 (Prone. In Minetest the zoom button is used)              |
| M                             | Cycle through minimap modes                                    |
| Shift + V                     | Change minimap orientation                                     |
| F1                            | Hide/show HUD                                                  |
| F2                            | Take screenshot                                                |
| F3                            | Cycle through debug information screens                        |
| F4                            | Disable/enable camera update (Mapblocks are not updated anymore when disabled, disabled in release builds)  |
| F5                            | Cycle through camera modes                                     |
| F6                            | Cycle through profiler info screens                            |
| F7                            | Disable/enable fog                                             |
| F10                           | Show/hide console                                              |
| F12                           | Hide/show chat                                                 |

Paths
-----
Locations:

* `bin`   - Compiled binaries
* `share` - Distributed read-only data
* `user`  - User-created modifiable data

Where each location is on each platform:

* Windows .zip / RUN_IN_PLACE source:
    * `bin`   = `bin`
    * `share` = `.`
    * `user`  = `.`
* Windows installed:
    * `bin`   = `C:\Program Files\FreeCraft\bin (Depends on the install location)`
    * `share` = `C:\Program Files\FreeCraft (Depends on the install location)`
    * `user`  = `%APPDATA%\FreeCraft` or `%FREECRAFT_USER_PATH%`
* Linux installed:
    * `bin`   = `/usr/bin`
    * `share` = `/usr/share/freecraft`
    * `user`  = `~/.freecraft` or `$FREECRAFT_USER_PATH`
* macOS:
    * `bin`   = `Contents/MacOS`
    * `share` = `Contents/Resources`
    * `user`  = `Contents/User` or `~/Library/Application Support/freecraft` or `$FREECRAFT_USER_PATH`

Worlds can be found as separate folders in: `user/worlds/`

Configuration file
------------------
- Default location: `user/freecraft.conf`
- This file is created by closing FreeCraft for the first time.
- A specific file can be specified on the command line: `--config <path-to-file>`
- A run-in-place build will look for the configuration file in
  `location_of_exe/../freecraft.conf` and also `location_of_exe/../../freecraft.conf`

Command-line options
--------------------
- Use `--help`

Compiling
---------
### Compiling on Linux

Musl may be possible, generally. Compatibility is being taken care.

#### Dependencies

| Dependency | Version | Commentary                                                             |
|------------|---------|------------------------------------------------------------------------|
| CMake      | 3.5+    |                                                                        |
| Freetype   | 2.0+    |                                                                        |
| GMP        | 5.0.0+  | Bundled mini-GMP is used if not present.                               |
| GCC        | 5.1+    | or Clang 3.5+.                                                         |
| IrrlichtMt | -       | Custom version of [Irrlicht](https://github.com/minetest/irrlicht).    |
| JsonCPP    | 1.0.0+  | Bundled JsonCPP is used if not present.                                |
| LuaJIT     | 2.0+    | Bundled Lua 5.1 is used if not present.                                |
| SQLite3    | 3+      |                                                                        |
| Zstd       | 1.0+    |                                                                        |

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

| Optional | Version | Commentary             |
|----------|---------|------------------------|
| Git      | any     | Keep game up to date.  |

Git can be widely installed by pointing the `git` package name.<br>
It is also recommended if you want a rolling-release update style.

#### Download

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

#### Build

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

### CMake options

General options and their default values:
```
BUILD_CLIENT=TRUE          - Build FreeCraft client
BUILD_SERVER=FALSE         - Build FreeCraft server
BUILD_UNITTESTS=TRUE       - Build unittest sources
BUILD_BENCHMARKS=FALSE     - Build benchmark sources
CMAKE_BUILD_TYPE=Release   - Type of build (Release vs. Debug)
    Release                - Release build
    Debug                  - Debug build
    SemiDebug              - Partially optimized debug build
    RelWithDebInfo         - Release build with debug information
    MinSizeRel             - Release build with -Os passed to compiler to make executable as small as possible
ENABLE_CURL=ON             - Build with cURL; Enables use of online mod repo, public serverlist and remote media fetching via http
ENABLE_CURSES=ON           - Build with (n)curses; Enables a server side terminal (command line option: --terminal)
ENABLE_GETTEXT=ON          - Build with Gettext; Allows using translations
ENABLE_GLES=OFF            - Enable extra support code for OpenGL ES (requires support by IrrlichtMt)
ENABLE_LEVELDB=ON          - Build with LevelDB; Enables use of LevelDB map backend
ENABLE_POSTGRESQL=ON       - Build with libpq; Enables use of PostgreSQL map backend (PostgreSQL 9.5 or greater recommended)
ENABLE_REDIS=ON            - Build with libhiredis; Enables use of Redis map backend
ENABLE_SPATIAL=ON          - Build with LibSpatial; Speeds up AreaStores
ENABLE_SOUND=ON            - Build with OpenAL, libogg & libvorbis; in-game sounds
ENABLE_LUAJIT=ON           - Build with LuaJIT (much faster than non-JIT Lua)
ENABLE_PROMETHEUS=OFF      - Build with Prometheus metrics exporter (listens on tcp/30000 by default)
ENABLE_SYSTEM_GMP=ON       - Use GMP from system (much faster than bundled mini-gmp)
ENABLE_SYSTEM_JSONCPP=ON   - Use JsonCPP from system
RUN_IN_PLACE=FALSE         - Create a portable install (worlds, settings etc. in current directory)
ENABLE_UPDATE_CHECKER=TRUE - Whether to enable update checks by default
INSTALL_DEVTEST=FALSE      - Whether the Development Test game should be installed alongside Minetest
USE_GPROF=FALSE            - Enable profiling using GProf
VERSION_EXTRA=             - Text to append to version (e.g. VERSION_EXTRA=foobar -> FreeCraft 0.4.9-foobar)
ENABLE_TOUCH=FALSE         - Enable Touchscreen support (requires support by IrrlichtMt)
```

Library specific options:
```
CURL_DLL                        - Only if building with cURL on Windows; path to libcurl.dll
CURL_INCLUDE_DIR                - Only if building with cURL; directory where curl.h is located
CURL_LIBRARY                    - Only if building with cURL; path to libcurl.a/libcurl.so/libcurl.lib
EGL_INCLUDE_DIR                 - Only if building with GLES; directory that contains egl.h
EGL_LIBRARY                     - Only if building with GLES; path to libEGL.a/libEGL.so
EXTRA_DLL                       - Only on Windows; optional paths to additional DLLs that should be packaged
FREETYPE_INCLUDE_DIR_freetype2  - Directory that contains files such as ftimage.h
FREETYPE_INCLUDE_DIR_ft2build   - Directory that contains ft2build.h
FREETYPE_LIBRARY                - Path to libfreetype.a/libfreetype.so/freetype.lib
FREETYPE_DLL                    - Only on Windows; path to libfreetype-6.dll
GETTEXT_DLL                     - Only when building with gettext on Windows; paths to libintl + libiconv DLLs
GETTEXT_INCLUDE_DIR             - Only when building with gettext; directory that contains libintl.h
GETTEXT_LIBRARY                 - Optional/platform-dependent with gettext; path to libintl.so/libintl.dll.a
GETTEXT_MSGFMT                  - Only when building with gettext; path to msgfmt/msgfmt.exe
ICONV_LIBRARY                   - Optional/platform-dependent; path to libiconv.so/libiconv.dylib
IRRLICHT_DLL                    - Only on Windows; path to IrrlichtMt.dll
IRRLICHT_INCLUDE_DIR            - Directory that contains IrrCompileConfig.h (usable for server build only)
LEVELDB_INCLUDE_DIR             - Only when building with LevelDB; directory that contains db.h
LEVELDB_LIBRARY                 - Only when building with LevelDB; path to libleveldb.a/libleveldb.so/libleveldb.dll.a
LEVELDB_DLL                     - Only when building with LevelDB on Windows; path to libleveldb.dll
PostgreSQL_INCLUDE_DIR          - Only when building with PostgreSQL; directory that contains libpq-fe.h
PostgreSQL_LIBRARY              - Only when building with PostgreSQL; path to libpq.a/libpq.so/libpq.lib
REDIS_INCLUDE_DIR               - Only when building with Redis; directory that contains hiredis.h
REDIS_LIBRARY                   - Only when building with Redis; path to libhiredis.a/libhiredis.so
SPATIAL_INCLUDE_DIR             - Only when building with LibSpatial; directory that contains spatialindex/SpatialIndex.h
SPATIAL_LIBRARY                 - Only when building with LibSpatial; path to libspatialindex.so/spatialindex-32.lib
LUA_INCLUDE_DIR                 - Only if you want to use LuaJIT; directory where luajit.h is located
LUA_LIBRARY                     - Only if you want to use LuaJIT; path to libluajit.a/libluajit.so
OGG_DLL                         - Only if building with sound on Windows; path to libogg.dll
OGG_INCLUDE_DIR                 - Only if building with sound; directory that contains an ogg directory which contains ogg.h
OGG_LIBRARY                     - Only if building with sound; path to libogg.a/libogg.so/libogg.dll.a
OPENAL_DLL                      - Only if building with sound on Windows; path to OpenAL32.dll
OPENAL_INCLUDE_DIR              - Only if building with sound; directory where al.h is located
OPENAL_LIBRARY                  - Only if building with sound; path to libopenal.a/libopenal.so/OpenAL32.lib
SQLITE3_INCLUDE_DIR             - Directory that contains sqlite3.h
SQLITE3_LIBRARY                 - Path to libsqlite3.a/libsqlite3.so/sqlite3.lib
VORBISFILE_LIBRARY              - Only if building with sound; path to libvorbisfile.a/libvorbisfile.so/libvorbisfile.dll.a
VORBIS_DLL                      - Only if building with sound on Windows; paths to vorbis DLLs
VORBIS_INCLUDE_DIR              - Only if building with sound; directory that contains a directory vorbis with vorbisenc.h inside
VORBIS_LIBRARY                  - Only if building with sound; path to libvorbis.a/libvorbis.so/libvorbis.dll.a
ZLIB_DLL                        - Only on Windows; path to zlib1.dll
ZLIB_INCLUDE_DIR                - Directory that contains zlib.h
ZLIB_LIBRARY                    - Path to libz.a/libz.so/zlib.lib
ZSTD_DLL                        - Only on Windows; path to libzstd.dll
ZSTD_INCLUDE_DIR                - Directory that contains zstd.h
ZSTD_LIBRARY                    - Path to libzstd.a/libzstd.so/ztd.lib
```

### Compiling on Windows

Instructions were shown using MSVC.<br>
Since FreeCraft does not agree with MSVC bloat and inconsistency,
better instructions using MinGW(Clang) will be tested and documented.

If you want to follow MSVC instructions, head to [Minetest](https://github.com/minetest/minetest/blob/master/doc/compiling/windows.md) section.

### Compiling on MacOS

#### Requirements
- [Homebrew](https://brew.sh/)
- [Git](https://git-scm.com/downloads)

Install dependencies with homebrew:
```
brew install cmake freetype gettext gmp hiredis jpeg jsoncpp leveldb libogg libpng libvorbis luajit zstd
```

#### Download

- Using git:
```sh
git clone --depth 1 https://gitlab.com/KanuX/freecraft.git
cd freecraft/
git clone --depth 1 https://gitlab.com/KanuX/freecraft_game.git ./games/freecraft/
git clone --depth 1 https://github.com/minetest/irrlicht.git ./lib/irrlichtmt/
```

#### Build

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

#### Run

```
open ./build/macos/freecraft.app
```

### Compiling for Android

See the [Android compiling instructions](android/README.md).

Docker
------
We provide FreeCraft server Docker images using the GitLab mirror registry.

Images are built on each commit and available using the following tag scheme:

* `registry.gitlab.com/KanuX/freecraft/server:latest` (latest build)
* `registry.gitlab.com/KanuX/freecraft/server:<branch/tag>` (current branch or current tag)
* `registry.gitlab.com/KanuX/freecraft/server:<commit-id>` (current commit id)

As <b>root</b>:

If you want to test it on a Docker server you can easily run:
```sh
docker run registry.gitlab.com/KanuX/freecraft/server:<docker tag>
```

If you want to use it in a production environment you should use volumes bound to the Docker host
to persist data and modify the configuration:
```sh
docker create -v /home/freecraft/data/:/var/lib/freecraft/ -v /home/freecraft/conf/:/etc/freecraft/ registry.gitlab.com/KanuX/freecraft/server:master
```

Data will be written to `/home/freecraft/data` on the host, and configuration will be read from `/home/freecraft/conf/freecraft.conf`.

**Note:** If you don't understand the previous commands please read the official Docker documentation before use.

You can also host your FreeCraft server inside a Kubernetes cluster. See our example implementation in [`misc/kubernetes.yml`](misc/kubernetes.yml).

Version scheme
--------------
We use `major.minor.patch`.

- Major is incremented when the release contains breaking changes, all other
numbers are set to 0.
- Minor is incremented when the release contains new non-breaking features,
patch is set to 0.
- Patch is incremented when the release only contains bug-fixes and very
minor/trivial features considered necessary.

The `dev` notation refers to the unstable release.<br>
i.e.: `0.1.4-dev` is the development version and `0.1.4` is the official stable version.

Troubleshooting
---------------

If your device is misbehaving, consider posting it on [issues](-/issues) using this [template](.github/ISSUE_TEMPLATE/bug_report.md).<br>
Known issued can be found under the [troubleshoot page](TROUBLESHOOTING.md).
