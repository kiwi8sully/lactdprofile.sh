#!/bin/bash
#
# [Steam]>[Game]>[Properties]>[General]>[Launch Options] 
# LACTD_PROFILE=4 GAMEMODERUNEXEC="$HOME/bin/lactd_profile.sh" gamemoderun %command%

echo '{"command":"set_profile","args":{"name":"'"$LACTD_PROFILE"'"}}' | ncat -U /run/lactd.sock

### BANG! ###
GAMEMODERUNEXEC=""
export MANGOHUD=1
#export ENABLE_VKBASALT=1
LD_PRELOAD="$LD_PRELOAD:/usr/\$LIB/libgamemodeauto.so.0"
exec "$@"
exit 0
