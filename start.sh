#!/bin/bash 
crontab -u steam /home/steam/crontab.txt
service cron start && service cron status
echo "checking game ${STEAMAPPID}"
#${STEAMCMDDIR}/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir ${STEAMAPPDIR} +login anonymous +app_update ${STEAMAPPID} validate +quit 
chown -R steam:steam ${STEAMAPPDIR}
#su steam -c "mkdir -p ${STEAMAPPDIR}/LF/Saved/Config/"
cp /home/steam/Game.ini ${STEAMAPPDIR}/WRSH/Saved/Config/WindowsServer/Game.ini

su steam
cd ./WRSH/Binaries/Win64
wine WRSHServer.exe -log -nosteam -server
