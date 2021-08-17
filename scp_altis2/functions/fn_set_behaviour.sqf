/* ********************************************************
                   set behaviour
******************************************************** */
params ["_group", "_pos", "_mode", ["_veh", objNull], ["_player", objNull]];

_mode = toUpper _mode;
switch (_mode) do {
    case "SAD": {
        //[_group, getPosATL (selectRandom playableUnits)] call BIS_fnc_taskAttack;
        [_group, _pos, 100] call BIS_fnc_taskPatrol;
    };
    case "PATROL": {
        [_group, _pos, 500] call BIS_fnc_taskPatrol;
    };
    case "DEFEND": {
        [_group, _pos] call BIS_fnc_taskDefend;
    };
    case "DRIVE_AND_DESTROY": {
        // Saddle up!
        private _wp = _group addWaypoint [_veh, -1];
        _wp setWaypointType "GETIN";

        // Go to target, then hop out
        _wp = _group addWaypoint [_player, 10 + (random 50)];
        _wp setWaypointType "GETOUT";

        _wp = _group addWaypoint [_player, -1];
        _wp setWaypointType "DESTROY";
        _wp setWaypointBehaviour "STEALTH";
        _wp setWaypointCombatMode "RED";
    };
}; 
