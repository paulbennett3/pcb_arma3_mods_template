// Wrapper to handle the argument passing from addAction invocation
params ["_target", "_caller", "_actionId", "_arguments"];

[_caller, _arguments] call compile preprocessFile "scripts\pcb_loadout.sqf";

// get the netId to store role 
private _netId = _caller call BIS_fnc_netId;
pcb_player_loadout set [_netId, _arguments];
publicVariable "pcb_player_loadout";
