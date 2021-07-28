/* ---------------------------------------------------------------------
                     start base setup

Move the players to the randomly selected starting point.
Spawn in helicopters, luggage, ...
--------------------------------------------------------------------- */

if (! isServer) exitWith {};

private _blacklist_pos = [];

// move everybody to the start position
{
   _x setVehiclePosition [start_pos, [], 5, "NONE"];
} forEach units (group (playableUnits select 0));


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
// Spawn an equipment crate ("unpacked") with attached base,
//   then spawn a "packed" create, and connect them to make them
//   swappable
// ------------------------------------------------------------------
// select a position
private _vpos = [start_pos, 50, _blacklist_pos] call pcb_fnc_get_empty_pos;
// mark it so other things don't spawn on top of it ...
_blacklist_pos pushBack _vpos;

private _start_crate = "Land_Pallet_MilBoxes_F" createVehicle _vpos;
// add a magic cargo section ...
_cargo = "Supply500" createVehicle [0,0,0];
_cargo attachTo [_start_crate, [0,0,0.85]];
// add our actual loadout ...
[_cargo, "crate"] call pcb_fnc_crate_loadout;

// place initial spawn marker
private _marker_respawn = createMarker ["respawn_west", _vpos]; 
_marker_respawn setMarkerType "respawn_inf";

// make a nice little base encampment relative to crate
private _attachIt = {
    params ["_target", "_type", "_pos", "_rot"];
    private _thing = _type createVehicle [0,0,0];
    _thing attachTo [_target, _pos]; _thing setDir _rot; _thing setPosASL getPosASL _thing;
    _thing
};
private _desk = "Land_PortableDesk_01_black_F" createVehicle (_start_crate getRelPos [2, 45]);
[_desk, "Land_DeskChair_01_black_F", [.8,1,-.25], 15] call _attachIt;
[_desk, "Land_PortableCabinet_01_bookcase_black_F", [1.5, 1, -.05], 110] call _attachIt;
[_desk, "Land_PortableCabinet_01_lid_black_F", [2.2, 1.3, -.35], 72] call _attachIt;
[_desk, "Land_Laptop_device_F", [0, 0, .6], 25] call _attachIt;
[_desk, "Land_File1_F", [1.05, 0, .45], 165] call _attachIt;
[_desk, "Land_File2_F", [.95, .05, .45], 145] call _attachIt;
[_desk, "Land_Tablet_01_F", [.65, -.15, .45], 27] call _attachIt;
[_desk, "Land_PortableLight_double_F", [7, -.5, 0.6], 115] call _attachIt;
[_desk, "Land_CanvasCover_01_F", [2, 2, 1.5], 0] call _attachIt;

//_desk setVehiclePosition [_start_crate getRelPos [3, 45], [], 0, "NONE"];
_desk setVehiclePosition [_start_crate getRelPos [3, 225], [], 0, "NONE"];
[_desk] call pcb_fnc_add_base_actions;

//_start_crate setVehiclePosition [_start_crate getRelPos [3, 45], [], 0, "NONE"];
//private _packed_crate = "B_CargoNet_01_ammo_F" createVehicle [0,0,0];
// link our unpacked and packed items, adding the action to "swap" them
//[_start_crate, _packed_crate, false] call pcb_fnc_make_packable;

// Do we need an objective to find it anymore?
[["T" + str ([] call pcb_fnc_get_next_UID), _pid], "Supply Box", _vpos, 15] call pcb_fnc_objective_locate_object;

_start_crate setDir (random 360);
_start_crate setPosASL getPosASL _start_crate;  // synch for MP


// ------------------------------------------------------------------
//       Spawn support units
// ------------------------------------------------------------------

// done as a base action!

// ------------------------------------------------------------------
// spawn vehicles
// ------------------------------------------------------------------
private _vehicle_list = [];
_vehicle_list pushBack ["Ground Vehicle", "B_T_Truck_01_transport_F"];
_vehicle_list pushBack ["Heli", "B_Heli_Transport_03_unarmed_F"];

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


/* ##########################################################################################################
                              !!!!!!!!!!!!!!!!! TESTING !!!!!!!!!!!!!!!!!
########################################################################################################## */

//[] call compile preprocessFileLineNumbers "scripts\test_destroyable_object.sqf";
//[] call compile preprocessFileLineNumbers "scripts\test_mines.sqf";
//[] call compile preprocessFileLineNumbers "scripts\test_desk.sqf";
//[] call compile preprocessFileLineNumbers "scripts\test_mission.sqf";

//private _loot = [start_pos] call pcb_fnc_loot_crate;

// --------------------------
/*
{
    private _mn = "MC" + (str ([] call pcb_fnc_get_next_UID));
    private _m = createMarker [_mn, _x];
    _m setMarkerType "KIA";
} forEach ([getPosATL (playableUnits select 0), 10000] call pcb_fnc_get_city_positions);
*/
// --------------------------

/*
private _target = "groundWeaponHolder" createVehicle ((playableUnits select 0) getRelPos [30, 0]);
_target addItemCargoGlobal ["dmpSmartphone" , 1];
[_target, "study", { hint "thanks for studying me"; }, 15] call pcb_fnc_add_interact_action_to_object;
["TSMART", "Smartphone", getPosATL _target, 1] call pcb_fnc_objective_locate_object;
*/
