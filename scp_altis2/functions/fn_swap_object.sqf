/* ********************************************
                 swap_object


Note -- called in a "spawned" script, so sleep ok

_target object (will be destroyed and replaced)
_new_type string -- which type of item packing/unpacking
******************************************** */
params ["_target", "_new_type", "_rot"];

// !!!!!!!!!!!!!! consider creating both objects, and putting one in a "safe" spot vice
//   deleteing ... -- this would preserve loadout!

private _pos = getPosATL _target;
private _dir = (getDir _target) + _rot;

deleteVehicle _target;
sleep .1;
_veh = createVehicle [_new_type, [0, 0, 0], [], 0, "NONE"];
_veh setVariable ["BIS_enableRandomization", false];
[_veh, _pos] call pcb_fnc_setPosAGLS;
_veh setDir _dir;
_veh;
