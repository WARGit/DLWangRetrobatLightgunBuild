@echo off
REM ====================================
REM Author:  Wayne Robinson
REM
REM Date: 	 17th Feb 24
REM
REM Purpose: To move all roms, bios / any copyrighted works out of the source to a seperate folder before uploading to github.
REM
REM Usage:   Place in the root of the source at the same level as retrobat.exe, 
REM			 execute and provide the path of a directory (without spaces) for content to be moved to when prompted
REM
REM Version: 0.1
REM ====================================

REM === Ask user for destination dir ===
@echo on
set /p directory="Enter dir path to copy files to: "
echo %directory%

REM === Create destination dir if not exist ===
mkdir "%directory%"

REM ==== Move entire bios dir out of source===
move /Y "%~dp0bios" "%directory%"

REM === Create Roms\dos dir in destination ===
mkdir "%directory%\roms\dos"

REM === Move dos Roms out of source ====
move /Y "%~dp0roms\dos\Duke Nukem 3D (Shareware).dosz" "%directory%\roms\dos"

REM === Move dos images out of source ====
move /Y "%~dp0roms\dos\images" "%directory%\roms\dos"

REM === Create Roms\dreamcast dir in destination ===
mkdir "%directory%\roms\dreamcast"

REM === Move Dreamcast Roms out of source ====
move /Y "%~dp0roms\dreamcast\Virtua Cop 2 v1.011 (2000)(Sega)(NTSC)(JP)(en)[!].chd" "%directory%\roms\dreamcast"

REM === Move dreamcast videos/images out of source ====
move /Y "%~dp0roms\dreamcast\images" "%directory%\roms\dreamcast"
move /Y "%~dp0roms\dreamcast\videos" "%directory%\roms\dreamcast"

REM === Create Roms\mame dir in destination ===
mkdir "%directory%\roms\mame"

REM === Move MAME Roms (zip files) out of source ====
move /Y "%~dp0roms\mame\area51.chd" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\area51t.chd" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\bbh_140.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\bbh_150.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\bbh_160.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\bbusters.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\carnevil.chd" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\cpzn1.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\cpzn2.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\cryptklr.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\decocass.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gollygho.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\iteagle.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\iteagle_fpga.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\konamigx.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\le2.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\lethalen.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\megaplay.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\megatech.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\neogeo.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\nss.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\oneshot.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\pgm.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\playch10.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\policetr13a.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\ptblank.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\ptblank2.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\sgunner.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\sgunner2.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\skns.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\stvbios.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\taitotz.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\timecris.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\tps.zip" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\zombraid.zip" "%directory%\roms\mame"

REM === Move mame folders out of source (these contain various bin/bios files etc) ===
move /Y "%~dp0roms\mame\32x" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\a5200" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\a7800" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\area51" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\area51mx" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\bbh" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\bbh2sp" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\bbhcotw" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\bbhsc" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\c1541" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\c64" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\carnevil" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\coleco" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\cpc6128" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\cryptklr" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\evilngt" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gameboy" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gba" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gbcolor" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_dkjr" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_dkong" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_dkong2" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_fire" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_fireatk" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_ghouse" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_lboat" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_manhole" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_mario" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_mariocm" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_mickdon" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_octopus" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_opanic" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_pchute" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_popeye" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_stennis" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_tbridge" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\gnw_zelda" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\intv" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\mame2003" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\pce" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\psu" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\segacd" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\sms" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\snes" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\spectrum" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\stic" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\tg16" "%directory%\roms\mame"

REM === Move mame videos/images out of source ====
move /Y "%~dp0roms\mame\images" "%directory%\roms\mame"
move /Y "%~dp0roms\mame\videos" "%directory%\roms\mame"

REM === Create Roms\megadrive dir in destination ===
mkdir "%directory%\roms\megadrive"
move /Y "%~dp0roms\megadrive\Menacer 6-Game Cartridge (USA, Europe).zip" "%directory%\roms\megadrive"

