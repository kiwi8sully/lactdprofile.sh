#!/bin/bash

$LACTD_PROFILE="BootUp"
echo '{"command":"set_profile","args":{"name":"'"$LACTD_PROFILE"'"}}' | ncat -U /run/lactd.sock

exit 0
