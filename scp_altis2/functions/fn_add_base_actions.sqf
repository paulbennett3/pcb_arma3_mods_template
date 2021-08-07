/* ---------------------------------------------------------------------
                       add base actions

Set up the "base" actions:
    Take Command 
    Role: Medic
    Role: Engineer
    Role: Occult Technician
    Single Player Mode (take all roles)
    Set Respawn Here

Parameters:
    _obj (object) : thing to attach commands to
--------------------------------------------------------------------- */
params ["_obj"];

if (! isServer) exitWith {};

// ------------------------------------
//            Take Command
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    (group _caller) selectLeader _caller;
    [(group _caller), _caller] remoteExec ["selectLeader", 0, true];
    [ ((str _caller) + " is now Leader") ] remoteExec ["diag_log", 2];
    { _x setUnitRank "PRIVATE"; } forEach playableUnits;
    _caller setUnitRank "SERGEANT";
    [ ((str _caller) + " is now Leader") ] remoteExec ["hint", 0];
};

[
    _obj,
    [
        "Take Command",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];

// ------------------------------------
//            Set Role: Engineer
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller setUnitTrait ["medic", false];
    _caller setUnitTrait ["engineer", true];
    _caller setUnitTrait ["explosiveSpecialist", false];

    [ ((str _caller) + " is now an Engineer") ] remoteExec ["diag_log", 2];
    [ ((str _caller) + " is now an Engineer") ] remoteExec ["hint", 0];
};

[
    _obj,
    [
        "Role: Engineer",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!

// ------------------------------------
//            Set Role: Medic
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller setUnitTrait ["medic", true];
    _caller setUnitTrait ["engineer", false];
    _caller setUnitTrait ["explosiveSpecialist", false];
    [ ((str _caller) + " is now a Medic") ] remoteExec ["diag_log", 2];
    [ ((str _caller) + " is now a Medic") ] remoteExec ["hint", 0];
};

[
    _obj,
    [
        "Role: Medic",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!

// ------------------------------------
//            Set Role: Explosives Expert
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller setUnitTrait ["medic", false];
    _caller setUnitTrait ["engineer", false];
    _caller setUnitTrait ["explosiveSpecialist", true];
    [ ((str _caller) + " is now an Explosives Specialist") ] remoteExec ["hint", 0];
    [ ((str _caller) + " is now an Explosives Specialist") ] remoteExec ["diag_log", 2];
};

[
    _obj,
    [
        "Role: Explosives Spec.",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!

// ------------------------------------
//            Set Role: Single Player
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller setUnitTrait ["medic", true];
    _caller setUnitTrait ["engineer", true];
    _caller setUnitTrait ["explosiveSpecialist", true];
    [ ((str _caller) + " is now a Single Player") ] remoteExec ["hint", 0];
    [ ((str _caller) + " is now a Single Player") ] remoteExec ["diag_log", 2];
};

[
    _obj,
    [
        "Single Player",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!


// ------------------------------------
//         Parachute To Group 
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    [_caller] remoteExec ["pcb_fnc_parachute_to_group", owner _caller];
};

[
    _obj,
    [
        "Parachute In",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!

// ------------------------------------
//            Show Role
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    [ ((str _caller) + " has roles <" + (str (getAllUnitTraits _caller))) ] call pcb_fnc_debug;
};

[
    _obj,
    [
        "Show Role",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!


// ------------------------------------
//           Get Current Load (mass) 
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    private _load = loadAbs _caller;
    [ ((str _caller) + " has load " + (str _load)) ] remoteExec ["hint", 0];
};

[
    _obj,
    [
        "Get Loadout Mass",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!



// ------------------------------------
//            Abandon Task
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    private _tid = (playableUnits select 0) call BIS_fnc_taskCurrent;
    private _state = createHashMap;
    _state set ["taskid", _tid];
    _state set ["failed", true];
    _state set ["taskpos", _tid call BIS_fnc_taskDestination];
    [_state] call pcb_fnc_end_mission;
    diag_log "Mission abandoned!";
};

[
    _obj,
    [
        "Abandon Task",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!


// ------------------------------------
//            Call Support Units 
// ------------------------------------
/*
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    
    [ ((str _caller) + " called for backup") ] remoteExec ["diag_log", 2];
    private _types_list = [
        [
            "Infantry", 
            [
                "B_GEN_Commander_F",
                "B_GEN_Soldier_F",
                "B_GEN_Soldier_F",
                "B_GEN_Soldier_F",
                "B_GEN_Soldier_F",
                "B_GEN_Soldier_F"
            ], 
            objNull 
        ],
        [
            "Infantry", 
            [
                "B_Patrol_Soldier_TL_F",
                "B_Patrol_Soldier_AT_F",
                "B_Patrol_Medic_F",
                "B_Patrol_Soldier_AR_F",
                "B_Patrol_Soldier_AR_F",
                "B_Patrol_Soldier_AR_F",
                "B_Patrol_Soldier_AR_F",
                "B_Patrol_Soldier_A_F"
            ], 
            objNull 
        ],
        [
            "Vehicle", 
            [
                "B_Heli_Attack_01_dynamicLoadout_F",
                "B_Heli_Attack_01_dynamicLoadout_F",
                "B_Heli_Attack_01_dynamicLoadout_F"
            ], 
            objNull 
        ]
    ];

    [ _types_list ] remoteExec ["pcb_fnc_spawn_support_units", 2];
    [ ((str _caller) + " called for backup") ] remoteExec ["hint", 0];
};

[
    _obj,
    [
        "Summon Support",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];
*/

