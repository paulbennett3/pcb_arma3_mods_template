/* ********************************************************
                      populate cities

For all "cities" (including large and small, villages, ...),
place "something" with a random chance.  Could be good, 
could be bad ...
******************************************************** */
params ["_active_area"];

private _blacklist = ["water"];

// --------------------------------
// place stuff in "named" cities
// --------------------------------
private _cities = [epicenter, worldSize] call pcb_fnc_get_city_positions;
private _cities_in_active_area = _cities inAreaArray "mEPI";
private _code = {
    params ["_types", "_n", "_pos", "_side"];
    private _group = createGroup _side;
    for [{_i = 0 }, {_i < _n}, {_i = _i + 1}] do {
        private _type = selectRandom _types;
        private _veh = _group createUnit [_type, _pos, [], 200, 'NONE'];
        _veh triggerDynamicSimulation false; // won't wake up enemy units:wq
        [_veh] joinSilent _group;
    };

    // there is a limit to the number of groups, so we will mark this to delete
    //  when empty
    _group deleteGroupWhenEmpty true;

    _group enableDynamicSimulation true;
    [_group, _pos] call BIS_fnc_taskDefend;
    sleep .1;
};

{
    // civilians
    if ((random 1) < 0.25) then {
        private _types = types_hash get "civilians";
        private _n = 10 + (ceil (random 10));
        [_types, _n, _x, civilian] call _code;

    };   
    // looters
    if ((random 1) < 0.25) then {
        private _types = types_hash get "looters";
        private _n = 3 + (ceil (random 7));
        [_types, _n, _x, independent] call _code;
    };   
    // zombies
    if ((random 1) < 0.25) then {
        private _types = types_hash get "zombies";
        private _n = 10 + (ceil (random 20));
        [_types, _n, _x, east] call _code;
    };   
        
    if (pcb_DEBUG) then {
        private _mn = "MC" + (str _x);
        private _m = createMarker [_mn, _x];
        _m setMarkerType "KIA";
    };
} forEach _cities_in_active_area;

// --------------------------------
// place cargo crates (and possibly spooks etc) in military bases
// --------------------------------
private _types = types_hash get "military buildings";

private _military_objects = nearestObjects [epicenter, _types, worldSize];
private _military_objects_in_area = _military_objects inAreaArray "mEPI";
{
    private _crates = types_hash get "resupply crates";
    private _building = nearestBuilding _x;
    private _positions = [_building] call BIS_fnc_buildingPositions;
    if ((count _positions) > 1) then {
        private _pos = selectRandom _positions;
        if ([_pos] call pcb_fnc_is_valid_position) then {
            private _object_type = selectRandom _crates;
            _target = _object_type createVehicle [0, 0, 0];
            _target setPos _pos;
            sleep 0.1;
        };
    };

    if (pcb_DEBUG) then {
        private _mn = "MC" + (str _x);
        private _m = createMarker [_mn, _x];
        _m setMarkerType "KIA";
        _m setMarkerColor "ColorRED";
    };
    private _roll = random 1; 
    if (_roll < 0.5) then {
        private _ztypes = types_hash get "zombies";
        private _n = 5 + (ceil (random 5));
        [_ztypes, _n, _x, east] call _code;
    };
    if ((_roll >= 0.5) and (_roll < 0.7)) then {
        private _types = types_hash get "looters"; 
        private _n = 3 + (ceil (random 3));
        [_types, _n, _x, east] call _code;
    };
    
} forEach _military_objects_in_area;

