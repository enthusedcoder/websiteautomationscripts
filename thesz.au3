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
#include <Array.au3>
#include <Zip.au3>
OnAutoItExitRegister ( "_Exit" )
If Not FileExists ( @UserProfileDir & "\Downloads\test" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test" )
EndIf

ProgressOn ( "SZ downloads", "Gathering Links", "Please wait", Default, Default, 18 )
$oIE = _IECreate ( "http://www.the-sz.com/products/index.php", Default, 0 )
_IELoadWait ( $oIE )
$links = _IELinkGetCollection ( $oIE )
$hold = ""
$p = 0
For $link In $links
	If StringInStr ( $link.href, "http://www.the-sz.com/products/" ) > 0 And StringRegExp ( $link.href, "http:\/\/www\.the-sz\.com\/products\/\w+\/" ) = 1 Then
		$hold = $hold & $link.href & ";"
	Else
		ContinueLoop
	EndIf
Next
$temp = StringSplit ( StringTrimRight ( $hold, 1 ), ";", 2 )
$prod = _ArrayUnique ( $temp )

For $i = 0 To UBound ( $prod ) - 1 Step 1
	$split2 = StringSplit ( StringTrimRight ( $prod[$i], 1 ), "/" )
	ProgressSet ( ( $i / UBound ( $prod ) - 1 ) * 100, $split2[$split2[0]], "Downloading files" )
	_IENavigate ( $oIE, $prod[$i] )
	_IELoadWait ( $oIE )
	$links2 = _IELinkGetCollection ( $oIE )
	For $link2 In $links2
		If StringRight ( $link2.InnerText, 3 ) = "zip" Then
			If StringInStr ( $link2.InnerText, "Free Download" ) > 0 Then
				$ansplit = StringSplit ( StringStripWS ( $link2.InnerText, 3 ), " " )
				If Not FileExists ( @UserProfileDir & "\Downloads\test\" & $ansplit[3] ) Then
					ShellExecuteWait ( "sfk.exe", 'wget ' & $link2.href & ' "' & @UserProfileDir & '\Downloads\test\' & $ansplit[3] & '"', @ScriptDir, Default, @SW_SHOW )
				Else
					ContinueLoop
				EndIf
			Else
				$split = StringSplit ( $link2.InnerText, ":" )
				If @error Then
					SetError ( 0 )
					ShellExecuteWait ( "sfk.exe", 'wget ' & $link2.href & ' "' & @UserProfileDir & '\Downloads\test\' & StringStripWS ( $link2.InnerText, 3 ) & '"', @ScriptDir, Default, @SW_SHOW )
				Else
					ShellExecuteWait ( "sfk.exe", 'wget ' & $link2.href & ' "' & @UserProfileDir & '\Downloads\test\' & StringStripWS ( $split[$split[0]], 3 ) & '"', @ScriptDir, Default, @SW_SHOW )
				EndIf
			EndIf
		Else
			ContinueLoop
		EndIf
	Next
Next
ProgressOff ()



Func _Exit ()
	_IEQuit ( $oIE )
EndFunc
