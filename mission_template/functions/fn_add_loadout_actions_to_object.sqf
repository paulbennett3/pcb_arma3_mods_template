// Given an object, add the "loadout" actions to that object

params ["_obj"];

_obj addAction [ "Leader Loadout", "[(_this select 1), 'Leader'] call pcb_fnc_loadout;", [], 1.5, true, true, "", "true", 5];
_obj addAction [ "Medic Loadout", "[(_this select 1), 'Medic'] call pcb_fnc_loadout;", [], 1.5, true, true, "", "true", 5 ];
_obj addAction [ "Engineer Loadout", "[(_this select 1), 'Engineer'] call pcb_fnc_loadout;", [] , 1.5, true, true, "", "true", 5];
_obj addAction [ "Heavy Loadout", "[(_this select 1), 'Heavy'] call pcb_fnc_loadout;", [] , 1.5, true, true, "", "true", 5];
//_obj addAction [ "Jaffa Loadout", "[(_this select 1), 'Jaffa'] call pcb_fnc_loadout;", [] , 1.5, true, true, "", "true", 5];
_obj addAction [ "Scholar Loadout", "[(_this select 1), 'Scholar'] call pcb_fnc_loadout;", [] , 1.5, true, true, "", "true", 5];
               