REM === Move megadrive videos/images out of source ====
move /Y "%~dp0roms\megadrive\images" "%directory%\roms\megadrive"
move /Y "%~dp0roms\megadrive\videos" "%directory%\roms\megadrive"

REM === Create Roms\model3 dir in destination ===
mkdir "%directory%\roms\model3"

REM === Move model3 Roms out of source ====
move /Y "%~dp0roms\model3\lamachin.zip" "%directory%\roms\model3"
move /Y "%~dp0roms\model3\lostwsga.zip" "%directory%\roms\model3"
move /Y "%~dp0roms\model3\oceanhun.zip" "%directory%\roms\model3"
move /Y "%~dp0roms\model3\swtrilgy.zip" "%directory%\roms\model3"

REM === Move model3 videos/images out of source ====
move /Y "%~dp0roms\model3\images" "%directory%\roms\model3"
move /Y "%~dp0roms\model3\manuals" "%directory%\roms\model3"
move /Y "%~dp0roms\model3\videos" "%directory%\roms\model3"

REM === Create Roms\naomi dirs in destination ===
mkdir "%directory%\roms\naomi"

REM === Move naomi Roms out of source ====
move /Y "%~dp0roms\naomi\confmiss" "%directory%\roms\naomi"
move /Y "%~dp0roms\naomi\lupinsho" "%directory%\roms\naomi"
move /Y "%~dp0roms\naomi\mok" "%directory%\roms\naomi"
REM === NOTE:: There are more videos in here than roms, correct? TBC.

REM === Move naomi videos/images out of source ====
move /Y "%~dp0roms\naomi\images" "%directory%\roms\naomi"
move /Y "%~dp0roms\naomi\videos" "%directory%\roms\naomi"

REM === Create Roms\nes dir in destination ===
mkdir "%directory%\roms\nes"

REM === Move nes Roms out of source ====
move /Y "%~dp0roms\nes\Barker Bill's Trick Shooting (USA).zip" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\Duck Hunt (World).zip" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\Freedom Force (USA).nes" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\Gumshoe (USA, Europe).zip" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\Hogan's Alley (World).zip" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\Mechanized Attack (USA).zip" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\To the Earth (USA).zip" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\Wild Gunman (World).zip" "%directory%\roms\nes"

REM === Move nes videos/images out of source ====
move /Y "%~dp0roms\nes\images" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\manuals" "%directory%\roms\nes"
move /Y "%~dp0roms\nes\videos" "%directory%\roms\nes"

REM === Create Roms\ps2 dir in destination ===
mkdir "%directory%\roms\ps2"

REM === Move PS2 Roms out of source ====
move /Y "%~dp0roms\ps2\Vampire Night (USA).gz" "%directory%\roms\ps2"
move /Y "%~dp0roms\ps2\Vampire Night (USA).gz.pindex.tmp" "%directory%\roms\ps2"
REM TODO What is the 8MB Vampire Night (USA).gz.pindex.tmp file in this folder? do we need it? - TBC

REM === Move ps2 videos/images out of source ====
move /Y "%~dp0roms\ps2\images" "%directory%\roms\ps2"
move /Y "%~dp0roms\ps2\videos" "%directory%\roms\ps2"

REM === Create Roms\psx dir in destination ===
mkdir "%directory%\roms\psx"

REM === Move psx Roms out of source ====
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 01).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 02).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 03).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 04).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 05).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 06).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 07).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 08).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 09).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 10).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 11).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 12).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 13).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 14).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 15).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 16).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 17).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 18).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 19).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 20).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0) (Track 21).bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Die Hard Trilogy (USA) (v1.0).cue" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Elemental Gearbolt (USA).chd" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Judge Dredd (USA).chd" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Point Blank 3 [SLUS-01354].bin" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\Point Blank 3 [SLUS-01354].cue" "%directory%\roms\psx"

