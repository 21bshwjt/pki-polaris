New-PolarisGetRoute -Path "/certmon" -Scriptblock {
    $pkiexp = . C:\WebApi\subroutes\json_payload.ps1
    $Response.SetContentType( "application/json" )
    $Response.json($pkiexp)
}
