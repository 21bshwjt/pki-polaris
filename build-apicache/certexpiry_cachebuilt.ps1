#PSSQLITE

    Import-Module PSSQLite | Out-Null
    $Database = "C:\WebApi\apicache\ca.SQLite"
    Invoke-SqliteQuery -DataSource $Database -Query "delete from ca" | Out-Null
    
    

#get CA2 Details
function Get_CorpCertExpiry ($duedays=500,$CAlocation="corp-dc02.msft.net\msft-ca1") 
        {
            $certs = @()
            $now = (Get-Date).Date
            $expirationdate = $now.AddDays($duedays)
            $CaView = New-Object -Com CertificateAuthority.View.1
            [void]$CaView.OpenConnection($CAlocation)
            $CaView.SetResultColumnCount(7)
            $index0 = $CaView.GetColumnIndex($false, "Issued Common Name")
            $index1 = $CaView.GetColumnIndex($false, "Certificate Expiration Date")
            $index2 = $CaView.GetColumnIndex($false, "Issued Email Address")
            $index3 = $CaView.GetColumnIndex($false, "Certificate Template")
            $index4 = $CaView.GetColumnIndex($false, "Request Disposition")
            $index5 = $CaView.GetColumnIndex($false, "Serial Number")
            $index6 = $CaView.GetColumnIndex($false, "Request ID")
            
            
            $index0, $index1, $index2, $index3, $index4, $index5, $index6 | %{$CAView.SetResultColumn($_)}
            
            # CVR_SORT_NONE 0
            # CVR_SEEK_EQ  1
            # CVR_SEEK_LT  2
            # CVR_SEEK_GT  16
            
            
            $index1 = $CaView.GetColumnIndex($false, "Certificate Expiration Date")
            $CAView.SetRestriction($index1,16,0,$now)
            $CAView.SetRestriction($index1,2,0,$expirationdate)
            
            
            # brief disposition code explanation:
            # 9 - pending for approval
            # 15 - CA certificate renewal
            # 16 - CA certificate chain
            # 20 - issued certificates
            # 21 - revoked certificates
            # all other - failed requests
            $CAView.SetRestriction($index4,1,0,20)
            
            $RowObj= $CAView.OpenView()
            
            while ($Rowobj.Next() -ne -1){
                $Cert = New-Object PsObject
                $ColObj = $RowObj.EnumCertViewColumn()
                [void]$ColObj.Next()
                do {
                $current = $ColObj.GetName()
                $Cert | Add-Member -MemberType NoteProperty $($ColObj.GetDisplayName()) -Value $($ColObj.GetValue(1)) -Force
                } until ($ColObj.Next() -eq -1)
                Clear-Variable ColObj
                $datediff = New-TimeSpan -Start ($now) -End ($cert."Certificate Expiration Date")
                #$cert."Issued Common Name" + "|" + $datediff.Days + "|" + $cert."Certificate Expiration Date"+ "|" + $cert."Serial Number"+ "|" + $cert."Request ID" + "|" + $cert."Certificate Template"
                #"Send email to : " + $cert."Issued Email Address"
                $RDPCert = "1.3.6.1.4.1.311.21.8.1182609.12583907.10568614.12547189.10026671.174.16355481.8775434"
                $DirectoryEmailReplication = "1.3.6.1.4.1.311.21.8.1182609.12583907.10568614.12547189.10026671.174.1.29"
                $DomainControllerAuthentication = "1.3.6.1.4.1.311.21.8.1182609.12583907.10568614.12547189.10026671.174.1.28"
                $KerberosAuthentication = "1.3.6.1.4.1.311.21.8.1182609.12583907.10568614.12547189.10026671.174.1.33"
                if (($cert."Certificate Template" -eq $RDPCert) -or `
                    ($cert."Certificate Template" -eq $DirectoryEmailReplication ) -or `
                    ($cert."Certificate Template" -eq $DomainControllerAuthentication) -or `
                    ($cert."Certificate Template" -eq $KerberosAuthentication )
                    
                    )
                {
                [PSCustomObject]@{
                    CertificateName = $cert."Issued Common Name"
                    DaysUntilExpired = $datediff.Days
                    ExpiryDate = $cert."Certificate Expiration Date"
                    Serial = $cert."Serial Number"
                    #ReqID = $cert."Request ID"
                    Template = ($cert."Certificate Template" -replace "$RDPCert","RDP Cert" `
                    -replace "$DirectoryEmailReplication","Directory EmailReplication" `
                    -replace "$DomainControllerAuthentication","DomainController Authentication" `
                    -replace "$KerberosAuthentication","Kerberos Authentication"
                    
                    )   
                }
                }
            
                #"------------------------"
            }
            $RowObj.Reset()
            $CaView = $null
            [GC]::Collect()
        }

    $getca = Get_CorpCertExpiry -EA SilentlyCOntinue

#http://ramblingcookiemonster.github.io/SQLite-and-PowerShell/
#Import the module, create a data source and a table
#Import-Module PSSQLite
 <#
    $Database = "C:\WebApi\apicache\ca.SQLite"
    
    $Query = "CREATE TABLE ca (
        CertificateName TEXT,
        DaysUntilExpired TEXT,
        ExpiryDate TEXT,
        Serial TEXT PRIMARY KEY,
        Template TEXT)"
        #>
        
 
    #SQLite will create Names.SQLite for us
    #Invoke-SqliteQuery -Query $Query -DataSource $Database
    #Invoke-SqliteQuery -DataSource $Database -Query "PRAGMA table_info(ca)" | FT
 
    $DataTable = $getca | ForEach-Object {
    [pscustomobject]@{
        CertificateName = $PSItem.CertificateName
        DaysUntilExpired = $PSItem.DaysUntilExpired
        ExpiryDate = $PSItem.ExpiryDate
        Serial = $PSItem.Serial
        Template = $PSItem.Template
    }
} | Out-DataTable
 
Invoke-SQLiteBulkCopy -DataTable $DataTable -DataSource $Database -Table ca -NotifyAfter 1000 -ConflictClause Ignore -Force -Verbose
Invoke-SqliteQuery -DataSource $Database -Query "SELECT * FROM ca"
