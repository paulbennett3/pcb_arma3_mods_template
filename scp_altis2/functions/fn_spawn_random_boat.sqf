/* --------------------------------------------------------------------
                        spawn random boat

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
_veh = [active_area, _buildings] call pcb_fnc_spawn_random_boat;

-------------------------------------------------------------------- */
if (! isServer) exitWith {};

params ["_active_area", "_buildings", ["_ignore_aa", false], ["_civ", true]];

private _veh = objNull;

// don't spawn in water or right near start
private _blacklist = [[start_pos, 500]];

private _tries = 50;

while {_tries > 0} do {
    _tries = _tries - 1;
 
    private _building = selectRandom _buildings;
    private _rpos = [
        _building,
        5,
        100,
        2,
        2,
        0.5,
        1,
        _blacklist
    ] call BIS_fnc_findSafePos;

    if ( ([_rpos] call pcb_fnc_is_valid_position) && { surfaceIsWater _rpos } ) then {
        private _type = ["boat", "any", _civ] call pcb_fnc_get_random_vehicle;
        _veh = createVehicle [_type, [_rpos select 0, _rpos select 1], [], 5, "NONE"];
        _veh setDir (random 360);

        // doesn't count if it blows up on spawn in ...
        sleep 0.1;
        if ((damage _veh) > 0.1) then {
            // d'oh -- it gots some dings.  try again ...
            deleteVehicle _veh;
            _veh = objNull;
        } else {
            _tries = -10;
        };

    };
};

_veh
