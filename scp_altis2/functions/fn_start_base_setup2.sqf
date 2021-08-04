/* ---------------------------------------------------------------------
                     start base setup 2

--------------------------------------------------------------------- */

if (! isServer) exitWith {};


// ------------------------------------------------------------------
// move everybody to the start position
// ------------------------------------------------------------------
{
   _x setVehiclePosition [start_pos, [], 5, "NONE"];
} forEach units (group (playableUnits select 0));

sleep .1;

// figure out position along the line of the runway
private _offset = 15; 
private _next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 10;

// ------------------------------------------------------------------
// Create a task for finding all the starting equipment
// ------------------------------------------------------------------
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
private _crate_type = "B_Slingload_01_Cargo_F";
_next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 10;
private _vpos = _next_pos;
systemChat ("Putting crate at <" + (str _vpos) + ">");

private _start_crate = _crate_type createVehicle _vpos;
_start_crate setDir start_dir;
_start_crate setPosASL getPosASL _start_crate;  // synch for MP
[_start_crate, "crate"] call pcb_fnc_crate_loadout;


// ------------------------------------------------------------------
// make a nice little base encampment relative to crate
// ------------------------------------------------------------------
private _attachIt = {
    params ["_target", "_type", "_pos", "_rot"];
    private _thing = _type createVehicle [0,0,0];
    _thing attachTo [_target, _pos]; _thing setDir _rot; _thing setPosASL getPosASL _thing;
    _thing
};

private _dir = (getDir _start_crate) - 90;
if (_dir < 0) then { _dir = _dir + 360; };
private _desk_pos = _start_crate getPos [5, _dir];

private _desk = "Land_PortableDesk_01_black_F" createVehicle _desk_pos;
_desk setDir _dir;
_desk setPosASL getPosASL _desk;
[_desk, "Land_DeskChair_01_black_F", [.8,1,-.25], 15] call _attachIt;
[_desk, "Land_PortableCabinet_01_bookcase_black_F", [1.5, 1, -.05], 110] call _attachIt;
[_desk, "Land_PortableCabinet_01_lid_black_F", [2.2, 1.3, -.35], 72] call _attachIt;
[_desk, "Land_Laptop_device_F", [0, 0, .6], 25] call _attachIt;
[_desk, "Land_File1_F", [1.05, 0, .45], 165] call _attachIt;
[_desk, "Land_File2_F", [.95, .05, .45], 145] call _attachIt;
[_desk, "Land_Tablet_01_F", [.65, -.15, .45], 27] call _attachIt;
[_desk, "Land_PortableLight_double_F", [7, -.5, 0.6], 115] call _attachIt;
[_desk, "Land_CanvasCover_01_F", [2, 2, 1.5], 0] call _attachIt;
[_desk, "B_supplyCrate_F", [0, -5, 0.5], 135] call _attachIt;
[_desk, "B_CargoNet_01_ammo_F", [0, 10, 0.4], 115] call _attachIt;
base_desk = _desk;
publicVariable "base_desk";


_start_crate setVariable ["type", _crate_type];
_start_crate setVariable ["base", _desk];
_start_crate setVariable ["packed", false];


// ------------------------------------------------------------------
// Add pack / unpack command
// ------------------------------------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    private _crate = _target;
    private _base = _crate getVariable "base";

    // flip the state
    private _state = not (_crate getVariable "packed");
    _crate setVariable ["packed", _state];

    { [ _x, _state ] remoteExec ["hideObject", 0, true]; } forEach (attachedObjects _base);
    [ _base, _state ] remoteExec ["hideObject", 0, true];
    _crate enableRopeAttach _state;

    // if we are unpacking, pick a new location to move the base to
    // Also if we are unpacking, move the respawn markers to the neighborhood
    if (not _state) then {
        private _dir = (getDir _crate) - 90;
        if (_dir < 0) then { _dir = _dir + 360; };
        private _base_pos = _crate getPos [5, _dir];
        _base setPos _base_pos;
        _base setDir _dir;
        _base setPosATL getPosATL _base;

        private _respawn_pos = _crate getPos [20, 180];
        "respawn_west" setMarkerPos _respawn_pos;
        "respawn_air" setMarkerPos _respawn_pos;
    }

};

[
    _start_crate,
    [
        "Pack/Unpack Base",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!


[_desk] call pcb_fnc_add_base_actions;

// ------------------------------------------------------------------
// place initial spawn marker
// ------------------------------------------------------------------
_next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 10;
private _marker_respawn = createMarker ["respawn_west", _next_pos]; 
_marker_respawn setMarkerType "respawn_inf";

_next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 10;
private _marker_respawn_veh = createMarker ["respawn_vehicle_west", _next_pos]; 
_marker_respawn_veh setMarkerType "respawn_air";



// ------------------------------------------------------------------
// spawn vehicles
// ------------------------------------------------------------------
private _vehicle_list = [];
//_vehicle_list pushBack ["Ground Transport", "B_T_Truck_01_transport_F"];
_vehicle_list pushBack ["Drone", "B_T_UGV_01_rcws_olive_F"];
_vehicle_list pushBack ["Prowler", "B_T_LSV_01_armed_F"];
_vehicle_list pushBack ["APC", "B_APC_Tracked_01_rcws_F"];
_vehicle_list pushBack ["Heli", "B_Heli_Light_01_F"];
_vehicle_list pushBack ["Heli", "B_Heli_Transport_03_unarmed_F"];
_vehicle_list pushBack ["VTOL", "B_T_VTOL_01_infantry_F"];

{
    private _label = _x select 0;
    private _type = _x select 1;
    _next_pos = (playableUnits select 0) getPos [_offset, start_dir]; _offset = _offset + 30;
    private _veh = _type createVehicle _next_pos;
    //_veh setVariable ["BIS_enableRandomization", false];
    [_veh] call pcb_fnc_set_scp_vehicle_loadout;
    private _cid = "T" + str ([] call pcb_fnc_get_next_UID);
    [[_cid, _pid], _label, _vpos, 15] call pcb_fnc_objective_locate_object;
    _veh respawnVehicle [10, 3 + (ceil (random 3))];
    _veh setDir start_dir;

    sleep 1;
} forEach _vehicle_list;

// ------------------------------------------------------------------
//    Spawn "support crates" relative to _start_crate
// ------------------------------------------------------------------
private _sc_dir = (getDir _start_crate) - 90;
if (_sc_dir < 0) then { _sc_dir = _sc_dir + 360; };
private _sc = "B_Slingload_01_Ammo_F" createVehicle (_start_crate getPos [20, _sc_dir]); _sc setDir start_dir;
_sc = "B_Slingload_01_Fuel_F" createVehicle (_start_crate getPos [25, _sc_dir]); _sc setDir start_dir;
_sc = "B_Slingload_01_Repair_F" createVehicle (_start_crate getPos [30, _sc_dir]); _sc setDir start_dir;

