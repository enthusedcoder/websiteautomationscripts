If (!(Test-Path "$env:USERPROFILE\Downloads\test"))
{
    New-Item -Path "$env:USERPROFILE\Downloads" -Name "test" -ItemType "directory"
}
$links = (Invoke-webrequest "http://www.kcsoftwares.com/?download").links
ForEach ($link in $links)
{
    If (($($link.InnerText) -eq 'Download Lite') -or (($link.href).EndsWith('zip')))
    {
        $string = ($link.href).Split('/')
        Invoke-WebRequest $link.href -OutFile $env:DOWNLOAD\test\$($string[-1])
    }
}