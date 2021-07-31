# Miscellaneous Scripts

## medic_me.sqf

This script shows how to set the "traits" for a unit.  Just copy and past the appropriate line from the file (medic, engineer, explosives expert) to the "init" block of a unit in the editor.

## spare_helis.sqf + initServer.sqf

The spare_helis.sqf script will spawn a different random type of helicopter (from the list in the file) for each helipad on the map.

To install, place both initServer.sqf and spare_helis.sqf in your mission root directory. 

For example, if you start a new mission in the editor, and "save as multiplayer" it as "mymission", it will make a folder in your Documents folder something like "...\Documents\Arma 3\mpmissions\mymission\". 

Put both files in that folder.  Note that this is a different directory than where the .pbo files live, but that might not matter to you.

## Downloading files from Git

Perhaps the easiest way for you to grab a file from Git (without using the git client):
- click on the file link -- this will display the file as a webpage, with line numbers and other cruft
- near the top right of the file is a button "Raw".  Click this -- it will reload the file as a plain text file.
- right click and "save page as", selecting the appropriate location and save as type "Text Document".
- viola!
