params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// give the "become leader" action
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments']; 
    playableUnits join _caller; 
    [group _caller, _caller] remoteExec ['selectLeader', groupOwner group  _caller, true];
};

_newUnit addAction [
    "Take Command",
    _cmd,
    [], 1.5, false, true, "", "true", -1
];

// set traits
_newUnit setUnitTrait ["engineer", true]; 
_newUnit setUnitTrait ["explosiveSpecialist", true]; 

// strip
//removeallweapons _newUnit; 
//removeAllAssignedItems _newUnit; 
