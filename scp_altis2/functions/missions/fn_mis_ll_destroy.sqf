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
   "taskpid"    (string)  parent id of task ("" for no parent)


Example:
    private _state = createHashMapFromArray [
        ["target", _idol],
        ["taskpos", getPosATL _idol],
        ["taskdesc", [
            "Destroy the stone statue at the Old Mill in Derbyshire",
            "Destroy Idol",
            "markername"]],
        ["taskpid", ""]]
    ];
    _result = [_state] call pcb_fnc_mis_destroy;
    _ok = _result select 0; _state = _result select 1;

------------------------------------------------------------------ */

params ["_state"];

private _ok = false;

if (pcb_DEBUG) then {
    hint ("DESTROY " + (str (_state get "target")));
};


// -------------------------------------------------
//  If there is enough of a boom by are target,
//    we make them destroyable (even if they were
//  "killable" before ...)
// -------------------------------------------------
[(_state get "target")] call pcb_fnc_make_destroyable;

// ---------------
// set up our task
// ---------------
private _tid = "MIS_DEST_" + (str ([] call pcb_fnc_get_next_UID));
if ((_state get "taskpid") isEqualTo "") then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};
private _pos = (_state get "taskpos");

[true, (_state get "taskid"), (_state get "taskdesc"), _pos, "ASSIGNED"] call BIS_fnc_taskCreate;

// add our state variable to the target so we can grab it later
(_state get "target") setVariable ["_state", _state, true];

// -------------------------------------
// Set up a way to tell task is complete
// -------------------------------------
[_state, _state get "target"] spawn {
    params ["_state", "_target"];
    waitUntil { sleep 5; ! (alive _target) };

    _state set ["failed", false];
    [_state] call pcb_fnc_end_mission;
};


// -----------------------------------------
_ok = true;
private _result = [_ok, _state];
_result
