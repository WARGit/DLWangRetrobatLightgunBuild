REM ====================================
REM Author:  Wayne Robinson
REM Date: 	 17th Feb 24
REM Purpose: To move all roms, bios / any copyrighted works out of the source to a seperate folder before uploading to github.
REM Usage:   Place in the root of the source at the same level as retrobat.exe.
REM Version: 0.1
REM ====================================

REM === Ask user for destination dir
@echo on
set /p directory="Enter dir path to copy files to: "
echo %directory%

REM === Create destination dir if not exist ===
mkdir "%directory%"

REM ==== Move entire bios dir out of source===
move /Y "%~dp0bios" "%directory%"
pause




