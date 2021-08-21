/* ---------------------------------------------------------------------
                     packable base
--------------------------------------------------------------------- */

params ["_target"];

private _crate = _target;
private _base = _crate getVariable "base";

// flip the state
private _state = not (_crate getVariable "packed");
_crate setVariable ["packed", _state];

{ 
    [ _x, _state ] remoteExec ["hideObject", 0, true]; 
} forEach (attachedObjects _base);
[ _base, _state ] remoteExec ["hideObject", 0, true];
[_crate, _state ] remoteExec ["enableRopeAttach", 0, true];

// if we are unpacking, pick a new location to move the base to
// Also if we are unpacking, move the respawn markers to the neighborhood
if (not _state) then {
    private _offset = _crate getVariable "offset";
    if (isNil "_offset") then { _offset = 5; };
    private _adjust = _crate getVariable "adjust";
    if (isNil "_adjust") then { _adjust = [0, 0, 0]; };
    private _dir = (getDir _crate) - 90;
    if (_dir < 0) then { _dir = _dir + 360; };
    private _base_pos = (_crate getPos [_offset, _dir]) vectorAdd _adjust;
    _base setPos _base_pos;
    _base setDir _dir;
    _base setPosATL getPosATL _base;

    private _respawn_pos = _crate getPos [20, 180];
    private _vrespawn_pos = _crate getPos [20, 90];
    "respawn_west" setMarkerPos _respawn_pos;
    "respawn_vehicle_west" setMarkerPos _vrespawn_pos;
};
