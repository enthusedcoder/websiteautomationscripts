If (!(Test-Path "$env:USERPROFILE\Downloads\test"))
{
    New-Item -Path "$env:USERPROFILE\Downloads" -Name "test" -ItemType "directory"
}
$url = "http://www.mediahuman.com/download.html"
$links = (Invoke-webrequest "http://www.mediahuman.com/download.html").Links
Foreach ($link in $links)
{
    If ($link.href.endswith('exe'))
    {
        $split = $link.href.Split('/')
        Invoke-WebRequest $($url.Replace("download.html","$($link.href)")) -OutFile "$env:DOWNLOAD\test\$($split[-1])"
    }
}