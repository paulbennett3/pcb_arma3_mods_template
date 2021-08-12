/* ******************************************************************
                         spawn squad

Spawn an infantry squad.

Parameters:
    _types (list of strings) : the types to randomly select from
    _n (number) : number to spawn
    _pos (position) : where to put 'em
    _side (side) : which side they are on (east, west, independent, civilian)
    _do_task (boolean) : if true, set BIS_fnc_taskDefend, otherwise don't (for Drongo's Spooks)

Returns:
    _group (group) : the group they were created in
****************************************************************** */
params ["_types", "_n", "_pos", "_side", ["_do_task", true]];
private _group = createGroup _side;
private _ij = 0;
for [{_ij = 0 }, {_ij < _n}, {_ij = _ij + 1}] do {
    private _type = selectRandom _types;
    private _veh = _group createUnit [_type, _pos, [], 50, 'NONE'];
    _veh triggerDynamicSimulation false; // won't wake up enemy units:wq
    [_veh] joinSilent _group;
};
[_group] call pcb_fnc_log_group;

if (_do_task) then {
    [_group, _pos] call BIS_fnc_taskDefend;
};
sleep .1;
_group
