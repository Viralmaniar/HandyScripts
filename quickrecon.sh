#!/bin/bash

# Simple network reconnaissance script
# Usage: ./recon.sh <target>

TARGET=$1

if [ -z "$TARGET" ]; then
  echo "Usage: $0 <target>"
  exit 1
fi

echo "[*] Starting recon on $TARGET..."

# Basic nmap scan
echo "[*] Running Nmap..."
nmap -sS -sV -T4 -Pn $TARGET -oN nmap_results.txt

# Basic whois info
echo "[*] Gathering WHOIS info..."
whois $TARGET > whois_info.txt

# DNS enumeration
echo "[*] Performing DNS enumeration..."
dig $TARGET ANY +noall +answer > dns_info.txt

echo "[*] Recon complete. Results saved to:"
echo "- nmap_results.txt"
echo "- whois_info.txt"
echo "- dns_info.txt"
