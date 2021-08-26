/* *******************************************************************
                        paradrop stuff

Parameters:
    _unit (object) : the unit to be parachuted
******************************************************************* */
params ["_unit", ["_pos", [0,0, 500]],["_obj", objNull], ["_dispersion", 300]];

[_unit, _pos, _obj, _dispersion] spawn {
    params ["_unit", "_pos", "_obj", "_dispersion"];


    // teleport to position, but up high
    if (! ([_pos] call pcb_fnc_is_valid_position)) then { _pos = getPosATL _unit; };
    _pos = _pos getPos [random _dispersion, random 360]; 
    private _up_pos = [_pos select 0, _pos select 1, 1000];
    if (isNull _obj) then {
        //private _payload = "B_CargoNet_01_ammo_F";
        private _payload = "B_supplyCrate_F";
        _obj = _payload createVehicle [0, 0, 0];
    };
    private _chute = createVehicle ['B_Parachute_02_F', _up_pos, [], 0, 'Fly'];
    _obj setPos _up_pos;
    _chute setPos (position _obj);
    _chute attachTo [_obj, [0, 0, 1]];
    _chute allowDamage false;
    _obj allowDamage false;

    private _smoke1 = "SmokeShellRed" createVehicle (position _chute);
    _smoke1 attachTo [_chute, [0.5, 0.5, 1]];
    private _smoke2 = "SmokeShellRed" createVehicle (position _chute);
    _smoke2 attachTo [_chute, [-0.5, -0.5, 1]];
    private _flare1 = "F_40mm_Green" createVehicle (position _chute);
    _flare1 attachTo [_chute, [0.5, -0.5, 1]];

    waitUntil { sleep 2; (isTouchingGround _obj) || (((getPosATL _obj) select 2) < 2) };
    detach _chute;
    private _smoke3 = "SmokeShellGreen" createVehicle (position _obj);
    _smoke3 attachTo [_obj, [-0.5, 0.5, 1]];
    _obj allowDamage true;
};
