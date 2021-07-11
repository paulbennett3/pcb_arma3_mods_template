/* ********************************************
                 swap_object

_target object (will be destroyed and replaced)
_new_type string -- which type of item packing/unpacking
******************************************** */
params ["_target", "_new_type", "_rot"];

private _pos = getPosATL _target;
private _dir = (getDir _target) + _rot;

deleteVehicle _target;
//_veh = createVehicle [_new_type, [0, 0, 0], [], 0, "NONE"];
_veh = createVehicle [_new_type, [0, 0, 0], [], 0, "CAN_COLLIDE"];
[_veh, _pos] call pcb_fnc_setPosAGLS;
_veh setDir _dir;
_veh;
