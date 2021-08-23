/* ---------------------------------------------------------------------
                     start base setup 3

--------------------------------------------------------------------- */

//["start base being made, please be patient ..." + (str (isServer))] call pcb_fnc_debug;
["start_pos <" + (str start_pos) + ">"] call pcb_fnc_debug;
if (! isServer) exitWith {};
["teleporting to start base area  ..."] call pcb_fnc_debug;

player_group = group (playableUnits select 0);
publicVariable "player_group";


private _pos = start_pos vectorAdd [0.5, 0.5];

// ------------------------------------------------------------------
// Spawn an equipment crate
// ------------------------------------------------------------------
private _vpos = _pos getPos [5, 90];
private _crate_type = "Land_PlasticCase_01_large_gray_F";
private _equip_crate = _crate_type createVehicle _vpos;
[_equip_crate, "crate"] call pcb_fnc_crate_loadout;
_equip_crate setPosASL getPosASL _equip_crate;  // synch for MP


// ------------------------------------------------------------------
// Spawn our "base" crate
// ------------------------------------------------------------------
[(start_pos getPos [5, 90])] call pcb_fnc_portable_base_crate;

// ------------------------------------------------------------------
//                     Boat Box
// ------------------------------------------------------------------
private _bbpos = _desk getPos [0.5, 180];
_bbpos = [_bbpos select 0, _bbpos select 1];
private _boat_box1 = "Land_PlasticCase_01_large_olive_F" createVehicle _bbpos;
_boat_box1 setDir (getDir _base_crate);
_boat_box1 setVariable ["packed", true];

private _bcmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    
    [["pck_boat", _target]] call pcb_fnc_send_mail; 
};

[
    _boat_box1,
    [
        "Pack/Unpack Boat",
        _bcmd,
        [], 1.5, true, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];  


// ------------------------------------------------------------------
// move everybody to the start position
// ------------------------------------------------------------------
private _id = 0;
private _unitslist = units player_group;
for [{_id = 0}, {_id < (count (_unitslist))}, {_id = _id + 1}] do {
    private _x = _unitslist select _id;
    _x setVehiclePosition [start_pos, [], 5, "NONE"];
    [_x, _id] call pcb_fnc_enable_ai_respawn;
    [_x] call pcb_fnc_set_scp_loadout;
    sleep .1;
}; // forEach units (group (playableUnits select 0));

["You should be there  ..."] call pcb_fnc_debug;

sleep .1;

// ------------------------------------------------------------------
// Spawn the support squad
// ------------------------------------------------------------------
[getPosATL (playableUnits select 0), player_group] call pcb_fnc_spawn_support_units;

// ------------------------------------------------------------------
// place initial spawn marker
// ------------------------------------------------------------------
private _offset = 10;
_next_pos = (playableUnits select 0) getPos [_offset, 0]; _offset = _offset + 10;
private _marker_respawn = createMarker ["respawn_west", _next_pos]; 
_marker_respawn setMarkerType "respawn_inf";

_next_pos = (playableUnits select 0) getPos [_offset, 270]; _offset = _offset + 10;
private _marker_respawn_veh = createMarker ["respawn_vehicle_west", _next_pos]; 
_marker_respawn_veh setMarkerType "respawn_air";


[] call pcb_fnc_convenience;

