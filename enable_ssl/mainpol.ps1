[void](Import-Module Polaris)
Set-Location C:\WebApi
#$VerbosePreference = 'Continue' # Comment this to stop transcript generation
$dateformat = Get-Date -format 'MM.dd.yyyy.HH.mm.ss' # modified this to reflect the exact time in 24 hour format
#$Subdateformat = Get-Date -format 'MM.dd.yyyy'
$LoggingDirectory = "C:\WebApi\Logs"
Start-Transcript -Path "$($LoggingDirectory)\Polaris_$($dateformat).log" -Force
$process = Get-Process -Id $pid
$process.PriorityClass = 'RealTime'
#Provide Friendly Name into the Certificate
$get_ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress
$get_thumbprint = (Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.FriendlyName -eq "webapi"}).Thumbprint
$Port = '443'
Invoke-Expression -Command "Netsh http delete sslcert ipport=0.0.0.0:$($Port)"
Invoke-Expression -Command "Netsh http delete sslcert ipport=$($get_ip):$($Port)"
#Start-Sleep -Seconds 5
$AppID = "{" + $(New-Guid) + "}"
Invoke-Expression -Command "netsh http add sslcert ipport=0.0.0.0:$($Port) certhash=$get_thumbprint appid='$($AppID)' certstorename=MY"
Invoke-Expression -Command "netsh http add sslcert ipport=$($get_ip):$($Port) certhash=$get_thumbprint appid='$($AppID)' certstorename=MY"
Set-Location C:\WebApi
#REGION GET ROUTES
.\routes\home.ps1
.\routes\certexpiry.ps1
.\routes\employees.ps1
#ENDREGION
Start-Polaris -Port $Port -MaxRunspaces 5 -Debug -Verbose -Https -Auth IntegratedWindowsAuthentication

while ($true) {
    Start-Sleep -Milliseconds 10
}
Stop-Transcript
