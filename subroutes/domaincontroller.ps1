[void](Import-Module PSWriteHTML)   
$Title = 'Dashboard | Domain Controllers'
$icon = 'Your Image URL'
$headertxt = "<h1>Corp Domain Controllers</h1>"
$TableTitle = "Corp Domain Controller"
$Get_dcs = [system.directoryservices.activedirectory.domain]::GetCurrentDomain().DomainControllers | Select Name,IPAddress,OSVersion,SiteName
#$DbwriteTime = (Get-Item "C:\WebApi\apicache\cert.json").LastWriteTime
New-HTML -FavIcon $icon -TitleText $Title -AutoRefresh 50 {
    New-HTMLContent -HeaderText "<center>$headertxt</center>" {
        New-HTMLTable -Title $TableTitle -DataTable $Get_dcs -HideFooter -PagingOptions @(25, 50) {
         #Conditional Formatting
         #TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator le -Value 364 -Color white -BackgroundColor Red
         #TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator ge -Value 363 -Color Black -BackgroundColor PaleGreen
            
        } 
    }
}
 
