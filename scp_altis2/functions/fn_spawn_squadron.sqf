/* ******************************************************************
                         spawn squadron

Spawn an infantry squad.

Parameters:
    _types (list of type strings) : the types to spawn
    _pos (position) : where to put 'em
    _side (side) : which side they are on (east, west, independent, civilian)
    _do_task (boolean) : if true, set BIS_fnc_taskDefend, otherwise don't (for Drongo's Spooks)

Returns:
    _group (group) : the group they were created in
****************************************************************** */
params ["_types", "_pos", "_side", ["_do_task", true]];


private _group = objNull;
private _veh = objNull;
private _crew = [];

// create a group
_group = createGroup _side;

private _vdx = 0;
for [{}, {_vdx < (count _types)}, {_vdx = _vdx + 1}] do {
    private _type = _types select _vdx;
    private _lpos = _pos findEmptyPosition [0, 50, _type];
    if ((count _lpos) == 0) then { _lpos = _pos; };
    private _res = [
        _lpos,
        random 360,
        _type,  
        _group 
    ] call BIS_fnc_spawnVehicle;

    // Note of result -> _res = [created vehicle, [crew]], group]
    _veh = _res select 0;
    [_res select 0, ceil (random 10)] call pcb_fnc_loot_crate;
    [_res select 0] joinSilent _group;

    _crew = _crew + (_res select 1);

    {
        _x triggerDynamicSimulation false;
    } forEach (_res select 1);
    [(_res select 1)] joinSilent _group;

    sleep .1;
};

_group selectLeader (_crew select 0);
[_group, _crew] spawn {
    params ["_group", "_crew"];
    { _x setUnconscious true; } forEach _crew;
    sleep 3;
    { _x setUnconscious false; } forEach _crew;
};

//[_group] call pcb_fnc_log_group;

_group
