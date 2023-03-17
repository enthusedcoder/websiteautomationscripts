#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
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
OnAutoItExitRegister ( "_Exit" )
If Not FileExists ( @UserProfileDir & "\Downloads\test" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test" )
EndIf

ProgressOn ( "Download files", "Gathering URLs", "Please Wait", Default, Default, 18 )
$oIE = _IECreate ( "http://soft4boost.com/download", Default, 0 )
_IELoadWait ( $oIE )
$links = _IELinkGetCollection ( $oIE )
$num = @extended
$hol = 0
For $link In $links
	$hol += 1
	ProgressSet ( ( $hol / $num ) * 100, "Downloading URLs", "Downloading URLs" )
	If StringRight ( $link.href, 3 ) = "exe" Then
		$split = StringSplit ( $link.href, "/" )
		$file = InetGet ( $link.href, @UserProfileDir & "\Downloads\test\" & $split[$split[0]] )
		InetClose ( $file )
	Else
		ContinueLoop
	EndIf
Next
ProgressOff ()
Func _Exit ()
	_IEQuit ( $oIE )
	Exit
EndFunc
