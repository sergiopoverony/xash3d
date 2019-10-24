# Xash3D for Raspberry Pi (RetroPie)
Xash3D Engine is a custom Gold Source engine rewritten from scratch. Xash3D is compatible with many of the Gold Source games and mods and should be able to run almost any existing singleplayer Half-Life mod without a hitch. The multiplayer part is not yet completed, multiplayer mods should work just fine, but bear in mind that some features may not work at all or work not exactly the way they do in Gold Source Engine.

## Install

Copy Half-Life folder from Steamapps:

../steam/steamapps/common/Half-Life in ../rom/ports folder

for example you can see ../rom/ports/Half-Life/ and more files from game

Next: In console go to Retropie-Setup folder

cd RetroPie-Setup

cd scriptmodules

cd ports

wget --no-check-certificate https://github.com/sergiopoverony/xash3d/raw/master/xash3d.sh

After it in Emulationstation settings RetroPie - you can run Retropie Setup -> Manage packages -> exp (experemental) -> xash3d

install with bin or sources.


## Playing

Use keyboard and mouse for control in game

For plying with joypad add -sdl_joy_old_api in cmd line /opt/retropie/ports/xash3d/Xash3D.sh



## License
The library is licensed under GPLv3 license, see https://github.com/FWGS/xash3d/blob/master/COPYING for details. 
