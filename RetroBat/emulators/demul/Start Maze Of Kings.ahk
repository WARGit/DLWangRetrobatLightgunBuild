#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

Run, nomousy.exe /hide
Run, V:\RetroBat\third party\DemulShooter\DemulShooter.exe -target=demul07a -rom=mok
Run, Demul.exe -run=naomi -rom=mok

Escape::
    Run, nomousy.exe
    Process,Close,Demul.exe
    Run,taskkill /im "Demul.exe" /F
    Process,Close,Demulshooter.exe
    Run,taskkill /im "Demulshooter.exe" /F
    ExitApp
return
