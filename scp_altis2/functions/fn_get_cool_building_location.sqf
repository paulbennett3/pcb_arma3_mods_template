/* *********************************************************
              get cool building location

Find a "cool" building within _radius of _target_obj
returns object found
********************************************************* */
/*
params ["_target_obj", ["_radius", worldSize], ["_min_positions", 10]];

// first time we are called, we calculate the upper 10th percentile
//  of buildings by number of positions, and save both that threshold
//   and a list of those building types

//if (isNil "large_building_threshold") then {
if (true) then {
    large_building_threshold = 0;

    // instead of querying each time, we'll use the info found during our "fn_find_building_density" function,
    //   and use the Nth percentile to define "large"
    private _positions = [];
    {
        private _n =  _x get "n"; // number of this type of building
        private _npos =  _x get "npositions"; // positions in this type of building
        private _pdx = 0;
        for [{}, {_pdx < _n}, {_pdx = _pdx + 1}] do {
            _positions pushBack _npos;
        };
    } forEach (values building_info_map);
    _positions sort false;  // sort in descending order
    large_building_threshold = _positions select (round ((count _positions) * 0.25)); // using Nth percentile

    // now that we have the threshold, use it to make a list of "large_building_types"
    large_building_types = [];
    {
        if (((building_info_map get _x) get "npositions") >= large_building_threshold) then {
            large_building_types pushBackUnique _x;
        };
    } forEach (keys building_info_map); 
};

// using our calculated list of large building types, we randomly select one
private _building_type = selectRandom large_building_types;

// now we just find every instance of that type of building
private _buildings = _target_obj nearObjects [_building_type, _radius];
private _obj = selectRandom _buildings;

while { sleep 0.1; ((isNil "_obj") || { isNull _obj}) } do {
    ["Error! fn_get_cool_building failed to get a building -- punting ..."] call pcb_fnc_debug;
    _obj = selectRandom (_target_obj nearObjects ["Building", _radius]);
};

_obj
*/

params ["_target_obj", ["_radius", worldSize], ["_use_cool_types", true], ["_min_positions", 5]];

private _types = ["House", "Building"];  // should find just about any building
if (_use_cool_types) then {
    _types = types_hash get "cool buildings"; // just use the ones listed in types_hash
};
private _tries = 15;
private _pos = [0,0,0];
private _obj = objNull;

while {_tries > 0} do {
    _tries = _tries - 1;
    private _objects = [];
    // private _objects = nearestObjects [_target_obj, _types, _radius];
    { _objects = _objects + (_target_obj nearObjects [_x, _radius]); } forEach _types;
    private _n_found = (count _objects);
    if (_n_found < 1) then {
        _radius = _radius + 1000;
    } else {
        while {_n_found > 0} do {
            _n_found = _n_found - 1;
            _obj = _objects select _n_found;
            // does it have at least as many positions in the building as we want?
            if ((count (_obj buildingPos -1)) >= _min_positions) then {
                _n_found = 0;
                _tries = 0;
            }
        }
    };
};

_obj
