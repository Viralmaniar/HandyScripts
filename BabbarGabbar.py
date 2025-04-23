# Python Script: T1595.002 Vulnerability Scanning (Basic Banner Grabbing)
# Author: Viral Maniar

import socket

target = input("Enter target IP or domain (e.g., 192.168.1.100): ")
ports = [21, 22, 23, 80, 443, 3389]

print(f"\nScanning {target} for open ports and banners...")

for port in ports:
    try:
        s = socket.socket()
        s.settimeout(2)
        s.connect((target, port))
        try:
            banner = s.recv(1024).decode().strip()
            if banner:
                print(f"Port {port} open - Banner: {banner}")
            else:
                print(f"Port {port} open - No banner")
        except:
            print(f"Port {port} open - No banner received")
        s.close()
    except:
        print(f"Port {port} closed or filtered")
