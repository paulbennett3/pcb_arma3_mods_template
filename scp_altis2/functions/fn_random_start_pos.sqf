/* --------------------------------------------------------------------------------------
                                random_start_pos
  Pick a semi-random starting position

Will start at either an Airfield or along the coastline

Makes the following public variables:
    start_pos         position
    All_airfields     [ [[airfield 1 pos], [airfield 1 dir]],
                        [[airfield 2 pos], [airfield 2 dir]], ...
-------------------------------------------------------------------------------------- */

if (! isServer) exitWith {};
diag_log "Setting random start position";

// Get location of all Airports, primary and secondary
// makes array of [ [[loc1], [dir1]], [[loc2], [dir2]], ...
All_airfields = [];
if (count allAirports > 0) then {
    private _first = [getArray (configfile >> "CfgWorlds" >> worldname >> "ilsPosition"),
                      getArray (configfile >> "CfgWorlds" >> worldname >> "ilsDirection")];
    All_airfields pushbackunique _first;
    private _sec = (configfile >> "CfgWorlds" >> worldname >> "SecondaryAirports");
    for "_i" from 0 to (count _sec - 1) do {
        All_airfields pushbackunique [getarray ((_sec select _i) >> "ilsPosition"),
                                      getarray ((_sec select _i) >> "ilsDirection")];
    };
};
publicVariable "ALL_airfields";

start_pos = objNull;
private _start_type = objNull;
private _roll = random 1;

if (_roll < 0.45) then {
    _start_type = "Airfield";
} else {
    if (_roll < 1) then {
        _start_type = "Coast";
    } else {
        _start_type = "Hilltop";
    }
};

switch (_start_type) do {
    case "Airfield": {
        // pick an airfield to start at
        start_airfield = selectRandom All_airfields;
        publicVariable "start_airfield";
        private _start_airfield_pos = start_airfield select 0;
        private _start_airfield_dir = start_airfield select 1;
        start_pos = _start_airfield_pos;
    };
    case "Coast": {
        // pick random bit of coastline ...
        // First we pick a center uniformly at random over the world size
        private _center = [nil, ["water"]] call BIS_fnc_randomPos; 
        // center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos
        //start_pos = _center;
        //start_pos = [[], 0, -1, 10, 0, 0.1, 1, [], []] call BIS_fnc_findSafePos;
        //start_pos = [_center, 0, -1, 10, 0, 0.1, 1, [], []] call BIS_fnc_findSafePos;
        start_pos = [_center, 0, 10000, 10, 0, 0.1, 1, [], []] call BIS_fnc_findSafePos;
    };
    case "Hilltop": {
        // pick a good hilltop ...
        // First we pick a center uniformly at random over the world size
        private _center = [nil, ["water"]] call BIS_fnc_randomPos; 

        // center, radius, expression, precision, count
        private _expression = "5*hills + meadow - 3*trees - 3*forests - houses - waterDepth";
        start_pos = selectBestPlaces [_center, mission_radius, _expression, 25, 1]; 
        if ((count start_pos) == 0) then {
            start_pos = _center;
        } else {
            start_pos = start_pos select 0;
        };

        private _hilltops = nearestLocations [start_pos, ['Hill'], worldSize];
        if ((count _hilltops) > 0) then {
            hint "Hilltop!";
            start_pos = locationPosition (selectRandom _hilltops);
        };
    };
    default {
        start_pos = (All_airfields select 0) select 0;
    };
};

publicVariable "start_pos";

// add a marker for where the start is
private _marker = createMarker ["mstart_pos", start_pos];
_marker setMarkerType "mil_start";
_marker setMarkerText "Insertion Point";
