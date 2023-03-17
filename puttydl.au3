; *** Start added by AutoIt3Wrapper ***
#include <InetConstants.au3>
; *** End added by AutoIt3Wrapper ***
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


If Not FileExists ( @UserProfileDir & "\Downloads\test\w64" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test\w64" )
EndIf
If Not FileExists ( @UserProfileDir & "\Downloads\test\w32" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test\w32" )
EndIf

$oie = _IECreate ( "https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
For $link In $links
	If StringRight ( $link.InnerText, 3 ) = "exe" Or StringRight ( $link.InnerText, 3 ) = "zip" Or StringRight ( $link.InnerText, 3 ) = "msi" Then
		$split = StringSplit ( $link.href, "/" )
		ConsoleWrite ( "Downloading file " & $split[$split[0]] & @CRLF )
		If StringInStr ( $link.href, "w64" ) > 0 Then
			$file = InetGet ( $link.href, @UserProfileDir & "\Downloads\test\w64\" & $split[$split[0]], $INET_IGNORESSL )
			InetClose ( $file )
		ElseIf StringInStr ( $link.href, "w32" ) > 0 Then
			$file = InetGet ( $link.href, @UserProfileDir & "\Downloads\test\w32\" & $split[$split[0]], $INET_IGNORESSL )
			InetClose ( $file )
		Else

		EndIf
	Else
		ContinueLoop
	EndIf
Next
_IEQuit ( $oie )