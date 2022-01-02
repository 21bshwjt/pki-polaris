New-PolarisGetRoute -Path "/domaincontroller" -Scriptblock {
    $getdcs = . C:\WebApi\subroutes\domaincontroller.ps1
    $Response.SetContentType("text/html")
    $Response.Send($getdcs)
}