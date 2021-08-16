/* ********************************************************
                   loadout clone

Clones the current loadout to all units in group (except players)
******************************************************** */
params ["_unit", "_save"];

["Cloned loadout to units"] call pcb_fnc_debug;
private _loadout = getUnitLoadout _unit;
{
    if (! (isPlayer _x)) then {
        _x setUnitLoadout _loadout;
    };
} forEach (units player_group);
