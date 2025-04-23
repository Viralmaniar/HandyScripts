#!/bin/bash

# Bash Script: MITRE ATT&CK T1595.001 - Scanning IP Blocks
# Author: Viral Maniar

subnet="192.168.1"  # Target subnet
start=1
end=254

echo "Scanning IP Block ${subnet}.${start} to ${subnet}.${end}..."

for i in $(seq $start $end); do
    ip="${subnet}.${i}"
    ping -c 1 -W 1 $ip > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Host Up: $ip"
    fi
done

echo "IP Block Scan Complete."
