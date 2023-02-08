#!/bin/bash

#variables
redream_emuName="redream"
redream_emuType="Binary"
redream_emuPath="$HOME/Applications/redream"

#cleanupOlderThings
redream_cleanup(){
    echo "Begin redream Cleanup"
}

#Install
Ryujinx_install(){
    echo "Begin redream Install"

# https://redream.io/download/redream.x86_64-linux-v1.5.0-1051-g4ba6a39.tar.gz
# https://redream.io/download/redream.x86_64-linux-v1.5.0-1049-gb05282e.tar.gz

    installEmuBI "Ryujinx"  "$(getReleaseURLGH "Ryujinx/release-channel-master" "-linux_x64.tar.gz")" "Ryujinx" "tar.gz"
    tar -xvf "$HOME/Applications/Ryujinx.tar.gz" -C "$HOME/Applications/"
    chmod +x "$HOME/Applications/publish/Ryujinx"
    rm -rf "$HOME/Applications/Ryujinx.tar.gz"
}

#ApplyInitialSettings
redream_init(){
    echo "Begin Ryujinx Init"

    configEmuAI "Ryujinx" "config" "$HOME/.config/Ryujinx" "$EMUDECKGIT/configs/Ryujinx" "true"
    
    redream_setEmulationFolder
    redream_setupStorage
    redream_setupSaves
    redream_finalize

}

#update
redream_update(){
    echo "Begin redream update"
    
    configEmuAI "yuzu" "config" "$HOME/.config/Ryujinx" "$EMUDECKGIT/configs/Ryujinx"
    
    redream_setEmulationFolder
    redream_setupStorage
    redream_setupSaves
    redream_finalize
}



#ConfigurePaths
redream_setEmulationFolder(){
    echo "Begin redream Config"
    
}

#SetupSaves
redream_setupSaves(){
    echo "Begin Ryujinx save link" 
    touch vmu0.bin && touch vmu1.bin && touch vmu2.bin && touch vmu3.bin
    ln -s "vmu0.bin" "${savesPath}/vmu0.bin"
    && ln -s "vmu1.bin" "${savesPath}/vmu1.bin"
    && ln -s "vmu2.bin" "${savesPath}/vmu2.bin"
    && ln -s "vmu3.bin" "${savesPath}/vmu3.bin"
    rm vmu*.bin
}

#SetupStorage
Ryujinx_setupStorage(){
    echo "Begin Ryujinx storage config"
    
    local origPath="$HOME/.config/"
    mkdir -p "${storagePath}/ryujinx/patchesAndDlc"
    rsync -av "${origPath}/Ryujinx/games/" "${storagePath}/ryujinx/games/" && rm -rf "${origPath}Ryujinx/games"
    unlink "${origPath}/Ryujinx/games"
    ln -ns "${storagePath}/ryujinx/games/" "${origPath}/Ryujinx/games" 
        
}

#WipeSettings
Ryujinx_wipe(){
    echo "Begin Ryujinx delete config directories"
    rm -rf "$HOME/.config/Ryujinx"
}

#Uninstall
Ryujinx_uninstall(){
    echo "Begin Ryujinx uninstall"
    rm -rf "$redream_emuPath"
}

#setABXYstyle
redream_setABXYstyle(){
echo "NYI"
}

#WideScreenOn
redream_wideScreenOn(){
echo "NYI"
}

#WideScreenOff
redream_wideScreenOff(){
echo "NYI"
}

#BezelOn
redream_bezelOn(){
echo "NYI"
}

#BezelOff
redream_bezelOff(){
echo "NYI"
}

#finalExec - Extra stuff
redream_finalize(){
    echo "Begin Ryujinx finalize"
}

redream_IsInstalled(){
	if [ -e "$redream_emuPath/redream" ]; then
		echo "true"
	else
		echo "false"
	fi
}

redream_resetConfig(){
	Rredream_init &>/dev/null && echo "true" || echo "false"
}