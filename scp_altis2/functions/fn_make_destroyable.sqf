/* ---------------------------------------------------------------------
                             destroyable obelisk

Decorate it with invisible UAVs, add event handlers to them
--------------------------------------------------------------------- */
params ["_obj"];

if (! isServer) exitWith {};

// for debug -- hide the UAVs or not
private _hide = true;
//private _type = "B_UAV_01_F";
private _type = "O_UAV_01_F";

// object to work with
private _bb = boundingBox _obj;

// Decorate with UAVs
// [[xmin, ymin, zmin], [xmax, ymax, zmax], boundingSphereDiameter].
private _min = _bb select 0;
private _max = _bb select 1;
private _s0 = [_min select 0, _min select 1, 1];
private _s1 = [_max select 0, _min select 1, 1];
private _s2 = [_min select 0, _max select 1, 1];
private _s3 = [_max select 0, _max select 1, 1];

private _foo = { 
    _foo = attachedTo (_this select 0); 
    {
        deleteVehicle _x;
    } forEach attachedObjects _foo;
    deleteVehicle (_this select 0); 
    deleteVehicle _foo; 
};
_uav = _type createVehicle (getPosATL _obj);
_uav attachTo [_obj, [1, 0, 0]];
_uav hideObject _hide; [_uav, _hide] remoteExec ["hideObject", 0, true];
_uav addMPEventHandler [ "mpkilled", _foo ];

_uav = _type createVehicle (getPosATL _obj);
_uav attachTo [_obj, [-1, 0, 0]];
_uav hideObject _hide; [_uav, _hide] remoteExec ["hideObject", 0, true];
_uav addMPEventHandler [ "mpkilled", _foo ];

_uav = _type createVehicle (getPosATL _obj);
_uav attachTo [_obj, [0, 1, 0]];
_uav hideObject _hide; [_uav, _hide] remoteExec ["hideObject", 0, true];
_uav addMPEventHandler [ "mpkilled", _foo ];

_uav = _type createVehicle (getPosATL _obj); 
_uav attachTo [_obj, [0, -1, 0]];
_uav hideObject _hide; [_uav, _hide] remoteExec ["hideObject", 0, true];
_uav addMPEventHandler [ "mpkilled", _foo ];


