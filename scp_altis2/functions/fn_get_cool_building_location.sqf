/* *********************************************************
              get cool building location

Find a "cool" building within _radius of _target_obj
returns object found
********************************************************* */
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