REM === Move psx videos/images out of source ====
move /Y "%~dp0roms\psx\images" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\manuals" "%directory%\roms\psx"
move /Y "%~dp0roms\psx\videos" "%directory%\roms\psx"

REM === Create Roms\snes dir in destination ===
mkdir "%directory%\roms\snes"

REM === Move snes Roms out of source ====
move /Y "%~dp0roms\snes\Battle Clash (USA).zip" "%directory%\roms\snes"
move /Y "%~dp0roms\snes\Bazooka Blitzkrieg (USA).zip" "%directory%\roms\snes"
move /Y "%~dp0roms\snes\Super Scope 6 (USA).zip" "%directory%\roms\snes"
move /Y "%~dp0roms\snes\X Zone (Japan, USA).zip" "%directory%\roms\snes"

REM === Move snes videos/images out of source ====
move /Y "%~dp0roms\snes\images" "%directory%\roms\snes"
move /Y "%~dp0roms\snes\videos" "%directory%\roms\snes"

REM === Create emulators\supermodel dir in destination ===
mkdir "%directory%\emulators\supermodel"

REM === Move supermodel Roms/saves/etc out of source ====
REM - NOTE: These roms are duplicated in roms\model3 why? - TBC
move /Y "%~dp0emulators\supermodel\ROMS" "%directory%\emulators\supermodel"
move /Y "%~dp0emulators\supermodel\Saves" "%directory%\emulators\supermodel"
move /Y "%~dp0emulators\supermodel\Snaps" "%directory%\emulators\supermodel"

REM === Create Roms\teknoparrot dir in destination ===
mkdir "%directory%\roms\teknoparrot"

REM === Move teknoparrot Roms out of source ====
move /Y "%~dp0roms\teknoparrot\2spicy.teknoparrot" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Aliens Extermination.teknoparrot" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Farcry Instincts Paradise.teknoparrot" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Let's Go Jungle Special.teknoparrot" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\LuigisMansion.teknoparrot" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Operation G.H.O.S.T..teknoparrot" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Sega Golden Gun.teknoparrot" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Star Trek Voyager.teknoparrot" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\Transformers Human Alliance.teknoparrot" "%directory%\roms\teknoparrot"

REM === Move teknoparrot videos/images out of source ====
move /Y "%~dp0roms\teknoparrot\box" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\images" "%directory%\roms\teknoparrot"
move /Y "%~dp0roms\teknoparrot\videos" "%directory%\roms\teknoparrot"

REM === Create Roms\wii dir in destination ===
mkdir "%directory%\roms\wii"

REM === Move wii Roms out of source ====
move /Y "%~dp0roms\wii\Alien Syndrome (USA).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\All Round Hunter.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Arcade Shooting Gallery.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Big Buck Hunter Pro.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Buck Fever.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Chicken Blaster (USA) (En,Fr,Es).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Chicken Riot (USA) (En,Fr,Es) (Rev 1).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Chicken Shoot (USA) (En,Fr,Es).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Deer Drive (USA).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Deer Drive Legends (USA) (En,Fr,Es).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Dino Strike.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Ghost Squad.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Gunblade NY & L.A. Machineguns Arcade Hits Pack (USA) (En,Fr,Es).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Gunslingers.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Heavy Fire - Afghanistan (USA).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\House of the Dead 2 & 3 Return, The (USA) (En,Fr,Es).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\House of the Dead, The - Overkill (USA) (En,Fr,Es).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Links Crossbow Training.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Mad Dog McCree - Gunslinger Pack.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Martian Panic.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Nerf N-Strike - Double Blast Bundle (USA).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Nerf N-Strike (USA).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\North American Hunting Extravaganza.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Operation Wolf (USA) (NES) (Virtual Console).wad" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Remington Great American Bird Hunt.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Resident Evil - The Darkside Chronicles.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Resident Evil - The Umbrella Chronicles.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Resident Evil 4 - Wii Edition (USA).wbfs" "%directory%\roms\wii"
REM --- Not sure why RE4 is here, not strictly a lightgun only game, requires a controller to move Leon - TBC
move /Y "%~dp0roms\wii\Resident Evil Archives - Resident Evil (USA).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Resident Evil Archives - Resident Evil Zero (USA).wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Sin And Punishment.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Target Terror.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Top Shot Arcade.wbfs" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\Top Shot Dinosaur Hunter (USA).wbfs" "%directory%\roms\wii"

