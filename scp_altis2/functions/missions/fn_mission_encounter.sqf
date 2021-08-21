/* *********************************************************
                    mission encounter
********************************************************* */
params ["_pos", ["_chance", 50], ["_max_n", 3]];

private _obj_list = [];
private _type = objNull;
private _n = 1 + (floor (random _max_n));
private _did = false;
private _group = grpNull;

// chance of encounter
if ((random 100) < _chance) then {
    _did = true;
    private _spooks = types_hash get "weaker spooks";
    _type = selectRandom _spooks;
    private _ctypes = [];
    private _i = 0;
    for [{}, {_i < _n}, {_i = _i + 1}] do {
        _ctypes pushBack _type;
    };
    _group = [_ctypes, _pos, east, false] call pcb_fnc_spawn_squad;
    _obj_list = _obj_list + (units _group);
};


[_obj_list, _type, _n, _did]
