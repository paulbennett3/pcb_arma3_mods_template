/* -----------------------------------------------------------
                   get small base pos

Randomly find a location suitable for a small base (say 10x10)
  -- no guarantee there will be room for vehicles!!!
----------------------------------------------------------- */
params [["_pos", [worldSize / 2, worldSize / 2]], ["_base_size", 20], ["_max_search_radius", 200], ["_check_surface", true]];

private _surface_types = [
    "BEACH",
    "DESERT",
    "DIRT",
    "FIELD",
    "FOREST",
    "GRASS",
    "SOIL",
    "STUBBLE",
    "MARSH",
    "MUD", 
    "WEED", 
    "SAND"
];

private _code = {
    private _result = _this isFlatEmpty [_base_size, -1, .1, 10, 0, false, objNull];
    private _stype = toUpper (surfaceType _this);
    private _ok_surface = true;
    if (_check_surface) then {
        _ok_surface = false;
        {
            if (_x in _stype) then { _ok_surface = true; };
        } forEach _surface_types;
    };
    (((count _result) > 0) &&  (! isOnRoad _this) && _ok_surface) 
};


private _tries = 50;
private _whitelist = [ [_pos, _max_search_radius] ];
while { _tries > -1 } do {
    _pos = [_whitelist, ["water"], _code] call BIS_fnc_randomPos;
    if (((_pos select 0) > 0) || { (_pos select 1) > 0 }) then {
        _tries = -10;    
    };
};

_pos
