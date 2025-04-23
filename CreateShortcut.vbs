dim oWS, objFSO, dtObj, desktopPathStr, pathOfSavedArksLocal, pathToScripts, qa, sLinkNm, dLink

Set oWS = CreateObject("WScript.Shell") 
set objFSO = CreateObject("Scripting.FileSystemObject") 
dtObj = oWS.SpecialFolders("Desktop") 

pathOfSavedArksLocal = "C:\Program Files (x86)\Steam\steamapps\common\ARK Survival Ascended\ShooterGame\Saved\SavedArksLocal" 
pathToScripts = "C:\ArkGameSaveScripts" 

desktopPathStr = objFSO.GetAbsolutePathName(dtObj) 
' WScript.Echo "Found Desktop folder as " + desktopPathStr 

WScript.Echo "Add the SavedArksLocal folder to the quick access list in File Explorer"
Set qa = CreateObject("Shell.Application")
qa.NameSpace(pathOfSavedArksLocal).Self.InvokeVerb("pintohome")

WScript.Echo "Create a folder shortcut named ARK Game Saves as a shortcut to the ARK save folder"
sLinkNm = desktopPathStr & "\ARK Game Saves.lnk" 
Set dLink = oWS.CreateShortcut(sLinkNm) 
dLink.TargetPath = pathOfSavedArksLocal
dLink.Description = "Shortcut to ASA save folder" 
dLink.IconLocation = "C:\WINDOWS\System32\SHELL32.dll,4" 
dLink.Save 

WScript.Echo "Create shortcuts to the Backup and Restore scripts in the ARK save folder"
Call CreateLinks (oWS, pathOfSavedArksLocal)
WScript.Echo "Create shortcuts to the Backup and Restore scripts on the Desktop"
Call CreateLinks (oWS, desktopPathStr)

Function CreateLinks (shellObj, pathForLink)
    Call CreateLink (shellObj, "Backup.bat", pathForLink, "Backup.ico")
    Call CreateLink (shellObj, "Restore.bat", pathForLink, "Restore.ico")
End Function 
    
Function CreateLink (shellObj, keyScript, pathForLink, iconFile) 
    sLinkFile = pathForLink & "\" & keyScript & ".lnk" 
    Set oLink = oWS.CreateShortcut(sLinkFile) 
    oLink.TargetPath = pathToScripts & "\" & keyScript
    oLink.Description = "ASA custom " + keyScript + " script" 
    oLink.IconLocation = pathToScripts & "\" & iconFile
    oLink.Save 
End Function 
