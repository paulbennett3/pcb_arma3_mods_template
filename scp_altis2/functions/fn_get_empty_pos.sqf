/* ----------------------------------------------------
                   get empty pos

Given a center location and vehicle type, find a flat, empty
position for a given vehicle type.  This wrapper gradually
expands the search until one is found. 

_center is a position
---------------------------------------------------- */

params ["_center", "_max_dist", "_blacklistPos"];

private _pos = [_center, 0, _max_dist, 10, 0, 1.0, 0, _blacklistPos] call BIS_fnc_findSafePos;

_pos;
