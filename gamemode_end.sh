#!/bin/bash

LACTD_PROFILE=BootUp
echo '{"command":"set_profile","args":{"name":"'"$LACTD_PROFILE"'","auto_switch":false}}' | ncat -U /run/lactd.sock
#echo '{"command":"set_profile","args":{"name":null,"auto_switch":false}}' | ncat -U /run/lactd.sock
exit 0
