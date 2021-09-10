/* ********************************************************
                   set behaviour
******************************************************** */
params ["_group", "_pos", "_mode", ["_veh", objNull], ["_player", objNull]];

if (isNull _player) then { _player = selectRandom playableUnits; };

_mode = toUpper _mode;
switch (_mode) do {
    case "SAD": {
        //[_group, getPosATL (selectRandom playableUnits)] call BIS_fnc_taskAttack;
        [_group, _pos, 100] call BIS_fnc_taskPatrol;
        private _wp = _group addWaypoint [_pos, 10];
        _wp setWaypointType "CYCLE";
    };
    case "PATROL": {
        [_group, _pos, 500] call BIS_fnc_taskPatrol;
        private _wp = _group addWaypoint [_pos, 10];
        _wp setWaypointType "CYCLE";
    };
    case "DEFEND": {
        [_group, _pos] call BIS_fnc_taskDefend;
    };
    case "DRIVE_AND_DESTROY": {
        // Saddle up!
        private _wp = _group addWaypoint [_veh, -1];
        _wp setWaypointType "GETIN";

        // Go to target, then hop out
        private _min_dist = 50 + (random 100);
        private _wpgo = _group addWaypoint [_player, _min_dist];
        _wpgo setWaypointType "GETOUT";
        [_player, _group, _wpgo, _min_dist] spawn {
            params ["_player", "_group", "_wpgo", "_min_dist"];

            private _done = false;
            while { sleep 10; ! _done } do {
                private _alive = (units _group) select { alive _x };
                private _dist = (_alive select 0) distance2D _player;
                if ((count _alive) < 1) then { _done = true; };
                if (_dist > (2*_min_dist)) then {
                    _wpgo setWaypointPosition [(getPosASL _player), _min_dist];
                };
            };
        };

        _wp = _group addWaypoint [_player, -1];
        _wp setWaypointType "SAD";
        _wp setWaypointBehaviour "STEALTH";
        _wp setWaypointCombatMode "RED";
    };
}; 
