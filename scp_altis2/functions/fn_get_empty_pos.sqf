/* ----------------------------------------------------
                   get empty pos

Given a center location and vehicle type, find a flat, empty
position for a given vehicle type.  This wrapper gradually
expands the search until one is found. 

_center is a position
---------------------------------------------------- */

params ["_center", "_max_dist", "_blacklistPos"];

private _pos = [0,0];
private _tries = 50;
while { _tries > 0 } do {
    _tries = _tries - 1;
    _pos = [_center, 0, _max_dist, 5, 0, 0.05, 0, _blacklistPos] call BIS_fnc_findSafePos;
    if (([_pos] call pcb_fnc_is_valid_position)) then {
        _tries = -10;
    };
};

_pos;
