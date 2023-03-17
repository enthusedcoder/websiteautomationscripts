
If (!(Test-Path "$env:USERPROFILE\Downloads\test"))
{
    New-Item -Path "$env:USERPROFILE\Downloads" -Name "test" -ItemType "directory"
}
$url = "http://www.netgate.sk/content/view/19/43/"
$products = @("Spy Emergency","FortKnox Personal Firewall","NETGATE Internet Security","NETGATE Registry Cleaner","NETGATE Amiti Antivirus","NETGATE Data Backup","BlackHawk Web Browser","Free Online TV","Black Panda Instant Messenger","BlackTube Free Youtube Video Downloader","Flash & USB Recovery")
$web = Invoke-WebRequest $url
$links = $web.Links
$i = 0
ForEach ($link in $links)
{
    If (($($link.InnerText) -like "Download Now") -and ($($link.href) -like "http://www.netgate.sk/download/download*"))
    {
       Start-Process sfk.exe -ArgumentList "wget $($link.href) `"$env:DOWNLOAD\test\$($products[$i]).exe`"" -Wait
        $i += 1
    }
}
