#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

FileCopyDir, GameConfigs\Time Crisis 3, inis, 1
Run, pcsx2.exe "roms/Time Crisis 3.gz" --nogui --fullscreen

sleep, 6000
WinActivate, ahk_exe pcsx2.exe
sleep, 500
Send {F3 down}
sleep, 100
Send {F3 up}

Esc::
Process,Close,pcsx2.exe
Run,taskkill /im "pcsx2.exe" /F
ExitApp