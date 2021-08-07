params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

[_newUnit] call pcb_fnc_set_scp_loadout;

// Transfer any roles from _oldUnit to _newUnit
if (! isNull _oldUnit) then {
    if (_oldUnit getUnitTrait "Medic") then { _newUnit setUnitTrait ["medic", true]; };
    if (_oldUnit getUnitTrait "engineer") then { _newUnit setUnitTrait ["engineer", true]; };
    if (_oldUnit getUnitTrait "explosiveSpecialist") then { _newUnit setUnitTrait ["explosiveSpecialist", true]; };

    // lead unit set to sergeant -- if the corpse was the sergeant, make the new unit the leader
    if ((rankId _oldUnit) == 2) then {
        (group _oldUnit) selectLeader _newUnit;
        [(group _oldUnit), _newUnit] remoteExec ["selectLeader", 0, true];
        _newUnit setUnitRank "SERGEANT";
    };
};
