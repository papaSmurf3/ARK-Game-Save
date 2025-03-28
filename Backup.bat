:: Purpose is to make a backup copy of the ARK Survival Ascended game save files, so that you can reload them later on using the matching resore batch file.
:: Free to use and change. I would appreciate if you update me on any changes to it.
::
:: ToDo: Add a selector to this script to give the users a chance to pick which game map they want to back up.

@echo off

set "arkLocalSavedDir=C:\Program Files (x86)\Steam\steamapps\common\ARK Survival Ascended\ShooterGame\Saved\SavedArksLocal"
set "arkLastSavedSubdir=TheIsland_WP"
set "arkSaveFile=%arkLocalSavedDir%\%arkLastSavedSubdir%\TheIsland_WP.ark"

@echo Looking for file %arkSaveFile%
if not exist "%arkSaveFile%" (
echo Did not find the ARK save file.  Check the path in this script, as it is likely not correct.
set /p allDone=Exiting script [hit ENTER]
Exit
)

for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set cYYYY=%dt:~0,4%
set cMM=%dt:~4,2%
set cDD=%dt:~6,2%
set cHH=%dt:~8,2%
set cMin=%dt:~10,2%
set cSec=%dt:~12,2%

set stamp=SAVE_%cYYYY%%cMM%%cDD%_%cHH%%cMin%%cSec%

set saveText=""
set /p saveText=Enter text to identify this save: 
set newFile=%arkLastSavedSubdir% - %stamp% - %saveText%

echo Copying entire last saved dir to new dir %newFile%
set doThis=y
set /p doThis=Continue the backup [y/n] (default - %doThis%)?:

if %doThis% EQU y (
cd "%arkLocalSavedDir%"
echo Executing xcopy /s /i /v /f "%arkLastSavedSubdir%" "%newFile%"
xcopy /s /i /v "%arkLastSavedSubdir%" "%newFile%"
echo Executing xcopy /s /i /v /f "%arkLastSavedSubdir%" "G:\My Drive\Ark Game Saves\%newFile%"
xcopy /s /i /v "%arkLastSavedSubdir%" "G:\My Drive\Ark Game Saves\%newFile%"
) ELSE (
echo Backup skipped
)

set /p allDone=All done (hit ENTER):

