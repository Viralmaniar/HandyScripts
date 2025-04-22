<#
.SYNOPSIS
  Basic Windows log monitor for failed logins.

.DESCRIPTION
  Monitors the Security log for Event ID 4625 (failed logon attempts) and outputs them in real-time.

.AUTHOR
  Viral Maniar
#>

Write-Host "Starting failed login monitor..." -ForegroundColor Cyan

$Query = @"
<QueryList>
  <Query Id="0" Path="Security">
    <Select Path="Security">
      *[System[(EventID=4625)]]
    </Select>
  </Query>
</QueryList>
"@

Register-WinEvent -Query $Query -Action {
    $event = $Event.SourceEventArgs.NewEvent
    $time = $event.TimeCreated
    $account = $event.Properties[5].Value
    $ip = $event.Properties[19].Value

    Write-Host "`n[!] Failed login detected:"
    Write-Host "Time: $time"
    Write-Host "Account: $account"
    Write-Host "Source IP: $ip"
} | Out-Null
