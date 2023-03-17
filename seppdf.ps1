If (!(Test-Path "$env:USERPROFILE\Downloads\test"))
{
    New-Item -Path "$env:USERPROFILE\Downloads" -Name "test" -ItemType "directory"
}
$url = "http://www.ne.jp/asahi/foresth/home/indexe.htm"
$links = (Invoke-webrequest "http://www.ne.jp/asahi/foresth/home/indexe.htm").Links
Foreach ($link in $links)
{
    If ($link.href.EndsWith("zip") -or $link.href.EndsWith("exe"))
    {
        $newlink = $url -replace "indexe.htm","$($link.href)"
        Invoke-WebRequest $newlink -OutFile "$env:DOWNLOAD\test\$($link.href)"
    }
}