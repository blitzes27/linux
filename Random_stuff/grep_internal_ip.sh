#!/bin/bash
# This script retrieves the internal IP address of the system.
# It works on both Linux and macOS.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ip_address=$(hostname -I | awk '{print $1}')
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ip_address=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}')
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi
echo "IP Address: $ip_address"