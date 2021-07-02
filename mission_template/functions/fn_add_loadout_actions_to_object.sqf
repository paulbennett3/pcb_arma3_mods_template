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
    _obj addAction [ _x + " Loadout", "[(_this select 1), '" + _x + "'] call pcb_fnc_loadout_scp_stargate;", [], 1.5, true, true, "", "true", 5];
} forEach _roles;

