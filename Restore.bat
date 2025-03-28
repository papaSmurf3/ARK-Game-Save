:: Purpose is to restore a previous game save done by the matching backup script.
:: Free to use and change. I would appreciate if you update me on any changes to it.
::

@echo off
setlocal

set "arkLocalSavedDir=C:\Program Files (x86)\Steam\steamapps\common\ARK Survival Ascended\ShooterGame\Saved\SavedArksLocal"
set "arkLastSavedSubdir=TheIsland_WP"
set "arkSaveFile=%arkLocalSavedDir%\%arkLastSavedSubdir%\TheIsland_WP.ark"

@echo Looking for file %arkSaveFile%
if not exist "%arkSaveFile%" (
echo Did not find the ARK save file.  Check the path in this script, as it is likely not correct.
set /p allDone=Exiting script [hit ENTER]
Exit
)

cd "%arkLocalSavedDir%"

dir "* SAVE_*"
set saveText=""
set /p saveText=Enter at least part of the name of the backup that you want to restore: 

echo Searching for saves containing: %saveText%
for /d %%G in ("*SAVE_*%saveText%*") do (
call :DoIt %%G
echo ----------------------------------------
)

set /p allDone=All done (hit ENTER):
goto End

:DoIt
set "saveFile=%*"
echo Found save: %saveFile%
set "restoreThis=n"
set /p "restoreThis=Restore this save? [y/n] "  
if %restoreThis% EQU y (
if exist %arkLastSavedSubdir%_LAST_ARK_DEFAULT_SAVE\ (
echo   Removing last default save directory
rmdir /s /q "%arkLastSavedSubdir%_LAST_ARK_DEFAULT_SAVE"
)
echo   Moving current save %arkLastSavedSubdir% to %arkLastSavedSubdir%_LAST_ARK_DEFAULT_SAVE
ren "%arkLastSavedSubdir%" "%arkLastSavedSubdir%_LAST_ARK_DEFAULT_SAVE"
echo   Restoring %saveFile% as %arkLastSavedSubdir%
xcopy /s /i /v "%saveFile%" "%arkLastSavedSubdir%"
) ELSE (
echo Restore skipped
)  
goto :eof

:CleanUpDir
set "dirToClean=%1"
if exist %dirToClean%\ (
echo   Removing last default save directory
rmdir /s /q %dirToClean%
)
goto :eof

:End
