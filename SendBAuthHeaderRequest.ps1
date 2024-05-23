$username = "changeme"
$password = "changeme"
$combo = "${user}:${pass}"

#Encode the string to the RFC2045-MIME variant of Base64, except not limited to 76 char/line.
$bytes = [System.Text.Encoding]::ASCII.GetBytes($combo)
$base64 = [System.Convert]::ToBase64String($bytes)

$base64AuthInfo = "Basic $base64"
Write-Output $base64AuthInfo

$headers = @{ Authorization = $base64AuthInfo }

#Invoke the web-request
Invoke-WebRequest -uri $uri -Headers $headers
