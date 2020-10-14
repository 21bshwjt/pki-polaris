[void](Import-Module PSWriteHTML)   
[void](Import-Module PSSQLite)
$Database = "C:\WebApi\apicache\ca.SQLite"
$getca = Invoke-SqliteQuery -DataSource $Database -Query "SELECT * FROM ca"
$DbwriteTime = (Get-Item "C:\WebApi\apicache\ca.SQLite").LastWriteTime

$Title = 'Dashboard | PKI-Expiry'
$icon = 'https://pngmind.com/wp-content/uploads/2019/08/Linkedin-Logo-Png-Transparent-Background.png'
$headertxt = "<h4>Corp Certificate Expiry Report</h4>"
$TableTitle = "MSFT-CA1 Expiry Report"

New-HTML -FavIcon $icon -TitleText $Title -Online -AutoRefresh 50 {
    New-HTMLContent -HeaderText $headertxt {
        New-HTMLTable -Title $TableTitle -DataTable $getca -HideFooter -PagingOptions @(6, 12, 24) {
         TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator le -Value 8 -Color white -BackgroundColor Red
         TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator ge -Value 8 -Color Black -BackgroundColor PaleGreen
            
        } 
    }
}

