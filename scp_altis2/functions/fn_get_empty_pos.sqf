/* ----------------------------------------------------
                   get empty pos

Given a center location and vehicle type, find a flat, empty
position for a given vehicle type.  This wrapper gradually
expands the search until one is found. 

_center is a position
---------------------------------------------------- */

params ["_center", "_veh_type"];

private _pos = _center;
private _args = [-1, -1, 0.05, 3, 0, false, objNull];
private _tries = 50;
private _offset = 5;
private _min_dist = 0;

while { _tries > 0 } do {
    _tries = _tries - 1;
    _pos = _center findEmptyPosition [_min_dist, _min_dist + 10, _veh_type ];
    _min_dist = _min_dist + _offset;
    if ([_pos] call pcb_fnc_is_valid_position) then {
        _pos = _pos isFlatEmpty _args;

        if ([_pos] call pcb_fnc_is_valid_position) then {
            _tries = -10;
        };
    };
};

_pos;



