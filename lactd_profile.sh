#!/bin/bash
#
# [Steam]>[Game]>[Properties]>[General]>[Launch Options] 
# LACTD_PROFILE="3D Games" GAMEMODERUNEXEC="$HOME/bin/lactd_profile.sh" gamemoderun %command%

ID=$( echo '{"command":"list_devices"}' | ncat -U /run/lactd.sock | cut -d , -f 2 | cut -d \" -f 6 )

# lactd() This function should build out a $CMD to be evaluated and sent to the socket
# $command $arg1 $val1 $arg2 $val2 $arg3 $val3
# eg... 
# lactd system_info
# lactd get_power_states id $ID
# lactd set_power_profile_mode id $ID index 0
# lactd confirm_pending_config command confirm
# lactd set_profile name null auto_switch false

lactd(){
CMD='{"command":"'"$1"'"'
shift

if [ $# -ne 0 ] ;then
    CMD=$CMD',"args":{'
fi

while (( "$#" )); do
case "$2" in
    [0-9] | null | false | true)
        CMD="$CMD"'"'"$1"'":'"$2"
    ;;
    *)
        CMD="$CMD"'"'"$1"'":"'"$2"'"'
    ;;
esac
    shift 2
        if [ $# -ne 0 ] ;then
            CMD=$CMD','
        else
            CMD=$CMD'}'
        fi
done
CMD=$CMD'}'
# echo "$CMD"
eval echo '"$CMD"' | ncat -U /run/lactd.sock
}

lactd set_profile name "$LACTD_PROFILE" auto_switch false

### BANG! ###
GAMEMODERUNEXEC=""
export MANGOHUD=1
#export ENABLE_VKBASALT=1
LD_PRELOAD="$LD_PRELOAD:/usr/\$LIB/libgamemodeauto.so.0"
exec "$@"
exit 0
