; *** Start added by AutoIt3Wrapper ***
#include <InetConstants.au3>
; *** End added by AutoIt3Wrapper ***
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
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

ProgressOn ( "WinxDVD", "Preparing files", "Please wait...", Default, Default, 18 )
$oie = _IECreate ( "https://www.winxdvd.com/download.htm", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
$tot = @extended
$i = 0
For $link In $links
	$split = StringSplit ( $link.href, "/" )
	$i += 1
	ProgressSet ( ( $i / $tot ) * 100, $split[$split[0]], "Downloading Files" )
	If StringRight ( $link.href, 3 ) = "exe" Then
		$file = InetGet ( $link.href, @UserProfileDir & "\Downloads\test\" & $split[$split[0]], $INET_IGNORESSL )
		InetClose ( $file )
	Else
		ContinueLoop
	EndIf
Next
_IEQuit ( $oie )
ProgressOff ()