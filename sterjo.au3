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
If Not FileExists ( @UserProfileDir & "\Downloads\test" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test" )
EndIf

ProgressOn ( "Sterjo soft", "Gathering list of products", "PLease wait...", Default, Default, 18 )
$sUrl = "http://www.sterjosoft.com/products.html"
$oIE = _IECreate($sUrl, Default, 0)
_IELoadWait($oIE)
$oLinks1 = _IELinkGetCollection($oIE)
$hol = ""
For $link In $oLinks1
	If StringLeft ( $link.InnerText, 6 ) = "Sterjo" Then
		$hol = $hol & $link.href & "|"
	Else
		ContinueLoop
	EndIf
Next
$array = StringSplit ( StringTrimRight ( $hol, 1 ), "|" )
For $i = 1 To $array[0] Step 1
	$split = StringSplit ( $array[$i], "/" )
	$filename = StringSplit ( $split[$split[0]], "." )
	ProgressSet ( ( $i / $array[0] ) * 100, $filename[1], "Downloading Files" )
	_IENavigate ( $oIE, $array[$i] )
	_IELoadWait ( $oIE )
	$links2 = _IELinkGetCollection ( $oIE )
	For $link2 In $links2
		If $link2.InnerText = "Portable" Then
			ShellExecuteWait ( "sfk.exe", "wget " & $link2.href & ' "' & @UserProfileDir & '\Downloads\test\' & $filename[1] & '.zip"', @ScriptDir )
		ElseIf $link2.InnerText = "Download" Then
			ShellExecuteWait ( "sfk.exe", "wget " & $link2.href & ' "' & @UserProfileDir & '\Downloads\test\' & $filename[1] & '.exe"', @ScriptDir )
		Else
			ContinueLoop
		EndIf
	Next
Next
_IEQuit ( $oIE )
ProgressOff ( )