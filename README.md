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
| Left mouse button             | Dig/punch/use                                                  |
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

This section got separated into pieces, as it was filling the entire repository space.<br>
It can be accessed [here](doc/compile/INSTRUCTIONS.md).

Docker
------

- [Developing freecraftserver with Docker](doc/developing/docker.md)

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
