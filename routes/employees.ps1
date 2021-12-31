New-PolarisGetRoute -Path "/employees" -Scriptblock {
    $emps = . C:\WebApi\subroutes\employees.ps1
    $Response.SetContentType("text/html")
    $Response.Send($emps)
}