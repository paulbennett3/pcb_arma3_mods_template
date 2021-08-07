/* ********************************************************
                   loadout save restore

Saves or restores from save a units loadout
******************************************************** */
params ["_unit", "_save"];

if (_save) then {
    _unit setVariable ["loadout", getUnitLoadout _unit];
    systemChat "Loadout Saved";
} else {
    private _loadout = _unit getVariable "loadout";
    if (isNil "_loadout") then {
        systemChat "No loadout saved to be able to restore!";
    } else {
        _unit setUnitLoadout _loadout;
        systemChat "Loadout Restored";
    };
};
