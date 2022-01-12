[void](Import-Module Pswritehtml -Force)
$getempdata = Get-Content C:\WebApi\apicache\employees.json | ConvertFrom-Json

New-HTML -TitleText "Identity" {
    New-HTMLSection -HeaderText '<h1>Contoso</h1>' {
        New-HTMLContent -HeaderText "<h3>Team Info</h3>" -CanCollapse -HeaderTextColor Black -HeaderBackGroundColor PaleGoldenrod {
            New-HTMLTable -Title "Copper" -DataTable $getempdata -HideFooter -PagingOptions @(50, 100, 500, 1000) {
                            
            } 
        }
        
    }

}