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

$oIE = _IECreate ( "http://www.mitec.cz/Data/XML/data_downloads.xml", Default, 0 )
_IELoadWait ( $oIE )
$links = _IELinkGetCollection ( $oIE )
For $link In $links
	If StringRight ( $link.href, 3 ) = "exe" Or StringRight ( $link.href, 3 ) = "zip" Then
		$split = StringSplit ( $link.href, "/" )
		$file = InetGet ( $link.href, @UserProfileDir & "\Downloads\test\" & $split[$split[0]] )
		InetClose ( $file )
	Else
		ContinueLoop
	EndIf
Next
_IEQuit ( $oIE )