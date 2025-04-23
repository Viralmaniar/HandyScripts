# Author: Viral Maniar
# Organisation: Preemptive Cyber Security Pty Ltd

import subprocess
import requests
import nvdlib

# Function to perform a version scan using nmap
def scan_versions(target_ip):
    print(f"Scanning {target_ip} for open ports and service versions...")
    result = subprocess.run(['nmap', '-sV', target_ip], capture_output=True, text=True)
    return result.stdout

# Function to extract service versions from nmap scan results
def extract_services(scan_output):
    services = []
    for line in scan_output.splitlines():
        if '/tcp' in line or '/udp' in line:
            parts = line.split()
            port = parts[0]
            service_info = parts[2] if len(parts) > 2 else ''
            services.append((port, service_info))
    return services

# Function to fetch CVEs for a given service and version
def fetch_cves(service_name, version):
    cve_list = []
    cpe = f"cpe:/a:{service_name}:{version}"
    try:
        cves = nvdlib.getCVE(cpe)
        for cve in cves:
            cve_list.append({
                'id': cve.cve.id,
                'description': cve.cve.description,
                'cvss': cve.cve.cvss
            })
    except Exception as e:
        print(f"Error fetching CVEs for {service_name} {version}: {e}")
    return cve_list

# Main function
def main():
    target_ip = input("Enter the target IP address: ")
    scan_output = scan_versions(target_ip)
    services = extract_services(scan_output)

    for port, service_info in services:
        if service_info:
            service_name, version = service_info.split(' ', 1)
            print(f"\nService: {service_name} Version: {version}")
            cves = fetch_cves(service_name, version)
            if cves:
                print("Known CVEs:")
                for cve in cves:
                    print(f"- {cve['id']}: {cve['description']} (CVSS: {cve['cvss']})")
            else:
                print("No known CVEs found.")
        else:
            print(f"\nPort {port}: Service information not available.")

if __name__ == "__main__":
    main()
