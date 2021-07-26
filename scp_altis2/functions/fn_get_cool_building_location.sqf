/* *********************************************************
              get cool building location

Find a "cool" building within _radius of _target_obj
returns object found
********************************************************* */
params ["_target_obj", ["_radius", worldSize]];

private _types = types_hash get "cool buildings";
private _tries = 10;
private _pos = [0,0,0];
private _obj = objNull;

while {_tries > 0} do {
    _tries = _tries - 1;
    private _objects = nearestObjects [_target_obj, _types, _radius];
    if ((count _objects) < 1) then {
        _radius = _radius + 1000;
    } else {
        _obj = selectRandom _objects;
        _tries = 0;
    };
};

_obj
