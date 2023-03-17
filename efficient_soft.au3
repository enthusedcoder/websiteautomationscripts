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

ProgressOn ( "Downloading files", "Obtaining links", "Please wait", Default, Default, 18 )
$oie = _IECreate ( "http://www.efficientsoftware.net/download.htm", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
$num = @extended
$i = 0
For $link In $links
	$i += 1
	$split = StringSplit ( $link.href, "/" )
	ProgressSet ( ( $i / $num ) * 100, $split[$split[0]], "Downloading..." )
	If StringInStr ( $link.href, "free" ) > 0 Then
		InetGet ( $link.href, @UserProfileDir & "\Downloads\test\" & $split[$split[0]] )
	Else
		ContinueLoop
	EndIf
Next
_IEQuit ( $oie )
ProgressOff ()