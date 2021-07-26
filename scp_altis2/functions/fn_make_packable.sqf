/* ********************************************
               make packable 

Create an (un)packable base / repair depot / etc

Create packed/unpacked version wher you want it (or at (0,0,0) then move for complex collections)
Create unpacked/packed version (ie, the other one) at [0,0,0].
Then call this function to "link" the two and call the addAction function 

_target (object) : the packed/unpacked version
_alternate (object) : unpacked/packed version
_packed (bool) :  true = _target is packed, else _target is unpacked
_rot (number - 0-360) : used to rotate when we swap, if needed


Example:
  private _base = "Land_Pallet_MilBoxes_F" createVehicle (getPosATL player);
  private _crate = "B_CargoNet_01_ammo_F" createVehicle [0,0,0];
  [_base, _crate, false] call pcb_fnc_spawn_packable_base;

******************************************** */
params ["_target", "_alternate","_packed", ["_rot", 0]];

// only run on server!
if (! isServer) exitWith {};

private _packed_unpacked_rot = [_target, _alternate, _rot];
private _act = objNull;
private _alt_act = objNull;

if (_packed) then {
    _act = "Unpack";
    _alt_act = "Pack";
} else {
    _act = "Pack";
    _alt_act = "Unpack";
};

// add an action to our _target
[_target, _packed_unpacked_rot, _act] call pcb_fnc_addAction_packable;
[_alternate, _packed_unpacked_rot, _alt_act] call pcb_fnc_addAction_packable;
