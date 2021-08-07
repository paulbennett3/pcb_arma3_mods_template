/* *********************************************************
              get cool building location

Find a "cool" building within _radius of _target_obj
returns object found
********************************************************* */
params ["_target_obj", ["_radius", worldSize], ["_min_positions", 10]];

private _types = ["House", "Building"];  // should find just about any building
private _objects = [];

{ _objects = _objects + (_target_obj nearObjects [_x, _radius]); } forEach _types;

private _large_buildings = _objects select { (count (_x buildingPos -1) >= _min_positions) };
["Found <" + (str (count _large_buildings)) + "> large buildings"] call pcb_fnc_debug;

private _obj = selectRandom _large_buildings;

_obj
