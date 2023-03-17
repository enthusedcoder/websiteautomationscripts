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
#include <Zip.au3>


OnAutoItExitRegister ( "_Exit" )
If Not FileExists ( @UserProfileDir & "\Downloads\test" ) Then
	DirCreate ( @UserProfileDir & "\Downloads\test" )
EndIf

$oIE = _IECreate ( "http://securityxploded.com/download.php", Default, 0 )
_IELoadWait ( $oIE )
$links = _IELinkGetCollection ( $oIE )
$store = @extended
Local $url[$store][2]
$store2 = 0
For $link In $links
	$url[$store2][0] = $link.innerText
	$url[$store2][1] = $link.href
	$store2 += 1
Next

_ArrayDisplay ( $url )

For $i = 0 To $store - 1 Step 1
	If $url[$i][0] = "Download" Then
		_IENavigate ( $oIE, $url[$i][1] )
		_IELoadWait ( $oIE )
		Sleep ( 3000 )
		$down = _IELinkGetCollection ( $oIE )
		For $dow In $down
			If StringCompare ( $dow.innerText, "Download Link" ) = 0 Then
				RunWait ( @ComSpec & ' /c sfk.exe wget ' & $dow.href & ' "' & @UserProfileDir & '\Downloads\test\hold.zip"', @ScriptDir )
				If FileGetSize ( @UserProfileDir & "\Downloads\test\hold.zip" ) = 0 Then
					Do
						FileDelete ( @UserProfileDir & "\Downloads\test\hold.zip" )
					Until ( @UserProfileDir & "\Downloads\test\hold.zip" )
					ContinueLoop 2
				EndIf
				$root = _Zip_List ( @UserProfileDir & '\Downloads\test\hold.zip' )
				FileMove ( @UserProfileDir & '\Downloads\test\hold.zip', @UserProfileDir & '\Downloads\test\' & $root[1] & '.zip', $FC_OVERWRITE )
				ExitLoop
			Else
				ContinueLoop
			EndIf
		Next
	Else
		ContinueLoop
	EndIf
Next




Func _Exit ()
	_IEQuit ( $oIE )
	Exit
EndFunc
