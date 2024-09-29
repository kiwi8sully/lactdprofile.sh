#!/bin/bash

LACTD_PROFILE=null
echo '{"command":"set_profile","args":{"name":'"$LACTD_PROFILE"'}}' | ncat -U /run/lactd.sock

exit 0
