/* ---------------------------------------------------------------------
                     start portable_base_crate

--------------------------------------------------------------------- */
params ["_start_pos", ["_packed", false]];

private _pos = _start_pos vectorAdd [0.5, 0.5];


// ------------------------------------------------------------------
// Spawn our "base" crate
// ------------------------------------------------------------------
_vpos = _pos;
_crate_type = "Land_PlasticCase_01_large_black_F";
private _base_crate = _crate_type createVehicle _vpos;
_base_crate setDir (random 360);
_base_crate setPosASL getPosASL _base_crate;  // synch for MP


// ------------------------------------------------------------------
// make a nice little base encampment relative to crate
// ------------------------------------------------------------------
private _attachIt = {
    params ["_target", "_type", "_pos", "_rot"];
    private _thing = _type createVehicle [0,0,0];
    _thing attachTo [_target, _pos]; _thing setDir _rot; _thing setPosASL getPosASL _thing;
    _thing
};

private _dir = (getDir _base_crate) - 90;
if (_dir < 0) then { _dir = _dir + 360; };
private _desk_pos = (getPos _base_crate) vectorAdd [0, -0.15, 1.0];


private _desk = createVehicle ["Land_Laptop_Intel_Oldman_F", _desk_pos, [], 0, "CAN_COLLIDE"];
_desk setDir _dir;
_desk setPosASL getPosASL _desk;
[_desk, "SatelliteAntenna_01_Black_F", [1,-1.5,0.05], 135] call _attachIt;
[_desk, "Land_PortableWeatherStation_01_white_F", [-2,-.5,.75], 180] call _attachIt;
[_desk, "Land_Router_01_black_F", [-.4,.05,-.03], 15] call _attachIt;
[_desk, "Land_SatellitePhone_F", [.48,.05,0.025], 135] call _attachIt;
//[_desk, "Box_NATO_Ammo_F", [-1.75,1.75, -.625], 15] call _attachIt;
//[_desk, "ACE_Box_Misc", [1.5, 1.5, -.65], 0] call _attachIt;
//[_desk, "ACE_medicalSupplyCrate_advanced", [1.5, 2.25, -.9], 0] call _attachIt;

_base_crate setVariable ["type", _crate_type];
_base_crate setVariable ["base", _desk];
_base_crate setVariable ["packed", false];
_base_crate setVariable ["offset", 0];
_base_crate setVariable ["adjust", [0, 0, 1]];


// ------------------------------------------------------------------
// Add pack / unpack command
// ------------------------------------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    
    [["pck", _target]] call pcb_fnc_send_mail; 
};

[
    _base_crate,
    [
        "Pack/Unpack Base",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];  


[_desk] call pcb_fnc_add_base_actions;

if (_packed) then {
    [["pck", _base_crate]] call pcb_fnc_send_mail; 
};

_base_crate
