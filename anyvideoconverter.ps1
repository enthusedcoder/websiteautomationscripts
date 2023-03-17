If (!(Test-Path "$env:USERPROFILE\Downloads\test"))
{
    New-Item -Path "$env:USERPROFILE\Downloads" -Name "test" -ItemType "directory"
}
$ie = Invoke-WebRequest "http://any-video-converter.com/download/#freeware"
$links = $ie.AllElements
Foreach ($link in $links)
{
    If ($link.href.EndsWith('exe'))
    {
        $file = $link.href.Split('/')
        Invoke-WebRequest $link.href -OutFile "$env:DOWNLOAD\test\$($file[-1])"
    }
    Write-Host "$link`n"
}