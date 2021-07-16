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
    // (group _caller) selectLeader _caller;
    // playableUnits join _caller;
    (group _caller) selectLeader _caller;
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
    _caller setUnitTrait ["Occult", false, true];
    _caller setUnitTrait ["Medic", false];
    _caller setUnitTrait ["engineer", true];
    _caller setUnitTrait ["explosiveSpecialist", true];

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
    _caller setUnitTrait ["Occult", false, true];
    _caller setUnitTrait ["Medic", true];
    _caller setUnitTrait ["engineer", false];
    _caller setUnitTrait ["explosiveSpecialist", false];
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
//            Set Role: Occult Tech
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller setUnitTrait ["Occult", true, true];
    _caller setUnitTrait ["Medic", false];
    _caller setUnitTrait ["engineer", false];
    _caller setUnitTrait ["explosiveSpecialist", false];
    [ ((str _caller) + " is now an Occult Tech") ] remoteExec ["hint", 0];
};

[
    _obj,
    [
        "Role: Occult Tech",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!

// ------------------------------------
//            Set Role: Single Player
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller setUnitTrait ["Occult", true, true];
    _caller setUnitTrait ["Medic", true];
    _caller setUnitTrait ["engineer", true];
    _caller setUnitTrait ["explosiveSpecialist", true];
    [ ((str _caller) + " is now a Single Player") ] remoteExec ["hint", 0];
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
//            Set Respawn Here
// ------------------------------------
private _cmd = {
    params ['_target', '_caller', '_actionId', '_arguments'];
    "respawn_west" setMarkerPos getPosATL _caller;
    { hint "Respawn point moved"; } remoteExec ["call", 0];
};

[
    _obj,
    [
        "Set Respawn Here",
        _cmd,
        [], 1.5, false, false, "", "true", 5
    ]
] remoteExec ["addAction", 0, true];   // Server only!



