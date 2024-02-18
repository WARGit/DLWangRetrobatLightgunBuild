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
move /Y "%~dp0roms\mame\area51.chd" "%directory\roms\mame"
move /Y "%~dp0roms\mame\area51t.chd" "%directory\roms\mame"
move /Y "%~dp0roms\mame\bbh_140.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\bbh_150.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\bbh_160.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\bbusters.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\carnevil.chd" "%directory\roms\mame"
move /Y "%~dp0roms\mame\cpzn1.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\cpzn2.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\cryptklr.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\decocass.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\gollygho.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\iteagle.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\iteagle_fpga.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\konamigx.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\le2.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\lethalen.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\megaplay.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\megatech.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\neogeo.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\nss.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\oneshot.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\pgm.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\playch10.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\policetr13a.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\ptblank.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\ptblank2.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\sgunner.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\sgunner2.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\skns.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\stvbios.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\taitotz.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\timecris.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\tps.zip" "%directory\roms\mame"
move /Y "%~dp0roms\mame\zombraid.zip" "%directory\roms\mame"

REM - mame BIOS bits to move too

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

REM === Move teknoparrot Roms out of source ====
move /Y "%~dp0roms\teknoparrot\2spicy.teknoparrot" "%directory\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Aliens Extermination.teknoparrot" "%directory\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Farcry Instincts Paradise.teknoparrot" "%directory\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Let's Go Jungle Special.teknoparrot" "%directory\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\LuigisMansion.teknoparrot" "%directory\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Operation G.H.O.S.T..teknoparrot" "%directory\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Sega Golden Gun.teknoparrot" "%directory\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Star Trek Voyager.teknoparrot" "%directory\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Transformers Human Alliance.teknoparrot" "%directory\roms\teknoparrot"

REM === Create Roms\wii dir in destination ===
mkdir "%directory%\roms\wii"

REM === Move wii Roms out of source ====
move /Y "%~dp0roms\wii\Alien Syndrome (USA).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\All Round Hunter.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Arcade Shooting Gallery.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Big Buck Hunter Pro.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Buck Fever.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Chicken Blaster (USA) (En,Fr,Es).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Chicken Riot (USA) (En,Fr,Es) (Rev 1).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Chicken Shoot (USA) (En,Fr,Es).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Deer Drive (USA).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Deer Drive Legends (USA) (En,Fr,Es).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Dino Strike.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Ghost Squad.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Gunblade NY & L.A. Machineguns Arcade Hits Pack (USA) (En,Fr,Es).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Gunslingers.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Heavy Fire - Afghanistan (USA).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\House of the Dead 2 & 3 Return, The (USA) (En,Fr,Es).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\House of the Dead, The - Overkill (USA) (En,Fr,Es).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Links Crossbow Training.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Mad Dog McCree - Gunslinger Pack.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Martian Panic.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Nerf N-Strike - Double Blast Bundle (USA).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Nerf N-Strike (USA).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\North American Hunting Extravaganza.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Operation Wolf (USA) (NES) (Virtual Console).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Remington Great American Bird Hunt.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Resident Evil - The Darkside Chronicles.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Resident Evil - The Umbrella Chronicles.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Resident Evil 4 - Wii Edition (USA).wbfs" "%directory\roms\wii"
REM --- Not sure why RE4 is here, not strictly a lightgun only game, requires a controller to move Leon - TBC
move /Y "%~dp0roms\wii\Resident Evil Archives - Resident Evil (USA).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Resident Evil Archives - Resident Evil Zero (USA).wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Sin And Punishment.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Target Terror.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Top Shot Arcade.wbfs" "%directory\roms\wii"
move /Y "%~dp0roms\wii\Top Shot Dinosaur Hunter (USA).wbfs" "%directory\roms\wii"

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




