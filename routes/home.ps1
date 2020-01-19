New-PolarisGetRoute -Path "/home" -Scriptblock {
    $Response.SetContentType('text/html')
    $Html = Get-Content C:\WebApi\htmls\home.html -Raw
    $Response.Send($Html)
}