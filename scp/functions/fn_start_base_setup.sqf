/* ---------------------------------------------------------------------
                     start base setup

Move the players to the randomly selected starting point.
Spawn in helicopters, luggage, ...
--------------------------------------------------------------------- */

private _blacklist_pos = [];

// move everybody to the start position
{
   _x setVehiclePosition [start_pos, [], 10, "NONE"];
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
//private _crate_type = "B_CargoNet_01_ammo_F";
private _crate_type = "B_Slingload_01_Ammo_F";  // can't cargo ...
private _vpos = [start_pos, 100, _blacklist_pos] call pcb_fnc_get_empty_pos;
_blacklist_pos pushBack _vpos;
private _start_crate = createVehicle [_crate_type, _vpos, [], 0, "NONE"];
[_start_crate, "start_crate"] call pcb_fnc_crate_loadout;
[["T" + str ([] call pcb_fnc_get_next_UID), _pid], "Supply Box", _vpos, 15] call pcb_fnc_objective_locate_object;
[_start_crate, ["B_Slingload_01_Ammo_F",  "Land_Cargo_House_V1_F", 90], "Unpack"] call pcb_fnc_addAction_packable;

// place initial spawn marker
private _marker_respawn = createMarker ["respawn_west", _vpos]; 
_marker_respawn setMarkerType "respawn_inf";

// ------------------------------------------------------------------
// spawn vehicles
// ------------------------------------------------------------------
private _vehicle_list = [];
_vehicle_list pushBack ["Heli", ["heli", "large"] call pcb_fnc_get_random_vehicle];
_vehicle_list pushBack ["Ground Vehicle", "B_T_Truck_01_transport_F"];
_vehicle_list pushBack ["Ground Vehicle", ["car", "small"] call pcb_fnc_get_random_vehicle];

{
    private _label = _x select 0;
    private _type = _x select 1;
    _vpos = [start_pos, 100, _blacklist_pos] call pcb_fnc_get_empty_pos;
    _blacklist_pos pushBack _vpos;
    createVehicle [_type, _vpos, [], 0, "NONE"];
    private _cid = "T" + str ([] call pcb_fnc_get_next_UID);
    [[_cid, _pid], _label, _vpos, 15] call pcb_fnc_objective_locate_object;
} forEach _vehicle_list;


// spawn support units (High Command)
[start_pos, _blacklist_pos] call pcb_fnc_spawn_support_units;