REM === Move wii videos/images out of source ====
move /Y "%~dp0roms\wii\images" "%directory%\roms\wii"
move /Y "%~dp0roms\wii\videos" "%directory%\roms\wii"

REM === Create roms\windows dirs in destination ===
mkdir "%directory%\roms\windows\RPCS3.pc"
mkdir "%directory%\roms\windows\PCSX2 1.6.0.pc"

REM === Move Windows Roms out of source ====
move /Y "%~dp0roms\windows\Banzai Escape 2.PC" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Banzai Escape.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Big Buck Hunter Arcade.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Block King Ball Shooter.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Blue Estaet.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Dead Containment.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Death Live.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Demul 180428 Light Guns.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Dream Raiders.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Ed Hunter.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Elevator Action Death Parade.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Friction.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Fruit Ninja.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Gaia Attack 4.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Gal.Gun.Double.Peace.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Gundam SOZ.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Haunted Museum 2.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Haunted Museum.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\House  Of The Dead Overkill.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\House Of The Dead Scarlet Dawn.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Intake.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Lets go Island 3d.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Mad Bullets.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Major Mayhem.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Music Gungun! 2.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Rabbids Hollywood Arcade.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Reload.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Silent Hill The Arcade.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Silent Scope 2.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\THE HOUSE OF THE DEAD Remake.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Time Crisis 5.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Tomb RaiderLC.pc" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\Wild West Shoot Out.pc" "%directory%\roms\windows"

REM === Move Windows videos/images/manuals out of source ====
move /Y "%~dp0roms\windows\box" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\images" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\manuals" "%directory%\roms\windows"
move /Y "%~dp0roms\windows\videos" "%directory%\roms\windows"

REM === Create PCSX2 dirs in destination ===
mkdir "%directory%\roms\windows\PCSX2 1.6.0.pc\roms"

REM === Move PS2 Roms out of source ====
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\roms\Time Crisis 2.gz" "%directory%\roms\windows\PCSX2 1.6.0.pc\roms"
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\roms\Time Crisis 3.gz" "%directory%\roms\windows\PCSX2 1.6.0.pc\roms"
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\roms\Time Crisis Crisis Zone.iso" "%directory%\roms\windows\PCSX2 1.6.0.pc\roms"
REM - TODO - These roms are in a different location to Vampire Night above, why? - TBC
REM - .tmp files also in this dir, TBC if these are required / not
REM - TODO There a number of save states in the "sstates" folder, TBC if these are required or not.

REM === Move xbox PS2 bios files out of source ====
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\bios" "%directory%\roms\windows\PCSX2 1.6.0.pc"

REM === Move other files/folders out of PS2 emu source ====
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\sstates" "%directory%\roms\windows\PCSX2 1.6.0.pc"
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\memcards" "%directory%\roms\windows\PCSX2 1.6.0.pc"
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\cheats_ws.zip" "%directory%\roms\windows\PCSX2 1.6.0.pc"
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\roms\Time Crisis 3.gz.pindex.tmp" "%directory%\roms\windows\PCSX2 1.6.0.pc\roms"
move /Y "%~dp0roms\windows\PCSX2 1.6.0.pc\roms\Time Crisis 2.gz.pindex.tmp" "%directory%\roms\windows\PCSX2 1.6.0.pc\roms"

