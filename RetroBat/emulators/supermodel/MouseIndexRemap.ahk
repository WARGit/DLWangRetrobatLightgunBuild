#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run %ComSpec% /c `"%A_ScriptDir%\ControllerRemap.exe`" /list > list.txt ,, hide
Sleep 500

;***********************************
; Insert guns ID/PID here
;***********************************
P1DeviceID = VID_2341_PID_8037
P1DevicePID = 8042
P2DeviceID = VID_2341_PID_8038
P2DevicePID = 8043
;***********************************

Loop, read, %A_ScriptDir%\list.txt
{
	DeviceIndex := SubStr(A_LoopReadLine, 4 , 1)

	if(DeviceIndex > 0 && DeviceIndex < 30) {
		if InStr(A_LoopReadLine, P1DevicePID) {
			if(DeviceIndex != P1DeviceID) {
				NewP1DeviceIndex = %DeviceIndex%
			}
		}
		if InStr(A_LoopReadLine, P2DevicePID) {
			if(DeviceIndex != P2DeviceID) {
				NewP2DeviceIndex = %DeviceIndex%
			}
		}
	}
}

if FileExist(A_ScriptDir "\retroarch.exe") {
	Loop, read, retroarch.cfg, retroarch.cfg.temp
	{
		if InStr(A_LoopReadLine, "input_player1_mouse_index") {
			FileAppend, input_player1_mouse_index = "%NewP1DeviceIndex%"`n, retroarch.cfg.temp
		} else if InStr(A_LoopReadLine, "input_player2_mouse_index") {
			FileAppend, input_player2_mouse_index = "%NewP2DeviceIndex%"`n, retroarch.cfg.temp
		} else {
			FileAppend, %A_LoopReadLine%`n, retroarch.cfg.temp
		}
	}
	Sleep 500
	FileMove, retroarch.cfg, retroarch.cfg.bak, 1
	Sleep 500
	FileMove, retroarch.cfg.temp, retroarch.cfg, 1
}

if FileExist(A_ScriptDir "\Supermodel.exe") {
	; Player 1 Light Gun
	IniWrite, %A_Space%"MOUSE%NewP1DeviceIndex%_XAXIS`,JOY1_XAXIS", %A_ScriptDir%\Config\Supermodel.ini, Global, InputGunX
	IniWrite, %A_Space%"MOUSE%NewP1DeviceIndex%_YAXIS`,JOY1_YAXIS", %A_ScriptDir%\Config\Supermodel.ini, Global, InputGunY
	IniWrite, %A_Space%"KEY_A`,JOY1_BUTTON1`,MOUSE%NewP1DeviceIndex%_LEFT_BUTTON", %A_ScriptDir%\Config\Supermodel.ini, global, InputTrigger
	IniWrite, %A_Space%"KEY_S`,JOY1_BUTTON2`,MOUSE%NewP1DeviceIndex%_RIGHT_BUTTON", %A_ScriptDir%\Config\Supermodel.ini, Global, InputOffscreen

	; Player 1 Analog Light Gun
	IniWrite, %A_Space%"MOUSE%NewP1DeviceIndex%_XAXIS`,JOY1_XAXIS", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogGunX
	IniWrite, %A_Space%"MOUSE%NewP1DeviceIndex%_YAXIS`,JOY1_YAXIS", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogGunY
	IniWrite, %A_Space%"KEY_A`,JOY1_BUTTON1`,MOUSE%NewP1DeviceIndex%_LEFT_BUTTON", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogTriggerLeft
	IniWrite, %A_Space%"KEY_S`,JOY1_BUTTON2`,MOUSE%NewP1DeviceIndex%_RIGHT_BUTTON", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogTriggerRight

	; Player 1 Analog Joystick
	IniWrite, %A_Space%"JOY1_XAXIS`,MOUSE%NewP1DeviceIndex%_XAXIS_INV", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogJoyX
	IniWrite, %A_Space%"JOY1_YAXIS`,MOUSE%NewP1DeviceIndex%_YAXIS_INV", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogJoyY
	
	; Player 2 Light Gun
	IniWrite, %A_Space%"MOUSE%NewP2DeviceIndex%_XAXIS`,JOY2_XAXIS", %A_ScriptDir%\Config\Supermodel.ini, Global, InputGunX2
	IniWrite, %A_Space%"MOUSE%NewP2DeviceIndex%_YAXIS`,JOY2_YAXIS", %A_ScriptDir%\Config\Supermodel.ini, Global, InputGunY2
	IniWrite, %A_Space%"KEY_Z`,JOY2_BUTTON1`,MOUSE%NewP2DeviceIndex%_LEFT_BUTTON", %A_ScriptDir%\Config\Supermodel.ini, Global, InputTrigger2
	IniWrite, %A_Space%"KEY_X`,JOY2_BUTTON2`,MOUSE%NewP2DeviceIndex%_RIGHT_BUTTON", %A_ScriptDir%\Config\Supermodel.ini, Global, InputOffscreen2

	; Player 2 Analog Light Gun
	IniWrite, %A_Space%"MOUSE%NewP2DeviceIndex%_XAXIS`,JOY2_XAXIS", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogGunX2
	IniWrite, %A_Space%"MOUSE%NewP2DeviceIndex%_YAXIS`,JOY2_YAXIS", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogGunY2
	IniWrite, %A_Space%"KEY_Z`,JOY2_BUTTON1`,MOUSE%NewP2DeviceIndex%_LEFT_BUTTON", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogTriggerLeft2
	IniWrite, %A_Space%"KEY_X`,JOY2_BUTTON2`,MOUSE%NewP2DeviceIndex%_RIGHT_BUTTON", %A_ScriptDir%\Config\Supermodel.ini, Global, InputAnalogTriggerRight2
}

ExitApp