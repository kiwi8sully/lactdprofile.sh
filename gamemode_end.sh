#!/bin/bash

#echo '{"command": "list_devices" }' | ncat -U /run/lactd.sock
#echo '{"command": "device_power_profile_modes", "args": { "id":  "1002:731F-1DA2:E409-0000:28:00.0" } }' | ncat -U /run/lactd.sock
#echo '{"command": "set_clocks_value", "args": { "id":  "1002:731F-1DA2:E409-0000:28:00.0", "command":{"type":"reset" }}}' | ncat -U /run/lactd.sock
#echo '{"command": "confirm_pending_config", "args": { "command": "confirm" } }' | ncat -U /run/lactd.sock

confirm_pending_config() {
    echo '{"command": "confirm_pending_config", "args": { "command": "confirm" } }' | ncat -U /run/lactd.sock
}

set_power_profile_mode() {
    case "$1" in
    [0-6])
        echo '{"command":"set_performance_level","args":{"id":"1002:731F-1DA2:E409-0000:28:00.0","performance_level":"manual"}}' | ncat -U /run/lactd.sock
        confirm_pending_config
        echo '{"command":"set_power_profile_mode","args":{"id":"1002:731F-1DA2:E409-0000:28:00.0","index":'$1'}}' | ncat -U /run/lactd.sock
        confirm_pending_config
        ;;
    auto)
        echo '{"command":"set_performance_level","args":{"id":"1002:731F-1DA2:E409-0000:28:00.0","performance_level":"manual"}}' | ncat -U /run/lactd.sock
        confirm_pending_config
        echo '{"command":"set_power_profile_mode", "args":{"id":"1002:731F-1DA2:E409-0000:28:00.0","index":null}}' | ncat -U /run/lactd.sock
        confirm_pending_config
        echo '{"command":"set_performance_level","args":{"id":"1002:731F-1DA2:E409-0000:28:00.0","performance_level":"auto"}}' | ncat -U /run/lactd.sock
        confirm_pending_config
        ;;
    *)
        echo "You need to specify a power profile [0-6] | auto"
        ;;
    esac
}

set_power_profile_mode auto

exit 0