REM === Create RPCS3 dirs in destination ===
mkdir "%directory%\roms\windows\RPCS3.pc"
mkdir "%directory%\roms\windows\RPCS3.pc\dev_hdd1"
mkdir "%directory%\roms\windows\RPCS3.pc\dev_hdd0\disc"
mkdir "%directory%\roms\windows\RPCS3.pc\dev_hdd0\game"
mkdir "%directory%\roms\windows\RPCS3.pc\dev_hdd0\home\00000001\exdata"

REM === Move PS3 Roms out of source ====
move /Y "%~dp0roms\windows\RPCS3.pc\dev_hdd0\disc\Time Crisis Razing Storm BLUS30528" "%directory%\roms\windows\RPCS3.pc\dev_hdd0\disc"
move /Y "%~dp0roms\windows\RPCS3.pc\dev_hdd0\game\BLUS30528_DSP" "%directory%\roms\windows\RPCS3.pc\dev_hdd0\game"
move /Y "%~dp0roms\windows\RPCS3.pc\dev_hdd0\game\BLUS30528" "%directory%\roms\windows\RPCS3.pc\dev_hdd0\game"
move /Y "%~dp0roms\windows\RPCS3.pc\dev_hdd0\game\BLUS30093" "%directory%\roms\windows\RPCS3.pc\dev_hdd0\game"
REM - BLUS30528 = Time Crisis Razing Storm
REM - BLUS30093 = Time Crisis 4

REM === Move other files/folders out of PS3 emu source ====
move /Y "%~dp0roms\windows\RPCS3.pc\savestates" "%directory%\roms\windows\RPCS3.pc"
move /Y "%~dp0roms\windows\RPCS3.pc\cache" "%directory%\roms\windows\RPCS3.pc"
move /Y "%~dp0roms\windows\RPCS3.pc\dev_hdd1\caches" "%directory%\roms\windows\RPCS3.pc\dev_hdd1"
move /Y "%~dp0roms\windows\RPCS3.pc\dev_flash" "%directory%\roms\windows\RPCS3.pc"
move /Y "%~dp0roms\windows\RPCS3.pc\rpcs3_old" "%directory%\roms\windows\RPCS3.pc"
move /Y "%~dp0roms\windows\RPCS3.pc\RPCS3.log.gz" "%directory%\roms\windows\RPCS3.pc"
move /Y "%~dp0roms\windows\RPCS3.pc\dev_hdd0\home\00000001\savedata" "%directory%\roms\windows\RPCS3.pc\dev_hdd0\home\00000001"
move /Y "%~dp0roms\windows\RPCS3.pc\dev_hdd0\home\00000001\trophy" "%directory%\roms\windows\RPCS3.pc\dev_hdd0\home\00000001"
move /Y "%~dp0roms\windows\RPCS3.pc\dev_hdd0\home\00000001\exdata" "%directory%\roms\windows\RPCS3.pc\dev_hdd0\home\00000001\exdata"

REM === Remove .git folder from RPCS3.pc ===
rmdir /S /Q "%~dp0roms\windows\RPCS3.pc\git"

REM === Create Roms\xbox dir in destination ===
mkdir "%directory%\roms\xbox"

REM === Move xbox Roms out of source ====
move /Y "%~dp0roms\xbox\Area 51 (USA).xiso.iso" "%directory%\roms\xbox"

REM === Create retroarch dirs in destination ===
mkdir "%directory%\emulators\retroarch\cores"

REM === Move emulators\retroarch\system out of source ====
move /Y "%~dp0emulators\retroarch\system" "%directory%\emulators\retroarch"

REM === Move libretro_cores.7z from retroarch\cores out of source (presume not required and can be deleted) ====
move /Y "%~dp0emulators\retroarch\cores\libretro_cores.7z" "%directory%\emulators\retroarch\cores"

REM === Create emulators\pcsx2 dir in destination ===
mkdir "%directory%\emulators\pcsx2"

