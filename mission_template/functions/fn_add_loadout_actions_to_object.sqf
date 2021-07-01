// Given an object, add the "loadout" actions to that object

params ["_obj"];

private _roles = [];
if (pcb_mod_name isEqualTo "scp") then {
    _roles pushBack "Leader";
    _roles pushBack "Medic";
    _roles pushBack "Engineer";
    _roles pushBack "Machine Gunner";
    _roles pushBack "Scholar";
    _roles pushBack "Marksman";
    _roles pushBack "Grenadier";
} else {
    _roles pushBack "Leader";
    _roles pushBack "Medic";
    _roles pushBack "Engineer";
    _roles pushBack "Scholar";
    _roles pushBack "Jaffa";
};

{
    _obj addAction [ (_x + " Loadout", "[(_this select 1), '" + _x + "'] call pcb_fnc_loadout_scp_stargate;", [], 1.5, true, true, "", "true", 5];
} forEach _roles;

//_obj addAction [ "Leader Loadout", "[(_this select 1), 'Leader'] call pcb_fnc_loadout;", [], 1.5, true, true, "", "true", 5];
//_obj addAction [ "Medic Loadout", "[(_this select 1), 'Medic'] call pcb_fnc_loadout;", [], 1.5, true, true, "", "true", 5 ];
//_obj addAction [ "Engineer Loadout", "[(_this select 1), 'Engineer'] call pcb_fnc_loadout;", [] , 1.5, true, true, "", "true", 5];
//_obj addAction [ "Heavy Loadout", "[(_this select 1), 'Heavy'] call pcb_fnc_loadout;", [] , 1.5, true, true, "", "true", 5];
//_obj addAction [ "Jaffa Loadout", "[(_this select 1), 'Jaffa'] call pcb_fnc_loadout;", [] , 1.5, true, true, "", "true", 5];
//_obj addAction [ "Scholar Loadout", "[(_this select 1), 'Scholar'] call pcb_fnc_loadout;", [] , 1.5, true, true, "", "true", 5];
               
