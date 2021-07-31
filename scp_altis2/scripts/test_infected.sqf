private _pos = (playableUnits select 0) getRelPos [120, 90];

private _n = 10;
private _did = false;
private _obj_list = [];
private _type = "";

// chance of encounter
if (true) then {
    _did = true;
    private _spooks = types_hash get "civ infected";

    private _group = createGroup east;
    private _tries = 50;
    while {_tries > 0} do {
        _tries = _tries - 1;
        private _keep = [];
        for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
            _type = selectRandom _spooks;
            private _veh = _group createUnit [_type, _pos, [], 5, 'NONE'];
            _veh triggerDynamicSimulation false; // won't wake up enemy units
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

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    // toggle dynamic simulation on -- shouldn't really matter since we delete when far
    // away, but there is a chance to have lots of units ...
    _group enableDynamicSimulation true;
    //[_group, _pos] call BIS_fnc_taskDefend;
    [_group, start_pos] call BIS_fnc_taskAttack;
};
