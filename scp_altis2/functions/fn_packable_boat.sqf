/* ---------------------------------------------------------------------
                     packable boat
B_Boat_Transport_01_F
--------------------------------------------------------------------- */

params ["_target"];

private _crate = _target;

// flip the state
private _state = not (_crate getVariable "packed");
_crate setVariable ["packed", _state];

// if we are unpacking, pick a spot to put the boat
if (not _state) then {
    // center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklist, default
    private _pos = [
        getPosATL _target,
        0,
       20,
        1,
        2,
        0.5,
        1,
        [],
        [getPosATL _target, getPosATL _target] 
    ] call BIS_fnc_findSafePos;

    private _veh = "B_Boat_Transport_01_F" createVehicle _pos;
    _target setVariable ["boat", _veh];
} else {
    private _boat = _target getVariable "boat";
    if ((! isNil "_boat") || (! isNull _boat)) then {
        if ( (_boat distance2D _target) < 20 ) then {
            deleteVehicle _boat;
            _target setVariable ["boat", objNull];
        } else {
            // failed to pack, so flip state back to unpacked
            _state = not (_crate getVariable "packed");
        };
    };
};
