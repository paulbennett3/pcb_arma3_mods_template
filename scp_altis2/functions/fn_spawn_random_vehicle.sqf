/* --------------------------------------------------------------------
                        spawn random vehicle

Args:
    _active_area (area) : active area for play
    _buildings (list of objects) : list of "building" objects

Returns:
    vehicle or objNull


Example:
private _buildings = nearestTerrainObjects [
    _pos, 
    ["House", "Fuelstation", "Lighthouse", "Church", "Hospital", "Transmitter"], 
    worldSize 
];
_veh = [active_area, _buildings] call pcb_fnc_spawn_random_vehicle;

-------------------------------------------------------------------- */

if (! isServer) exitWith {};

params ["_active_area", "_buildings"];

private _veh = objNull;

// find a good position.  Assume near a building and road
// first find the nearest buildings, and use those as white lists for the 
// NOTE: _buildings list is on the order of 18,000 buildings for Altis.
// We'll subsample down to just a few for each iteration ...
private _n_subsample_size = 100;
private _whitelist = [];
while {(count _whitelist) < _n_subsample_size} do 
{
    _whitelist pushBackUnique [(selectRandom _buildings), 20];
};

// don't spawn in water or right near start
private _blacklist = ["water", [start_pos, 500]];

// { (isOnRoad _this) and (_this inArea _active_area) }
private _rpos = [
    _whitelist, 
    _blacklist,
    { (_this inArea _active_area) and ((count (_this nearRoads 10)) > 0) } 
] call BIS_fnc_randomPos;


if (((_rpos select 0) != 0) or ((_rpos select 1) != 0)) then {
    private _type = ["car", "any"] call pcb_fnc_get_random_vehicle;
    _veh = createVehicle [_type, _rpos, [], 0, "NONE"];
    // _veh setVariable ["BIS_enableRandomization", false];
    _veh setDir (random 360);

    // doesn't count if it blows up on spawn in ...
    sleep 0.1;
    if ((damage _veh) > 0.1) then {
        // d'oh -- it gots some dings.  try again ...
        deleteVehicle _veh;
        _veh = objNull;
    };

    if (pcb_DEBUG) then {
        private _mn = "M" + str ([] call pcb_fnc_get_next_UID);
        private _m = createMarker [_mn, _rpos];
        _mn setMarkerShapeLocal "ELLIPSE";
        _mn setMarkerColorLocal "ColorBLACK";
        _mn setMarkerSizeLocal [50, 50];
        _mn setMarkerAlpha 0.9;
    };
};

_veh
