#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
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
#include <Array.au3>
If Not FileExists ( @UserProfileDir & "\Downloads\test" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test" )
EndIf

ProgressOn ( "download henry", "Setting up", "Please wait", Default, Default, 18 )
$oie = _IECreate ( "http://www.henrypp.org/", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
$hol = ""
For $link In $links
	If StringInStr ( $link.href, "http://www.henrypp.org/product/" ) > 0 Then
		$hol = $hol & $link.href & "|"
	Else
		ContinueLoop
	EndIf
Next
$arr = StringSplit ( StringTrimRight ( $hol, 1 ), "|", 2 )
$new = _ArrayUnique ( $arr )
For $i = 0 To UBound ( $new ) - 1 Step 1
	ProgressSet ( ( $i / ( UBound ( $new ) - 1 ) ) * 100, $new[$i], "Downloading files" )
	_IENavigate ( $oie, $new[$i] )
	_IELoadWait ( $oie )
	$links2 = _IELinkGetCollection ( $oie )
	$git = ""
	For $link2 In $links2
		If $link2.InnerText = "Binaries from GitHub" Then
			$git = $link2.href
			ExitLoop
		Else
			ContinueLoop
		EndIf
	Next
	_IENavigate ( $oie, $git )
	_IELoadWait ( $oie )
	$links3 = _IELinkGetCollection ( $oie )
	For $link3 In $links3
		If StringRight ( $link3.href, 3 ) = "zip" Or StringRight ( $link3.href, 3 ) = "exe" Or StringRight ( $link3.href, 2 ) = "7z" Then
			$split = StringSplit ( $link3.href, "/" )
			$file = InetGet ( $link3.href, @UserProfileDir & "\Downloads\test\" & $split[$split[0]], 2 )
			InetClose ( $file )
		Else
			ContinueLoop
		EndIf
	Next
Next
_IEQuit ( $oie )
ProgressOff ( )