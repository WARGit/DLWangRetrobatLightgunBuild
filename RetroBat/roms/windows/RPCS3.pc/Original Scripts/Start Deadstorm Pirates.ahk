#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

FileCopyDir, GameConfigs\Time Crisis 4, config\custom_configs, 1

Run, rpcs3.exe --no-gui "dev_hdd0\disc\Time Crisis Razing Storm BLUS30528\PS3_GAME\USRDIR\deadstorm.self"

sleep, 7000



MsgBox % WinExist("A")

maxWindow("ahk_id" A)
return


maxWindow(title) 
{
    WinMove, % title, , 0, 0, % A_ScreenWidth, % A_ScreenHeight
    WinActivate, % title
    WinSet, Style, -0xC00000, % title
    WinSet, Style, -0x40000, % title
    WinSet, AlwaysOnTop, Off, % title
}

1::
Send {RButton down}
Sleep, 60
Send {MButton down}
Sleep, 60
Send {LButton down}
Sleep, 20
Send {LButton up}
Sleep, 60
Send {MButton up}
Send {RButton up}
Return

2::
Run, nomousy.exe /hide
Return

6::up

l::RButton


Esc::
Run, nomousy.exe
Process,Close,rpcs3.exe
Run,taskkill /im "rpcs3.exe" /F
sleep, 500
if WinExist("LaunchBox")
{
 WinActivate
}

if WinExist("LaunchBox BigBox")
{
 WinActivate
}
ExitApp
return