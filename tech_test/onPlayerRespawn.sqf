params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// check if the role has been set already
private _netId = _oldUnit call BIS_fnc_netId;
private _role = pcb_player_loadout getOrDefault [_netId, "NotFound"];

if (_role isEqualTo "NotFound") then {
    [_newUnit, (roleDescription _newUnit)] remoteExecCall ["pcb_loadout"];
} else {
    [_newUnit, _role] remoteExecCall ["pcb_loadout"];
};

