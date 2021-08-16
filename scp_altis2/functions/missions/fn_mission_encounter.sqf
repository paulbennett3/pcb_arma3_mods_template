/* *********************************************************
                    mission encounter
********************************************************* */
params ["_pos", ["_chance", 50], ["_max_n", 3]];

private _obj_list = [];
private _type = objNull;
private _n = 1 + (floor (random _max_n));
private _did = false;

// chance of encounter
if ((random 100) < _chance) then {
    _did = true;
    private _spooks = types_hash get "weaker spooks";
    _type = selectRandom _spooks;

    private _group = createGroup east;
    private _tries = 50;
    while {_tries > 0} do {
        _tries = _tries - 1;
        private _keep = [];
        for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
            private _veh = _group createUnit [_type, _pos, [], 5, 'NONE'];
            _veh triggerDynamicSimulation true; // *will* wake up enemy units
            _keep pushBack _veh;
            sleep .1;
        };
        sleep 0.1;

        {
            if (alive _x) then {
                _tries = -10;
                _obj_list pushBack _x;
            } else {
                deleteVehicle _x;
            };
        } forEach _keep;
    };

    _obj_list joinSilent _group;

    [_group] call pcb_fnc_log_group;
    _group enableDynamicSimulation false;
};


[_obj_list, _type, _n, _did]
