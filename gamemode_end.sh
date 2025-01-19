#!/bin/bash

echo '{"command":"set_profile","args":{"name":null,"auto_switch":false}}' | ncat -U /run/lactd.sock
exit 0
