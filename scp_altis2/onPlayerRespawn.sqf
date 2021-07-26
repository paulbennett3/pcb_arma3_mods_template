params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

[_newUnit] call pcb_fnc_set_scp_loadout;

// Transfer any roles from _oldUnit to _newUnit
if (_oldUnit getUnitTrait "Occult") then { _newUnit setUnitTrait ["Occult", true, true]; };
if (_oldUnit getUnitTrait "Medic") then { _newUnit setUnitTrait ["medic", true]; };
if (_oldUnit getUnitTrait "engineer") then { _newUnit setUnitTrait ["engineer", true]; };
if (_oldUnit getUnitTrait "explosiveSpecialist") then { _newUnit setUnitTrait ["explosiveSpecialist", true]; };
