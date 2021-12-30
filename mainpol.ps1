[void](Import-Module Polaris)
Set-Location C:\WebApi
$VerbosePreference = 'Continue' # Comment this to stop transcript generation
$dateformat = Get-Date -format 'MM.dd.yyyy.HH.mm.ss' # modified this to reflect the exact time in 24 hour format
#$Subdateformat = Get-Date -format 'MM.dd.yyyy'
$LoggingDirectory = "C:\WebApi\Logs"
Start-Transcript -Path "$($LoggingDirectory)\Polaris_$($dateformat).log" -Force
$process = Get-Process -Id $pid
$process.PriorityClass = 'RealTime'
Start-Sleep -Seconds 5
$HostName = ($env:COMPUTERNAME+"."+$env:USERDNSDOMAIN).ToLower()
$Port = '81'
Set-Location C:\WebApi
#REGION STATIC ROUTES
#New-PolarisStaticRoute -RoutePath "/assets" -FolderPath "./assets"
New-PolarisStaticRoute -RoutePath "/routes" -FolderPath "./routes"
#ENDREGION
#REGION GET ROUTES
.\routes\home.ps1
.\routes\certexpiry.ps1

#ENDREGION
#Start-Polaris -Port $Port -Https -MaxRunspaces 5 -Auth IntegratedWindowsAuthentication
Start-Polaris -Port $Port -MaxRunspaces 5 -Auth IntegratedWindowsAuthentication

while ($true) {
    Start-Sleep -Milliseconds 10
}
Stop-Transcript


