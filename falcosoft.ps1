If (!(Test-Path "$env:USERPROFILE\Downloads\test"))
{
    New-Item -Path "$env:USERPROFILE\Downloads" -Name "test" -ItemType "directory"
}
$url = "http://falcosoft.hu/softwares.html"
$links = (Invoke-webrequest $url).Links
Foreach ($link in $links)
{
    If ($link.href.EndsWith("zip") -or $link.href.EndsWith("exe") -or $link.href.EndsWith("msi"))
    {
        $newlink = $url -replace "softwares.html","$($link.href)"
        Invoke-WebRequest $newlink -OutFile "$env:DOWNLOAD\test\$($link.href)"
    }
}