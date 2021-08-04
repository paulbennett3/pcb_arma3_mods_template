/* ********************************************************
                    cargo base
******************************************************** */
params ["_pos"];

if (! isServer) exitWith {};

_pos = [_pos select 0, _pos select 1];

// Handy attachment code
private _attachIt = {
    params ["_target", "_type", "_pos", "_rot"];
    private _thing = _type createVehicle [0,0,0];
    _thing attachTo [_target, _pos]; _thing setDir _rot; _thing setPosASL getPosASL _thing;
    _thing
};

private _cargo_container = "B_Slingload_01_Cargo_F" createVehicle [0,0,0];
_cargo_container setPos _pos;
_cargo_container enableRopeAttach false;  // have to pack before loading

//_start_crate = [_cargo_container, "Land_Pallet_MilBoxes_F", [20,20,0], 90] call _attachIt;
_ppos = _cargo_container getRelPos [20, 180];
_ppos = [_ppos select 0, _ppos select 1];
_start_crate = "Land_Pallet_MilBoxes_F" createVehicle [0,0,0];
_start_crate setPos _ppos;

// add a magic cargo section ...
_cargo = "Supply500" createVehicle [0,0,0];
_cargo attachTo [_start_crate, [0,0,0.85]];
// add our actual loadout ...
[_cargo, "crate"] call pcb_fnc_crate_loadout;

private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    private _cargo = _arguments select 0;
    private _crate = _arguments select 1;
    [ _crate, true ] remoteExec ["hideObject", 0, true];
    [ "hiding crate <" + (str _crate) + ">"] remoteExec ["hint", 0, true];
    _cargo enableRopeAttach true;  
};

[
    _cargo_container,
    [
        "Pack Base",
        _cmd,
        [_cargo_container, _start_crate], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!

_cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    private _cargo = _arguments select 0;
    private _crate = _arguments select 1;
    private _ppos = _cargo getRelPos [20, 180];
    _ppos = [_ppos select 0, _ppos select 1];

    _crate setPos _ppos;
    [ _crate, false ] remoteExec ["hideObject", 0, true];
    [ "revealing crate <" + (str _crate) + ">"] remoteExec ["hint", 0, true];
    _cargo enableRopeAttach false;  // have to pack before loading
};

[
    _cargo_container,
    [
        "Unpack Base",
        _cmd,
        [_cargo_container, _start_crate], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!
