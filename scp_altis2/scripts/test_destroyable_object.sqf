hint "test destroyable object called";

// spawn a building near the start position
//private _building = "Land_Medevac_HQ_V1_F" createVehicle start_pos;
private _pos = (playableUnits select 0) getRelPos [100, 180];
private _target = "Land_Castle_01_tower_F" createVehicle [0,0,0];
_target setPos _pos;
[_target] call pcb_fnc_make_destroyable;
["boomable", "blow me", getPosATL _target, 1] call pcb_fnc_objective_locate_object;

[_target] spawn {
    while {true} do {
        params ["_target"];
        sleep 5;
        private _isNull = isNull _target;
        private _alive = alive _target;
        private _tpos = getPosATL _target;
        hint ("target <" + (str _target) + "> <" + (str _isNull) + "><" + (str _alive) + "><" + (str _tpos) + ">"); 
    };
};
