#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <IE.au3>

If Not FileExists ( @UserProfileDir & "\Downloads\test" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test" )
EndIf
ProgressOn ( "Freevideosoft.com", "Gathering URLs", "Please Wait", Default, Default, 18 )
$oie = _IECreate ( "https://www.dvdvideosoft.com/free-dvd-video-software-download.htm", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
$hol = ""
For $link In $links
	If $link.InnerText = "Download" Then
		$hol = $hol & $link.href & "|"
	Else
		ContinueLoop
	EndIf
Next
$array = StringSplit ( StringTrimRight ( $hol, 1 ), "|" )
For $i = 1 To $array[0] Step 1
	_IENavigate ( $oie, $array[$i] )
	_IELoadWait ( $oie )
	$links2 = _IELinkGetCollection ( $oie )
	For $link2 In $links2
		If $link2.InnerText = "direct download link" Then
			$filname = StringSplit ( $link2.href, "/" )
			ProgressSet ( ( $i / $array[0] ) * 100, $filname[$filname[0]], "Downloading Files" )
			$file = InetGet ( $link2.href, @UserProfileDir & "\Downloads\test\" & $filname[$filname[0]] )
			InetClose ($file)
			ExitLoop
		Else
			ContinueLoop
		EndIf
	Next
Next
_IEQuit ( $oie )
ProgressOff ()