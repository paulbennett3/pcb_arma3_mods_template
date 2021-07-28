/* ------------------------------------------------------------------
                            Mission: destroy

Kill person or destroy object

Designed to be called to handle all aspect (create, update, delete) of the mission.
Pass in a string to the "_action" parameter to select which action to do.
The _state hashmap contains arguments for the phase, as well as outputs (object lists
for deletion, markers, etc).

Arguments:
   _state     (hashmap) State and parameters for the mission

Returns:
   _ok (boolean) : true if mission started correctly 
   _state (hash map) : any state we'll need for later (cleanup, etc)


State Object:
   "target"     (object)  person / thing to inhume
                   Assumed to already exist and be positioned!!!
   "taskdesc"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task (defaults to objNull for no parent)
   "is_destroyable"  (bool)    if true, kill it. If false, use UAVs to allow it to be blown up


Example:
    private _state = createHashMapFromArray [
        ["target", _idol],
        ["taskpos", getPosATL _idol],
        ["taskdesc", [
            "Destroy the stone statue at the Old Mill in Derbyshire",
            "Destroy Idol",
            "markername"]],
        ["taskpid", objNull],
        ["is_destroyable", false]
    ];
    _result = [_state] call pcb_fnc_mis_destroy;
    _ok = _result select 0; _state = _result select 1;

------------------------------------------------------------------ */

params ["_state"];

private _ok = false;

diag_log (str _state);
if (pcb_DEBUG) then {
    hint ("DESTROY " + (str (_state get "target")));
};


// -------------------------------------------------
// If our target isn't a person, make it destroyable
// -------------------------------------------------
if (!(_state get "is_destroyable")) then {
    [(_state get "target")] call pcb_fnc_make_destroyable;
};

// ---------------
// set up our task
// ---------------
private _tid = "MIS_DEST_" + (str ([] call pcb_fnc_get_next_UID));
if (isNull (_state get "taskpid")) then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};
private _pos = (_state get "taskpos");

[true, (_state get "taskid"), (_state get "taskdesc"), _pos, "ASSIGNED", 2] call BIS_fnc_taskCreate;

// add our state variable to the target so we can grab it later
(_state get "target") setVariable ["_state", _state, true];

// -------------------------------------
// Set up a way to tell task is complete
// -------------------------------------
// isKindOf
//   Man -- kill it
//   AllVehicle -- kill it
//       MPKilled event handler
//   Building -- [target] call pcb_fnc_destroy_building 
//       hidden?
//   not destroyable -- Deleted event handler
if (((_state get "target") isKindOf "Man") or
    ((_state get "target") isKindOf "AllVehicle")) then {
    [
        (_state get "target"), 
        [
            "MPKilled",
            {
                params ["_unit", "_killer", "_instigator", "_useEffect"];
                private _state = _unit getVariable "_state";
                _state set ["failed", false];
                [_state] call pcb_fnc_end_mission;
            }
        ]    
    ] remoteExec ["addMPEventHandler", 0, true];
    [
        (_state get "target"), 
        [
            "Explosion",
            {
                params ["_vehicle", "_damage"];
                private _state = _vehicle getVariable "_state";

                _state set ["failed", false];
                [_state] call pcb_fnc_end_mission;
            }
        ]    
    ] remoteExec ["addEventHandler", 0, true];
};


if ( ! (_state get "is_destroyable")) then { 
    [
        (_state get "target"), 
        [
            "Deleted",
            {
                params ["_entity"];
                private _state = _entity getVariable "_state";

                _state set ["failed", false];
                [_state] call pcb_fnc_end_mission;
            }
        ]    
    ] remoteExec ["addEventHandler", 0, true];

    [
        (_state get "target"), 
        [
            "Explosion",
            {
                params ["_vehicle", "_damage"];
                private _state = _vehicle getVariable "_state";

                _state set ["failed", false];
                [_state] call pcb_fnc_end_mission;
            }
        ]    
    ] remoteExec ["addEventHandler", 0, true];
};


// -------------------------------------------------------------------
// stick our state in the target so we can get it from event handlers
// -------------------------------------------------------------------
(_state get "target") setVariable ["_state", _state, true];


// -----------------------------------------
_ok = true;
private _result = [_ok, _state];
_result
