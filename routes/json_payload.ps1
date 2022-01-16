New-PolarisGetRoute -Path "/certmon" -Scriptblock {
    $pkiexp = . C:\WebApi\subroutes\certmon.ps1
    $Response.SetContentType( "application/json" )
    $Response.json($pkiexp)
}
