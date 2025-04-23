@echo off
setlocal EnableDelayedExpansion 

set "thisRelease=ARK-Game-Save*"
set "arkGameSaveScriptsDir=C:\ArkGameSaveScripts"

for %%I in (.) do set CurrDirName=%%~nxI
echo This release is %CurrDirName%

echo This script is used to initialize the scripts for backing up ARK Single Player game saves.
echo Please open the README file for more information, including how to set this up to copy the backup to additional folder(s), such as a Google drive.
echo ------
echo Verifying that the destination folder exists:
echo %arkGameSaveScriptsDir%

if not exist "%arkGameSaveScriptsDir%\" (
    echo This folder does not exist, so creating it.
    mkdir "%arkGameSaveScriptsDir%"
) else (
    echo Scripts location is verified to exist
)
echo ----------------------------------
set "arkLocalSavedDir=C:\Program Files (x86)\Steam\steamapps\common\ARK Survival Ascended\ShooterGame\Saved\SavedArksLocal"
echo Verifying that the ARK game save folder is where I expect it:
echo %arkLocalSavedDir%
if not exist "%arkLocalSavedDir%\" (
    echo It appears that this is not where the saves are stored on your computer.
    echo Open the README file to get more information on how to change this.
    echo Installation is aborting.
    goto :EndOfScript
) else (
    echo Ark game sSave location is verified to exist
    echo ----------------------------------
)

echo This script will perform the following actions:
echo 1. Copy this script directory into the ARK saved games scripts directory.
echo 2. Add a quick access pin for the ARK saved games directory, so you can easily navigate to it in File Explorer.
echo 3. Create shortcut links to the Backup and Restore scripts in the ARK saved games directory.
echo 4. Create shortcut links to the Backup and Restore scripts on the desktop.
echo 5. Create a shortcut to the ARK saved games directory.
echo ----------------------------------------------------------

set doThis=y
set /p doThis=Do you want to continue? [y/n] (default - %doThis%):
if %doThis% EQU y goto :itsTrue 
if %doThis% EQU Y goto :itsTrue
echo You chose to not proceed.
goto :EndOfScript 

:itsTrue
cd ..

echo Copying the script directory into the ARK saved game scripts directory: %arkGameSaveScriptsDir%
robocopy "%CurrDirName%" "%arkGameSaveScriptsDir%" /LOG:ARKScriptsInitRobocopyLog.txt

cd "%arkGameSaveScriptsDir%"

echo Version=%CurrDirName% > info.txt
echo InstallDir=%arkGameSaveScriptsDir% >> info.txt

cscript CreateShortcut.vbs

:EndOfScript
set /p allDone=End of the script [hit ENTER]
EXIT /B
