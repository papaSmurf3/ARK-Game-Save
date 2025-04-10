:: Purpose is to restore a previous game save done by the matching backup script.
:: Free to use and change. I would appreciate if you update me on any changes to it.
::

@echo off
setlocal EnableDelayedExpansion 

set "arkLocalSavedDir=C:\Program Files (x86)\Steam\steamapps\common\ARK Survival Ascended\ShooterGame\Saved\SavedArksLocal"
set "keyText=_WP"

echo Changing to ARK save dir: %arkLocalSavedDir%
cd "%arkLocalSavedDir%"

set val=0
echo Searching for saved games: %saveText%
for /d %%G in ("*%keyText%") do (
set /a val+=1
set dirOpt[!val!]=%%G
)

set "exitTxt=Exit"
echo 0 %exitTxt%

@For /L %%i in (1,1,%val%) do (
    echo %%i !dirOpt[%%i]! 
)

set /a dirNbr=0
set /p dirNbr=Enter the number for the map to restore: 

if %dirNbr% EQU 0 (
    echo You chose to not do a restore.
    goto :EndOfScript
)
if %dirNbr% GTR %val% (
  echo You chose to not do a restore.
  goto :EndOfScript
)

set "arkLocalSavedDir=C:\Program Files (x86)\Steam\steamapps\common\ARK Survival Ascended\ShooterGame\Saved\SavedArksLocal"
call set arkLastSavedSubdir=%%dirOpt[%dirNbr%]%%
set "arkSaveFile=%arkLocalSavedDir%\%arkLastSavedSubdir%\%arkLastSavedSubdir%.ark"

@echo Looking for file %arkSaveFile%
if not exist "%arkSaveFile%" (
echo Did not find the ARK save file.  Check the path in this script, as it is likely not correct.
set /p allDone=Exiting script [hit ENTER]
Exit
)

cd "%arkLocalSavedDir%"

dir "%arkLastSavedSubdir% - SAVE_*"
set saveText=""
set /p saveText=Enter at least part of the name of the backup that you want to restore or something else to exit: 

echo Searching for saves containing: %saveText%
for /d %%G in ("%arkLastSavedSubdir%*SAVE_*%saveText%*") do (
call :DoIt %%G
echo ----------------------------------------
)

:EndOfScript
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
