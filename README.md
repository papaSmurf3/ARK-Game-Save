# ARK-Game-Save
NOTE: THIS DOES NOT SAVE YOUR GAME! THIS DOES NOT WORK FOR GAMES YOU PLAY ON A SERVER.

Windows batch scripts to save and restore your ARK Survival Ascended (ASA) game saves.

Purpose: This allows you to make a backup of the current ASA local game saves. Once a backup is made, you can restore this backup at some point in the future to return to that point in time and location in the game.

Example scenario: You are about to venture far from base to try to tame a Giga! You've spent a lot of time gathering the right resources. Before you head out, you save your game from the in-game option menu. Now, you run the Backup script to make a copy of that specific point in time save. You return to the game and head out to get that Giga. Well, things do not go so well, and you want to return to that backed up save point. Just exit from your game back to the main menu and run the Restore script to put you back to that specific location and point in time before you headed out to get the Giga.  Better luck this time!

I also plan on creating a YouTube video to walk through how to use it.

Steps to download and use these scripts:
1. On the right side, click on the latest entry under "Releases".
2. Under Assets, click on the "Source.zip" entry to download the code package.
3. Open Windows File Explorer application.
4. Click on "Downloads" in the left navigation pane.
5. You should have an "ARK-Game-Save" entry zip file (which will also include the version number in the name)
6. Select (single click) this zip file and choose the "Extract All" option on the top menu bar.
7. Double click to go into the "ARK-Game-Save" folder twice.
8. Double click the the "init.bat" file to run the initialization script amd follow the prompts.

You should be set up to run the scripts.

For proper use of these scripts, do the following:
1. I find it easiest to already have the ARK save game folder open by double clicking the "ARK Game Saves" link to it on your desktop. (this will be created AFTER you run the initiallization script)
2. While playing ARK Survival Ascended locally on your computer, save the game you are currently playing. (ESC, then select Save)
3. You may want to pause the game by hitting ESC to bring up the menu, again. (optional)
4. Alt-Tab out of your game back to the File Explorer view of the ARK game saves folder.
5. Double click the "Backup.bat" script to make a backup of the save that you just created in the game.
   Note: there should also be a shortcut to it on your Desktop as well.
6. Follow the prompts and make sure you pick the correct map (the last modified date and time should appear by each map option).
7. When prompted, make sure to enter meaningful text to describe the save, for example:
    about to tame a rex
    heading into south cave
    done with build project
  NOTE: the current date and time of when you run the script is prepended to the name.
  NOTE: You cannot use any symbols that are not valid for windows file names (like question mark or asterisk)
8. Return to your ARK game and keep playing.

Now, suppose you play for a while and something goes wrong. Wouldn't it be nice to "go back in time" to your previous save (that you ran the backup for)?  You can!  
1. You must EXIT the game back to at least the game main menu. (you do not have to totally exit the game)
2. Alt-Tab out of the game back to the File Explorer window that is opened to the Ark Game Saves directory and double click to run the "Restore.bat" script.
   Note: there should also be a shortcut to it on your Desktop.
3. Follow the prompts to pick the right map.
4. When prompted, enter at least part of the text you entered when you made a backup.
   Note: Every backup made that contains at least the text you entered will be presented for restoring. For example, if you created a backup named "before rex tame" and later made a backup named "before giga tame", then entered just "before" as the text to look for, the script will present all saves containing the word "before" (one at a time).

This script also supports copying the backup to additional folders. For example, if you have your Google drive mapped on your computer, you can have the Backups copied to it as well. Steps to do this:
1. Using Windows File Explorer, go into the ARK Game Saves folder (you can use the Desktop shortcut to go right to it).
2. Click on the "New" option and select to create a text document.
3. Rename this newly created file to "AdditionalDestinations.txt"
4. Open up this file in Notepad and add the folder path where you want to also copy the backup save.
For example, my Google drive is mapped to my G drive. On my Google drive, I created a folder named "Ark Game Saves". So I added this entry into this new file:
G:\My Drive\Ark Game Saves
5. The next time you run the backup script, it should also copy the backup save to this directory.


Final note: There is no automated cleanup process. So you will likely want to go into the ARK Game Saves folder and delete old backups that you no longer need.  All of these backup saves have a name format like:
<Map Name> - SAVE_<Date>_<Time> - <entered description>
Date is in YYYYMMDD format. Time is in HHMMSS format.

Example:
TheIsland_WP - SAVE_20250327_222030 - hunt megaladon
