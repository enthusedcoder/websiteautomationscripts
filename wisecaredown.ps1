If (!(Test-Path "$env:USERPROFILE\Downloads\test"))
{
    New-Item -Path "$env:USERPROFILE\Downloads" -Name "test" -ItemType "directory"
}
$ie = Invoke-WebRequest http://www.wisecleaner.com/download.html
$links = $ie.Links
Foreach ($link in $links)
{
    If ($link.href.EndsWith('exe') -or $link.href.EndsWith('zip'))
    {
        $file = $link.href.Split('/')
        Invoke-WebRequest $link.href -OutFile "$env:DOWNLOAD\test\$($file[-1])"
    }
    Write-Host "$link`n"
}