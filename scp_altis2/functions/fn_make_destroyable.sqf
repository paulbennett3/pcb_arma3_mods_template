/* ---------------------------------------------------------------------
                             destroyable obelisk

Decorate it with invisible UAVs, add event handlers to them



 In a repeatable trigger, covering the area you want:

condition:

{_x inArea thisTrigger} count allMissionObjects "#explosion" > 0 

allMissionObjects very expensive -- maybe only enable this trigger
when players are within say 300 meters?
--------------------------------------------------------------------- */
params ["_obj"];

if (! isServer) exitWith {};

// for debug -- hide the UAVs or not
private _hide = true;
//private _hide = false;
private _type = "O_UAV_01_F";

private _foo = { 
    hint "killed called";
    _foo = attachedTo (_this select 0); 
    {
        deleteVehicle _x;
    } forEach attachedObjects _foo;
    deleteVehicle (_this select 0); 
    deleteVehicle _foo; 
};

private _group = createGroup east;
private _temp = [];
{
    private _uav = _type createVehicle (getPosATL _obj); 
    _uav attachTo [_obj, _x];
    _uav hideObject _hide; [_uav, _hide] remoteExec ["hideObject", 0, true];
// should use:
//    _uav hideObjectGlobal _hide;
    _uav addMPEventHandler [ "mpkilled", _foo ];
    _uav triggerDynamicSimulation false;
    _temp pushBack _uav;
} forEach [[1, 0, 0], [-1, 0, 0], [0, 1, 0], [0, -1, 0]];

_temp joinSilent _group;
_group deleteGroupWhenEmpty true;
_group enableDynamicSimulation true;
