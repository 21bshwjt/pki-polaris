$css = @"
<link rel="shortcut icon" href="https://media-exp1.licdn.com/dms/image/C5603AQF32M9PAU6shg/profile-displayphoto-shrink_200_200/0?e=1585180800&v=beta&t=TxiT4J6jY6aH0W6jT_gskE4IoGim8lDT8EWBPqSqA0s"/>
<Title>Corp | Certificate Expiry</Title>
<head><meta http-equiv="refresh" content="60"></head>
"@
    
Import-Module PSSQLite | Out-Null
$Database = "C:\WebApi\apicache\ca.SQLite"
$getca = Invoke-SqliteQuery -DataSource $Database -Query "SELECT * FROM ca"
$DbwriteTime = (Get-Item "C:\WebApi\apicache\ca.SQLite").LastWriteTime

$htmlca = $getca
$htmlca | ConvertTo-Html -Title "Corp | CA Report" -CssUri "http://corp-dc02/table.css" -Head $css -PreContent "<h2><font color = #008000><center>Corp | Certificate Expiry Report</font></h2><h8>Last Update: $DbwriteTime</h8>" | Out-String