$username = "changeme"
$password = "changeme"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $password)))

Write-Output $base64AuthInfo
