[void](Import-Module PSSQLite)
[void](Import-Module PSWriteHTML)
    $Database = "C:\WebApi\apicache\ca.SQLite"
    $getca = Invoke-SqliteQuery -DataSource $Database -Query "SELECT * FROM ca"
    $DbwriteTimeca = (Get-Item "C:\WebApi\apicache\ca.SQLite").LastWriteTime
    Dashboard -Name 'Certificate Expiry' -AutoRefresh 300 {
       
        Section -Name "<h4>Corp | Certificate Expiry</h4><span>Last Updated: $DbwriteTimeca</span>" -BackgroundColor Cornsilk {
         Table -DataTable $getca -DefaultSortColumn 'DaysUntilExpired' -HideFooter {
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator le -Value 8 -Color white -BackgroundColor Red
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator eq -Value 8 -Color Black -BackgroundColor Pink
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator eq -Value 9 -Color Black -BackgroundColor Pink
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator eq -Value 10 -Color Black -BackgroundColor Pink
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator eq -Value 11 -Color Black -BackgroundColor Pink
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator eq -Value 12 -Color Black -BackgroundColor Pink
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator eq -Value 13 -Color Black -BackgroundColor Pink
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator eq -Value 14 -Color Black -BackgroundColor Pink
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator eq -Value 15 -Color Black -BackgroundColor Pink
            TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator ge -Value 16 -Color Black -BackgroundColor PaleGreen
        }
    }
}