REM === Move emulators\pcsx2\sstates & memcards out of source ====
move /Y "%~dp0emulators\pcsx2\sstates" "%directory%\emulators\pcsx2"
move /Y "%~dp0emulators\pcsx2\memcards" "%directory%\emulators\pcsx2"

REM === Create emulators\duckstation dir in destination ===
mkdir "%directory%\emulators\duckstation"

REM === Move emulators\duckstation\savestates out of source ====
move /Y "%~dp0emulators\duckstation\savestates" "%directory%\emulators\duckstation"
move /Y "%~dp0emulators\duckstation\screenshots" "%directory%\emulators\duckstation"

REM === Create emulators\redream dir in destination ===
mkdir "%directory%\emulators\redream"

REM === Move emulators\redream\cache out of source ====
move /Y "%~dp0emulators\redream\cache" "%directory%\emulators\redream"

REM === Create emulators\fpinball dir in destination ===
mkdir "%directory%\emulators\fpinball"

REM === Move emulators\fpinball\Feeds out of source ====
move /Y "%~dp0emulators\fpinball\Feeds" "%directory%\emulators\fpinball"

REM === Create emulators\redream dir in destination ===
mkdir "%directory%\emulators\daphne"

REM === Move emulators\daphne\images out of source ====
move /Y "%~dp0emulators\daphne\images" "%directory%\emulators\daphne"

REM === Remove .git folder from emulators\rpcs3 ===
rmdir /S /Q "%~dp0emulators\rpcs3\git"

REM === Create teknoparrot dir in destination ===
mkdir "%directory%\emulators\teknoparrot"

REM === Move various files from teknoparrot out of source (presume these are not required and can be deleted) ====
move /Y "%~dp0emulators\teknoparrot\FFB.Arcade.Plugin.v2.0.0.4.zip" "%directory%\emulators\teknoparrot"
move /Y "%~dp0emulators\teknoparrot\FFB.Arcade.Plugin.v2.0.0.4.7z" "%directory%\emulators\teknoparrot"
move /Y "%~dp0emulators\teknoparrot\SegaTools - Copie" "%directory%\emulators\teknoparrot"

REM === Create misc dirs in destination ===
mkdir "%directory%\emulationstation\.emulationstation\themes\LightgunMaxDLWangv8"
mkdir "%directory%\emulationstation\.emulationstation\music"
mkdir "%directory%\emulationstation\.emulationstation\video"
mkdir "%directory%\emulationstation\.emulationstation\tmp"
mkdir "%directory%\roms\zxspectrum"

REM === Move Misc files out of source ====
robocopy "%~dp0emulationstation\.emulationstation\music" "%directory%\emulationstation\.emulationstation\music" /MOVE /E
robocopy "%~dp0emulationstation\.emulationstation\video" "%directory%\emulationstation\.emulationstation\video" /MOVE /E
robocopy "%~dp0emulationstation\.emulationstation\themes" "%directory%\emulationstation\.emulationstation\themes" /MOVE /E
robocopy "%~dp0emulationstation\.emulationstation\tmp "%directory%\emulationstation\.emulationstation\tmp" /MOVE /E

REM === Create saves in destination ===
mkdir "%directory%\saves"

REM === Move saves dirs out of source ====
move /Y "%~dp0saves\mame" "%directory%\saves"
move /Y "%~dp0saves\megadrive" "%directory%\saves"
move /Y "%~dp0saves\naomi" "%directory%\saves"
move /Y "%~dp0saves\ps2" "%directory%\saves"
move /Y "%~dp0saves\psx" "%directory%\saves"
move /Y "%~dp0saves\saturn" "%directory%\saves"
move /Y "%~dp0saves\wii" "%directory%\saves"
move /Y "%~dp0saves\xbox" "%directory%\saves"

move /Y "%~dp0roms\zxspectrum\images" "%directory%\roms\zxspectrum"

REM ==========================
REM =======MOVE COMPLETE======
REM ==========================
pause




