params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

private _loadout_profile = profileNamespace getVariable "unit_loadout";
if (! (isNil "_loadout_profile")) then {
    _newUnit setUnitLoadout _loadout_profile;
} else {
    [_newUnit] call pcb_fnc_set_scp_loadout;
};

// Transfer any roles from _oldUnit to _newUnit
if (! isNull _oldUnit) then {
    if (_oldUnit getUnitTrait "medic") then { _newUnit setUnitTrait ["medic", true]; };
    if (_oldUnit getUnitTrait "engineer") then { _newUnit setUnitTrait ["engineer", true]; };
    if (_oldUnit getUnitTrait "explosiveSpecialist") then { _newUnit setUnitTrait ["explosiveSpecialist", true]; };

    // lead unit set to sergeant -- if the corpse was the sergeant, make the new unit the leader
    if ((rankId _oldUnit) == 2) then {
        (group _oldUnit) selectLeader _newUnit;
        [(group _oldUnit), _newUnit] remoteExec ["selectLeader", 0, true];
        _newUnit setUnitRank "SERGEANT";
    };
};

/*
_newUnit addEventHandler ["Fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    hint ("fired: " + (str _ammo));
}];
*/

addMissionEventHandler ["HandleChatMessage", {
    params ["_channel", "_owner", "_from", "_text", "_person",
            "_name", "_strID", "_forcedDisplay", "_isPlayerMessage",
            "_sentenceType", "_chatMessageType"];
    if ("resupply" in _text) then {
        private _msg = ["resupply_request", _name, _text, _owner];
        [_msg] call pcb_fnc_send_mail;
    };
}];
