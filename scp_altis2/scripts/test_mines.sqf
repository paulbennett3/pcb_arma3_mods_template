hint "test mines called";
private _pos = (playableUnits select 0) getRelPos [50, 180];

[_pos] spawn {
    params ["_pos"];
    while {true} do {
        sleep 30;
        private _result = [_pos] call pcb_fnc_boom_guy;
        private _target = _result select 1;
        ["boomable" + (str _target), "blow me", getPosATL _target, 1] call pcb_fnc_objective_locate_object;
        hint "spawned boomable";
    };
};

