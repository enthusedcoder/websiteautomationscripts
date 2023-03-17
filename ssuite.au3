#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
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

ProgressOn ( "Download files", "Gathering information", "Please wait", Default, Default, 18 )
DirCreate ( @UserProfileDir & "\Downloads\test" )
$oie = _IECreate ( "http://www.ssuitesoft.com/freedownloads.htm", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
$i = 0
For $link in $links
	If StringInStr ( $link.href, "http://www.ssuitesoft.com/downloads/" ) > 0 Then
		$i += 1
	Else
		ContinueLoop
	EndIf
Next
Local $arr[$i]
$i = 0
For $link In $links
	If StringInStr ( $link.href, "http://www.ssuitesoft.com/downloads/" ) > 0 Then
		$arr[$i] = $link.href
		$i += 1
	Else
		ContinueLoop
	EndIf
Next
For $g = 0 To UBound ( $arr ) - 1 Step 1
	ConsoleWrite ( $g & " out of " & UBound ( $arr ) & @CRLF )
	_IENavigate ( $oie, $arr[$g] )
	_IELoadWait ( $oie )
	$links2 = _IELinkGetCollection ( $oie )
	For $ls In $links2
		If StringRight ( $ls.href, 3 ) = "exe" Or StringRight ( $ls.href, 3 ) = "zip" Then
			$split = StringSplit ( $ls.href, "/" )
			ProgressSet ( ( $g / UBound ( $arr ) ) * 100, $split[$split[0]], "Downloading Files" )
			$file = InetGet ( $ls.href, @UserProfileDir & "\Downloads\test\" & $split[$split[0]] )
			InetClose ( $file )
			ExitLoop
		Else
			ContinueLoop
		EndIf
	Next
Next
ProgressOff ()
_IEQuit ( $oie )