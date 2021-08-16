/* ********************************************************
                   set behaviour
******************************************************** */
params ["_group", "_pos", "_mode"];

switch (_mode) do {
    case "SAD": {
        //[_group, getPosATL (selectRandom playableUnits)] call BIS_fnc_taskAttack;
        [_group, _pos, 100] call BIS_fnc_taskPatrol;
    };
    case "Patrol": {
        [_group, _pos, 500] call BIS_fnc_taskPatrol;
    };
}; 
