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

REM === Create Roms\dos dir in destination ===
mkdir "%directory%\roms\dos"

REM === Move Dos Roms out of source ====
move /Y "%~dp0roms\dos\Duke Nukem 3D (Shareware).dosz" "%directory\roms\dos"

REM === Create Roms\dreamcast dir in destination ===
mkdir "%directory%\roms\dreamcast"

REM === Move Dreamcast Roms out of source ====
move /Y "%~dp0roms\dreamcast\Virtua Cop 2 v1.011 (2000)(Sega)(NTSC)(JP)(en)[!].chd" "%directory\roms\dreamcast"

REM === Create Roms\mame dir in destination ===
mkdir "%directory%\roms\mame"

REM === Move MAME Roms out of source ====
REM move /Y "%~dp0roms\mame\TODO" "%directory\roms\mame"
REM - There are a lot of mame roms / other files to move.. TODO

REM === Create Roms\megadrive dir in destination ===
mkdir "%directory%\roms\megadrive"
move /Y "%~dp0roms\megadrive\Menacer 6-Game Cartridge (USA, Europe).zip" "%directory\roms\megadrive"

REM === Create Roms\model3 dir in destination ===
mkdir "%directory%\roms\model3"

REM === Move model3 Roms out of source ====
move /Y "%~dp0roms\model3\lamachin.zip" "%directory\roms\model3"
move /Y "%~dp0roms\model3\lostwsga.zip" "%directory\roms\model3"
move /Y "%~dp0roms\model3\oceanhun.zip" "%directory\roms\model3"
move /Y "%~dp0roms\model3\swtrilgy.zip" "%directory\roms\model3"

REM === Create Roms\naomi dirs in destination ===
mkdir "%directory%\roms\naomi"
mkdir "%directory%\roms\naomi\confmiss"
mkdir "%directory%\roms\naomi\lupinsho"
mkdir "%directory%\roms\naomi\mok"

REM === Move naomi Roms out of source ====
move /Y "%~dp0roms\naomi\confmiss\confmiss\gds-0001.chd" "%directory\roms\naomi\confmiss"
move /Y "%~dp0roms\naomi\confmiss\lupinsho\lupinsho\gds-0018.chd" "%directory\roms\naomi\lupinsho"
move /Y "%~dp0roms\naomi\confmiss\mok\gds-0022.chd" "%directory\roms\mok\confmiss"
REM === NOTE:: There are more videos in here than roms, correct? TBC.

REM === Create Roms\nes dir in destination ===
mkdir "%directory%\roms\nes"

REM === Move nes Roms out of source ====
move /Y "%~dp0roms\nes\Barker Bill's Trick Shooting (USA).zip" "%directory\roms\nes"
move /Y "%~dp0roms\nes\Duck Hunt (World).zip" "%directory\roms\nes"
move /Y "%~dp0roms\nes\Freedom Force (USA).nes" "%directory\roms\nes"
move /Y "%~dp0roms\nes\Gumshoe (USA, Europe).zip" "%directory\roms\nes"
move /Y "%~dp0roms\nes\Hogan's Alley (World).zip" "%directory\roms\nes"
move /Y "%~dp0roms\nes\Mechanized Attack (USA).zip" "%directory\roms\nes"
move /Y "%~dp0roms\nes\To the Earth (USA).zip" "%directory\roms\nes"
move /Y "%~dp0roms\nes\Wild Gunman (World).zip" "%directory\roms\nes"

REM === Create Roms\ps2 dir in destination ===
mkdir "%directory%\roms\ps2"

REM === Move PS2 Roms out of source ====
move /Y "%~dp0roms\ps2\Vampire Night (USA).gz" "%directory\roms\ps2"
REM TODO What is the 8MB Vampire Night (USA).gz.pindex.tmp file in this folder? do we need it? - TBC
REM TODO - There are other PS2 games missing from this roms folder where are they and why?

REM === Create Roms\psx dir in destination ===
mkdir "%directory%\roms\psx"

REM === Move psx Roms out of source ====
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 01).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 02).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 03).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 04).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 05).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 06).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 07).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 08).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 09).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 10).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 11).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 12).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 13).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 14).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 15).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 16).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 17).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 18).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 19).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 20).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 21).bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0).cue" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Elemental Gearbolt (USA).chd" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Judge Dredd (USA).chd" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Point Blank 3 [SLUS-01354].bin" "%directory\roms\psx"
move /Y "%~dp0roms\psx\Point Blank 3 [SLUS-01354].cue" "%directory\roms\psx"

REM === Create Roms\snes dir in destination ===
mkdir "%directory%\roms\snes"

REM === Move snes Roms out of source ====
move /Y "%~dp0roms\snes\Battle Clash (USA).zip" "%directory\roms\snes"
move /Y "%~dp0roms\snes\Bazooka Blitzkrieg (USA).zip" "%directory\roms\snes"
move /Y "%~dp0roms\snes\Super Scope 6 (USA).zip" "%directory\roms\snes"
move /Y "%~dp0roms\snes\X Zone (Japan, USA).zip" "%directory\roms\snes"

REM === Create Roms\teknoparrot dir in destination ===
mkdir "%directory%\roms\teknoparrot"

REM === Create Roms\wii dir in destination ===
mkdir "%directory%\roms\wii"

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




