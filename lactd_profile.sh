#!/bin/bash
#
# gamemode_profile.sh
# [Steam]>[Game]>[Properties]>[General]>[Launch Options] 
# LACTD_PROFILE=4 GAMEMODERUNEXEC="$HOME/bin/lactd_profile.sh" gamemoderun %command%

ID=$( echo '{"command": "list_devices" }' | ncat -U /run/lactd.sock | cut -d , -f 2 | cut -d \" -f 6 )
echo $ID
echo $LACTD_PROFILE
GFXCLK='0,5,4,1800,4,800,3932160,-65536,0'
SOCCLK='0,5,1,850,4,800,1310720,-6553,0'
MEMCLK='0,5,4,850,4,800,327680,-65536,0'

confirm_pending_config() {
    echo '{"command": "confirm_pending_config", "args": { "command": "confirm" } }' | ncat -U /run/lactd.sock
}

set_power_profile_mode() {
    echo '{"command":"set_performance_level","args":{"id":"'"$ID"'","performance_level":"manual"}}' | ncat -U /run/lactd.sock
    confirm_pending_config
        case "$1" in
            [0-5])
                echo '{"command":"set_power_profile_mode","args":{"id":"'"$ID"'","index":'"$1"'}}' | ncat -U /run/lactd.sock
                confirm_pending_config
                ;;
            6)
                echo '{"command":"set_power_profile_mode","args":{"id":"'"$ID"'","index":null,"custom_heuristics":[]}}' | ncat -U /run/lactd.sock
                confirm_pending_config
                echo '{"command":"set_power_profile_mode","args":{"id":"'"$ID"'","index":'"$1"',"custom_heuristics":[['"$GFXCLK"'],['"$SOCCLK"'],['"$MEMCLK"']]}}' | ncat -U /run/lactd.sock
                confirm_pending_config
                ;;
            *)
                echo "You need to specify a power profile [0-6] | auto"
                ;;
        esac
}

set_performance_level() {
    echo '{"command":"set_power_profile_mode","args":{"id":"'"$ID"'","index":null,"custom_heuristics":[]}}' | ncat -U /run/lactd.sock
    confirm_pending_config
    case "$1" in
        auto | low | high)
            echo '{"command":"set_performance_level","args":{"id":"1002:731F-1DA2:E409-0000:28:00.0","performance_level":"'"$1"'"}}' | ncat -U /run/lactd.sock
            confirm_pending_config
            ;;
        *)
            echo "You need to specify a performance level low | high | auto"
            ;;
        esac
}

set_lactd_profile() {
    echo '{"command":"set_profile","args":{"name":"'"$LACTD_PROFILE"'"}}' | ncat -U /run/lactd.sock
#    echo '{"command":"list_profiles"}' | ncat -U /run/lactd.sock
}

case "$LACTD_PROFILE" in
    [0-6])
        set_power_profile_mode "$LACTD_PROFILE"
        ;;
    auto | low | high)
        set_performance_level "$LACTD_PROFILE"
        ;;
    *)
        set_lactd_profile "$LACTD_PROFILE"
        ;;
esac

### BANG! ###
GAMEMODERUNEXEC=""
export MANGOHUD=1
#export ENABLE_VKBASALT=1
LD_PRELOAD="$LD_PRELOAD:/usr/\$LIB/libgamemodeauto.so.0"
exec "$@"
exit 0
