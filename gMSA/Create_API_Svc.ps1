function Install-Service {

    Param(

        [string]$nssmPath = 'C:\nssm-2.24\win64',
        [string]$Name,
        [string]$Description,
        [string]$Executable,
        [string]$Arguments

    )

    $nssm = Join-Path -Path $nssmPath -ChildPath 'nssm.exe'
    & $nssm install $name $executable $arguments
    $null = & $nssm set $name Description $description
    Start-Service $name
}
Install-Service -Name corp-webapi -Description 'PolarisWebAPI' -Executable Powershell.exe -Arguments '-ExecutionPolicy Bypass -Command C:\WebApi\mainpol.ps1'