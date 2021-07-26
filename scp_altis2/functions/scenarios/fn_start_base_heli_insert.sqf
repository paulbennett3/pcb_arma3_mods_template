/* ---------------------------------------------------------------------
                     start base - Helicopter Insertion

Move the players to the randomly selected starting point.
Spawn in helicopters, luggage, ...
--------------------------------------------------------------------- */

private _blacklist_pos = [];

// move everybody to the start position
{
   _x setVehiclePosition [start_pos, [], 5, "NONE"];
} forEach playableUnits;


// Create a task for finding all the starting equipment
private _pid = "T" + str ([] call pcb_fnc_get_next_UID);
[
    true, 
    _pid, 
    [
        "Locate the equipment scattered during infiltration", 
        "Locate Gear", 
        "foo"
    ], 
    start_pos, 
    "ASSIGNED"
] call BIS_fnc_taskCreate;

// ------------------------------------------------------------------
// spawn equipment bin
// ------------------------------------------------------------------
//private _crate_type = "B_Slingload_01_Repair_F";
private _crate_type = "B_CargoNet_01_ammo_F";
//private _crate_type = "B_Slingload_01_Ammo_F";  // can't cargo ...
private _vpos = [start_pos, 100, _blacklist_pos] call pcb_fnc_get_empty_pos;
_blacklist_pos pushBack _vpos;
private _start_crate = createVehicle [_crate_type, _vpos, [], 0, "NONE"];
_start_crate setVariable ["BIS_enableRandomization", false];
[_start_crate, "start_crate"] call pcb_fnc_crate_loadout;
[["T" + str ([] call pcb_fnc_get_next_UID), _pid], "Supply Box", _vpos, 15] call pcb_fnc_objective_locate_object;
//[_start_crate, ["B_Slingload_01_Ammo_F",  "Land_Cargo_House_V1_F", 90], "Unpack"] call pcb_fnc_addAction_packable;
//[_start_crate, ["B_Slingload_01_Repair_F",  "Land_Cargo_House_V1_F", 90], "Unpack"] call pcb_fnc_addAction_packable;

[_start_crate] call pcb_fnc_add_base_actions;

// place initial spawn marker
private _marker_respawn = createMarker ["respawn_west", _vpos]; 
_marker_respawn setMarkerType "respawn_inf";

// ------------------------------------------------------------------
// spawn vehicles
// ------------------------------------------------------------------
private _vehicle_list = [];
private _heli_type = selectRandom [
    "vn_b_air_uh1d_01_04",
    "vn_b_air_uh1d_01_06",
    "vn_b_air_uh1d_01_07",
    "vn_o_air_mi2_01_01",
    "vn_o_air_mi2_01_02",
    "vn_i_air_ch34_02_02",
    "B_Heli_Transport_03_unarmed_F",
    "O_Heli_Transport_04_covered_F",
    "O_Heli_Light_02_unarmed_F",
    "I_Heli_light_03_unarmed_F",
    "B_Heli_Light_01_F",
    "C_Heli_Light_01_civil_F"
];

_vehicle_list pushBack ["Helicopter",_heli_type];

{
    private _label = _x select 0;
    private _type = _x select 1;
    _vpos = [start_pos, 100, _blacklist_pos] call pcb_fnc_get_empty_pos;
    _blacklist_pos pushBack _vpos;
    private _veh = createVehicle [_type, _vpos, [], 0, "NONE"];
    _veh setVariable ["BIS_enableRandomization", false];
    [_veh] call pcb_fnc_set_scp_vehicle_loadout;
    private _cid = "T" + str ([] call pcb_fnc_get_next_UID);
    [[_cid, _pid], _label, _vpos, 15] call pcb_fnc_objective_locate_object;
} forEach _vehicle_list;
