[void](Import-Module Polaris)
Set-Location C:\WebApi
#$VerbosePreference = 'Continue' # Comment this to stop transcript generation
$dateformat = Get-Date -format 'MM.dd.yyyy.HH.mm.ss' # modified this to reflect the exact time in 24 hour format
#$Subdateformat = Get-Date -format 'MM.dd.yyyy'
$LoggingDirectory = "C:\WebApi\Logs"
Start-Transcript -Path "$($LoggingDirectory)\Polaris_$($dateformat).log" -Force
$process = Get-Process -Id $pid
$process.PriorityClass = 'RealTime'
#Netsh http delete sslcert ipport=0.0.0.0:443
#Change the IP
Invoke-Expression -Command "Netsh http delete sslcert ipport=0.0.0.0:443"
Invoke-Expression -Command "Netsh http delete sslcert ipport=192.168.1.5:443"
#Start-Sleep -Seconds 5
$AppID = "{" + $(New-Guid) + "}"
$Port = '443'
#Change IP & Certificate Thumprint
Invoke-Expression -Command "netsh http add sslcert ipport=0.0.0.0:$($Port) certhash=b9e617a9729fbac954f54a2c8ed58eec1aae3151 appid='$($AppID)' certstorename=MY"
Invoke-Expression -Command "netsh http add sslcert ipport=192.168.1.5:$($Port) certhash=b9e617a9729fbac954f54a2c8ed58eec1aae3151 appid='$($AppID)' certstorename=MY"
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


