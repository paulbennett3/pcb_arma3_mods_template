/* ********************************************************
                   loadout save restore

Saves or restores from save a units loadout
******************************************************** */
params ["_unit", "_save"];

if (_save) then {
    _unit setVariable ["loadout", getUnitLoadout _unit];
    profileNamespace setVariable ["unit_loadout", getUnitLoadout _unit];
    systemChat "Loadout Saved";
} else {
    private _loadout = _unit getVariable "loadout";
    private _loadout_profile = profileNamespace getVariable "unit_loadout";
    if (isNil "_loadout") then {
        if (! isNil "_loadout_profile") then {
            _unit setUnitLoadout _loadout_profile;
            _unit setVariable ["loadout", _loadout_profile];
            systemChat "Loadout Restored from profile";
        } else {
            systemChat "No loadout saved to be able to restore!";
        };
    } else {
        _unit setUnitLoadout _loadout;
        systemChat "Loadout Restored";
    };
};
