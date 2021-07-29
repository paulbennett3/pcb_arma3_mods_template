/* *********************************************************
                    mission encounter
********************************************************* */
params ["_pos", ["_chance", 50]];

// chance of encounter
if ((random 100) < _chance) then {
    private _spooks = types_hash get "spooks";
    private _type = selectRandom _spooks;
    private _n = 1 + (floor (random 3));

    private _group = createGroup east;
    for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
        private _veh = _group createUnit [_type, _pos, [], 5, 'NONE'];
        [_veh] joinSilent _group;
        _veh triggerDynamicSimulation false; // won't wake up enemy units
//        _obj_list pushBack _veh;
        sleep .1;
    };

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    // toggle dynamic simulation on -- shouldn't really matter since we delete when far
    // away, but there is a chance to have lots of units ...
    _group enableDynamicSimulation true;
    [_group, _pos] call BIS_fnc_taskDefend;
};
