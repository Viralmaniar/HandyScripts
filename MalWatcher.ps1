<#
.SYNOPSIS
  Monitors common drop directories for executable files.

.DESCRIPTION
  Watches for .exe, .dll, .bat files dropped in Downloads, Temp, Desktop

.AUTHOR
  Viral Maniar
#>

$paths = @(
  "$env:USERPROFILE\Downloads",
  "$env:USERPROFILE\Desktop",
  "$env:TEMP"
)

foreach ($path in $paths) {
    Register-WmiEvent -Query "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'CIM_DataFile' AND TargetInstance.Drive = 'C:' AND TargetInstance.Path = '\\$($path.Replace(':','').Replace('\','\\'))\\'" -Action {
        $file = $Event.SourceEventArgs.NewEvent.TargetInstance.Name
        if ($file -match "\.exe$|\.dll$|\.bat$") {
            Write-Host "[!] Suspicious drop: $file"
        }
    }
}

Write-Host "Monitoring drop paths for suspicious files..."
while ($true) { Start-Sleep 60 }
