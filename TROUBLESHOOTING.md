Troubleshooting
===============

General
-------

- FreeCraft use it's own Modding API call type (freecraft), but Minetest uses their own call type (minetest).<br>
Currently there is no possible way to use Minetest mods on FreeCraft engine.<br>
The default value is set to `freecraft` because of this engine calls.

Android
-------

- If the game is crashing after 7AM/7PM (in-game time), your device can not handle the in-game music.<br>
It is possible to disable the music by modifying the `music_volume` (Content: Games/FreeCraft) value to 0.<br>
If the gameplay is offline only, it is recommended to go to `Android/data/net.freecraft.freecraft/files/FreeCraft/games/freecraft/mods/default/sounds` and delete the `music` folder or move it out of the `mods` folder.