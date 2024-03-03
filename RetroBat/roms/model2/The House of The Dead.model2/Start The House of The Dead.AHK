#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force

SetWorkingDir D:\SegaModel2

Run, V:\RetroBat\third party\DemulShooter\DemulShooter.exe -target=model2 -rom=hotd, V:\RetroBat\third party\DemulShooter

sleep, 1000
Run, V:\RetroBat\emulators\m2emulator\emulator_multicpu.exe - hotd

$Esc::
    Process,Close,emulator_multicpu.exe
    Run,taskkill /im "emulator_multicpu.exe" /F
    Run,taskkill /im "DemulShooter.exe" /F
    sleep, 2000
    ExitApp
return
