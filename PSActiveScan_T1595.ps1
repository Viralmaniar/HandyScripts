# PowerShell Script: Active Scanning - Port Scan (T1595)
# Author: Viral Maniar

$targetIP = "192.168.1.1" # Replace with the IP address of the target
$ports = 80, 443, 22, 3389  # List of common ports to scan (HTTP, HTTPS, SSH, RDP)

# Function to check if a port is open
function Test-Port {
    param (
        [string]$ip,
        [int]$port
    )
    try {
        $tcpConnection = Test-NetConnection -ComputerName $ip -Port $port
        if ($tcpConnection.TcpTestSucceeded) {
            Write-Host "Port $port is OPEN on $ip"
        } else {
            Write-Host "Port $port is CLOSED on $ip"
        }
    } catch {
        Write-Host "Error scanning port $port on $ip"
    }
}

# Loop through each port and test it
foreach ($port in $ports) {
    Test-Port -ip $targetIP -port $port
}

Write-Host "Active Scan Completed"
