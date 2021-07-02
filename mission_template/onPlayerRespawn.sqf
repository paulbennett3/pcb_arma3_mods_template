params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

[_newUnit, roleDescription _newUnit] remoteExecCall ["pcb_fnc_loadout_scp_stargate"];

// give the "become leader" action 
_newUnit addAction ["Take Command",
                    "params ['_target', '_caller', '_actionId', '_arguments']; playableUnits join _caller; [group _caller, _caller] remoteExec ['selectLeader', groupOwner group  _caller];",
                    [], 1.5, false, true, "", "true", -1];
