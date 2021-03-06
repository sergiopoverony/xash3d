#!/usr/bin/env bash

# This file is a modification of the setup scripts from The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="xash3d"
rp_module_desc="xash3d engine for play Half-Life and Half-Life modes on Raspberry Pi"
rp_module_section="exp"
rp_module_flags=""

function depends_xash3d() {
    local depends=(cmake libx11-dev libxext-dev libfontconfig1-dev libfontconfig1 libsdl2-dev libsdl2-2.0-0 libsdl2-mixer-dev libsdl2-mixer-2.0-0 libsdl2-net-dev libsdl2-net-2.0-0 libsdl2-ttf-2.0-0 libsdl2-ttf-dev libsdl2-image-dev libsdl2-image-2.0-0)
    isPlatform "rpi" && depends+=(libraspberrypi-dev)
    getDepends "${depends[@]}"
}

function sources_xash3d() {
    gitPullOrClone "$md_build" git://github.com/FWGS/xash3d
    gitPullOrClone "$md_build"/engine/nanogl git://github.com/FWGS/nanogl
    gitPullOrClone "$md_build"/hlsdk git://github.com/FWGS/hlsdk-xash3d
}

function build_xash3d() {
    cd "$md_build"
    mkdir build && cd build
    sudo cmake -DXASH_NANOGL=yes -DXASH_VGUI=no -DXASH_GLES=yes ..
    sudo make -j2
    cd ..
    cd hlsdk
    mkdir build && cd build
    sudo cmake ..
    sudo make -j2
}

function install_bin_xash3d() {
    mkdir -p /home/pi/RetroPie/roms/ports/Half-Life
    cd /home/pi/RetroPie/roms/ports/Half-Life
    wget --no-check-certificate "https://github.com/sergiopoverony/xash3d_pi/raw/master/xash3d.tar" -O xash3d.tar
    tar -xvf xash3d.tar
    rm -r xash3d.tar
}

function install_xash3d() {
    cd "$md_build"
    mkdir -p /home/pi/RetroPie/roms/ports/Half-Life
    mkdir -p /home/pi/RetroPie/roms/ports/Half-Life/valve
	mv /xash-extras/*.* /home/pi/RetroPie/roms/ports/Half-Life/valve
    cp -Rvf hlsdk/build/dlls/hl.so /home/pi/RetroPie/roms/ports/Half-Life/valve/dlls/hl.so
    cp -Rvf hlsdk/build/cl_dll/client.so /home/pi/RetroPie/roms/ports/Half-Life/valve/cl_dlls/client.so 
    cp -Rvf build/engine/libxash.so build/game_launch/xash3d build/mainui/libxashmenu.so /home/pi/RetroPie/roms/ports/Half-Life
    cd /home/pi/RetroPie/roms/ports/Half-Life/valve
    wget --no-check-certificate "https://github.com/sergiopoverony/xash3d_pi/raw/master/xash-extras.tar" -O xash-extras.tar
    tar -xvf xash-extras.tar
    rm -r xash-extras.tar
	
}

function configure_xash3d() {
    addPort "$md_id" "Xash3D" "Xash3D" "$md_inst/Xash3D.sh"
    cat > "$md_inst/Xash3D.sh" << _EOF_
LD_LIBRARY_PATH=/home/pi/RetroPie/roms/ports/Half-Life /home/pi/RetroPie/roms/ports/Half-Life/xash3d -console -clientlib cl_dlls/client.so -dll dlls/hl.so
_EOF_
    chmod +x "$md_inst/Xash3D.sh"
    
}

function remove_xash3d() {
    rm /home/pi/RetroPie/roms/ports/Half-Life/*xash* /home/pi/RetroPie/roms/ports/Half-Life/client.* /home/pi/RetroPie/roms/ports/Half-Life/xash3d.*
}
