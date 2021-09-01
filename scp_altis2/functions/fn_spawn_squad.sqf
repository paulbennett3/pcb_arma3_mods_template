/* ******************************************************************
                         spawn squad

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
private _group = createGroup _side;
private _ij = 0;
for [{_ij = 0 }, {_ij < (count _types)}, {_ij = _ij + 1}] do {
    private _type = _types select _ij;
    private _veh = _group createUnit [_type, _pos, [], 50, 'NONE'];
    _veh triggerDynamicSimulation false; // won't wake up enemy units
    [_veh] joinSilent _group;
};
[_group] call pcb_fnc_log_group;

// possible dedicated server "freeze" workaround ...
{ _x setUnconscious true; } forEach (units _group);
sleep 3;
{ _x setUnconscious false; } forEach (units _group);


if (_do_task) then {
    [_group, _pos] call BIS_fnc_taskDefend;
};
sleep .1;
_group
