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

ProgressOn ( "Flexsense", "Obtaining product links", "Please Wait", Default, Default, 18 )
$oie = _IECreate ( "http://www.flexense.com/downloads.html", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
$hol = ""
For $link In $links
	If $link.InnerText = "Windows 64-Bit" Then
		If StringInStr ( $link.href, "sysgauge" ) = 0 Then
			$hol = $hol & $link.href & "|"
		Else
			$hol = $hol & $link.href & "downloads.html|"
		EndIf
	Else
		ContinueLoop
	EndIf
Next
$navarr = StringSplit ( StringTrimRight ( $hol, 1 ), "|" )
For $i = 1 To $navarr[0] Step 1
	_IENavigate ( $oie, $navarr[$i] )
	_IELoadWait ( $oie )
	$links = _IELinkGetCollection ( $oie )
	$split = StringSplit ( $navarr[$i], "." )
	ProgressSet ( ( $i / $navarr[0] ) * 100, $split[2], "Downloading Files" )
	For $link In $links
		If StringInStr ( $link.href, $split[2] & "_setup_" ) > 0 Or StringInStr ( $link.href, $split[2] & "_portable_" ) > 0 Then
			$split2 = StringSplit ( $link.href, "/" )
			$file = InetGet ( $link.href, @UserProfileDir & "\Downloads\test\" & $split2[$split2[0]] )
			InetClose ( $file )
		Else
			ContinueLoop
		EndIf
	Next
Next
_IEQuit ( $oie )
ProgressOff ()