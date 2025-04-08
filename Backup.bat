:: Purpose is to make a backup copy of the ARK Survival Ascended game save files, so that you can reload them later on using the matching resore batch file.
:: Free to use and change. I would appreciate if you update me on any changes to it.
::
@echo off
setlocal EnableDelayedExpansion 

set "arkLocalSavedDir=C:\Program Files (x86)\Steam\steamapps\common\ARK Survival Ascended\ShooterGame\Saved\SavedArksLocal"
set "keyText=_WP"
set "additionalDestFile=AdditionalDestinations.txt"

set val=0
echo Searching for saved games
for /d %%G in ("*%keyText%") do (
  set /a val+=1
  set dirOpt[!val!]=%%G
)

set "exitTxt=Exit"
echo 0 %exitTxt%
@For /L %%i in (1,1,%val%) do (
    set "fileToCheck=!arkLocalSavedDir!\!dirOpt[%%i]!\!dirOpt[%%i]!.ark"
    Call :GetLastModifiedDate "!fileToCheck!" LastModifiedDate
    echo %%i !dirOpt[%%i]!  [!LastModifiedDate!]
)

set /a dirNbr=0
set /p dirNbr=Enter the number for the game to save : 

if %dirNbr% EQU 0 (
  echo You chose to not make a backup.
  goto :EndOfScript
)
if %dirNbr% GTR %val% (
  echo You chose to not make a backup.
  goto :EndOfScript
)

set "arkLocalSavedDir=C:\Program Files (x86)\Steam\steamapps\common\ARK Survival Ascended\ShooterGame\Saved\SavedArksLocal"
call set arkLastSavedSubdir=%%dirOpt[%dirNbr%]%%
set "arkSaveFile=%arkLocalSavedDir%\%arkLastSavedSubdir%\%arkLastSavedSubdir%.ark"

@echo Looking for file %arkSaveFile%
if not exist "%arkSaveFile%" (
echo Did not find the ARK save file.  Check the path in this script, as it is likely not correct.
goto :EndOfScript
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
set newSaveDir=%arkLastSavedSubdir% - %stamp% - %saveText%

echo Copying entire last saved dir to new dir %newSaveDir%
set doThis=y
set /p doThis=Continue the backup [y/n] (default - %doThis%)?:

if %doThis% EQU y (
  cd "%arkLocalSavedDir%"
  echo Executing xcopy /s /i /v /f "%arkLastSavedSubdir%" "%newSaveDir%"
  xcopy /s /i /v "%arkLastSavedSubdir%" "%newSaveDir%"
  echo Checking to see if you have additional destination folders listed in the file: %additionalDestFile%
  if exist "%additionalDestFile%" (
    for /f "tokens=* delims=" %%a in ('type "%additionalDestFile%"') do (
        echo Also backing up to: %%a
        xcopy /s /i /v "%arkLastSavedSubdir%" "%%a\!newSaveDir!"
    )
  )
) ELSE (
echo Backup skipped
)

:EndOfScript
set /p allDone=End of the script [hit ENTER]
EXIT /B

::----------------------------------------------------------------------------
:GetLastModifiedDate <ArkFile> <LastModifiedDate>
for /f "skip=5 tokens=1,2,3,4,5* delims= " %%a in ('dir  /a:-d /o:d /t:w "%~1"') do (
    if "%%~d" NEQ "bytes" (
        set "fileUpdateDt=%%~a"
        set "fileUpdateTm=%%~b"
        set "xampm=%%~c"
    )
)

for /f "tokens=1-3 delims=/ " %%a in ("%fileUpdateDt%") do (
  set "MM=%%a"
  set "DD=%%b"
  set "YYYY=%%c"
)


for /f "tokens=1-2 delims=: " %%a in ("%fileUpdateTm%") do (
  set "HH=%%a"
  set "Min=%%b"
)

set HR=%HH%
IF "%HH:~0,1%" == "0" SET HR=%HH:~1,1%

if %xampm% EQU PM (
if %HH% LSS 12 (
set /A HH=HR+12
)
)

set %2=%YYYY%-%MM%-%DD% %HH%:%Min%
Exit /B
::----------------------------------------------------------------------------
