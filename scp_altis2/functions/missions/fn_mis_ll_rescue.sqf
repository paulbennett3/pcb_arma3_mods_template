/* ------------------------------------------------------------------
                            Mission: rescue

Get at least one player to within range of one or more AI units, which
   will join the player group.  

Arguments:
   _state     (hashmap) State and parameters for the mission

Returns:
   _ok (boolean) : true if mission started correctly 
   _state (hash map) : any state we'll need for later (cleanup, etc)


State Object:
   "taskpos"    (position) location of rescue (and target(s))
   "taskradius" (number) radius of "acceptable area" if in_area is true 
   "taskdesc"   [(string),(string),(string)]  task description, task name, task marker
   "taskpid"    (string)  parent id of task ("" for no parent)
   "targetlist" (array of AI objects) list of one or more units to rescue (objects must exist!)

Example:
    private _state = createHashMapFromArray [
        ["taskpos", getPosATL _crate],
        ["taskradius", 5],
        ["taskdesc", [
            "Rescue scientists from research lab",
            "Rescue scientists",
            "markername"]],
        ["taskpid", ""],
        ["targetlist", [_sci1, _sci2]]
    ];
    _result = [_state] call pcb_fnc_mis_ll_goto;
    _ok = _result select 0; _state = _result select 1;

------------------------------------------------------------------ */

params ["_state"];

private _ok = false;

if (pcb_DEBUG) then {
   ["Rescue mission called"] call pcb_fnc_debug;
};


// ---------------
// set up our task
// ---------------
private _tid = "MIS_RESCUE_" + (str ([] call pcb_fnc_get_next_UID));
if ((_state get "taskpid") isEqualTo "") then {
    _state set ["taskid", _tid];
} else {
    _state set ["taskid", [_tid, (_state get "taskpid")]];
};
private _pos = (_state get "taskpos");
[true, (_state get "taskid"), (_state get "taskdesc"), _pos, "ASSIGNED"] call BIS_fnc_taskCreate;

// -------------------------------------
// Set up a way to tell task is complete
// -------------------------------------
[_state] spawn {
    params ["_state"];

    // done when either all targets are dead (fail), or all targets in player_group (succeed)
    private _done = false;
    private _target_list = _state get "targetlist";
    while { sleep 5; ! _done } do {
        private _targets = _target_list select { alive _x };;
        if ((isNil "_targets") || {(count _targets) < 1}) then {
            _state set ["failed", true];
            [_state] call pcb_fnc_end_mission;
            _done = true;
        };
        private _rescued = _targets select { (group _x) != player_group };
        if (! (isNil "_rescued")) then {
            if ((count _rescued) < 1) then {
                _state set ["failed", false];
                [_state] call pcb_fnc_end_mission;
                _done = true;
            };
        };
    };
    private _trg = _state get "trigger";
    if (! (isNil "_trg")) then {
        deleteVehicle _trg;
    };
};

// -----------------------------------------
_ok = true;
private _result = [_ok, _state];
_result
