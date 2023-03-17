#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
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
#include <Console.au3>
If Not FileExists ( @UserProfileDir & "\Downloads\test" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test" )
EndIf

$oie = _IECreate ( "http://www.nchsoftware.com/download/index.html", Default, 0 )
_IELoadWait ( $oie )
$links = _IELinkGetCollection ( $oie )
$num = @extended
$i = 0
For $link In $links
	$i += 1
	Cout ( "Processing link " & $i & " of " & $num & "." & @CRLF )
	If StringRight ( $link.href, 3 ) = "exe" Then
		$split = StringSplit ( $link.href, "/" )
		$file = InetGet ( $link.href, @UserProfileDir & "\Downloads\test\" & $split[$split[0]] )
		InetClose ( $file )
	Else
		ContinueLoop
	EndIf
Next
_IEQuit ( $oie )
