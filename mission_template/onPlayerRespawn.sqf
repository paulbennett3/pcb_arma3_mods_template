params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

[_newUnit, (roleDescription _newUnit)] remoteExecCall ["pcb_loadout"];
