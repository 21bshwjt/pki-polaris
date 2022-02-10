[void](Import-Module PSWriteHTML)   
$Title = 'Dashboard | PKI-Expiry'
$icon = 'Your Image URL'
$headertxt = "<h1>Corp Certificate Expiry Report</h1>"
$TableTitle = "MSFT-CA1 Expiry Report"
$data = Get-Content "C:\WebApi\apicache\cert.json" | ConvertFrom-Json
$DbwriteTime = (Get-Item "C:\WebApi\apicache\cert.json").LastWriteTime
New-HTML -FavIcon $icon -TitleText $Title -AutoRefresh 50 {
    New-HTMLContent -HeaderText "<center>$headertxt</center><span><center>Refreshed: $DbwriteTime</center></span>" {
        New-HTMLTable -Title $TableTitle -DataTable $data -HideFooter -PagingOptions @(25, 50) {
         #Conditional Formatting
         TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator le -Value 364 -Color white -BackgroundColor Red
         TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator ge -Value 363 -Color Black -BackgroundColor PaleGreen
            
        } 
    }
}
