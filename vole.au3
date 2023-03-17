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

ProgressOn ( "Vole Download", "Obtaining links", "Please Wait", Default, Default, 18 )
$oie = _IECreate ( "http://www.sanwhole.com/iExchange/Message.aspx?gash=e6ed452dd9ff410cbd30923acd895ecf&tash=a0978bcd97354f3d984e2828f970f8ba&cash=a0978bcd97354f3d984e2828f970f8ba", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
$num = @extended
$i = 0
For $link In $links
	$i += 1
	If StringRight ( $link.href, 3 ) = "zip" Or StringRight ( $link.href, 3 ) = "exe" Then
		$split = StringSplit ( $link.href, "/" )
		ProgressSet ( ( $i / $num ) * 100, $split[$split[0]], "Downloading files" )
		$file = InetGet ( $link.href, @UserProfileDir & "\Downloads\test\" & $split[$split[0]] )
		InetClose ( $file )
	Else
		ProgressSet ( ( $i / $num ) * 100, $link.href, "Downloading files" )
		ContinueLoop
	EndIf
Next
ProgressOff ()
_IEQuit ( $oie )