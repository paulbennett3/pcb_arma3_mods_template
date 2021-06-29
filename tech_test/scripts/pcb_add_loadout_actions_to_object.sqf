// Given an object, add the "loadout" actions to that object

params ["_obj"];

_obj addAction [ "Leader Loadout", "scripts\pcb_loadout_actionwrapper.sqf", "Leader" ];
_obj addAction [ "Medic Loadout", "scripts\pcb_loadout_actionwrapper.sqf", "Medic" ];
_obj addAction [ "Engineer Loadout", "scripts\pcb_loadout_actionwrapper.sqf", "Engineer" ];
_obj addAction [ "Heavy Loadout", "scripts\pcb_loadout_actionwrapper.sqf", "Heavy" ];
               
