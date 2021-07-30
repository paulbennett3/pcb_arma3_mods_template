/* ------------------------------------------------------------------
                            Mission: goto

Get at least one player to area (as opposed to an object / type string, which would use "put item")

Arguments:
   _state     (hashmap) State and parameters for the mission

Returns:
   _ok (boolean) : true if mission started correctly 
   _state (hash map) : any state we'll need for later (cleanup, etc)


State Object:
   "taskpos"    (position) location of container (and target)
   "taskradius" (number) radius of "acceptable area" if in_area is true 
   "taskdesc"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task ("" for no parent)

Example:
    private _state = createHashMapFromArray [
        ["taskpos", getPosATL _crate],
        ["taskradius", 5],
        ["taskdesc", [
            "Report to the research lab",
            "Go to lab",
            "markername"]],
        ["taskpid", ""],
    ];
    _result = [_state] call pcb_fnc_mis_ll_goto;
    _ok = _result select 0; _state = _result select 1;

------------------------------------------------------------------ */

params ["_state"];

private _ok = false;

diag_log ("GOTO" +  (str _state));
if (pcb_DEBUG) then {
   hint ("GOTO " + (str (_state get "target")));
   ["Goto mission called"] remoteExec ["systemChat", 0, true];
};


// ---------------
// set up our task
// ---------------
private _tid = "MIS_GOTO_" + (str ([] call pcb_fnc_get_next_UID));
if ((_state get "taskpid") isEqualTo "") then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};
private _pos = (_state get "taskpos");
[true, (_state get "taskid"), (_state get "taskdesc"), _pos, "ASSIGNED", 2] call BIS_fnc_taskCreate;

// -------------------------------------
// Set up a way to tell task is complete
// -------------------------------------
[_state] spawn {
    params ["_state"];

    // at least one player in area?
    private _center = _state get "taskpos";
    private _radius = _state get "taskradius";
    private _done = false;
    while { sleep 5; ! _done } do {
        if ([[_center, _radius]] call pcb_fnc_players_in_area) then {
            [_state] call pcb_fnc_end_mission;
            _done = true;
        }; 
    };
};

// -----------------------------------------
_ok = true;
private _result = [_ok, _state];
_result
