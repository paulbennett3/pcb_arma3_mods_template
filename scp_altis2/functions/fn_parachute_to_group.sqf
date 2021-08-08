/* *******************************************************************
                        parachute to group

Instead of "teleporting" or respawn-on-the-spot, this teleports
a player to a position near the group, but up in the air, with
a parachute on.

Parameters:
    _unit (object) : the unit to be parachuted
******************************************************************* */
params ["_unit", ["_pos", [0,0, 350]]];

[_unit, _pos] spawn {
    params ["_unit", "_pos"];

    // teleport to position, but up high
    if (! ([_pos] call pcb_fnc_is_valid_position)) then { _pos = getPosATL _unit; };
    private _up_pos = [_pos select 0, _pos select 1, 200];
    _unit setPos _up_pos;
    private _chute = createVehicle ['Steerable_Parachute_F', _up_pos, [], 0, 'Fly'];
    _chute setPos (position _unit);
    _unit moveIndriver _chute; 
    _chute allowDamage false;
};
