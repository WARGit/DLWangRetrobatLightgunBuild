@echo off
REM ====================================
REM Author:  Wayne Robinson
REM Date: 	 17th Feb 24
REM Purpose: To move all roms, bios / any copyrighted works out of the source to a seperate folder before uploading to github.
REM Usage:   Place in the root of the source at the same level as retrobat.exe.
REM Version: 0.1
REM ====================================

REM === Ask user for destination dir ===
@echo on
set /p directory="Enter dir path to copy files to: "
echo %directory%
@echo off

REM === Create destination dir if not exist ===
mkdir "%directory%"

REM ==== Move entire bios dir out of source===
move /Y "%~dp0bios" "%directory%"

REM === Create Roms\Windows dir in destination ===
mkdir "%directory%\roms\windows"

REM === Move Windows Roms out of source ====
move /Y "%~dp0roms\windows\Banzai Escape 2.PC" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Banzai Escape.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Big Buck Hunter Arcade.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Block King Ball Shooter.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Blue Estaet.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Dead Containment.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Death Live.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Demul 180428 Light Guns.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Dream Raiders.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Ed Hunter.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Elevator Action Death Parade.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Friction.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Fruit Ninja.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Gaia Attack 4.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Gal.Gun.Double.Peace.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Gundam SOZ.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Haunted Museum 2.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\Haunted Museum.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\House  Of The Dead Overkill.pc" "%directory\roms\windows"
move /Y "%~dp0roms\windows\House Of The Dead Scarlet Dawn.pc" "%directory\roms\windows"

pause




